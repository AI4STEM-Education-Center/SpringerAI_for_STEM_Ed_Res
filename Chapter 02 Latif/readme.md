# AI for Automatic Scoring in STEM Education

This repository contains activities and resources for students to explore the use of AI in automatic scoring of STEM responses. These activities are based on the chapter *Using AI for Automatic Scoring* and include hands-on exercises to help you understand data collection, contextualized scoring, fairness, and scalability.

## Activities

1. **Contextualized Automatic Scoring**

   * Pretrain and fine-tune language models for scoring.
   * Activity 1: Context-Based Science Assessment
   * Activity 2: Peer Review and Contextualization

2. **Fair Automatic Scoring**

   * Explore fairness and bias in AI scoring.
   * Activity 1: Bias Analysis in AI Scoring
   * Activity 2: Fairness in Dataset Curation

3. **Efficient and Scalable Automatic Scoring**

   * Optimize models for speed and resource use, including knowledge distillation.
   * Activity 1: Optimizing Scoring Models (Knowledge Distillation)
   * Activity 2: Scoring in Large-Scale Assessments

---

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

---

## Reference

* Based on: *Using AI for Automatic Scoring* (Springer, 2025)

---

## Notebooks: Step-by-Step Instructions for Activities

### 1. Contextualized Automatic Scoring (`contextualized_scoring.ipynb`)

* **Objective**: Use language models for context-aware assessment and peer review.
* **Sections**:

  1. Load a sample science dataset (provided or created by students).
  2. Preprocess the data (script can help here).
  3. Fine-tune a language model (e.g., BERT or GPT-based).
  4. Score student responses and provide feedback.
  5. Peer Review: Exchange responses and compare AI feedback with human feedback.
  6. Reflection: Discuss where the model succeeded/failed and how context matters.

### 2. Fair Automatic Scoring (`fair_scoring.ipynb`)

* **Objective**: Analyze and mitigate bias in automatic scoring.
* **Sections**:

  1. Analyze scoring accuracy on gender-diverse or otherwise varied datasets.
  2. Implement bias metrics (accuracy difference, mean score gaps, equalized odds).
  3. Curate a small, diverse dataset.
  4. Train a simple scoring model and evaluate fairness.
  5. Discussion: Why is fairness important? What causes bias?

### 3. Efficient and Scalable Automatic Scoring (`scalable_scoring.ipynb`)

* **Objective**: Implement and evaluate knowledge distillation for efficient scoring.
* **Sections**:

  1. Overview of teacher-student models (knowledge distillation).
  2. Train a “teacher” model (can be small for demo).
  3. Distill to a smaller “student” model.
  4. Compare inference speed, accuracy, and scalability.
  5. Simulate large-scale assessment and discuss trade-offs.

---

## Knowledge Distillation: Efficient AI for Automatic Scoring

Knowledge distillation is a key method for making powerful AI models lightweight and practical for real-world STEM education settings. This repository demonstrates how to distill a fine-tuned Large Language Model (LLM) into a much smaller neural network—optimizing speed, size, and cost for deployment.

### What is Knowledge Distillation?

Knowledge distillation (KD) involves training a small “student” model to mimic the output of a large, high-performing “teacher” model (such as a fine-tuned BERT or GPT variant). The student model learns not just from the true labels, but also from the teacher's “soft labels”—the probability distribution over all possible answers—which encode the teacher’s generalization.

### Why Use KD in Education AI?

* **Efficiency:** Student models require less memory and computation, enabling use on typical school hardware.
* **Speed:** Inference time is reduced, allowing real-time scoring in classroom or at scale.
* **Accuracy:** Properly distilled models can maintain nearly the same accuracy as their large teacher models.
* **Fairness & Accessibility:** Efficient models make advanced AI accessible for a wider range of schools and learners.

### Example Results

* KD student models in this project are up to 4,000x smaller and 10x faster than their teacher LLMs (e.g., fine-tuned BERT), with accuracy within 2-3% of the teacher.
* KD student models outperform both standard artificial neural networks and SOTA small transformer models like TinyBERT on automatic scoring tasks for science assessments.

### Workflow in `scalable_scoring.ipynb`:

1. **Train a Teacher Model:** Fine-tune a large language model (e.g., BERT) on science scoring data.
2. **Distill the Model:** Use the teacher’s output probabilities (soft labels) to train a much smaller student neural network via KD loss.
3. **Evaluate:** Compare student vs. teacher vs. TinyBERT/ANN on scoring accuracy, model size, and inference speed.
4. **Discuss Tradeoffs:** Consider the balance between efficiency, scalability, and accuracy for real-world education deployments.

---

### Citing the Knowledge Distillation Method

If you use this code or model in your research, please cite:

```
@article{latif2023knowledge,
  title={Knowledge distillation of llm for education},
  author={Latif, Ehsan and Fang, Luyang and Ma, Ping and Zhai, Xiaoming},
  booktitle={International Conference on Artificial Intelligence in Education},
  year={2024}
}
```

---

## requirements.txt

This project requires typical AI/ML libraries:

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

## Questions or Feedback?

Open an issue in this repository! We welcome questions, comments, and contributions.

---

*Last updated: June 2025*
