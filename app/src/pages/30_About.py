import streamlit as st
from streamlit_extras.app_logo import add_logo
from modules.nav import SideBarLinks

SideBarLinks()

st.write("# About this App")

st.markdown (
    """
    CoinShroud is a crypto investment analytics and tracking app. 
    It supports multiple user roles including investors, average users, developers, and regulatory bodies. 
    Users can view live data, track their holdings, submit compliance reports, and more.
    """
        )
