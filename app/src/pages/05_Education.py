import logging

logger = logging.getLogger(__name__)
import pandas as pd
import streamlit as st
from modules.nav import SideBarLinks
from modules.nav import api_request

SideBarLinks()

# set the header of the page
st.header('Education')

# You can access the session state to make a more customized/personalized app experience
st.write(f"### Hi, {st.session_state['first_name']}.")

education = api_request("/education")

if education:
    st.markdown(education)
else:
    st.info("No educational content available.")




