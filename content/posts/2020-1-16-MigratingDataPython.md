+++
title = 'Migrating Data to the Cloud with Python'
date = 2020-01-16
tags = ["python", "sql"] 
+++

In the past year, or so, I have been experimenting with writing my own custom 
ETL programs in Python. Among the functionality that I included was extracting
data from a local Postgres database, and migrating to a Postgres database in 
the cloud.

## The Reasoning

While I'm aware that platforms-as-a service (PaaS) like AWS, and 
Azure provide their own services for this. Nevertheless, I opted to implement 
my own solution for data migration(s). I decided on this course of action for
a couple reasons: 1) I saw it as a valuable learning experience for, and 2)
I also found it be a practical solution as well. 

## The Goal

The ultimate goal of this was to create a simple, interactive way of extracting
data from individual tables on my local instance of PostgreSQL, and loading
them into an AWS RDS Postgres instance. Ideally, I wanted to implement a 
solution that provided the best possible balance between simplicity and 
performance. Ultimately, the packages that I relied on the most for this task
were *psycopg2*, and *Pandas*. 

## Implementation

The function I wrote to perform this task consisted of the following key steps:

1. Extract the data from a table, and load it into a `DataFrame`.
2. Dump the contents of the `DataFrame` to a (temporary) CSV file.
3. Create a *psycopg2* `cursor` based on AWS connection parameters to execute operations.
4. Use `cursor.copy_from()` to load data from the CSV into the AWS database.
5. Commit the transaction to the database, and close the connection.
6. Delete the temporary CSV file, as it is no longer needed.

<br>

If you are familiar with Pandas DataFrames, you might be wondering "why dump 
the DataFrame to a CSV file? Why not just directly write to the target database
using `DataFrame.to_sql()`? I actually did originally use this technique.
However, I found that even with using the optional `index=multi` parameter, 
was still prohibitively slow. Don't get me wrong: `DataFrame.to_sql()` is a
totally viable option, if you are just working with small datasets of under
10,000 records. However, beyond that, things will start to slow down noticeably.

I had the hypothesis that it although it would require an extra step, it would
actually be far faster to dump the data to a CSV file so I could use 
`cursor.copy_from()`, and therefore, load all the records into the database as
a single ACID transaction. This proved to be correct, as it took about a 
quarter of the time to complete as `DataFrame.to_sql()` did, even using
`index=multi` to speed things up. Also, after the data was successfully loaded
into the database, I could easily just delete the CSV file that I was staging 
my data in.

Here is the exact implementation I used:

```python
def aws_pg_migration(src_table, target_table):

    try:
        # Extract the data, and dump it to a temporary CSV file
        df = pd.read_sql_table(src_table, local_pg_engine, index_col='id')
        df.to_csv('data/temp/sql_dump.csv', sep=',')
                
        # Create a cursor
        curs = aws_pg_conn.cursor()

        with open('data/temp/sql_dump.csv', 'r', encoding="utf8") as data_src:

            # Skip header row 
            next(data_src)
                        
            # Load data from CSV into db
            curs.copy_from(data_src, target_table, sep=',')

            # Commit the transaction to the database, and close the connection
            aws_pg_conn.commit()
            aws_pg_conn.close()
            
            # Delete the CSV file, as it is no long necessary
            remove('data/temp/sql_dump.csv')

            # Show the user how many records were migrated, and terminate program.
            input(f'{len(df)} record(s) successfully loaded into the "{target_table}" table in "{aws_pg_creds["database"]}" on "{aws_pg_creds["host"]}". Press enter to exit.')

    # Throw exception if data source is empty           
    except EmptyDataError:
        input('Error: No data in data source! Press enter to exit.')
    # Throw exception if data types are not compatible 
    except DtypeWarning:
        input('Error: Incompatible data type! Press enter to exit.')
    # Throw exception if table does not exist in DB.
    except UndefinedTable:
        input('Error: Table does not exist in database! Press enter to exit.')
```

## Conclusions

This particular methodology has worked well enough that I am now considering 
implementing in other functions in the same project where I am currently 
using `DataFrame.to_sql()`. After all, I have thus far only tested those functions
will data sets of no more than 5,000 records so far. More information about
the project can be found <a href="https://github.com/d-bits/chapman" target="blank">here</a>.

<br>