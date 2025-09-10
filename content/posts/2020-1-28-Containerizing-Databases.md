---
layout: post
title: Adventures in Containerizing Databases
publishdate: 2020-01-28
updated: January 29, 2020
tags: ["docker"] 
---

I recently made a breakthrough by finally getting a handle on containerizing databases with Docker. If you don't already know, Docker is software that allows you to run software in isolated, virtual environments that contain all the necessary dependencies that said software needs to run. Therefore, Docker can considerably simplify both setting up development environments, and deploying software to production.

![docker-whale](https://zdnet2.cbsistatic.com/hub/i/r/2016/12/14/411ea5c5-dae7-4756-8cd3-d506a0675333/resize/770xauto/b90dbe53b50ee955f5b322262444bcea/docker-whale-1.jpg)
*I was making a similar face when I got this all worked out*

However, I won't get into a whole lot of technical details about Docker. For that, I've published a gist that you can read [here](https://gist.github.com/D-Bits/275a7ce6666590717da619c43f11d8df). Instead, I want to talk about how containerizing databases can be useful, as well as some of the challenges I encountered in my own learning process regarding the topic.

## Why Docker?

You may be asking: "why use Docker?" That is, why use Docker when one can simply download an installer, or install a DBMS via a package manager? Well, the fact of the matter is, installing and configuring database servers can be quite a bit of work, depending on one's level of familiarity with doing so. Therefore, if you're not very comfortable with installing and configuring server software, you might want to look into using Docker. The main reason I have been trying to master Docker is not because I hate installing and setting up database servers, but rather because I wanted to simplify setting up development environments for a variety of different technology stacks, pretty much all of which include a database. 

## Challenges

I cannot really speak for the challenges that others have faced in containerizing databases, therefore, I will only talk about the challenges that I personally have faced with setting up Docker databases here.
My main challenge by far, was simply trying to get data stored in my containerized database(s) to persist, so that I would not loose everything when I shut a container down. Beyond that, `docker-compose` mostly simplified things pretty nicely. 

## Going Forward

Now that I can easily setup containerize databases, and persist the data their holding, I can easily setup entire development environments without spending a bunch of time manually installing and configuring a bunch of dependencies. As a result, I plan on moving fully ahead with plans to stockpile various pre-configured Dockerfiles and `docker-compose` files for various different development environments. The repo for this project can be found [here](https://github.com/D-Bits/Docker-Configs).

## Summary

In spite of the struggles I faced, I am very glad that I have managed to successfully containerize databases, as no being able to has pretty much been the main barrier that has been preventing me from almost exclusively relying on Docker to setup development environments going forward. With that more-or-less behind me, I hope that configuring dev environments going forward will be a whole lot more simple for me. 

Again, if you want the technical details of how I figured this out, I referring you to this [gist](https://gist.github.com/D-Bits/275a7ce6666590717da619c43f11d8df).

<br>

Sincerely,

Dana

<br>