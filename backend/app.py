from flask import Flask, request, jsonify
from flask_cors import CORS

app = Flask(__name__)

# Mengizinkan Flutter mengakses API
CORS(app)


# ============================================================
# TEST BACKEND
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

        print("\n========== REQUEST DITERIMA ==========")
        print(data)

        if not data:

            return jsonify({
                "success": False,
                "message": "Data tidak ditemukan"
            }), 400


        # ====================================================
        # 2. MENGAMBIL DATA AYAT
        # ====================================================

        surah_name = data.get("surahName")
        verse_number = data.get("verseNumber")
        arabic_text = data.get("arabicText")
        translation = data.get("translation")

        terjemahan = data.get("terjemahan")
        tafsir = data.get("tafsir")


        # ====================================================
        # 3. VALIDASI
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
        # 4. DEBUG
        # ====================================================

        print("\n========== DATA AYAT ==========")

        print("Surah       :", surah_name)
        print("Ayat        :", verse_number)

        print("\nArab:")
        print(arabic_text)

        print("\nTranslation:")
        print(translation)

        print("\nTerjemahan:")
        print(terjemahan)

        print("\nTafsir:")
        print(tafsir)

        print("\n================================")


        # ====================================================
        # 5. HASIL SEMENTARA
        #
        # NANTI BAGIAN INI DIGANTI DENGAN MODEL SVM
        # ====================================================

        label = "Shalat"
        confidence = 94


        # ====================================================
        # 6. KEMBALIKAN HASIL KE FLUTTER
        # ====================================================

        return jsonify({

            "success": True,

            # hasil klasifikasi
            "label": label,
            "confidence": confidence,

            # informasi hasil
            "status": "Ayat berhasil diklasifikasikan",

            "explanation": (
                "Hasil sementara dari backend. "
                "Model SVM akan digunakan pada tahap berikutnya."
            ),

            # data ayat
            "surahName": surah_name,
            "verseNumber": verse_number,
            "arabicText": arabic_text,
            "translation": translation,

            "message": "Klasifikasi berhasil"

        })


    # ========================================================
    # ERROR
    # ========================================================

    except Exception as e:

        print("\n========== ERROR ==========")
        print(e)
        print("===========================\n")

        return jsonify({

            "success": False,
            "message": str(e)

        }), 500


# ============================================================
# RUN SERVER
# ============================================================

if __name__ == "__main__":

    app.run(
        host="0.0.0.0",
        port=5000,
        debug=True
    )