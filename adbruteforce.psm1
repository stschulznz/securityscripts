<# 
This very basic PowerShell script has been created to test for weak Active Directory passwords using the users/passwords specified in userlist/passwordlist files.
First, import the script (import-module adbruteforce.psm1). Then execute as per: adbruteforce <userlist.txt> <AD domain> <passwordlist.txt>.
 #>
Function testlogin {
    param($u,$p)
    $null -ne (new-object directoryservices.directoryentry "",$u,$p).psbase.name
  }
   
  Function adbruteforce {
    param($userlist,$addomain,$passswordlist)
  
    if (!$passswordlist) {
      Write-Host "Usage: adbruteforce <userlist.txt> <AD domain> <passwordlist.txt>"
      Write-Host "Example: adbruteforce users.txt addomain.com passwords.txt"
      return
    }
  
    foreach($line1 in gc $userlist) {
        foreach($line2 in gc $passswordlist) {

      $output = "$line1,$line2,"
      $output += testlogin "$addomain\$line1" "$line2"
      Write-Host "$output"
    }
      
    }
  }
