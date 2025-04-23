import logging

logger = logging.getLogger(__name__)
import pandas as pd
import streamlit as st
from modules.nav import SideBarLinks
from modules.nav import api_request


# Call the SideBarLinks from the nav module in the modules directory
SideBarLinks()

# set the header of the page
st.header('Transactions')

# You can access the session state to make a more customized/personalized app experience
st.write(f"### Hi, {st.session_state['first_name']}.")


user_id = st.session_state.get('user_id', '1')  # Default to 1 if not set
user_type = st.session_state.get('user_type', 'investor')  # Default to investor if not set


# Get wallet information
all_transactions = api_request("/transactions")

if all_transactions:
    if user_type == 'investor':
        st.subheader("Your Transactions")
        investor_transactions = api_request(f"/transactions/investor/{user_id}")
        st.dataframe(pd.DataFrame(investor_transactions))
    elif user_type == 'average_person':
        st.subheader("Your Transactions")
        user_transactions = api_request(f"/transactions/average_person/{user_id}")
        st.dataframe(pd.DataFrame(user_transactions))

st.subheader("Create a transaction")
with st.form("transaction_form"):
    project_id = st.text_input("Project ID")
    transaction_type = st.selectbox("Transaction Type", ["Buy", "Sell"])

    submitted = st.form_submit_button("Submit Transaction")
    if submitted:
        payload = {
            "projectID": project_id,
        }
        if user_type == 'investor':
            payload["investorID"] = user_id
        else:
            payload["userID"] = user_id

        if transaction_type == "Buy":
            payload["buy"] = True
        else:
            payload["sell"] = True

        response = api_request("/transactions", method="POST", data=payload)

        if 'error' in response:
            st.error(response['error'])
        else:
            st.success("Transaction created!")
            st.json(response)


