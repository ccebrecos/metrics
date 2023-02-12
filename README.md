# Specification
_We want a Frontend + Backend application that allows you to post and visualize metrics. Each metric will have: Timestamp, name, and value. The metrics will be shown in a timeline and must show averages per minute/hour/day The metrics will be persisted in the database._

## General decisions
I've decided to provide both projects, backend and frontend, in separated folders inside the same repo.
I didn't want to overload this PoC adding extra logic with a tool as webpack to do it in a classic monorepo.

## Backend (metrics-api)
The metrics can be filtered by name and grouped by a period, computing the proper value average during the given period. That period of grouping can be specified using an ISO 8601 duration.

Stack used:
- RoR (3.2.0, 7.0.4.2)
- PostgreSQL (dockerized, 15.2-bullseye)

Layers used:
- Request validation using [dry-validation](https://dry-rb.org/gems/dry-validation/1.8/)
- Controller
- Services (for more complex business logic)
- Model
- View, using [Jb](https://github.com/amatsuda/jb)

For tests used:
- [rspec](https://rspec.info/)
- [Factory bot](https://github.com/thoughtbot/factory_bot), to ease models construction with random
- [Faker](https://github.com/faker-ruby/faker) to generate the mentioned random data

Tested services and controllers, as those are the layers where the logic is. Discarded to test models for this PoC since the only model is really simple.

### Setup
Inside `backend` folder:
Create a new file with the environment variables like the following, and replace the placeholders `<user>` and `<password>` with the proper values.

```.env
POSTGRES_USER= <user>
POSTGRES_PASSWORD= <password>
POSTGRES_DB=metrics_api_development

METRICS_DB_HOST=localhost
METRICS_DB_PORT=5432
METRICS_DB_DATABASE=metrics_api_development
METRICS_DB_USER= <user>
METRICS_DB_PASSWORD= <password>
```
export those variables to make them available from the console:
```bash
export $(grep -v '^#' .env | xargs)
```
and finally:

```bash
rake db:create
rake db:migrate
rake db:seed
```

Now, we're ready to start the server:
```bash
rails server -e development
```
And we'll have a server running locally listening in the default port, `3000`.

## Frontend (metrics-webapp)
- Angular (15.1.5) with Node (v16.14.0), NPM (8.3.1)
- Used [chart.js](https://github.com/chartjs/Chart.js) as a library for rendering the graphs
- Added [Angular Material](https://github.com/angular/components) for styling a bit the webapp
- Added [Tailwind CSS](https://tailwindcss.com/) for better styling the webapp


### Setup
Inside frontend folder:

```bash
npm install -D
npm run start
```

Now, we're ready! You can open a browser and navigate to the [main page](http://localhost:4200).

## General comments & further improvements
- All the setup could be dockerized to ease the deploy and the local management.

- Another different approach could have been to return all the metrics grouped by name and then displayed all together.
  - To achieve that, we could add `.group_by { |m| m.name }` instead of `.where(name: name)` in backend side (`Getter` service) and then
  add a new dataset using each group in frontend, combining all the data in the same graphic.

- A good next step would be adding users with authentication support and link the metrics to its related user.
