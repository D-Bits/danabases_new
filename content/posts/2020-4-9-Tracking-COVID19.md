---
layout: post
title: Tracking COVID19
publishdate: 2020-04-09
updated: April 9th, 2020
tags: ["python"] 
---

In light of the recent pandemic (and partially as a result of being laid off recently, due to said pandemic), I recently took it upon myself to build a reporting service of sorts for the COVID-19 pandemic. After all, got to have something to work on during quarantine. The project consisted of the following core steps: 1) Find a REST API with comprehensive and reliable data, 2) Clean the data, and calculate aggregates, 3) Render the data into HTML templates, 4) Deploy the client to a production environment.

Following a little research, I found out that Postman had built an [REST API](https://documenter.getpostman.com/view/10808728/SzS8rjbc?version=latest), in collaboration with John Hopkins, to track developments with the pandemic. All the data that I worked with for this project comes from that API.

So, on that note, let the games begin.

## Obtaining the Data

Although the API that were are using provides a variety of endpoints, for this blog post, we will just be using one. The "summary" endpoint will give basic data for all the world's countries: total confirmed cases, total confirmed fatalities, etc. All this can be accessed from the [endpoint](https://api.covid19api.com/summary). To extract the JSON data from the endpoint, we use the following Python code.

```python
from requests import get


summary = get("https://api.covid19api.com/summary")
summary_json = summary.json()
```

Now that we have extracted our data, we can load it into a Pandas `DataFrame`. In this case, I will just using the data stored in the `countrires` variable. We would load that into a `DataFrame` like so:

```python
# Universally used aliasing convention for importing Pandas
import pandas as pd


df = pd.DataFrame(summary_json['Countries'])
``` 

If we output our data to a console, then it should display it in a nicely ordered, rows-and-columns format. Now that we have that done, we can carry on to cleaning up the data in our `DataFrame`.

## Preparing the Data

As useful as all this data is, we do not quite need all of it. Also, after pouring through it, I noticed that there was some duplicate data. If you look over the JSON data from the endpoint, you will notice that some countries appear more than once, and with the exact same data. For example, Vietnam appears twice as both "Vietnam" and "Viet Nam", each with the same statistics. Fortunately, for our needs, each record (associative array) in the JSON data has an `id` integer identifying it. Therefore, we can drop redundant records from the `DataFrame` by using the `DataFrame.drop()` method. Specifically, in this case, we will pass in a list of integers, corresponding to the IDs of the records that we want to eliminate from our `DataFrame`, with the code for it looking like this:

```python
cleaned_data = df.drop([0, 93, 101, 125, 168, 169, 170, 171, 172, 175, 194, 199, 205, 224])
``` 

So, now that we have eliminated redundant records from the `DataFrame`, we can now focus on how we want our remaining data to be organized. For this particular `DataFrame`, we want it to be organized by country, in alphabetical (ascending) order. To do this, we would use the `DataFrame.sort_values()` method in the following manner:

```python
ordered_df = cleaned_data.sort_values('Country', ascending=True)
``` 
In addition to sorting records in alphabetical order, we also want total values for each column, so we can see the global amount of confirmed cases, new cases, confirmed deaths, etc. To do so, we would use `Dataframe.sum(axis=0)`. So, in our case, we would use `cleaned_data.sum(axis=0)`. Now that our data is organized, its on to displaying it in our Jinja2 template.

## Displaying the Data

With our data neatly organized, its time for us to render it in HTML templates. For this project, I used the Flask web framework to build the web client, which is also built on Python, as I knew it would be easy to integrate my `DataFrames` with it, and it would afford me greater flexibility that Django, which is what I usually use for building web applications. Jinja2 is that templating engine that Flask comes bundled with. Ultimately, to display our data, we will be specifying our DataFrames in our Flask routes, and from there, directly rendering them into HTML tables in our Jinja2 templates. For example, a Flask route for our summary data, that we defined and cleaned above, would look like this:

```python
@app.route('/')
@app.route('/home')
def index():

        # Load the data into DataFrame
        df = pd.DataFrame(summary_json['Countries'])
        # Drop redundant records
        cleaned_data = df.drop([0, 93, 101, 125, 168, 169, 170, 171, 172, 175, 194, 199, 205, 224])
        # Order countries in alphabetical order
        ordered_df = cleaned_data.sort_values('Country', ascending=True)
        # Aggregate data
        totals = cleaned_data.sum(axis=0)
        # Convert the DataFrame to a dictionary, so its values can be iterated over in a template
        df_dict = ordered_df.to_dict(orient=columns)

        # Render the template, with DataFrame values
        return render_template('index.html', data=df_dict, total=total)
```

We would iterate over those values in an HTML table with the following code:

```html
<table>
    <thead>
        <tr>
            <th class="header-row">Country</th>
            <th class="header-row">New Confirmed</th>
            <th class="header-row">Total Confirmed</th>
            <th class="header-row">New Deaths</th>
            <th class="header-row">Total Deaths</th>
            <th class="header-row">New Recovered</th>
            <th class="header-row">Total Recovered</th>
        </tr>  
    </thead>
    {% for nation in data %}
    <!--Table for summary data-->
    <tbody>
        <tr>
            <td><a href="{{ url_for('country_cases', country=nation.Country)}}">{{nation.Country}}</a></td>
            <td>{{nation.NewConfirmed}}</td>
            <td>{{nation.TotalConfirmed}}</td>
            <td>{{nation.NewDeaths}}</td>
            <td>{{nation.TotalDeaths}}</td>
            <td>{{nation.NewRecovered}}</td>
            <td>{{nation.TotalRecovered}}</td>
        </tr>
    </tbody>
    {% endfor %}
</table>   
```

## Testing and Quality Assurance

Before we deploying to production, we should write some unit tests to help ensure the functionality of our code base. A good place to start, would be to test that all of our routes return a 200 status code response.
Using the `unittest` module, that is built into the Python standard library, we would create unit tests to ensure the route that looks like this:

```python
from unittest import TestCase
from app import app


"""
Unit testing for routes
"""
class RoutesTests(TestCase):

    # Test index route(s) returns a 200 response
    def test_index_route(self):

        with app.test_client() as tc:

            response = tc.get('/')
            redirect_response = tc.get('/home')
            self.assertEqual(response.status_code, 200)
            self.assertEqual(redirect_response.status_code, 200)
```


## Final Thoughts and Going Forward

What I have outlined here is certainly not the full extent of the work that I have put into this project thus far, and there are other features I have on the road map, as well. To view the entire code base for the project, please refer to the GitHub [repo](https://github.com/D-Bits/COVID-19-Tracker) for it. In the near future, I would definitely like to do additional analysis, and using data from some of the other endpoints that the API provides. Furthermore, I also hope to add functionality that allows the user to download the data, and save it to their device(s). 

So far, I have found this to be a very rewarding project to work on. At a minimum, it has definitely helped improve my skills with both Flask and Pandas. This is actually the first Flask project that I have deployed to a production environment of some kind. While I did not go into the details of deployment in this article, I hope to go over that in a future post. Until then, there is always more work to be done.

Sincerely,

Dana