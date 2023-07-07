# Check what is/would be blocked by Applocker 
# author Florian Hansemann | https://hansesecure.de
# date 07.07.2023


function checkApplockerLog {

$system = $args[0]

rm temp.txt
echo "Is blocked by applocker"
Get-WinEvent -FilterHashtable @{logname="Microsoft-Windows-Applocker/*"; id=8004} -ComputerName $system | select Message -unique | Out-File temp.txt #-ComputerName WVDES230002 
cat temp.txt | foreach {echo $_.split(" ")[3]} | out-file blocked-by-applocker.txt
cat blocked-by-applocker.txt

sleep 5

rm temp.txt
echo "will be blocked by applcoker"
Get-WinEvent -FilterHashtable @{logname="Microsoft-Windows-Applocker/*"; id=8003} -ComputerName $system| select Message -unique | Out-File temp.txt #-ComputerName WVDES230002 
cat temp.txt | foreach {echo $_.split(" ")[3]} | out-file willbeblocked-by-applcoker.txt
cat willbeblocked-by-applcoker.txt
}


