# page_scrapper
Scrapes a URL and stores the contents. It provides a RESTful API to index a page's content.

# Configurations
- Ruby: 2.2.4
- Rails: 4.2.7
- Database: PostgreSQL

# Installation instructions

- git clone `git:@github.com:BoTreeConsultingTeam/page_scrapper.git`
- Go to root directory of page_scrapper
- `bundle install`
- Configure database.yml as per your local settings
- Create database by executing command `rake db:create`
- Perform database migrations by `rake db:migrate`
- All the API calls and endpoints are listed in wiki
- To execute the API calls start the rails server by `rails s`
- To run the tests execute `rake test`

# Future Enhancements 

- Move the scrapping logic into sidekiq workers to make it more scalable
- Ignore links like #, javascript etc before saving to database
