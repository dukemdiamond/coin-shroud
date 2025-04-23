import logging

logger = logging.getLogger(__name__)
import pandas as pd
import streamlit as st
from modules.nav import SideBarLinks
from modules.nav import api_request


# Call the SideBarLinks from the nav module in the modules directory
SideBarLinks()

# set the header of the page
st.header('Withdrawals')

# You can access the session state to make a more customized/personalized app experience
st.write(f"### Hi, {st.session_state['first_name']}.")


user_id = st.session_state.get('user_id', '1')  # Default to 1 if not set
user_type = st.session_state.get('user_type', 'investor')  # Default to investor if not set

if user_type == 'investor':
    withdrawals_data = api_request(f"/withdrawals/investor/{user_id}")
else: #avg
    withdrawals_data = api_request(f"/withdrawals/average_person/{user_id}")

# Display data
if withdrawals_data:
    st.subheader("Your Withdrawals")
    df = pd.DataFrame(withdrawals_data)
    st.dataframe(df)
else:
    st.info("No withdrawal data found.")

wallet_data = api_request("/wallet")
wallet_balance = wallet_data['balance'] if wallet_data else 0

st.subheader("Request a withdrawal")
with st.form("withdrawal_form"):
    amount = st.number_input("Enter withdrawal amount", minvalue=0.1, format = "%.2f")
    submitted = st.form_submit_button("Submit")
    if submitted:
        if amount > wallet_balance:
            st.error(f"Insufficient balance. Your wallet has ${wallet_balance:.2f}")
        else:
            payload = {
                "amount": amount,
                "status": "pending",
                f"{'investorID' if user_type == 'investor' else 'userID'}": user_id
            }
            response = api_request("/withdrawals", method="POST", data=payload)

            if "error" in response:
                st.error("Withdrawal request failed.")
            else:
                st.success("Withdrawal request submitted successfully.")
                st.json(response)


