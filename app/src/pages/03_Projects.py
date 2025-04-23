import logging

logger = logging.getLogger(__name__)
import pandas as pd
import streamlit as st
from modules.nav import SideBarLinks
from modules.nav import api_request

# Call the SideBarLinks from the nav module in the modules directory
SideBarLinks()

# set the header of the page
st.header('Projects')

# You can access the session state to make a more customized/personalized app experience
st.write(f"### Hi, {st.session_state['first_name']}.")


user_id = st.session_state.get('user_id', '1')  # Default to 1 if not set
user_type = st.session_state.get('role', 'investor')  # Default to investor if not set

project_list = api_request("/projects")

if isinstance(project_list, list) and project_list:
    df = pd.DataFrame(project_list)
    st.subheader("All Projects")
    st.dataframe(df)
else:
    st.error("No project data returned.")

st.subheader("Search a specific project by ProjectID")
projectID = st.number_input("Enter ProjectID", min_value = 1, step= 1, value=1)
if projectID:
    specific_project_list = api_request(f"/projects/{projectID}")

    # Handle response as a list
    if isinstance(specific_project_list, list) and specific_project_list:
        specific_project_data = specific_project_list[0]

        col1, col2 = st.columns(2)
        with col1:
            st.metric("Project ID", specific_project_data.get('projectID'))
            st.metric("Name", specific_project_data.get('name'))
            st.metric("Status", specific_project_data.get('status'))
        with col2:
            st.metric("Price", specific_project_data.get('price'))
            st.metric("Quantity", specific_project_data.get('quantity'))
    else:
        st.error(f"No project found with ID: {projectID}")

