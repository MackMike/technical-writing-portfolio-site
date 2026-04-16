# Migrate User Application

Administrator-focused documentation sample for an AppleScript tool used to restore ownership and group permissions on a migrated macOS home folder after reimaging.

## Repository Contents
- `README.md` — administrator guide and usage documentation
- `MigrateUser-portfolio.applescript` — revised portfolio edition of the script
- `historical-note.md` — context on the original internal tool and portfolio revisions
- `portfolio-description.md` — concise project summary

## Overview
The **Migrate User** application is an AppleScript-based administrative tool designed to help restore ownership and group permissions on a user’s home folder after a Mac has been reimaged.

The script assumes the user’s existing home folder has already been copied to the newly imaged Mac and placed in the `/Users` directory. It then updates ownership and group settings so the user can log in and access the migrated home folder.

## Intended Audience
This tool is intended for:

- Platform administrators
- Desktop support technicians
- macOS administrators

It is **not** intended for end users.

## Use Case
This tool supports scenarios in which:

- a Mac has been reimaged
- the user’s original home folder has been restored or copied to the machine
- ownership and group permissions must be updated before the user logs in

## Requirements
Before running this application, verify the following:

1. **Administrator credentials are available**  
   The script runs commands that require administrative privileges.

2. **The user’s home folder already exists in `/Users`**  
   Copy or restore the user’s home folder to the newly imaged Mac before running the application.

3. **The Mac is bound to Active Directory**  
   The system must already be bound to Active Directory so the user account can be resolved correctly at login.

4. **You know the user’s short name / home folder name**  
   When prompted, enter the user’s **short name / home folder name**, not the user’s full name.

   Example:  
   If the user’s home folder is:

   `/Users/bigboy.billybob`

   enter:

   `bigboy.billybob`

   Do **not** enter:
   - the user’s full name
   - a display name
   - an account name that does not exactly match the home folder name

## Important Limitation
This application does **not** validate the entered account name against LDAP or Active Directory.

Before proceeding, verify that:

- the entered name exactly matches the home folder name in `/Users`
- the home folder belongs to the intended user
- the Mac is correctly bound to Active Directory

## What the Script Does
The script runs the equivalent of the following commands:

```bash
chown -R <username> /Users/<username>
chgrp -R staff /Users/<username>
```
These commands:

* assign ownership of the migrated home folder to the specified user
* assign the folder group to staff

Expected Result
After the script completes successfully:

* the user’s home folder should have the correct ownership and group settings
* the user should be able to log in to the reimaged Mac
* the user’s migrated files and home folder contents should be accessible after login

⚠️ **Caution**

Running this tool with an incorrect account name or with the home folder placed in the wrong location may result in incorrect permissions being applied.

Before selecting Proceed, confirm that:

* the home folder is located at /Users/<username>
* the entered account name exactly matches the home folder name
* the Mac is bound to Active Directory

Troubleshooting

If the script fails:

* verify that the username was entered correctly
* confirm that the home folder exists in /Users
* confirm that the Mac is bound to Active Directory
* confirm that administrator credentials were entered when prompted

## Additional Project Notes

* [Historical Note](historical-note.md)
* [Portfolio Description](portfolio-description.md)
