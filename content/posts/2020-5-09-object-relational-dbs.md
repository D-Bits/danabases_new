---
layout: post
title: Understanding Object Relational Databases
publishdate: 2020-06-02T00:00:00.000Z
updated: April 26th, 2020
draft: true
tags:
  - sql
---

If you a developer, you may have come across the the term *object relational* in the context of database management systems (DBMS). In the most simple sense, it is a DBMS that combines the principles of relational databases with at least some of the principles of object-oriented programming.

In this post, we will be reviewing why one should use object relational databases, and how they implement various principles of object oriented programming.

## Why Use Them?

You might be wondering: why use an object-relational database, instead of a regular relational database? Broadly speaking, object relational databases allow us to extend the functionality of relational databases. In particular, it allows to create complex, custom data types for our database. Ultimately, this allows us a lot more freedom and flexibility than we might otherwise having with regular relational databases.

## Table Inheritance

This is probably the single most important aspect of object-relational databases. It works quite similar to inheritance in OOP. When a table inherits from a parent table, it acquires all of the fields of the parent table. For an example, let's say we have a....

## Encapsulation

In OOP, *encapsulation* mandates that objects should be entirely self-contained. That  is, an object should be a complete description of the thing that it is supposed to describe. In an object relational database, this is manifested in the form of tables. That is, a table should have fields that account for every aspect of what it's describing. For example, a `cars` table should have fields for every aspect of a car: model, manufacturer, engine, year, etc.

## Polymorphism

With an object relational database, polymorphism is manifested in relationships. That is, values in one table can have different can have different information and meaning in related tables. For example, you could have a car company, like Honda, in one table, related records in a different table for something like the models it produces, another table can contain manufacturing centers for the company, and so on.

## Final Thoughts

My personal take is that object relational databases are generally superior to regular relational databases. Furthermore, they will likely feel more approachable to developers who do not necessarily come from a SQL background.