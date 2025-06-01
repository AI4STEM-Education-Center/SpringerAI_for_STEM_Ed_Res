import numpy as np
import pandas as pd
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity

np.random.seed(42)

# Simulated video catalogue (title + transcript-like blurb)
videos = pd.DataFrame({
    "title": [
        "Intro to Newton's Laws", "Friction on Inclines", "Work–Energy Theorem",
        "Simple Harmonic Motion", "Electric Fields", "Capacitors in Circuits",
        "Magnetic Force on Wires", "Wave Interference Basics"
    ],
    "text": [
        "law motion inertia net force acceleration second law f equals m a",
        "kinetic friction static coefficient ramp angle component gravity",
        "work energy kinetic potential theorem net work equals delta k",
        "spring constant oscillation period mass sine cosine displacement",
        "electric field charges coulomb force lines magnitude distance",
        "parallel series capacitor voltage charge energy dielectric plates",
        "current magnetic field right hand rule force wire length vector",
        "wave crest trough interference constructive destructive path difference"
    ]
})

# 1. TF-IDF Vectorization (sparse matrix)
vec = TfidfVectorizer()
X = vec.fit_transform(videos.text)  # csr_matrix

# 2. Convert to dense array to avoid numpy.matrix type
X_dense = X.toarray()               # ndarray, shape (8, n_features)

# 3. Build user profile
watched_ix = [0, 1]                  # user watched video indices
profile = X_dense[watched_ix].mean(axis=0).reshape(1, -1)  # ndarray, shape (1, n_features)

# 4. Calculate cosine similarity
scores = cosine_similarity(profile, X_dense).flatten()

# 5. Filter watched videos and select Top 3
videos["score"] = scores
unwatched = videos.drop(index=watched_ix).copy()
top3 = unwatched.sort_values("score", ascending=False)[["title", "score"]].head(3)

print(top3)
