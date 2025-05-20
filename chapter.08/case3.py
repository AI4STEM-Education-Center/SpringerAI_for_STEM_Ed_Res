# ------------ cell 1 : install + imports -------------
# !pip install --quiet transformers accelerate sentencepiece

import torch
from transformers import AutoTokenizer, AutoModelForCausalLM, pipeline
import random, textwrap, json
import re
DEVICE = "cuda" if torch.cuda.is_available() else "cpu"
MODEL_ID = "path/to/your/model"

tokenizer = AutoTokenizer.from_pretrained(MODEL_ID)
model = AutoModelForCausalLM.from_pretrained(
    MODEL_ID,
    torch_dtype=torch.float16,
    device_map="auto",
)
llama = pipeline(
    "text-generation",
    model=model,
    tokenizer=tokenizer,
    max_new_tokens=256,
    temperature=0.4,
)

# ------------ cell 2 : synthetic data -------------
modules = [
    {"id": 1, "title": "Vectors & Vector Spaces", "level": "intro"},
    {"id": 2, "title": "Matrix Multiplication Drill", "level": "intro"},
    {"id": 3, "title": "Determinants & Geometry", "level": "intermediate"},
    {"id": 4, "title": "LU Decomposition Lab", "level": "intermediate"},
    {"id": 5, "title": "Eigenvalues Intuition", "level": "intermediate"},
    {"id": 6, "title": "Spectral Theorem Proof", "level": "advanced"},
    {"id": 7, "title": "Least-Squares Applications", "level": "intermediate"},
    {"id": 8, "title": "Singular Value Decomposition", "level": "advanced"},
    {"id": 9, "title": "Complex Vector Spaces", "level": "advanced"},
    {"id":10, "title": "Principal-Component Analysis Project", "level": "advanced"},
]

def random_profile():
    strengths = random.sample(
        ["vectors", "matrices", "row-reduction"], k=1)
    struggles = random.sample(
        ["determinants", "eigenvalues", "proof writing"], k=2)
    return dict(strengths=strengths, struggles=struggles)

learner = random_profile()

# ------------ cell 3 : build prompt -------------
module_str = "\n".join(
    f"{m['id']}. {m['title']} — {m['level']}" for m in modules)
profile_str = (
    f"Strengths: {', '.join(learner['strengths'])}; "
    f"Struggles: {', '.join(learner['struggles'])}"
)

prompt = textwrap.dedent(f"""
    You are an adaptive Linear-Algebra tutor.
    A learner profile and a list of 10 candidate modules follow.
    Choose EXACTLY three module IDs that best suit the learner's needs.
    Output a JSON array of objects with fields id and reason.

    === Learner Profile ===
    {profile_str}

    === Module Catalogue ===
    {module_str}

    Your answer:
""")
print(prompt)
# ------------ cell 4 : call LLaMA3-8B -------------
response = llama(prompt)[0]["generated_text"].split("Your answer:")[-1].strip()

# Extract JSON array part (will fail if the response is not a valid JSON array)
match = re.search(r'\[\s*{.*?}\s*\]', response, re.DOTALL)
if match:
    json_part = match.group(0)
    parsed = json.loads(json_part)
    print("Parsed JSON output →", parsed)
else:
    print("Failed to extract JSON from response.")

