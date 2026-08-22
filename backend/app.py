from flask import Flask, request, jsonify
from flask_cors import CORS

import joblib
from scipy.sparse import hstack
import os


app = Flask(__name__)
CORS(app)


# ============================================================
# PATH MODEL
# ============================================================

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
MODEL_DIR = os.path.join(BASE_DIR, "models")


# ============================================================
# LOAD MODEL
# ============================================================

print("\n========================================")
print("MEMUAT MODEL")
print("========================================")

tfidf_terjemahan = joblib.load(
    os.path.join(MODEL_DIR, "tfidf_terjemahan.pkl")
)

tfidf_tafsir = joblib.load(
    os.path.join(MODEL_DIR, "tfidf_tafsir.pkl")
)

model = joblib.load(
    os.path.join(MODEL_DIR, "svm_tfidf_calibrated.pkl")
)


print("TF-IDF terjemahan :", len(tfidf_terjemahan.vocabulary_))
print("TF-IDF tafsir     :", len(tfidf_tafsir.vocabulary_))
print("Model             :", type(model).__name__)
print("Classes           :", model.classes_)

print("========================================")
print("MODEL BERHASIL DIMUAT")
print("========================================\n")


# ============================================================
# HOME
# ============================================================

@app.route("/", methods=["GET"])
def home():

    return jsonify({
        "success": True,
        "message": "Backend klasifikasi Rukun Islam aktif"
    })


# ============================================================
# CLASSIFICATION
# ============================================================

@app.route("/classify", methods=["POST"])
def classify():

    try:

        # ====================================================
        # 1. MENERIMA DATA DARI FLUTTER
        # ====================================================

        data = request.get_json()

        if not data:

            return jsonify({
                "success": False,
                "message": "Data tidak ditemukan"
            }), 400


        terjemahan = data.get("terjemahan")
        tafsir = data.get("tafsir")


        # Data ayat
        surah_name = data.get("surahName")
        verse_number = data.get("verseNumber")
        arabic_text = data.get("arabicText")


        # ====================================================
        # 2. VALIDASI
        # ====================================================

        if not terjemahan:

            return jsonify({
                "success": False,
                "message": "Terjemahan tidak boleh kosong"
            }), 400


        if not tafsir:

            return jsonify({
                "success": False,
                "message": "Tafsir tidak boleh kosong"
            }), 400


        # ====================================================
        # 3. DEBUG
        # ====================================================

        print("\n========================================")
        print("DATA DITERIMA")
        print("========================================")

        print("Surah       :", surah_name)
        print("Ayat        :", verse_number)

        print("\nTerjemahan:")
        print(terjemahan)

        print("\nTafsir:")
        print(tafsir)


        # ====================================================
        # 4. TF-IDF TERJEMAHAN
        # ====================================================

        X_terjemahan = tfidf_terjemahan.transform(
            [terjemahan]
        )

        print("\nUkuran TF-IDF terjemahan:")
        print(X_terjemahan.shape)


        # ====================================================
        # 5. TF-IDF TAFSIR
        # ====================================================

        X_tafsir = tfidf_tafsir.transform(
            [tafsir]
        )

        print("\nUkuran TF-IDF tafsir:")
        print(X_tafsir.shape)


        # ====================================================
        # 6. GABUNGKAN FITUR
        # ====================================================

        X_combined = hstack([
            X_terjemahan,
            X_tafsir
        ])

        print("\nUkuran fitur gabungan:")
        print(X_combined.shape)


        # ====================================================
        # 7. PREDIKSI
        # ====================================================

        prediction = model.predict(X_combined)[0]


        # ====================================================
        # 8. CONFIDENCE
        # ====================================================

        probabilities = model.predict_proba(
            X_combined
        )[0]

        confidence = float(probabilities.max() * 100)


        # ====================================================
        # 9. DEBUG HASIL
        # ====================================================

        print("\n========================================")
        print("HASIL KLASIFIKASI")
        print("========================================")

        print("Label      :", prediction)
        print("Confidence :", confidence)

        print("\nProbabilitas:")

        for label, probability in zip(
            model.classes_,
            probabilities
        ):

            print(
                f"{label:<20}: "
                f"{probability * 100:.2f}%"
            )

        print("========================================\n")


        # ====================================================
        # 10. RESPONSE KE FLUTTER
        # ====================================================

        return jsonify({

            "success": True,

            "label": str(prediction),

            "confidence": round(confidence, 2),

            "status": "Ayat berhasil diklasifikasikan",

            "explanation": (
                "Klasifikasi dilakukan menggunakan "
                "TF-IDF dan SVM terkalibrasi."
            ),

            # Data ayat dikembalikan ke Flutter
            "surahName": surah_name,

            "verseNumber": verse_number,

            "arabicText": arabic_text,

            "translation": terjemahan,

            "message": "Klasifikasi berhasil"

        })


    except Exception as e:

        print("\n========================================")
        print("ERROR KLASIFIKASI")
        print("========================================")

        print(str(e))

        print("========================================\n")


        return jsonify({

            "success": False,

            "message": str(e)

        }), 500


# ============================================================
# RUN SERVER
# ============================================================

if __name__ == "__main__":

    port = int(os.environ.get("PORT", 5000))

    app.run(
        host="0.0.0.0",
        port=port,
        debug=False
    )