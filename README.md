# Auction Application
This application is just an example of what can be a real auction application. It offers some features like:
- A list with auction items being auctioned
- Any user can make a new bid on an auction item
- An auto-bidding ability on auction items
- An auction timer until auction items get expired

## Technologies
|Tech|Version|
|---|---|
|Postgres|Latest|
|PHP|7.4-fpm-alpine|

## Dependencies
1. [Docker](https://www.docker.com/)
2. [docker-compose](https://docs.docker.com/compose/)
3. (*Optional*) [Make](https://www.gnu.org/software/make/)

## Where to start?
To initialize the application and navigate on them, you have two options

### Using Makefile
We had prepared a [makefile](https://www.gnu.org/software/make/manual/make.html#Makefile-Contents) to initialize the application for you. You must just run:
```sh
make
```
and all will be initialized. After run this command, log application container execution using: `docker-compose log -f app`, and wait untill you see:
```sh
[20-Apr-2021 01:59:41] NOTICE: ready to handle connections
```
Now, you can access: [http://localhost]

## XDebug
The project has [xdebug](https://xdebug.org/) installed. You can use it with the following IDEs/Text Editors

### Xdebus with VScode
To use xdebug on vscode, create a file on the root project with the name and path: `.vscode/lauch.json`, and paste the body below:
```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Listen for XDebug",
            "type": "php",
            "request": "launch",
            "port": 9000,
            "log": false,
            "stopOnEntry": false,
            "pathMappings": {
                "/var/www/html": "${workspaceRoot}/",
            }
        }
    ]
}
```

## Running tests
### Back-end tests
If you have installed **Make**, just run:
```sh
make test-back-end
```
If you doesn't have make:
```sh
docker-compose exec -T app composer test
```
