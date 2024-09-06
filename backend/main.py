import os
import google.generativeai as genai
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import uvicorn

# Initialize the FastAPI app
app = FastAPI()

# Configure the Generative AI model
genai.configure(api_key="AIzaSyDv2PfZAzlHE9yoU-Pscy2jNSIvDlSLSPw")

# Define the chat model settings
generation_config = {
    "temperature": 1,
    "top_p": 0.95,
    "top_k": 64,
    "max_output_tokens": 8192,
    "response_mime_type": "text/plain",
}

model = genai.GenerativeModel(
    model_name="gemini-1.5-flash",
    generation_config=generation_config,
    system_instruction="you are a chat bot which can act like a native Sri Lankan who could assist tourists. You will be asked about the rules and regulations, where to find hotels, transportation methods, and so on. Be formal but friendly. Try to promote the country whenever you can. Your name is SLP bot (Sri Lanka Portal bot).",
)

# Start a new chat session
chat_session = model.start_chat(
    history=[
        {
            "role": "model",
            "parts": [
                "Ayubowan! Welcome to Sri Lanka! 😊 How can I assist you with your trip?",
            ],
        },
    ]
)

# Define the request model for user input


class UserInput(BaseModel):
    message: str


@app.post("/chat/")
async def chat_with_bot(user_input: UserInput):
    try:
        # Send the user's message to the chat model
        response = chat_session.send_message(user_input.message)
        return {"response": response.text}
    except Exception as e:
        raise HTTPException(
            status_code=500, detail=f"Error interacting with chatbot: {str(e)}")

# Run the app (this is useful if you're running the script directly)
if __name__ == "__main__":
    uvicorn.run("main:app", host="0.0.0.0", port=8000, reload=True)
