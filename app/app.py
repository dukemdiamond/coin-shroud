import streamlit as st
import requests
import json
import pandas as pd
from pages import investor, developer, governing_body, average_person

# Set page configuration
st.set_page_config(
    page_title="CoinShroud Platform",
    page_icon="💰",
    layout="wide"
)

# Define API base URL
API_URL = "http://localhost:8502"  # Adjust this to your Flask API's address


def main():
    # Title and description
    st.title("CoinShroud Platform")
    st.subheader("Select Your User Role")

    # CSS to style the user persona buttons
    st.markdown("""
    <style>
    div.stButton > button {
        background-color: #4CAF50;
        color: white;
        padding: 15px 32px;
        text-align: center;
        text-decoration: none;
        display: inline-block;
        font-size: 16px;
        margin: 10px 2px;
        cursor: pointer;
        border-radius: 8px;
        border: none;
        width: 100%;
        height: 100px;
    }
    </style>
    """, unsafe_allow_html=True)

    # Create a 2x2 grid for persona buttons
    col1, col2 = st.columns(2)

    with col1:
        if st.button("👨‍💼 Investor"):
            st.session_state.user_persona = "investor"
            st.experimental_rerun()

        if st.button("👨‍⚖️ Governing Body"):
            st.session_state.user_persona = "governing_body"
            st.experimental_rerun()

    with col2:
        if st.button("👨‍💻 Developer"):
            st.session_state.user_persona = "developer"
            st.experimental_rerun()

        if st.button("👤 Average Person"):
            st.session_state.user_persona = "average_person"
            st.experimental_rerun()


# Initialize session state
if 'user_persona' not in st.session_state:
    st.session_state.user_persona = None

# Route to appropriate page based on selected persona
if st.session_state.user_persona == "investor":
    investor.show()
elif st.session_state.user_persona == "developer":
    developer.show()
elif st.session_state.user_persona == "governing_body":
    governing_body.show()
elif st.session_state.user_persona == "average_person":
    average_person.show()
else:
    main()


# Helper function for making API requests (can be used by all pages)
def api_request(endpoint, method="GET", data=None):
    url = f"{API_URL}{endpoint}"

    headers = {
        "Content-Type": "application/json"
    }

    try:
        if method == "GET":
            response = requests.get(url, headers=headers)
        elif method == "POST":
            response = requests.post(url, headers=headers, data=json.dumps(data))
        elif method == "PUT":
            response = requests.put(url, headers=headers, data=json.dumps(data))
        elif method == "DELETE":
            response = requests.delete(url, headers=headers)

        if response.status_code in [200, 201]:
            return response.json()
        else:
            st.error(f"API Error: {response.status_code} - {response.text}")
            return None
    except Exception as e:
        st.error(f"Connection Error: {str(e)}")
        return None