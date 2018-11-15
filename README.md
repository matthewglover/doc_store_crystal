# Doc Store

A web app built in Crystal for storing simple documents and related meta-data

## Installation

### Pre-requisites
- Crystal
- [Guardian](https://github.com/f/guardian) - for watching tests

### Optional
- Docker (for running Docker containers)
- psql (for connecting to the database)

### First run
- To install dependencies, run: `shards install`

## Usage

### Tests
To run the tests: `crystal spec`
To run and watch the tests (using guardian): `guadian`

### Build and run the Application
To run the application: `crystal run src/doc_store.cr`
To build the application: `crystal build --release src/doc_store.cr`
Once built, run the application on port 5000 (default is 3000) `./doc_store -p 5000`

### Building and running the application in Docker
To build the application: `ENV=[env] docker-compose build`
To run the application: `ENV=[env] docker-compose up`

### Database
To connect to the database: `psql -h localhost -U doc_store`

## Development

TODO: Write development instructions here

