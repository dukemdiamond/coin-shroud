import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks

st.set_page_config(layout = 'wide')

# Show appropriate sidebar links for the role of the currently logged in user
SideBarLinks()

st.title(f"Welcome Average Person, {st.session_state['first_name']}.")
st.write('')
st.write('')
st.write('### What would you like to do today?')

if st.button('View Wallet',
             type='primary',
             use_container_width=True):
  st.switch_page('pages/01_Wallet.py')

if st.button('View Portfolio',
             type='primary',
             use_container_width=True):
  st.switch_page('pages/02_Portfolio.py')

if st.button('View Projects in the Market',
             type='primary',
             use_container_width=True):
  st.switch_page('pages/03_Projects.py')

if st.button('View Transactions',
             type='primary',
             use_container_width=True):
  st.switch_page('pages/04_Transactions.py')

if st.button('View Educational Crypto Information',
             type='primary',
             use_container_width=True):
  st.switch_page('pages/05_Education.py')

if st.button('View Withdrawals',
             type='primary',
             use_container_width=True):
  st.switch_page('pages/06_Withdrawals.py')