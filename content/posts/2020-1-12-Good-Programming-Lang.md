+++
title = 'What Makes a Good Programming Language? '
date = 2020-01-12
draft = false
tags = ["other"] 
+++

First, I should note that the is perhaps a somewhat loaded question, as 
different people will inevitably have different criteria, and priorities 
for the languages they choose to use. Therefore, you will get many different
answers to this question, depending on who you ask. It is also equally
important to ask: what makes a good programming language for a specific use
case? A language that is ideal for say, building web applications is likely
not going to be equally ideal for writing drivers and operating system
kernels. Nevertheless, I that there are some core criteria that almost all
developers will value in a given language to at least some degree. Among
these are: performance, simplicity, versatility, and cross-platform support.
With that in mind, I would like to break down what each of these criteria 
entail.   

## Performance

Performance generally refers to how efficiently a language and its runtime
utilize system resources such as RAM. Even though we generally do not need 
to worry quite as much about conserving memory as we did 40-50 years ago,
this is still a significant factor. We certainly want our programs to run
fast and efficiently for the sake of our users, and ourselves. It is also
on account of performance that certain languages are ill suited to certain
use-cases. For example, wile some interpreted languages like Ruby and 
Python may be awesome for building web applications, they are not exactly
what one would use for implementing something that requires super efficient
usage of memory, like a physics engine. However, it is important to recognize
that at least some languages try to strike a balance between performance and 
abstraction/simplicity. I would argue that languages like C# and Golang do
an at least decent job of this.

## Simplicity

In addition to performance, we also largely want to minimize the barrier to 
entry for the language we use. That is, we want to make it easier to learn
new languages, rather than more difficult. There are a multitude of factors
that can contribute to this, such as the specific syntax that the language
uses, as well as the amount of setup involved in installing the runtime, and
development environment. To quote Tim Peters' *The Zen of Python*: "Readability
counts." Programmers generally spend more time reading existing source code
than they do writing new code. Therefore, how easy it is to read code written
in a given language is often an important factor in people's decision to use 
said language. Syntax can have a major effect on how easy or difficult it is
to learn and use a programming language.

## Versatility

Another major factor in the popularity of programming languages is the variety
of different use-cases that they can be applied to. Indeed, many languages
(such as JavaScript and Python) have seen their popularity skyrocket due to
being easily portable to a variety of different contexts, while others, like
PHP and Ruby, have experienced a significant drop in popularity largely on
account of not being ideal for use outside of a specific context.

## Cross-Platform Support

This brings me to my final priority for a programming language: cross-platform
support, which ties into the previous point about versatility. It is also not
necessarily a priority for every developer. For example, a career iOS developer
will not necessarily be bothered by the lack of cross-platform support for 
Swift, or Objective C. Similarly, veteran C# programmers are probably content
with the fact that .NET Framework (not including the Mono project) is only 
supported on Windows. Nevertheless, there is something to be said for a
language that is not bound to a specific operating system, or domain. Indeed,
many programmers specifically seek out platform-independent languages, and 
they are not wrong to do so.

## Conclusions

I am sure that there are any number of people who at least partially disagree
with some of my assessments in this post. This is completely understandable.
Again, everyone has their own priorities that are deciding factors in the 
tools they use. I welcome feedback on this. After all, different strokes for
different folks.

<br>


Sincerely,

Dana


<br>