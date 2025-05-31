
# AI for Automatic Scoring in STEM Education

This repository contains activities and resources for students to explore the use of AI in automatic scoring of STEM responses. These activities are based on the chapter *Using AI for Automatic Scoring* and include hands-on exercises to help you understand data collection, contextualized scoring, fairness, and scalability.

## Activities

1. **Contextualized Automatic Scoring**
    - Pretrain and fine-tune language models for scoring.
    - Activity 1: Context-Based Science Assessment
    - Activity 2: Peer Review and Contextualization

2. **Fair Automatic Scoring**
    - Explore fairness and bias in AI scoring.
    - Activity 1: Bias Analysis in AI Scoring
    - Activity 2: Fairness in Dataset Curation

3. **Efficient and Scalable Automatic Scoring**
    - Optimize models for speed and resource use.
    - Activity 1: Optimizing Scoring Models (Knowledge Distillation)
    - Activity 2: Scoring in Large-Scale Assessments

## Getting Started

1. Clone this repository:
   ```bash
   git clone https://github.com/AI4STEM-Education-Center/SpringerAI_for_STEM_Ed_Res.git
   cd SpringerAI_for_STEM_Ed_Res
    ```

2. Create a virtual environment and install dependencies:

   ```bash
   python -m venv venv
   source venv/bin/activate
   pip install -r requirements.txt
   ```

## Reference

* Based on: *Using AI for Automatic Scoring* (Springer, 2025)

---

## Notebooks: Step-by-Step Instructions for Activities

### 1. Contextualized Automatic Scoring (`contextualized_scoring.ipynb`)
- **Objective**: Use language models for context-aware assessment and peer review.
- **Sections**:
    1. Load a sample science dataset (provided or created by students).
    2. Preprocess the data (script can help here).
    3. Fine-tune a language model (e.g., BERT or GPT-based).
    4. Score student responses and provide feedback.
    5. Peer Review: Exchange responses and compare AI feedback with human feedback.
    6. Reflection: Discuss where the model succeeded/failed and how context matters.

### 2. Fair Automatic Scoring (`fair_scoring.ipynb`)
- **Objective**: Analyze and mitigate bias in automatic scoring.
- **Sections**:
    1. Analyze scoring accuracy on gender-diverse or otherwise varied datasets.
    2. Implement bias metrics (accuracy difference, mean score gaps, equalized odds).
    3. Curate a small, diverse dataset.
    4. Train a simple scoring model and evaluate fairness.
    5. Discussion: Why is fairness important? What causes bias?

### 3. Efficient and Scalable Automatic Scoring (`scalable_scoring.ipynb`)
- **Objective**: Implement and evaluate knowledge distillation for efficient scoring.
- **Sections**:
    1. Overview of teacher-student models (knowledge distillation).
    2. Train a “teacher” model (can be small for demo).
    3. Distill to a smaller “student” model.
    4. Compare inference speed, accuracy, and scalability.
    5. Simulate large-scale assessment and discuss trade-offs.

---

## requirements.txt

Include typical AI/ML libraries (PyTorch or TensorFlow, transformers, scikit-learn, pandas, Jupyter, etc.), for example:

```

torch
transformers
scikit-learn
pandas
numpy
jupyter
matplotlib

```

---