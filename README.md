# CoinShroud – Cryptocurrency Investment App

![COINSHROUDIMAGE](coinshroud.jpg)

CoinShroud is a crypto investment analytics and tracking app. It supports multiple user roles including
investors, average users, developers, and regulatory bodies. Users can view live data, track their holdings, submit
compliance reports, and more.

## Team Members

- Francis Qin
- Duke Diamond
- Alexander Lopez

---

## How to Build and Start the Project

### 1. Prerequisites

Make sure you have the following installed:

- Docker

- Docker Compose

- Git

- VSCode (recommended) with extensions for Python and Docker

### 2. Clone the Repository

Use the following commands to clone the repository and navigate into the project directory:

- `git clone` - git@github.com:dukemdiamond/coin-shroud.git

- `cd coinshroud`

### 3. Create a `.env` File

In the root directory of the project, create a `.env` file to store environment variables used by the application and
Docker containers.

You can create it using your text editor or with this terminal command:

- `touch .env`

Add environment variables like database credentials or secret keys inside this file as needed.
Do not commit the .env file to version control—it contains sensitive information.
