[![Code Climate](https://codeclimate.com/github/joatuapp/joatu-v2/badges/gpa.svg)](https://codeclimate.com/github/joatuapp/joatu-v2)
<!-- [![Build
Status](https://semaphoreapp.com/api/v1/projects/f723d0c2-dcfd-4b6a-9b3e-f4e30e0189ba/357065/badge.png)](https://semaphoreapp.com/joatu/joatu-v2) -->

# JoatU

## Contents
- About the project
- Contributing
- Development Setup (Docker)
    - Requirements
    - Installation
    - Configuration
    - Running the application

## About the Project
The Jack Of All Trade Universe is an online marketplace for self-organized
exchanges. The JoatUnit is a currency that is generated to promote community
activities such as planting community gardens or teaching classes. More
information can be found at [joatu.com](http://www.joatu.com)

## Contributing
JoatU is created and maintained by Volunteers, and we would love your help.
Please feel free to check out our
[issues](https://github.com/joatuapp/joatu-v2/issues) and if you fix something, send us
a [pull request](https://github.com/joatuapp/joatu-v2/pulls)!

### Dependencies
#### Development Dependencies
- Docker
- Docker Compose

#### Production Dependencies
- Ruby 2.4.5+
- Bundler
- Postgres 9.3+
- Postgis (Postgres Geo Extension) 2.1+

### Setup
The following commands will get you set up to begin develpment on JoatU:

1. Check out the code:
  - `git clone https://github.com/joatuapp/joatu-v2.git`
  - `cd joatu-v2`
  - `docker-compose build`

2. Set up environment:
  - You must create a [Google Maps API key](https://developers.google.com/maps/documentation/embed/get-api-key) before completing this next step
  - Once you have obtained your API key, you must add it to the environment file located at `<project_folder>/docker/.env.app.conf`. 
      - edit the file and add the following line to the end, replacing `<api_key_value>` with the API key that you created.
      - `GOOGLE_API_KEY=<api_key_value>`


3. Load seed data and create an initial admin user:
  - `docker-compose run app bundle exec rake db:seed INITIAL_ADMIN_EMAIL=joatu-admin@grr.la INITIAL_ADMIN_PASSWORD=password`
  - Log in to JoatU using email `joatu-admin@grr.la`, password `password`.
  - Once logged in, you will have access to administration tools from within
    the "Manage JoatU" menu.

4. Start up the app
  - run `docker-compose up app`
  - The app should now be available on `localhost:3000`

