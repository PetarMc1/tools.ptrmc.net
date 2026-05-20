# tools.ptrmc.net
This repository contains the source code for [tools.ptrmc.net](https://tools.ptrmc.net/), a collection of tools for developers.

It combines a few projects into one docker image, which is then deployed to [tools.ptrmc.net](https://tools.ptrmc.net/).


## Structure of the project
Details about the complicated structure of this repo :D 

### Submodules/Subprojects
GitRSS, openapi-merger and package-json-analyzer are added as submodules. Patches for each submodule are present at `/patches/<submodule name>`

### `/frontend`
The directory is a website thats is bridge between the 3 tools. It Includes the terms and FAQs of each tool.

### `/swagger-ui-docs` 
This directory is an html site that serves the API docs for the site.

### `/docker`
The nginx configuration and the start script for the docker image are located here

### Build tool
There is a build tool (`./build`) that is used to:
- apply patches
- create/generate patches
- update submodules
- hard reset submodules
- install dependencies on all projects
- build the docker image
- run a test docker image

For more info run `./build help` to see detailed info about each command

### Getting all together
Everything is held together in a docker image. 
Each project frontend is build and served using nginx and the APIs are build and ran using NodeJS.


## Deployment
Just use the example docker compose files thats provided:
```bash
git clone https://github.com/PetarMc1/tools.ptrmc.net
docker compose up -d
```


## Development

I do not recommend to try to develop on this project. But if you wish to heres a guide:

1. Apply patches to all submodules:
```bash
./build patch
```
2. Install dependencies on all projects:
```bash
./build install
```
3. Do the changes you want. If they are on nay of the submodules make sure you have committed the changes to the submodule and then create new patch files:
```bash
./build create-patch
```

4. Build the final docker image to check for errors:
```bash
./build build <tag of the image>
```
OR if you just want to test if it compiles you can run:
```bash
./build run <optional tag>
```
This runs a test container named `tools-test`, listening on port 80.

5. Commit the patches to your fork and submit a Pull Request.


## Licenses

[GitRSS](https://github.com/PetarMc1/GitRSS), [openapi-merger](https://github.com/PetarMc1/openapi-merger) and
[package-json-analyzer](https://github.com/PetarMc1/package-json-analyzer) are licensed under the Apache 2.0 License.
