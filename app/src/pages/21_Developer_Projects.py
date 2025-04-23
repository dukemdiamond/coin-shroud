import logging

logger = logging.getLogger(__name__)
import pandas as pd
import streamlit as st
from modules.nav import SideBarLinks
from modules.nav import api_request


# Call the SideBarLinks from the nav module in the modules directory
SideBarLinks()

# set the header of the page
st.header('Developer Projects')

# You can access the session state to make a more customized/personalized app experience
st.write(f"### Hi, Developer {st.session_state['first_name']}.")

# Create
st.subheader("Create Project")
with st.form("create_form"):
    name = st.text_input("Project Name")
    status = st.selectbox("Status", ['active', 'pending', 'completed', 'suspended'])
    price = st.number_input("Price", min_value=0)
    quantity = st.number_input("Quantity", min_value=0)
    create_btn = st.form_submit_button("Create")

    if create_btn:
        payload = {
            "name": name,
            "status": status,
            "price": price,
            "quantity": quantity,
        }
        response = api_request("/projects", method="POST", data=payload)
        if isinstance(response, dict) and response.get("error"):
            st.error(response["error"])
        else:
            st.success("Project created!")

# Update
st.subheader("Update Project")
with st.form("update_form"):
    projectID = st.number_input("Project ID")
    name = st.text_input("Project Name")
    status = st.selectbox("Status", ['active', 'pending', 'completed', 'suspended'])
    price = st.number_input("Price", min_value=0)
    quantity = st.number_input("Quantity", min_value=0)
    update_btn = st.form_submit_button("Update")

    if update_btn:
        updated_load = {
            "projectID": projectID,
            "name": name,
            "status": status,
            "price": price,
            "quantity": quantity,
        }
        response = api_request("/projects", method="POST", data=updated_load)
        if isinstance(response, dict) and response.get("error"):
            st.error(response["error"])
        else:
            st.success("Project created!")

# Delete

st.subheader("Delete Project")
with st.form("delete form"):
    projectID = st.number_input("Project ID")
    delete_btn = st.form_submit_button("Delete")

    if delete_btn:
        response = api_request(f"/projects/{projectID}", method="DELETE")
        if isinstance(response, dict) and response.get("error"):
            st.error(response["error"])
        else:
            st.success(f" Project {projectID} deleted!")

