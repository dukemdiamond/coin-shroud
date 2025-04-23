import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks

st.set_page_config(layout = 'wide')

# Show appropriate sidebar links for the role of the currently logged in user
SideBarLinks()

st.title(f"Welcome Developer, {st.session_state['first_name']}.")
st.write('')
st.write('')
st.write('### What would you like to do today?')

if st.button('View Projects in the Market',
             type='primary',
             use_container_width=True):
  st.switch_page('pages/03_Projects.py')

if st.button('Create, Update, or Delete Projects',
             type='primary',
             use_container_width=True):
  st.switch_page('pages/02_Portfolio.py')

if st.button('View Compliance Reports',
             type='primary',
             use_container_width=True):
  st.switch_page('pages/12_Compliance.py')
