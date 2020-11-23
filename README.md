# Gustavo's Go Case Internship Challenge
*I am writing a complete document in English for the first time. So, forgive me for the poor English*
## Stack
  - Ruby 2.7.1
  - Rails 6
  - Postgres
**Gems**
    -    jsonapi-serializer
    -    rack-cors
    -    factory_bot_rails
    -    faker
    -    pry-rails
    -    rack-cors
    -    simplecov
    -    rspec-rails
    -    shoulda-matchers

## How run the app
Just clone the repository and with rails 6 and ruby in version 2.7.1 run:
`bundle install`, 
`rails db:create db:migrate`
## Link to Access
To facilitate the assessment of the challenge I uploaded the api on heroku, it can be accessed through the following link

`https://gustavo-internship-challenge.herokuapp.com/api/v1`
## Endpoint Documentation
In order to improve the understanding of how the api and its end points work I made a documentation using swagger that can be accessed by the following link
  `https://app.swaggerhub.com/apis/go-case-internship/gustavo-internship-challenge/1`
## How i structure my API:
  - I tried to use a full RESET pattern on my controllers. It means that i always created a new controller when i found an action with it cannot be described by the REST methods. I tried this to achieve a scalable standard for the entire controllers structure
  - For the format of the resquests, I chose that, whenever a parameter other than reference for an endpoint is needed, this parameter must be sent in the request body in json format.
  - I created two more endpoints, one for show a specific order end other to show a specifc batch. They were usefull to test the application via insommia
 
## Insommia Project
- I also created a small project on insomnia to make it easier to test the "flow" through the app's endpoints

the import file is in `public/gustavo-internshp-challenge-insommia.json`.
## Automated testing
- In order to create an application that is easier to maintain and evolve, I programmed automated tests using RSpec, Shoulda-matchers and Factorybot, for all endpoints requested on the challenge

Use  `bundle exec rspec` to run the tests

## Where i think i need to improve
- I believe the main point is the elegance of my code. I think it has a lot of conditional branches, especially when I try to handle exceptions and I have to deal with similar code that is repeated in different files, causing a little polluted code. I believe that a key point is to learn better how to manipulate via object orientation techniques, classes and structures of rails, in addition to obviously developing even more knowledge about ruby ​​and rails tools, such as jobs and services. I also believe that I have to improve the standards used in the responses.I'm really looking for that knowledge and I got a little better during the challenge, but I hope that the experience in the Go Case can help me take off in these matters.