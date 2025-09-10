---
layout: post
title: A Primer on DataFrames
publishdate: 2020-04-24
updated: February 13th, 2020
tags: ["python"]
---

Today, we will be going over what Pandas DataFrames are, as well as how to use them to manipulate and dump data. They are something that I, and many others, have come to rely heavily on in variety of contexts. So, without further ado, time to get started.

## What Are DataFrames?

A `DataFrame` is a type of data structure. That is, a way of storing values in memory. They are designed to store and organize potentially large volumes of data in a rows-and-columns format. It is essentially a two-dimensional array to store values in. While there are multiple technologies that utilize DataFrames, in this post, we will be using the DataFrames from Pandas. If you are not already aware, Pandas is a Python library, built on NumPy, that is designed to simplify data manipulation and analysis. To install it, create/activate a `venv` and run `pip install pandas`. To use Pandas, we use the following universal aliasing for our import:
```python
import pandas as pd
```
Now that we have installed and imported Pandas, we can start manipulating data.

## Loading Data into DataFrames

For the purposes of demonstration, I will be using a CSV file containing 1,000 records worth of information about individual, fictitious people. The data includes the following columns: `id`, `last_name`, `first_name`, `email`, `gender`, `job`, and `language`. To load this data into our `DataFrame`, we would simply use the following code, assuming the .csv file is located in the same directory as our Python file:

```python
# DataFrames are often stored in a variable called "df"
df = pd.read_csv('people-data.csv')
```
This will load all the values from that CSV file into the `DataFrame`, and will look like this when printed to the standard output:

![df](/assets/pics/posting_pics/df_print.jpg)

If we needed to load our data from sources in different formats, like JSON or Excel workbooks, then we would use the following implementations:

```python
# JSON
df = pd.read_json('people-data.json')

# Excel
df = pd.read_json('people-data.xlsx', sheet_name='data')

# SQL Table
df = pd.read_sql_table(table_name, sqlalchemy_engine, index_col='id')
```

Any of the above methods will load data into a `DataFrame`. Perhaps one of the best things about Pandas, is that it provides an easy way to "flatten" JSON data, into a rows-and-columns format, assuming the JSON data in question is organized neatly as a list of associative arrays. Now that our data has been loaded into our `DataFrame`, we can start analyzing and manipulating data.

## Sorting Data

Pandas is designed to make data analysis easy. Suppose we want to find out which people in our data set speak English. To do that, we just to specify a column, and value for it, like this:

```python
df = pd.read_csv('people-data.csv')

english_speakers = df[df['language'] == 'English']
```
If we run this code, it will show all rows in the DataFrame where `language` is equal to `English`. In this case, that ended up being six people. There are also any number of other manipulations we can apply to our `DataFrame`. For rexample, to find everyone in our data set over the age of 40, we would apply similar logic:

```python
over_40 = df[df['age'] > 40]
```

Now, time to move on to aggregating data.

## Aggregates

Suppose we want to find values in our data like highest values for a column, the lowest, averages, and so on. Fortunately, DataFrames have a variety of methods for doing all these kinds of calculations. For example, here is how we would find the average age of the people in our data source:

```python
df = pd.read_csv('people-data.csv')
avg_age = df['age'].mean()
```
In this case, the mean age turns out to be 44.38 years old. If we want to sum a column, we would use similar logic:

```python
df = pd.read_csv('people-data.csv')
avg_age = df['age'].sum()
```

## Exporting DataFrames to Other Sources

Once, we have done our various data manipulations, we can then export our data to a variety of other sources. This is also quite easy, as Pandas DataFrames has methods for exporting data to a variety of sources:

```python
# Export to CSV
df.to_csv('data.csv')
# Export to JSON
df.to_json('data.json')
# Export to Excel
df.to_excel('data.xlsx')
# Export to a SQL db
df.to_sql(table_name, sqlalchemy_engine, index_label='id', method='multi')
```
Note: You should always pass in `method='multi'`, other Pandas will automatically create a separate transaction for each record it inserts, which is painfully (and needlessly) slow.

## Final Thoughts

Remember that we are just barely scratching the surface of what one can do with Pandas here. Pandas is an incredibly robust and versatile library, that is adaptable to a variety of situations. If you want to learn more about Pandas, please refer to their [documentation](https://pandas.pydata.org/pandas-docs/stable/index.html).

Sincerely,

Dana
