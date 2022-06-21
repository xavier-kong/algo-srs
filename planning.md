/home
    show stats overview like streak and cards to study etc
/deck/[deckName]/study
    where the studying happens
    rep cards essentially, with a timer
/deck/[deckName]/add
    add cards to deck
    name, link, inital time, first date of completion, needed answer?, solution
/stats
    detailed stats breakdown
/login
    to login
/signup
    to signup
/
    intro home page?



v1: only the srs bit\
    26/6 1. study page                with local backend and tests, with CI/CD pipeline, and migrate relevant data
    3/7  2. addding page              with local backend and tests, with CI/CD pipeline, and migrate relevant data
    10/7 3. home page                 with local backend and tests, with CI/CD pipeline, and migrate relevant data
    17/7 4. stats page                with local backend and tests, with CI/CD pipeline, and migrate relevant data
    24/7 5. user admin (login/signup) with local backend and tests, with CI/CD pipeline, and migrate relevant data
    31/7 6. backend deployed to aws with lambda and whatever postgres service migrate all existing data to service
    7/8  7. front end deployed to cdn or vercel and migrate all existing data to service

v2: code within the site