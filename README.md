### common template

## Prerequisites
Make sure you have [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and [Docker desktop](https://www.docker.com/products/docker-desktop) installed.

## Installation 
Clone/git pull the repo into any local directory
```
git https://github.com/rcemper/GlobalStreams-to-SQL.git
```
Run the IRIS container with your project: 
```
docker-compose up -d --build
```
## How to Test it
```
docker-compose exec iris iris session iris
```
or use [Webterminal](http://localhost:42773/terminal/)
### Example 1 

 ![](https://raw.githubusercontent.com/rcemper/IRIS-fast-ECP-setup/master/CodeQuality.JPG)


