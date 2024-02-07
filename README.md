# ESDA Builder

This application presents a sequence of web forms that are used to build an ESDA submission

## Installation

To run this application, you will need Ruby and Postgres installed locally.

To install the app clone the application and then cd into the app root.
Then run the following commands:

- bundle
- rails javascript:build
- rails css:build
- rails db:create
- rails db:migrate

You should then be able to start a server instance using the command `rails s`.
The application should then be available at http://localhost:3000
