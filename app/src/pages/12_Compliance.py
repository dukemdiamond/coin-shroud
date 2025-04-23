import logging

logger = logging.getLogger(__name__)
import pandas as pd
import streamlit as st
from modules.nav import SideBarLinks
from modules.nav import api_request

# Call the SideBarLinks from the nav module in the modules directory
SideBarLinks()

# set the header of the page
st.header('Compliance')

# You can access the session state to make a more customized/personalized app experience
st.write(f"### Welcome!")

user_type = st.session_state.get('role', 'developer') # default dev

curr_compliance_reports = api_request("/compliance")
if curr_compliance_reports:
    st.subheader("Current Compliance Reports")
    df = pd.DataFrame(curr_compliance_reports)
    st.dataframe(df)

st.subheader("View Compliance Report for Specific projectID")
with st.form("report_form"):
    projectID = st.number_input("Enter projectID")
    submitted = st.form_submit_button("Submit")
    if submitted:
        specific_compliance_report = api_request(f"/compliance/{projectID}")
        if specific_compliance_report:
            st.subheader(f"Specific Compliance Report for project {projectID}")
            df = pd.DataFrame(specific_compliance_report)
            st.dataframe(df)
        else:
            st.error(f"No compliance report for {projectID}")
if user_type == 'governing_body':
    st.subheader("Update Compliance Report for Specific projectID")

    # dropdown logic
    projects_data = api_request("/projects")
    if not projects_data or not isinstance(projects_data, list):
        st.error("Failed to fetch project list.")
        st.stop()


    project_options = {f"{proj['projectID']} - {proj.get('name', 'Unnamed')}": proj['projectID'] for proj in
                       projects_data}
    selected_project_label = st.selectbox("Select a project to update:", list(project_options.keys()))
    project_id = project_options[selected_project_label]

    with st.form("update_form"):
        is_compliant = st.selectbox("Is Compliant?", [True, False])
        report_date = st.date_input("Report Date")  # returns a datetime.date
        regulator_id = st.text_input("Regulator ID", max_chars=36)

        submitted = st.form_submit_button("Update Report")

        if submitted:
            report_date_str = report_date.strftime('%Y-%m-%d')

            payload = {
                "isCompliant": is_compliant,
                "reportDate": report_date_str,
                "regulatorID": regulator_id
            }

            response = api_request(f"/compliance/{project_id}", method="PUT", data=payload)

            if isinstance(response, dict) and response.get("error"):
                st.error(f"Error: {response['error']}")
            else:
                st.success("Compliance report updated successfully.")
                st.write(response)






