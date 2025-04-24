import logging

logger = logging.getLogger(__name__)
import pandas as pd
import streamlit as st
from modules.nav import SideBarLinks
from modules.nav import api_request
import datetime


# Call the SideBarLinks from the nav module in the modules directory
SideBarLinks()

# set the header of the page
st.header('Withdrawals')

# You can access the session state to make a more customized/personalized app experience
st.write(f"### Hi, {st.session_state['first_name']}.")


user_id = st.session_state.get('user_id', '1')  # Default to 1 if not set
user_type = st.session_state.get('role', 'investor')  # Default to investor if not set

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


def get_wallet_balance():
    wallet_data = api_request("/wallet")
    return wallet_data[0].get('balance', 0) if wallet_data else 0

wallet_balance = get_wallet_balance()

st.subheader("Request a withdrawal")
with st.form("withdrawal_form"):
    amount = st.number_input("Enter withdrawal amount", min_value=0.1, format = "%.2f")
    submitted = st.form_submit_button("Submit")
    if submitted:
        if amount > wallet_balance:
            st.error(f"Insufficient balance. Your wallet has ${wallet_balance:.2f}")
        else:
            today_str = datetime.date.today().strftime('%Y-%m-%d')
            payload = {
                "amount": amount,
                "status": "pending",
                "date": today_str,
            }

            # Investor vs. Average Person Handling
            if user_type == 'investor':
                payload["investorID"] = user_id
            else:
                payload["userID"] = user_id

            response = api_request("/withdrawals", method="POST", data=payload)

            if "error" in response:
                st.error("Withdrawal request failed.")
            else:
                st.success("Withdrawal request submitted successfully.")

                # refresh balance after withdrawing
                wallet_balance = get_wallet_balance()
                st.json(response)

if st.button("Refresh Withdrawals"):
    st.rerun()



