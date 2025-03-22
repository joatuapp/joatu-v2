[![Code Climate](https://codeclimate.com/github/joatuapp/joatu-v2/badges/gpa.svg)](https://codeclimate.com/github/joatuapp/joatu-v2)
[![Build Status](https://travis-ci.org/joatuapp/joatu-v2.svg?branch=master)](https://travis-ci.org/joatuapp/joatu-v2)
[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Fjoatuapp%2Fjoatu-v2.svg?type=shield)](https://app.fossa.io/projects/git%2Bgithub.com%2Fjoatuapp%2Fjoatu-v2?ref=badge_shield)

# JoatU

# This repository is not currently maintained and has since become outdated, but the ideas of JoatU live on and are still being worked on through other projects. Thank you for all of the hard work and interest. JoatU will be reborn in a new form one day.

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
  - `docker-compose run app bundle`

2. Set up environment:
  - You must create a [Google Maps API key](https://developers.google.com/maps/documentation/embed/get-api-key) before completing this next step
  - Once you have obtained your API key, you must add it to the environment file located at `<project_folder>/docker/.env.app.conf`. 
      - edit the file and add the following line to the end, replacing `<api_key_value>` with the API key that you created.
      - `GOOGLE_API_KEY=<api_key_value>`

3. Create the development and test databases
  - Run the following command, it will create the development and test databases in the postgres server
  - `docker-compose run app bundle exec rake db:setup`
4. Load seed data and create an initial admin user:
  - `docker-compose run app bundle exec rake db:seed INITIAL_ADMIN_EMAIL=joatu-admin@grr.la INITIAL_ADMIN_PASSWORD=password`
  - Log in to JoatU using email `joatu-admin@grr.la`, password `password`.
  - Once logged in, you will have access to administration tools from within
    the "Manage JoatU" menu.

5. Start up the app
  - run `docker-compose up app`
  - The app should now be available on `localhost:3000`



## License
[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Fjoatuapp%2Fjoatu-v2.svg?type=large)](https://app.fossa.io/projects/git%2Bgithub.com%2Fjoatuapp%2Fjoatu-v2?ref=badge_large)
