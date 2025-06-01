# ----------  cell 1  ----------
import numpy as np, pandas as pd
from sklearn.decomposition import TruncatedSVD
from sklearn.metrics import mean_squared_error

np.random.seed(7)
n_students, n_courses = 200, 40
true_rank = 5

# ground-truth latent factors (simulation only)
U_true = np.random.randn(n_students, true_rank)
V_true = np.random.randn(n_courses, true_rank)
R_full = U_true @ V_true.T + 3        # center around 3
R_full += 0.5 * np.random.randn(*R_full.shape)  # noise
R_full = np.clip(R_full, 1, 5)

# 80 % observable ratings
mask = np.random.rand(*R_full.shape) < 0.8
R_obs = np.where(mask, R_full, np.nan)

# replace NaN with column means for SVD baseline
filled = pd.DataFrame(R_obs).apply(lambda col: col.fillna(col.mean()), axis=0).values
svd = TruncatedSVD(n_components=true_rank, random_state=0)
U = svd.fit_transform(filled)
V = svd.components_.T
R_hat = U @ V.T

# Simple evaluation
rmse = mean_squared_error(R_full[~mask], R_hat[~mask], squared=False)
print(f"Hold-out RMSE ≈ {rmse:0.3f}")

# Recommend 3 electives for student 0 not yet taken
unseen = np.where(~mask[0])[0]
top = unseen[np.argsort(R_hat[0, unseen])][::-1][:3]
print("Top elective recommendations for Student 0:", top)
