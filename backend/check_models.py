import joblib


files = [
    "models/svm_tfidf_calibrated.pkl",
    "models/tfidf_tafsir.pkl",
    "models/tfidf_terjemahan.pkl",
]


for file in files:

    print("\n===================================")
    print("FILE:", file)
    print("===================================")

    obj = joblib.load(file)

    print("TYPE:", type(obj))
    print("OBJECT:")
    print(obj)

    if hasattr(obj, "get_params"):
        print("\nPARAMETERS:")
        print(obj.get_params())

    if hasattr(obj, "classes_"):
        print("\nCLASSES:")
        print(obj.classes_)

    if hasattr(obj, "vocabulary_"):
        print("\nVOCAB SIZE:")
        print(len(obj.vocabulary_))