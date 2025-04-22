import logging

logger = logging.getLogger(__name__)
import pandas as pd
import streamlit as st
from modules.nav import SideBarLinks
from modules.nav import api_request


# Call the SideBarLinks from the nav module in the modules directory
SideBarLinks()

# set the header of the page
st.header('Portfolio')

# You can access the session state to make a more customized/personalized app experience
st.write(f"### Hi, {st.session_state['first_name']}.")

user_id = st.session_state.get('user_id', '1')  # Default to 1 if not set
user_type = st.session_state.get('user_type', 'investor')  # Default to investor if not set

if user_type == 'investor':
    portfolio_data = api_request(f"/investors/{user_id}/portfolio")
    if portfolio_data:
        col1, col2 = st.columns(2)
        with col1:
            st.metric("Portfolio ID", portfolio_data.get('portfolioID', 'Unknown'))
            st.metric("Investor ID", portfolio_data.get('investorID'))
            st.metric("Value", portfolio_data.get('value', 'Unknown'))

        with col2:
            st.metric("Holdings", portfolio_data.get('holdings', 'No Holdings'))
else:
    portfolio_data = api_request(f"/average_persons/{user_id}/portfolio")
    if portfolio_data:
        col1, col2 = st.columns(2)
        with col1:
            st.metric("Portfolio ID", portfolio_data.get('portfolioID', 'Unknown'))
            st.metric("User ID", portfolio_data.get('userID'))
            st.metric("Value", portfolio_data.get('value', 'Unknown'))

        with col2:
            st.metric("Holdings", portfolio_data.get('holdings', 'No Holdings'))



