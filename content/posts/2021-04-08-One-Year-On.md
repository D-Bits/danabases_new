---
title: One Year On 
publishdate: 2021-04-08
tags:
  - other
draft: false
---

After recently going over some of my earliest blog [posts](https://danabases.net/posts/2020-1-10-welcome-everyone/), it dawned on me that I have been maintaining this blog for a whole year now. This realization inspired me to reflect on how and where the blog started, what's happened since, as well as what the future might entail.

## In the Beginning....

The blog was without form. Well, not quite. When this blog started out, it was rather primitive. I was using Jekyll, as I had not yet done research into other static site generators, and deploying to GitHub Pages without a custom domain. At the time, I was looking for the simplest (and cheapest setup) possible to get things started. The UI of the website looked something like this:

![danabases original](/assets/pics/posting_pics/danabases-original.jpg)

*This original UI of Jekyll-based Danabases. It can still be accessed [here](https://danabases.netlify.app/)*.

At first, this setup actually worked reasonably well: I got throw together a decent enough blog, and host it on GitHub Pages for free with seemingly minimal hassle. The minimalist UI didn't bother me. I prefer a more basic UI to one that obsesses over purely cosmetic details,  plus it was easy enough to make minor modifications to the layout of the website. However, after about a couple months, certain serious problems began to emerge. 

First, is a disturbing tendency by Jekyll to try execute snippets of Jinja2 and/or Django template code that I tried to include in some of my blog posts. That kind of template code is actually very syntactically similar to the templating language that Jekyll uses. The other problem I faced was simply the fact that Jekyll is Ruby-based, which I have very little expertise in. Also, given that Ruby is rapidly becoming somewhat of a legacy language, I couldn't really see myself investing a lot of time and energy into learning the language, and its related technologies.

## The Next Iteration

With these challenges in mind, I set out to overhaul Danabases. I won't go into a whole lot technical details about that process, as I have already done so in a [previous post](/posts/2020-05-10-overhauling-this-website/). The TL;DR is that I opted for re-building the blog using the Hugo static site generator, and deploying to Netlify. This setup has served me pretty well, and I continue to use it to this day. However, I didn't recently switch to new theme for the new year, on account of seemingly random problems in how the previous theme was rendering text to HTML.

## What I've Learned, and Struggles Along the Way

> *Writing is easy. All you have to do is cross out the wrong words.*

**-Mark Twain**

Ok, writing may have been easy enough for a brilliant and career writer like Twain, but for a technologist like myself, its not so easy. While I certainly don't detest blogging, it's also not exactly something I love doing enough to author a new post every week. Nevertheless, it is something I intend to keep up with on at least some level.

That's blogging. As for the technological skills I've learned over the past year, I've learned a lot. Part of it came from a summer internship, some came from an open source community project I'm still working on, and a lot of what I've learned has come from working on my own personal projects, including this blog. One of the most important lessons I've learned is: never underestimate the knowledge you can teach yourself.

## Going Forward and the Future

All of this brings us today. So far, I'm pretty content with the current design and layout of the website, with no plans to extensively modify it. That said, I am looking at adding search functionality to the website, so one can easily look up past posts. As for my personal learning road map, I'm about to do a deep dive into the realm of "big data" by way of Apache Spark, and related technologies. While it will certainly be a challenge, I have no doubts that it will be well worth it. Also, I'm hoping to improve my C#/ASP.NET Core game this year, as well. Of course, I'm also hoping to find more gainful employment as a developer this year too. Hopefully, that will also provide me with some interesting experiences to write about.

As for future blog posts, I'm hoping to keep with publishing at least one new post a month. Stay tuned ;)
