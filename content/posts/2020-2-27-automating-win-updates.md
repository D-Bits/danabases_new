---
layout: post
title: Automating Software Updates on Windows
publishdate: 2020-02-27
updated: February 27, 2020
tags: ["automation"] 
---

Let us be real, for a moment: keeping software up-to-date is critically important, but also often quite a pain. The more software you have installed on your PC, the more true this is. Fortunately, it does not have to be, even on Windows. All you need is: a package manager, a little Python, the Windows Task Scheduler, and a batch file.

In a [previous post](https://danabases.net/posts/2020-2-15-postgres-chocolatey/), I wrote about how to easily install and update a Postgres instance on Windows. This post will ultimately build on that, as it uses the same package manager, Chocolatey. There is, of course, a little bit of setup to be done to automating this, but nothing too labor-intensive, and definitely worth the amount of time it will save.

## Chocolatey

First, we need to ensure Chocolatey is installed, and working properly. Open a PowerShell terminal, and run the following command:
```
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```

Then, run the command `choco`. If it returns a listing of possible arguments, then Chocolatey has been installed successfully.

## A Wee Bit of Python

To write the necessary code to execute Chocolatey updates, we will be using the `subprocess` module in Python's standard library. Methods in this module will allow use to spawn external processes (like shell commands) inside Python programs. In particular, we will use the `subprocess.run()` method.

```python
from subprocess import run


try:
    run(['choco', 'upgrade', 'all'], check=True)
except:
    input("Error has occured. Press enter to exit.")
```

That's all the Python code we need. Now, we just need a way to run it on a specific schedule.

## Automating Script Execution

First, we need to create a batch file, with the `.bat` extension. In that batch file, we need to include the following line of code:

`"C:\Python38\python.exe" "C:\Users\YourUsername\Documents\Path\To\PythonScript\updates.py"`

Once we had that added, and the file saved, we can create a task in the Windows Task Scheduler. This will allow us to run the Python script on a specific schedule, thus automating the whole process.

Next, we need to use the Windows Task Scheduler. To open it, press `windows key + s`, then search for "task scheduler". Once you find it, click it to open it, then click "Create Task". Under the "General" tab, name the task "updates", or something to that effect, and (very important) be sure check the box that says "*Run with highest privileges*". Chocolatey needs admin privileges to install and update packages. Under "Triggers", create a new trigger to run the task on a daily basis, at a time of your choosing. 

Then, go to the "Actions" tab, and click new. Keep "Start Program" as the action, and set your batch file as the program/script to execute. By this point, you should be more-or-less ready to go. You can test whether or not it works by selecting your newly created task in the Task Scheduler, and clicking the run button.

## Final Thoughts

Even though this specific case focused entirely on automating Windows updates, a similar methodology could easily be applied to Unix-like systems via Cron, and some minor code tweaks. Either way, automating software updates will surely relieve a lot of headache, even for people who aren't total geeks. I know it sure will for me.