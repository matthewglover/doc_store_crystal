# Doc Store

A web app built in Crystal for storing simple documents and related meta-data

## Installation

### Pre-requisites
- Crystal
- [Guardian](https://github.com/f/guardian) - for watching tests
- Docker (for running Docker containers)


## Usage

### Tests
To run the tests: `crystal spec`
To run and watch the tests (using guardian): `guadian`

### Build and run the Application
To run the application: `crystal run src/doc_store.cr`
To build the application: `crystal build --release src/doc_store.cr`
Once built, run the application on port 5000 (default is 3000) `./doc_store -p 5000`

### Building and running the application in Docker
To run the application in Docker: `docker-compose up`


## Development

TODO: Write development instructions here

