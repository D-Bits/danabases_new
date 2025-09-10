---
layout: post
title: Integrating JSONB Data into Django Projects
publishdate: 2020-02-13
updated: February 13th, 2020
tags: ["python", "json", "sql"]
---

This post follows up on my earlier post about [storing json data in Postgres](https://danabases.net/posts/2020-1-22-postgres-json/). In this article, I will be going over how to integrate the same `JSONB` data I used in that post with a Django web application.

## Modeling the Data

Modeling `JSONB` data with Django's ORM tool is rather easy, as the framework has built in support for this in the `django.contrib` module. Therefore, we would model our data like this in our `models.py` file:

```python
from django.db import models
from django.contrib.postgres.fields import JSONField


# Create your models here.
class Textbook(models.Model):

    title = models.CharField(max_length=200)
    properties = JSONField()

    def __str__(self):
        
        return self.title
```

## Creating a View

In this example, I will be using Django's class-based `ListView` to simplify our view logic. As such, the view will simply look like this:

```python
from django.views.generic import ListView
from .models import Textbook


# List all textbooks
class IndexView(ListView):

    model = Textbook
    template_name = 'books/index.html'
    context_object_name = 'books'
    ordering = ['-title']

    def get_queryset(self):

        return Textbook.objects.all()
```

## Templating

Templating `JSONB` data in Django works very much like templating non-JSON data. If you have worked with Django templates (or similar templating languages) in the past, this will look quite familiar:

```html
<div class="container">

    {% for book in books %}
        <h3><strong>Title: </strong>{{book.title}}</h3>
        <p><strong>Author(s): </strong>{{book.properties.authors}}</p>
        <p><strong>ISBN: </strong>{{book.properties.ISBN}}</p>
        <p><strong>Price: </strong>${{book.properties.price}}</p>
        <p><strong>Condition: </strong>{{book.properties.condition}}</p>
        <p><strong>Hardcover?: </strong>{{book.properties.hardcover}}</p>
    {% endfor %}

</div>
```

## Final Thoughts

This would certainly be considerably more difficult to implement without Django's built-in support for Postgres' `JSONB` type. However, given that Django does have built in support for this, it was about as easy as working with SQL data. Going forward, I would like to implement more complete CRUD functionality. Stay tuned. 