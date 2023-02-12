# Specification 3 (better for senior)
We want a Frontend + Backend application that allows you to post and visualize metrics. Each metric will have: Timestamp, name, and value. The metrics will be shown in a timeline and must show averages per minute/hour/day The metrics will be persisted in the database.

## General decisions
I've decided to provide both projects, backend and frontend , in separated folders inside the same repo.
I didn't want to overload this PoC adding extra logic with a tool as webpack to do it in a classic monorepo.

## Backend (metrics-api)
Stack used:
- RoR (3.2.0, 7.0.4.2)
- PostgreSQL (dockerized, 15.2-bullseye)

Layers used:
- Request validation using [dry-validation](https://dry-rb.org/gems/dry-validation/1.8/)
- Controller
- Services (more complex business logic)
- Model
- View, using [Jb](https://github.com/amatsuda/jb)

For tests layer used:
- [rspec](https://rspec.info/)
- [Factory bot](https://github.com/thoughtbot/factory_bot), to ease models construction with random
- [Faker](https://github.com/faker-ruby/faker) to generate the mentioned random data

## Frontend (metrics-webapp)
Stack used:
- Angular (15.1.5) with Node (v16.14.0), NPM (8.3.1)
- Use [chart.js](https://github.com/chartjs/Chart.js) as a library for rendering the graphs
- Added [Angular Material](https://github.com/angular/components) for styling a bit the webapp
- Added [Tailwind CSS](https://tailwindcss.com/) for better styling the webapp.