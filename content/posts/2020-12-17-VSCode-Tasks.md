---
title: Improving Developer Productivity with VS Code Tasks
publishdate: 2020-12-18
tags:
  - productivity
  - json
draft: false
---

Often in our developer workflows, we find ourselves running routine, or semi-routine, and monotonous tasks. This can be things like compiling code, bootstrapping dev servers, running migrations, etc. The kind of commands that you eventually get rather tired of typing into a terminal over, and over again. These days, many developers often rely on various kinds of *task runners* to at least partially automate execution of these kinds of tedious and repetitive tasks.

Effectively doing so can save you a lot of time. I will be showing you how can use one such task runner to do just that.

## Tasks.json

The specific task runner I will be using here is Visual Studio Code's built-in task runner. Why? First, because VS Code is my go to editor for almost every kind of development I do. Second, because it is a popular editor that many developers are already at least somewhat familiar with. Finally, I also wanted a task runner that entailed minimal configuration.

## The Project

Of course, we cannot automate project tasks without a project. To demonstrate, we will be creating tasks for a Django project. Anyone who has used Django will know that you will quite frequently be running various `manage.py` commands from a terminal. This includes running things such as migrations, unit tests, and more. Therefore, rather than manually type them out every time we need to run such commands, we can configure a `tasks.json` to run them for us.

## Setting Things Up

First, open the VS Code command palette (Ctrl+Shift+P on Windows and Linux, Cmd+Shift+P on Mac), and run the `"Tasks: Configure Task"` , then select `"Configure tasks.json from template"` , and choose `"Others"` from the list of templates. This will create a directory in your project called `.vscode` with a basic `tasks.json` files, featuring a "hello world" task.

![command-palette](/assets/pics/posting_pics/vscode-command-palette.jpg)

*The VS Code Command Palette menu*

Now that we have our template, we can move on to adding our own tasks.

## The Actual Tasks

Time to get to the meat and bones of the matter. To add a task to our `tasks.json`, we add another JSON object to the `"tasks"` list in the file. Suppose that we want to bootstrap the development server for the above mentioned Django project? To create a tasks for that, we would add a JSON object that looks like this:

```json
{
	"label": "Bootstrap Django Dev Server",
	"type": "shell",
	"command": "docker-compose exec django python manage.py runserver",
}
```

The `"label"` field describes the name of the task, `"type"` defines what type of task we are running (in this case, a shell command), and the value for `"command"` is the command we want to run.

To actually run our new task, we would again open the command palette, select `"Tasks: Run Tasks"`, and then select the name of the task we want to run, based on the value specified in the `"label"`.

There a certainly more Django tasks that you can add to the file. For a more complete example, I have published a [gist](https://gist.github.com/D-Bits/769706795cf918bd4c838abdc186c7ba) on the topic.

## Handling User Input

What if we want or need to make our tasks more dynamic by passing in different values, based on user input? We can do this by adding an `"inputs"` variable to our task JSON object. For example, if we wanted to create a simple task that prints "hello <user_name>" to stdout, we could configure it like this:

```json
"tasks": [
        {
            "label": "Hello Person",
            "type": "shell",
            "command": "echo Hello ${input:yourName}"
        },
    ],
    "inputs": [
        {
            "id": "yourName",
            "type": "promptString",
            "description": "Enter your name:"
        }
    ]
```
This, of course, is a very simple example of parameterizing tasks. However, we can easily use the same functionality to do more complicated things. 

## Conclusions

Simplifying common and tedious development tasks like this can save a whole bunch of time and trouble for many different kinds of projects. Even though I have been using VS Code for close to three years now, I'm only just starting to really appreciate how useful its task runner can be. While I have used similar set-ups via Python scripts in the past, I will probably be primarily using the VS Code task runner going forward. Also, I should note that even though this post revolved around a very specific task runner, I think using a task runner, in general, saves one a decent amount of time, be it Make, a Python script, or something else.

You can read more about running tasks in VS Code [here](https://code.visualstudio.com/docs/editor/tasks).