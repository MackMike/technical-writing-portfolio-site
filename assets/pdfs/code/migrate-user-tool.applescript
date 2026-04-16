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
¥ Enter the name exactly as it appears in /Users
¥ Do not enter the user's full name" default answer "" buttons {"Continue"} default button 1
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
¥ the account name is correct
¥ the home folder is in the correct location
¥ the Mac is bound to Active Directory" buttons {"Cancel", "Proceed"} default button "Proceed"
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
¥ The account name is correct
¥ The home folder exists in /Users
¥ The Mac is bound to Active Directory
¥ Administrator credentials were entered successfully

Error details:
" & errMsg buttons {"OK"} default button "OK"
	end try
end tell