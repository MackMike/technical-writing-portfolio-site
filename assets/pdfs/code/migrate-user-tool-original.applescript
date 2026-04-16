-- First, we need to get the old home folder name
-- Then we need to get the new home folder name
-- We need to verify that the new user's home folder name is correctly entered
-- This asks for the user name, then confirms it's correct. It gives the option to quit at 
-- this point. This script does not check LDAP to ensure the username is correct.

tell application "Finder"
	set validAnswer to false
	repeat while (validAnswer = false)
		display dialog "Please give me the Active Directory user's home folder name for the account you're migrating." default answer ""
		set ADUserName to text returned of result
		display dialog "Is " & ADUserName & " the correct Active Directory user name?" buttons {"Yes", "No", "Quit"} default button 1
		if result = {button returned:"Yes"} then
			set validAnswer to true
		else
			if result = {button returned:"Quit"} then error number -128
		end if
	end repeat
	
	-- Now that we have the AD user name, we need to confirm it's in the right place
	
	display dialog "Make sure the user's home folder is now in the /Users directory. Click 'OK' when that's done and not before" default button 1
	display dialog "LAST CHANCE! Bad things may happen if I don't have the correct name or the home folder isn't in the proper directory. Are you sure?" buttons {"No Way", "Go For It"} default button 1
	
	-- Now we try to change the owner and group permissions on the folder
	try
		do shell script "chown -R " & ADUserName & " /Users/" & ADUserName with administrator privileges
	on error
		display dialog "Something went wrong.  Sorry.
 It may be a typo, or I can't find the name in A.D."
		try
			do shell script "chgrp -R staff /Users/" & ADUserName with administrator privileges
		on error
			display dialog "Something went wrong.  Sorry.
 It may be a typo or I can't find the name in A.D."
		end try
		
	end try
	
	display dialog "Successfully migrated " & ADUserName
	
end tell