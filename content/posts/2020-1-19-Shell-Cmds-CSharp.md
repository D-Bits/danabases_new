+++
title = 'Invoking Shell Commands in C# Programs'
date = 2020-01-19
tags = ["c-sharp"] 
+++

After extensive wrangling and experimentation, I finally have managed to
successfully invoke external commands in C# programs, which I hope will make
me a considerably more productive C# programmer. So without further ado, let's
dive into the nitty gritty details.

### Purpose

First, you might ask: why would one need to do this? Ultimately, the potential
to automate all sorts of things by invoking external commands inside a program
are nearly limitless. I have already been relying heavily on `subprocess.run()`
in Python's standard library to do exactly that for a while now. Yet, as much
as I have been utilizing that, I recently started to explore if I could implement
the same, or at least similar, functionality in other languages. C# has long been 
my designated language to fall back on, when Python isn't ideal for the task
at hand, such as when I need to easily cross-compile binaries. Therefore, I 
started looking for whatever documentation and guides I could find on the 
topic. 

## Implementation

In the following example, we will be executing a command to update currently
installed software on Windows, via the Chocolatey package manager.

```c#
using System;
using System.Diagnostics;

public static void WindowsUpdates()
{
    try
    {
        // Update all packages install via Chocolatey
        var ChocoUpdates = Process.Start("CMD.exe", "/K choco upgrade all");
    }
    catch (Exception ex)
    {
        // If there is an exception, output the error message
        Console.WriteLine("ERROR: " + ex.Message);
    }
}
```

This next example (part of the same class) will update MacOS software, via
Homebrew.

```c#
using System;
using System.Diagnostics;

// Automate updates on MacOS via Homebrew
public static void HomebrewUpdates()
{
    try
    {
        // Ensure downloadable packages are up-to-date
        var HomebrewUpdate = Process.Start("/bin/bash", "-c brew update");
        // Update all installed packages
        var HomebrewUpgrade = Process.Start("/bin/bash", "-c brew upgrade");
    }
    catch (Exception ex)
    {
        Console.WriteLine("ERROR: " + ex.Message);
    }
}
```

Notice how we have to do things a little differently when working with Bash
commands. Instead of starting our string that contains our command (and arguments) 
with *-K*, like we did with Command Prompt commands, we now begin them with a
*-c*. We also have to pass in *"/bin/bash"*, rather than *"CMD.exe"*. Otherwise,
the basic idea is the same. 

You can view the rest of the source code for this project 
<a href="https://github.com/d-bits/syscentral" target="blank">here</a>.

## Conclusions

While invoking shell commands in C# with `Process.Start()` has not been quite
as intuitive as Python's `subprocess.run()`, and it was rather difficult to
find accurate documentation, being able to now do so effectively will be very
helpfully in reimplementing certain past projects in C#.  In addition to that,
I will also look into what other things I can automate with `Process.Start()`.

<br>