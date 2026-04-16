# Migrate User Administrative Tool Project Page

## Project Background

This sample is based on an internal AppleScript-based macOS administrative tool originally used in an enterprise migration workflow. After a Mac was reimaged and a user’s home folder had already been restored to the target system, the tool was used to update ownership and group permissions so the user could successfully log in and access their files.

The version included in this portfolio preserves the original workflow and administrative purpose while revising the surrounding documentation and script presentation to better reflect technical writing best practices.

## My Role

I revised and edited the documentation and supporting script content for this tool. My work included:

- improving the administrator README
- refining task instructions
- clarifying warnings and prerequisites
- revising user-facing dialog text
- strengthening code comments for readability and maintainability
- making minor script refinements to improve readability and error handling

## Revision Focus

The portfolio version was updated to better support an administrator audience and to present the workflow more clearly as a technical documentation sample. Revision priorities included:

- clearer audience targeting
- more explicit prerequisites
- stronger warning and confirmation language
- improved consistency in terminology and instructions
- more maintainable code comments
- more usable, task-focused documentation structure

## Project Documents

### Administrator Guide
Administrator-facing instructions covering the tool’s purpose, prerequisites, limitations, usage steps, and expected results.

```
applescript

-- Migrate User Application
-- Portfolio edition
--
-- Purpose:
-- Restore ownership and group permissions on a migrated user home folder
-- after a Mac has been reimaged.
--
-- Intended audience:
-- Platform administrators, desktop support technicians, and macOS administrators
--
-- Assumptions:
-- 1. The user's home folder has already been copied to /Users on the target Mac.
-- 2. The entered value matches the user's short name/home folder name exactly.
-- 3. The Mac is bound to Active Directory.
-- 4. The administrator running the script has valid admin credentials.
--
-- This script does not validate the entered account name against LDAP or Active Directory.

tell application "Finder"
	set validAnswer to false
	
	-- Prompt for the user's short name/home folder name and require confirmation.
	repeat while (validAnswer = false)
		display dialog "Enter the Active Directory short name (home folder name) for the account being migrated.

Important:
• Enter the name exactly as it appears in /Users
• Do not enter the user's full name" default answer "" buttons {"Continue"} default button 1
		set ADUserName to text returned of result
		
		display dialog "Confirm the account name:

" & ADUserName & "

This value must exactly match the user's home folder name in /Users." buttons {"Re-enter", "Quit", "Confirm"} default button "Confirm"
		
		if button returned of result is "Confirm" then
			set validAnswer to true
		else if button returned of result is "Quit" then
			error number -128
		end if
	end repeat
	
	-- Confirm that the migrated home folder is already in the expected location.
	display dialog "Verify that the user's home folder has already been copied to the /Users directory on this Mac.

Select OK only after this has been confirmed." buttons {"OK", "Cancel"} default button "OK"
	if button returned of result is "Cancel" then error number -128
	
	-- Provide a final confirmation before permissions are updated.
	display dialog "Final confirmation:

This tool will update ownership and group permissions for:
/Users/" & ADUserName & "

Proceed only if:
• the account name is correct
• the home folder is in the correct location
• the Mac is bound to Active Directory" buttons {"Cancel", "Proceed"} default button "Proceed"
	if button returned of result is "Cancel" then error number -128
	
	-- Apply ownership to the specified home folder.
	try
		do shell script "chown -R " & quoted form of ADUserName & " /Users/" & quoted form of ADUserName with administrator privileges
		
		-- Apply the staff group to the same home folder.
		do shell script "chgrp -R staff /Users/" & quoted form of ADUserName with administrator privileges
		
		display dialog "Migration completed successfully for account:

" & ADUserName buttons {"OK"} default button "OK"
		
	on error errMsg number errNum
		display dialog "The migration could not be completed.

Check the following and try again:
• The account name is correct
• The home folder exists in /Users
• The Mac is bound to Active Directory
• Administrator credentials were entered successfully

Error details:
" & errMsg buttons {"OK"} default button "OK"
	end try
end tell
```
- [Open Administrator README](../assets/pdfs/migrate-user-admin-readme.md)

### Revised AppleScript
Portfolio edition of the script with improved comments, prompts, warnings, and readability refinements.

- [Open Revised AppleScript](https://mackmike.github.io/technical-writing-portfolio-site/assets/pdfs/code/migrate-user-tool.applescript)

### Original AppleScript
Original version of the script included to show the basis for revision and improvement.

- [Open Original AppleScript](https://mackmike.github.io/technical-writing-portfolio-site/assets/pdfs/code/migrate-user-tool-original.applescript)

## Comparison Value

Including both the original and revised script helps demonstrate the editing and documentation value of this sample. It shows how technical writing improvements can strengthen an internal administrative tool by making it easier to understand, safer to use, and easier to maintain.

Areas of improvement include:

- clearer user-facing prompts
- more explicit warning language
- improved administrator guidance
- more readable code comments
- cleaner presentation for portfolio review

## Notes

This repository contains a portfolio edition of the original internal tool and documentation. It is included to demonstrate documentation revision and editing rather than original software development.

The sample preserves the core workflow and administrative purpose of the original utility, but it does not represent a production-supported enterprise tool.

## Related Materials

If included, supporting materials may also show:

- before-and-after excerpts from the README
- before-and-after dialog text revisions
- selected examples of improved code comments
- documentation notes explaining revision decisions
