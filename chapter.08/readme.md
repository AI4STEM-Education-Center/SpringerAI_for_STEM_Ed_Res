# Recommender Systems for STEM Education: Three Use Cases

This repository contains three educational use cases for recommender systems in STEM education. Each script demonstrates a different paradigm of recommendation:

- **Case 1**: Content-Based Filtering
- **Case 2**: Collaborative Filtering
- **Case 3**: LLM-Based Recommendation

These examples are designed for educators, researchers, or developers interested in building personalized learning tools using standard or emerging AI techniques.

---

## 📁 Files Overview

| Filename   | Description                                                      | Method Paradigm          |
|------------|------------------------------------------------------------------|--------------------------|
| `case1.py` | Recommends physics videos based on TF-IDF and cosine similarity | Content-Based Filtering  |
| `case2.py` | Recommends elective courses using matrix factorization (SVD)    | Collaborative Filtering  |
| `case3.py` | Recommends math modules using a language model (LLaMA)          | LLM-Based Recommendation |

---

## 🔧 Installation & Setup

### 📦 Dependencies

Install required libraries using `pip`:

#### For Case 1 & 2:

```bash
pip install numpy pandas scikit-learn
```

#### For Case 3 (LLM):

```bash
pip install torch transformers accelerate sentencepiece
```

> **Note**: Case 3 also requires a local deployment of a large language model (LLaMA-3.1-8B-Instruct).

---

## ▶️ How to Run

Each script can be executed directly:

### ✅ Case 1: Content-Based Filtering

```bash
python case1.py
```

This script builds a TF-IDF representation of a small physics video catalogue. Based on videos already watched by a student, it recommends the top 3 most relevant unwatched videos using cosine similarity.

### ✅ Case 2: Collaborative Filtering

```bash
python case2.py
```

This script simulates student ratings for elective STEM courses. Using Truncated SVD, it reconstructs missing entries and recommends the top 3 unseen electives for a target student (Student 0).

### ✅ Case 3: LLM-Based Recommendation

```bash
python case3.py
```

This example builds a personalized learning prompt for a fictional student profile and sends it to a deployed LLaMA-3.1-8B-Instruct model to receive structured JSON recommendations.

To run this example:

1. Download and deploy the LLaMA-3.1-8B-Instruct model from the official Meta repository (see [Meta AI GitHub](https://huggingface.co/meta-llama/Llama-3.1-8B-Instruct)).
2. Replace this line in `case3.py` with the actual model path on your machine:

```python
MODEL_ID = "path/to/your/model"
```

3. Make sure your system has GPU access with CUDA for efficient inference.


