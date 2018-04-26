# base image from dockerhub
FROM microsoft/aspnetcore-build:2.0.5-2.1.4-jessie

# execute command to setup environment
RUN apt-get update && rm -rf /var/lib/apt/lists/*

# copy local files to container
COPY . /srv/ 

WORKDIR /srv/GirafRest

ENV ASPNETCORE_ENVIRONMENT=Production

# ensure correct dependencies are available
RUN dotnet restore

# perform any migrations necessary (according to the database context in repo)
RUN dotnet ef database update 

RUN dotnet build

ENTRYPOINT ["dotnet", "run", "--list"]
