from flask import Flask, request, jsonify
from flask_cors import CORS
from transformers import BertForSequenceClassification, BertTokenizer
import torch
import random

app = Flask(__name__)
CORS(app)

# Load model and tokenizer
path = "./mental_health_classifier"
model = BertForSequenceClassification.from_pretrained(path, local_files_only=True)
tokenizer = BertTokenizer.from_pretrained(path, local_files_only=True)

label_map = {
    'LABEL_0': 'Depression and Suicidal',
    'LABEL_1': 'Normal',
    'LABEL_2': 'Mood and Anxiety Disorders'
}

questions = {
    'Depression and Suicidal': [
        "Can you describe a recent moment when you felt completely hopeless or lost?",
        "Could you share your thoughts on whether your life feels meaningful at this moment?",
        "What do you find yourself thinking about most often when you're alone?",
        "Describe your sleep patterns recently. Have you noticed any major changes, and how are these changes affecting your daily routine?",
        "Have you lost interest in things you once enjoyed? Could you explain how your feelings toward these activities have changed?",
        "Can you talk about your appetite or eating habits lately? Have you noticed any significant changes?",
        "Describe how you've been interacting with friends or family recently. Has anything significantly changed?",
        "Have you been experiencing overwhelming feelings of sadness recently? Can you share what's been contributing to these feelings?",
        "Tell me about your motivation levels these days. What seems to affect them most?",
        "Do you often find yourself experiencing thoughts about harming yourself or ending your life? Can you elaborate on these thoughts?",
        "When was the last time you felt genuinely happy or excited? Describe that experience and what has changed since then.",
        "Could you describe a situation in your life currently that makes you feel trapped or helpless?",
        "What is your outlook on your future right now? Explain why you feel this way.",
        "Have you ever written or thought deeply about suicide or death? If so, can you describe those moments?",
        "Can you explain how frequently and intensely you've been experiencing feelings of worthlessness or guilt?"
    ],
    'Mood and Anxiety Disorders': [
        "Can you describe a recent situation that triggered intense feelings of anxiety or worry for you?",
        "How do you typically react physically and mentally when you're extremely anxious or stressed?",
        "Could you discuss any repetitive or obsessive thoughts you've experienced lately?",
        "Can you share a scenario in which you felt sudden shifts in your mood without an obvious reason?",
        "Have you experienced episodes of extreme fear or panic recently? Describe your experience in detail.",
        "Can you describe situations or places you actively avoid because they provoke anxiety or distress?",
        "Tell me about a recent experience where you found yourself feeling irritable or agitated without fully understanding why.",
        "How would you describe your concentration or focus levels lately? Are certain thoughts or worries interrupting them?",
        "Can you explain how your sleep has been affected by worry or anxiety lately?",
        "Describe how feelings of nervousness or anxiety affect your daily interactions and activities.",
        "Have you recently experienced moments when you felt emotionally unstable or overly sensitive? Could you elaborate on that?",
        "Do you ever experience physical symptoms (like trembling, sweating, nausea, or rapid heartbeat) when feeling anxious? Describe an instance.",
        "Could you describe your current coping strategies when experiencing anxiety or mood fluctuations?",
        "Have you noticed yourself being overly concerned or fixated about certain issues lately? Explain in detail.",
        "Could you describe your energy levels and how they've fluctuated in recent days or weeks?"
    ],
    'Normal': [
        "Describe a recent experience that made you feel genuinely content or satisfied with life.",
        "How do you typically handle stress or difficult situations in your daily life? Can you give an example?",
        "Can you describe how your relationships with family or friends are currently going? What's working well?",
        "Describe something you're currently passionate about or deeply interested in and why it matters to you.",
        "Tell me about a recent accomplishment or achievement you're proud of.",
        "How would you describe your usual sleep patterns and overall quality of sleep?",
        "Can you talk about a personal goal you're working toward right now? What's motivating you to achieve it?",
        "Describe how you usually spend your free time or what you do for enjoyment.",
        "Share an experience recently where you felt optimistic or excited about the future.",
        "How would you describe your typical energy levels throughout the day?",
        "Can you explain how you generally deal with negative emotions or temporary setbacks?",
        "Tell me about something you're looking forward to in the near future and why.",
        "How would you describe your appetite or eating habits generally? Have there been any significant changes lately?",
        "Can you share your approach to maintaining balance between your personal life, work, or studies?",
        "Describe the last activity or interaction that left you feeling fulfilled or happy."
    ]
}

# Max questions per session
MAX_QUESTIONS = 3

session_data = {}

@app.route('/start', methods=['POST'])
def start_session():
    session_id = request.json.get('sessionId')
    if session_id not in session_data:
        session_data[session_id] = {
            "scores": {'Depression and Suicidal': 0, 'Normal': 0, 'Mood and Anxiety Disorders': 0},
            "current_category": 'Normal',
            "asked_questions": set(),
            "questions_asked_count": 0,
            "completed": False
        }
    return jsonify({"message": "Session started", "category": "Normal"})

@app.route('/ask', methods=['POST'])
def get_question():
    session_id = request.json.get('sessionId')
    if session_id not in session_data:
        return jsonify({"error": "Session not found"}), 400

    data = session_data[session_id]

    # If max questions reached or session completed, send done
    if data['completed'] or data['questions_asked_count'] >= MAX_QUESTIONS:
        data['completed'] = True
        return jsonify({
            "done": True,
            "message": "Max questions reached.",
            "final_scores": data['scores'],
            "most_probable_status": max(data['scores'], key=data['scores'].get),
            "total_questions": data['questions_asked_count']
        })

    category = data["current_category"]
    asked = data["asked_questions"]
    available_questions = [q for q in questions[category] if q not in asked]

    if not available_questions:
        # If no questions left in category, also consider session done
        data['completed'] = True
        return jsonify({
            "done": True,
            "message": "No more questions in this category.",
            "final_scores": data['scores'],
            "most_probable_status": max(data['scores'], key=data['scores'].get),
            "total_questions": data['questions_asked_count']
        })

    question = random.choice(available_questions)
    asked.add(question)
    data['questions_asked_count'] += 1

    return jsonify({"question": question, "category": category})

@app.route('/respond', methods=['POST'])
def classify_response():
    session_id = request.json.get('sessionId')
    user_input = request.json.get('userInput')

    if session_id not in session_data:
        return jsonify({"error": "Session not found"}), 400

    inputs = tokenizer(user_input, truncation=True, padding=True, return_tensors="pt")
    with torch.no_grad():
        outputs = model(**inputs)
    logits = outputs.logits
    pred_idx = torch.argmax(logits, dim=-1).item()
    label = label_map[f"LABEL_{pred_idx}"]

    data = session_data[session_id]
    data['scores'][label] += 1
    data['current_category'] = label

    return jsonify({
        "classification": label,
        "next_category": label,
        "scores": data['scores']
    })

@app.route('/summary', methods=['POST'])
def summary():
    session_id = request.json.get('sessionId')
    if session_id not in session_data:
        return jsonify({"error": "Session not found"}), 400

    scores = session_data[session_id]['scores']
    total = session_data[session_id]['questions_asked_count']
    highest = max(scores, key=scores.get)

    return jsonify({
        "final_scores": scores,
        "most_probable_status": highest,
        "total_questions": total
    })

if __name__ == '__main__':
    app.run(port=5000)
