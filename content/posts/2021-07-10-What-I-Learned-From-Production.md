---
title: What I've Learned from Maintaining a Web App in Production for Over a Year
publishdate: 2021-07-23
tags:
  - python
  - automation
  - other
draft: false
---

It has been more than a year now since I originally deployed my [COVID-19 Tracker](https://covid19-reporting.herokuapp.com/) to a live environment. In the time that it has been in production, I have learned a whole lot, both in terms of maintaining an app in production, and in watching the progression of the pandemic. 

At the very least, I have definitely come to truly appreciate how essential having something deployed to a live environment is to the learning process of being a good developer. To summarize, here are some of the most important things I've learned from this experience.

## Simplify and Automate Deployments as Much as Possible

This was a key objective of mine from the moment I decided to deploy this project to a live environment. Regardless of what technologies or production environment one is using, deployments should be as simple, intuitive, and easily reproducible as possible. Fortunately, Heroku makes deploying from a remote Git repository via pipeline very easy to set up. I did my very first deployment using this setup, and have stuck with it ever since. 

## Prioritize Good Code Organization from the Beginning 

This is definitely a lesson that I wish I kept in mind from the beginning, but I guess hindsight is 20/20. When I first converted this project from a simple command line program to a web application, I ended up dumping pretty much all my routing/controller logic into a single `app.py` file. At first, this worked out well enough and, given that Flask doesn't box one into structuring their application in a specific manner like Django does, I could get away with this. However, a soon as I started to look into integrating U.S.-specific data into my application, I realized how much of a mistake I had made, as well as how much I needed to re-organize my code base. So, I cleaned things up, and organized the codebase in Flask "blueprints", which has removed a lot of headache. That said, I have no illusions how much time I may have saved, if I had organized my project this way from the beginning, but again, hindsight is 20/20. 

## Unit Testing is Essential, but Not Infallible 

While I have pretty consistently prioritized comprehensive test coverage for this projects, and it certainly has served me well, there are still a number of problems I have encountered that unit tests alone could not catch. For problems with the app's logic, I have sometimes had to dive into the environment's logs to find out what was wrong. For example, a page might load, but not display any data. In other cases, such as CSS-related stuff, it was pure trial-and-error, with no breadcrumbs to follow. None of this is to suggest that I couldn't solve these problems, only that unit testing is not a silver bullet, but essential nonetheless.

## Certain Problems Don't Become Apparent, Until Its Been in Production For a Bit

For better, or for worse, things work differently in production than they do in one's strictly local dev environment. Consequently, things you may not have even considered as potential problems might gradually emerge over time as your project has been live for a bit. It could be something like a missing, or outdated, dependency in your production environment. It could also be something like scalability issues that only become apparent as your user base grows. Also, you might find out (as detailed above) that you haven't organized your codebase in a manner that is easily maintainable in the long run, and that one must revisit a lot of early design choices. 

## Conclusions, and the Future

Ultimately, the process of setting up deployments was not nearly as painfully as I was originally expecting it to be. I'm very much grateful for that. Also, it has been quite interesting, albeit frustrating at times, to see the miscellaneous problems that have popped up over the time this web app has been in production. At the moment, I am undertaking the daunting task of re-writing a lot of application logic (again) to accommodate new data sources, since both of the REST APIs that I have been depending on for data have become unreliable. The amount of code I'm going to have to refactor as a result of this is admittedly a little bit daunting, but I will press on nonetheless.

#### Sincerely,

Dana
