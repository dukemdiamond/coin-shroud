import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks

st.set_page_config(layout = 'wide')

# Show appropriate sidebar links for the role of the currently logged in user
SideBarLinks()

st.title(f"Welcome Governing Body!")
st.write('')
st.write('')
st.write('### What would you like to do today?')

if st.button('View Projects in the Market',
             type='primary',
             use_container_width=True):
  st.switch_page('pages/03_Projects.py')

if st.button('View and Update Compliance Reports',
             type='primary',
             use_container_width=True):
  st.switch_page('pages/12_Compliance.py')

if st.button("View and Update Compliance Rules",
             type='primary',
             use_container_width=True):
  st.switch_page('pages/13_Compliance_Rules.py')