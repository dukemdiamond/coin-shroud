import logging

logger = logging.getLogger(__name__)
import pandas as pd
import streamlit as st
from modules.nav import SideBarLinks
from modules.nav import api_request
import html

SideBarLinks()

# set the header of the page
st.header('Education')

# You can access the session state to make a more customized/personalized app experience
st.write(f"### Hi, {st.session_state['first_name']}.")

education_list = api_request("/education")

if isinstance(education_list, list) and education_list:
    entry = education_list[0]
    st.subheader(f"Here is some educational content regarding Cryptocurrency. Stay safe while investing!")

    # Clean and format the text
    content = entry.get('information', '')
    content = html.unescape(content.replace("â€”", "—"))
    paragraphs = content.split("\n\n")

    for paragraph in paragraphs:
        st.markdown(paragraph.strip())
        st.markdown("")
else:
    st.info("No educational content available.")



