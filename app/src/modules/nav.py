# Idea borrowed from https://github.com/fsmosca/sample-streamlit-authenticator

# This file has function to add certain functionality to the left side bar of the app

import streamlit as st
import requests
import json

#### ------------------------ General ------------------------
def HomeNav():
    st.sidebar.page_link("Home.py", label="Home", icon="🏠")


def AboutPageNav():
    st.sidebar.page_link("pages/30_About.py", label="About", icon="🧠")


#### ------------------------ Role of investor/avg_person ------------------------
def InvestorNav():
    st.sidebar.page_link(
        "pages/00_Investor_Home.py", label="Investor Home", icon="📈"
    )

def WalletNav():
    st.sidebar.page_link(
        "pages/01_Wallet.py", label="Wallet", icon="💳"
    )

def ProjectsNav():
    st.sidebar.page_link("pages/03_Projects.py", label="Projects", icon="🗺️")


def TransactionsNav():
    st.sidebar.page_link("pages/05_Education.py", label="Education", icon="📕")


def WithdrawalsNav():
    st.sidebar.page_link(
        "pages/06_Withdrawals.py", label="Withdrawals", icon="📉"
    )

def PortfolioNav():
    st.sidebar.page_link(
        "pages/02_Portfolio.py", label="Portfolio", icon="💼"
    )

def AveragePersonNav():
    st.sidebar.page_link(
        "pages/10_Average_Person_Home.py", label="Average Person Home", icon="🚹"
    )

## Governing Body
def GoverningBodyNav():
    st.sidebar.page_link(
        "pages/11_Governing_Body_Home.py", label="Governing Body Home", icon="👨‍⚖️"
    )

def ComplianceNav():
    st.sidebar.page_link(
        "pages/12_Compliance.py", label="Compliance", icon="🔧"
    )

def ComplianceRulesNav():
    st.sidebar.page_link(
        "pages/13_Compliance_Rules.py", label="Compliance Rules", icon="📝"
    )

## Developer
def DeveloperNav():
    st.sidebar.page_link(
        "pages/20_Developer_Home.py", label="Developer Home", icon="💻"
    )

def DeveloperProjectsNav():
    st.sidebar.page_link(
        "pages/21_Developer_Projects.py", label="Developer Projects", icon="📽️"
    )





# --------------------------------Links Function -----------------------------------------------
def SideBarLinks(show_home=False):
    """
    This function handles adding links to the sidebar of the app based upon the logged-in user's role, which was put in the streamlit session_state object when logging in.
    """

    # add a logo to the sidebar always
    st.sidebar.image("assets/csd.png", width=3000)

    # If there is no logged in user, redirect to the Home (Landing) page
    if "authenticated" not in st.session_state:
        st.session_state.authenticated = False
        st.switch_page("Home.py")

    if show_home:
        # Show the Home page link (the landing page)
        HomeNav()

    # Show the other page navigators depending on the users' role.
    if st.session_state["authenticated"]:

        # if investor show
        if st.session_state["role"] == "investor":
            InvestorNav()
            WalletNav()
            ProjectsNav()
            TransactionsNav()
            WithdrawalsNav()
            PortfolioNav()

        # If the user role is avg person, show the Api Testing page
        if st.session_state["role"] == "average_person":
            AveragePersonNav()
            WalletNav()
            ProjectsNav()
            TransactionsNav()
            WithdrawalsNav()
            PortfolioNav()

        # If the user is an gov body, give them access to the gov body pages
        if st.session_state["role"] == "governing_body":
            GoverningBodyNav()
            ProjectsNav()
            ComplianceNav()
            ComplianceRulesNav()

        # if dev
        if st.session_state["role"] == "developer":
            DeveloperNav()
            ProjectsNav()
            ComplianceNav()
            ComplianceRulesNav()
            DeveloperProjectsNav()


    # Always show the About page at the bottom of the list of links
    AboutPageNav()

    if st.session_state["authenticated"]:
        # Always show a logout button if there is a logged in user
        if st.sidebar.button("Logout"):
            del st.session_state["role"]
            del st.session_state["authenticated"]
            st.switch_page("Home.py")

API_URL = "http://web-api:4000"
# Function to make API requests
def api_request(endpoint, method="GET", data=None):
    url = f"{API_URL}{endpoint}"

    headers = {
        "Content-Type": "application/json"
    }

    try:
        if method == "GET":
            response = requests.get(url, headers=headers)
        elif method == "POST":
            response = requests.post(url, headers=headers, data=json.dumps(data))
        elif method == "PUT":
            response = requests.put(url, headers=headers, data=json.dumps(data))
        elif method == "DELETE":
            response = requests.delete(url, headers=headers)

        if response.status_code in [200, 201]:
            return response.json()
        else:
            st.error(f"API Error: {response.status_code} - {response.text}")
            return None
    except Exception as e:
        st.error(f"Connection Error: {str(e)}")
        return None