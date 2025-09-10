+++
title = 'Storing and Querying JSON Data in PostgreSQL'
date = 2020-01-22
tags= ["sql", "json"] 
+++

I recently started exploring how to store JSON data in a traditional relational
database management system (RDBMS), rather than a dedicated form of JSON/document 
storage, like MongoDB. While I could write a lot more about the problems with 
MongoDB, that's not what I want to do here. Instead, I want to
focus primarily on how to store and query JSON in PostgreSQL. However, I
should note that PostgreSQL is not the only RDBMS that supports JSON storage.
I know that MariaDB also does, as of v10.2, and possibly other RDBMS as well. However,
since I have been mostly using and enjoying Postgres for awhile now,
I decided to focus on that, specifically.

## The Test Case

As a sort of test case to experiment with storing JSON in a relational database,
I decided create a table to store miscellaneous textbooks, and various information
for them. While this is a somewhat simple example, it nonetheless illustrates at 
least the basics of how to store and query JSON in Postgres.

## Creating a Table for JSON Data and Seeding It

First, I should note that while Postgres has both a `JSON` data type, and a JSON bytes (`JSONB`)
data type, we will be using `JSONB`, as that data type supports indexing, while the `JSON`
type does not.

Here is the sample table I created to store data in:

```sql

-- Create table for textbooks
CREATE TABLE textbooks
(
    id SERIAL PRIMARY KEY,
    book_info JSONB
);

```

And here is how to insert JSON data into a `JSONB` field.

```sql

-- Populate textbooks table
INSERT INTO textbooks(book_info)
VALUES
('{
    "title": "Python Crash Course, 2nd Edition: A Hands-On, Project-Based Introduction to Programming",
    "ISBN": 1593279280,
    "condition": "new",
    "price": 22.99,
    "hardcover": false,
    "authors": ["Eric Matthes"]
}'),
('{
    "title": "Applied Cryptography: Protocols, Algorithms and Source Code in C 20th Anniversary Edition",
    "ISBN": 1119096723,
    "condition": "new",
    "price": 55.00,
    "hardcover": true,
    "authors": ["Bruce Schneier"]
}'),
('{
    "title": "Gravitation",
    "ISBN": 9780691177793,
    "condition": "used",
    "price": 45.40,
    "hardcover": true,
    "authors": ["Charles W. Misner", "Kip S. Thorne", "John A. Wheeler"]
}'),
('{
    "title": "Programming C# 8.0: Build Cloud, Web, and Desktop Applications",
    "ISBN": 1492056812,
    "condition": "new",
    "price": 54.82,
    "hardcover": false,
    "authors": ["Ian Griffiths"]
}'),
('{
    "title": "Mastering PostgreSQL 11: Expert techniques to build scalable, reliable, and fault-tolerant database applications, 2nd Edition",
    "ISBN": 1789537819,
    "condition": "used",
    "price": 39.99,
    "hardcover": false,
    "authors": ["Hans-Jürgen Schönig"]
}');


```

## Querying the Data

If we simply wanted to get all the data in the table, then we would just do your
basic `SELECT * FROM textbooks;`, but if only want to select specific elements
from our `JSONB` field, then we have to use syntax that might look somewhat 
unfamiliar. Let's say we only wanted to select `title` values from our JSON
data. Then, we would use: `select book_info ->> 'title' as title from textbooks;`.
However, what if we need to do a more complicated `SELECT` query? For example,
what if I'm on a budget, and only want to see textbooks that cost less than $50.00?
In that case, we would have to do a little type casting with the following query:

```sql

-- Select books that cost less than $50.00
SELECT book_info ->> 'title' AS title, book_info ->> 'price' AS price
FROM textbooks
WHERE cast
(
    book_info ->> 'price' AS DECIMAL
) < 50.00;

```

For another example, let's say we just want hardcover books. Then, we would use:

```sql

-- Select only hardcover books
SELECT book_info ->> 'title' AS title, book_info ->> 'hardcover' AS is_hardcover
FROM textbooks
WHERE cast
(
    book_info ->> 'hardcover' AS BOOLEAN
) = true;

```

## Conclusions

Storing, and querying JSON data in a traditional, relational database like Postgres, is
not only possible, but also practical. So, the next time you find yourself in one
of those niche use-cases where you actually need to persistently store data in JSON,
don't simply assume that you need to use a NoSQL DBMS, like MongoDB. At least look 
into using Postgres, and its `JSONB` data type. I have also authored a [gist](https://gist.github.com/D-Bits/d0f5ef2f79839d6e814a235e14e9e418) 
on the topic.



<br>