+++
title = 'Easy Postgres Installation and Setup on Windows with Chocolatey'
date = 2020-02-15
tags = ["sql", "automation"] 
+++

This post will be demonstrating how to easily install, configure and update a PostgreSQL instance on Windows, specifically via the [Chocolatey](https://chocolatey.org/) package manager. Yes, you can always take the old school route by going to the [official Postgres website](https://www.postgresql.org/download/), and download an installer, followed by clicking through a wizard a bunch of times. However, using a package manager makes it easier to install, and much easier to update regularly. 

## Installing Chocolatey

To install Chocolatey, you will first need to open a Powershell terminal, specifically in admin mode. Next, run `Get-ExecutionPolicy`. If it says "restricted", then you will need to run either `Set-ExecutionPolicy AllSigned` or `Set-ExecutionPolicy Bypass -Scope Process`.
 
Then, copy and paste the following into your terminal:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```

This will install Chocolatey on your system. Once its done, run the command `choco -v`. If it outputs a version number (0.10.15, at the time of this writing), then we know that Chocolatey was installed successfully. 

## Installing Postgres

With that sorted out, we can now quickly install Postgres by running `choco install postgresql`. Enter `y` when prompted to. You will see that it sets a default (random hex value) password for the `postgres` user. **IMPORTANT:** Quickly copy and paste this default password from your terminal into a safe place, like a password manager, as you will need it to connect to the server. I highly recommend changing it to something more secure at your earliest convenience with an `ALTER USER` query. The installation will also default to listening on port 5432. This is installation should also include the "stack builder" tool for adding extensions. Once that's done, you should be more-or-less ready to go!

## Additional Configurations

In addition to changing the default password, we should also add `psql.exe` to `$PATH`, so we can connect to and query databases on our server by running `psql` from Powershell, or the command prompt. `psql.exe` should be located in `C:\Program Files\PostgreSQL\12\bin`. Once you successfully add `psql` to `$PATH`, then try running `psql` from a terminal. If it doesn't throw any errors, then you succeeded. While there are certainly any number of other configs that you can do, that should be all that's needed for now. Happy querying!

## Final Thoughts

Going forward, it is going to be at lot easier to update my Postgres instance, along with other software that I have installed on my Windows machine. I don't think I will be able to easily go back to the whole *download an installer and click through wizard setup*. That now just seems crude and primitive. Therefore, don't always assume that installing and setting up a database server (or other software, for that matter) has to be super complicated.
