import logging

logger = logging.getLogger(__name__)
import streamlit as st
from modules.nav import SideBarLinks
from modules.nav import api_request

SideBarLinks()

# set the header of the page
st.header('Compliance')

# You can access the session state to make a more customized/personalized app experience
st.write(f"### Governing Body, Welcome!")

curr_compliance_rules = api_request("/compliance_rules")
if curr_compliance_rules:
    st.subheader("View Current Compliance Rules")
    df = pd.DataFrame(curr_compliance_rules)
    st.dataframe(df)

st.subheader("Update Compliance Rules")
with st.form("update_form"):
    c_id = curr_compliance_rules["c_id"]
    rules = st.text_input("Updated rules:")
    submitted = st.form_submit_button("Submit")

    if submitted:
        payload = {
            "c_id": c_id,
            "compliance_rules": rules
        }
        response = api_request("/compliance_rules", method="PUT", data = payload)
        if isinstance(response, dict) and response.get("error"):
            st.error(f"Error: {response['error']}")
        else:
            st.success("Compliance Rules updated successfully.")
            st.write(response)

