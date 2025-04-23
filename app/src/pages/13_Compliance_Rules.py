import logging

logger = logging.getLogger(__name__)
import streamlit as st
from modules.nav import SideBarLinks
from modules.nav import api_request
import pandas as pd

SideBarLinks()

# set the header of the page
st.header('Compliance Rules')

st.write(f"### Welcome!")
user_type = st.session_state.get('role', 'developer') # default dev

curr_compliance_rules = api_request("/compliance_rules")
if curr_compliance_rules is not None:
    st.subheader("View Current Compliance Rules")
    df = pd.DataFrame(curr_compliance_rules)
    st.dataframe(df)

if user_type == 'governing_body':
    st.subheader("Update Compliance Rules")

    # user choice
    rule_options = {f"{rule['c_id']}: {rule['compliance_rules']}": rule['c_id'] for rule in curr_compliance_rules}
    selected_label = st.selectbox("Select a rule to update:", list(rule_options.keys()))
    c_id = rule_options[selected_label]

    with st.form("update_form"):
        rules = st.text_input("Updated rules:")
        submitted = st.form_submit_button("Submit")

        if submitted:
            payload = {
                "compliance_rules": rules
            }

            response = api_request(f"/compliance_rules/{c_id}", method="PUT", data=payload)

            if isinstance(response, dict) and response.get("error"):
                st.error(f"Error: {response['error']}")
            else:
                st.success("Compliance Rules updated successfully.")
                st.write(response)
