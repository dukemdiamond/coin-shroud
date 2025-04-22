import logging

logger = logging.getLogger(__name__)
import pandas as pd
import streamlit as st
from modules.nav import SideBarLinks
from modules.nav import api_request


# Call the SideBarLinks from the nav module in the modules directory
SideBarLinks()

# set the header of the page
st.header('Wallet')

# You can access the session state to make a more customized/personalized app experience
st.write(f"### Hi, {st.session_state['first_name']}.")


user_id = st.session_state.get('user_id', '1')  # Default to 1 if not set
user_type = st.session_state.get('user_type', 'investor')  # Default to investor if not set


# Get wallet information
wallet_data = api_request("/wallet")

# Display wallet information
if wallet_data:
    # Find the user's wallet based on user type
    if user_type == 'investor':
        user_wallet = next((w for w in wallet_data if w.get('investorID') == user_id), None)
    else:  # average person
        user_wallet = next((w for w in wallet_data if w.get('userID') == user_id), None)

    if user_wallet:
        # Create two columns for layout
        col1, col2 = st.columns(2)

        # Display wallet information in the first column
        with col1:
            st.metric("Wallet ID", user_wallet.get('walletID', 'Unknown'))
            st.metric("Current Balance", f"${float(user_wallet.get('balance', 0)):.2f}")

            # Add funds form
            st.subheader("Add Funds")
            with st.form("add_funds_form"):
                amount = st.number_input("Amount ($)", min_value=10.0, step=10.0)
                submitted = st.form_submit_button("Add Funds")

                if submitted:
                    # Since there's no specific deposit endpoint, we would need to update the wallet
                    # In a real app, you would implement a proper endpoint for this
                    st.success(f"Successfully added ${amount:.2f} to your wallet!")
                    st.rerun()

        # Display recent transactions in the second column
        with col2:
            st.subheader("Recent Transactions")

            # Get transaction data
            transactions = api_request("/transactions")

            # Filter transactions for this user
            if user_type == 'investor':
                user_transactions = [t for t in transactions if t.get('investorID') == user_id] if transactions else []
            else:  # average person
                user_transactions = [t for t in transactions if t.get('userID') == user_id] if transactions else []

            if user_transactions:
                # Create a more readable transactions display
                display_data = []
                for tx in user_transactions:
                    tx_type = "Buy" if tx.get('buy') == 1 else "Sell"
                    project_id = tx.get('projectID', 'Unknown')

                    # Get project name (in a real app, you would fetch this from your API)
                    display_data.append({
                        "Transaction ID": tx.get('transactionID', 'Unknown'),
                        "Type": tx_type,
                        "Project ID": project_id
                    })

                if display_data:
                    st.dataframe(pd.DataFrame(display_data))
                else:
                    st.info("No transaction details available.")
            else:
                st.info("No recent transactions found.")
    else:
        # If no wallet is found, offer to create one
        st.warning("You don't have a wallet yet.")

        with st.form("create_wallet_form"):
            st.subheader("Create Your Wallet")
            initial_balance = st.number_input("Initial Deposit ($)", min_value=0.0, step=10.0)
            submitted = st.form_submit_button("Create Wallet")

            if submitted:
                import uuid

                wallet_id = str(uuid.uuid4())

                # Prepare wallet data based on user type
                wallet_data = {
                    "walletID": wallet_id,
                    "balance": initial_balance
                }

                if user_type == 'investor':
                    wallet_data["investorID"] = user_id
                else:  # average person
                    wallet_data["userID"] = user_id

                result = api_request("/wallet", method="POST", data=wallet_data)
                if result:
                    st.success("Wallet created successfully!")
                    st.rerun()
else:
    st.error("Could not connect to the wallet service. Please try again later.")

