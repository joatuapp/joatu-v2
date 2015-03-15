[![Code
Climate](https://codeclimate.com/github/joatuapp/joatu-v2/badges/gpa.svg)](https://codeclimate.com/github/joatuapp/joatu-v2)
[![Build
Status](https://semaphoreapp.com/api/v1/projects/f723d0c2-dcfd-4b6a-9b3e-f4e30e0189ba/357065/badge.png)](https://semaphoreapp.com/joatu/joatu-v2)

# JoatU

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
- Ruby 2.1.3+
- Bundler
- Postgres 9.3+
- Postgis (Postgres Geo Extension) 2.1+

### Setup
The following commands will get you set up to begin develpment on JoatU:

1. Check out the code:
  - `git clone
  https://github.com/joatuapp/joatu-v2.git`
  - `cd joatu-v2`
  - `bundle install`

2. Set up environment:
  - `cp .env.example .env`
  - Edit .env file as necessary. SECRET_TOKEN, SECRET_KEY_BASE,
  DEVISE_SECRET, and DEVISE_PEPPER should all be set with values created by
  running `rake secret`

3. Set up the Database:
  - `foreman start db` (note: it will start then stay running for subsequent
  steps)
  - In a new terminal window, from the code path, run `rake db:setup`
  - In the original window, hit Ctl+C to stop the DB process.

4. Start the app server:
  - `foreman start`
  - Visit [localhost:3000](http://localhost:3000) to see the app!

On subsequent runs, simply change to the app directory and run `foreman start`
to start the app. In the terminal window while the app is running, hit Ctl+C at
any point to shut down the app. The JoatU app uses a custom postgres database
(stored in vendor/postgresql) and will start that database when `foreman start`
is run. If `foreman start` fails and you are running postgres for other 
projects, please try shutting down any other instances of postgrss, and then 
running `foreman start` again.
