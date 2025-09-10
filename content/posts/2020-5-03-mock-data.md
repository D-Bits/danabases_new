---
layout: post
title: Generating Mock Data with Faker 
publishdate: 2020-05-03
draft: false
tags: ["python", "automation"] 
---

Very frequently in software development, we find ourselves in a situation where we need to test the functionality and/or performance of a program with random data. This data needs to be: a) seemingly realistic, b) of arbitrary volume, and c) conformant to the logic of our program. How do we solve this problem? While there are a variety of services that do exactly that, those almost always cost money, and if they do have a free version, that comes with some considerable limitations. Sure, a data set of 1,000 records will be adequate to test if an ETL job works altogether, but it is still a paltry amount of data for testing the performance of the program, or how scalable it is. This is where tools like Faker come into play.

## What is Faker?

*Faker* is a library designed to simplify generating mock data for testing. There are actually a number of libraries across different languages called Faker, that serve this purpose. However, this post will be specifically about using the Python library. Faker comes with a variety of different types for different kinds of information, such as `first_name`, `country`, `ipv4`, etc. To install it, we simply run `pip install faker` in a `venv`.

## Generating the Data

Once installed, the first step to generate mock data with Faker is instantiation the `Faker` class.

```python 
fake = Faker()
```
Now that we have instantiated the class, we can use the various attributes of the `Faker` class to generate data. In the following example, we will be generating some random data for an `employees` table, and writing it to a CSV file:

```python
def gen_employees_csv(filename, records_num):

    emp = open(f'data/{filename}.csv', 'w', newline='')
    fields = ['last_name','first_name','job','email','password_hash','phone','home_address','city','state','zip']
    writer = DictWriter(emp, fieldnames=fields)
    # Write the columns to file
    writer.writeheader()
    
    fake = Faker()

    for i in range(records_num):

        writer.writerow(
            {
                'last_name': fake.last_name(),
                'first_name': fake.first_name(),
                'job': fake.job(),
                'email': fake.email(),
                'password_hash': fake.sha256().upper(),
                'phone': fake.phone_number(),
                'home_address': fake.street_address(),
                'city': fake.city(),
                'state': fake.state(),
                'zip': fake.random_int(11111, 99999),
            }
        )
```
Each time we call `fake.<attribute()>`, it creates a random piece of data for that field, and writes it to a CSV file. For example, `fake.job()` might generate "Neurosurgeon" for a value. If we want to generate values in bulk, and write them to a CSV file, then we simply call `writer.writerow()` in a for loop, with a range of however many records we want to create. Even though the example above is very context-specific, Faker ultimately provides a variety of different types to generate mock data from.  

## Final Thoughts

With this new tool in my toolbox, I will be able to generate arbitrarily large data sets for testing programs going forward. While I would ideally prefer something a little faster (*the above function took about 6.5 minutes to generate 500,000 records worth of data on my home machine*), it still has performed at least reasonably well so far. For more information about Faker, check out their [documentation](https://faker.readthedocs.io/en/master/index.html). Thank you for reading.


Sincerely,

Dana