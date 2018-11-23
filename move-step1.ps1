Write-Host "Added to Phase 1"

#$logfile = "C:\Users\933621\Desktop\logs\log_$(get-date -format `"yyyyMMdd_hhmmsstt`").txt"
#function log($string)
#{
#$string | out-file -Filepath $logfile -append
#}
Start-Transcript -NoClobber "$env:HOMEPATH\Desktop\logs\log_$(get-date -format `"yyyyMMdd_hhmmsstt`").txt" 

function copyFile([string] $source, [string] $destination)
{
    Copy-Item $source $destination
}

$sourceFilePath = "C:\Users\933621\Desktop\scriptci\folder1\file1.rtf" 
$destinationFilePath = "C:\Users\933621\Desktop\scriptci\folder2" 

if (!$sourceFilePath.Trim("") -or !$destinationFilePath.Trim(""))
{
    echo "Enter valid paths"
    return
}

$fileName =  ($sourceFilePath.Split('\')[($sourceFilePath.Split('\')).Count - 1]) 
$destFilePath = "$destinationFilePath\$fileName"
$FileBaseName = $fileName.Split('.')[0]
$FileExt = $fileName.Split('.')[1]
echo $destFilePath

if(Test-Path $destFilePath)
{
   $timeStamp = Get-Date -UFormat "%Y%m%d_%H%M%S"
   $newName = "$FileBaseName-$timeStamp.$FileExt"
   echo $newName
 Rename-Item $destFilePath $newName 
 Move-Item "$destinationFilePath\$newName" "$destinationFilePath\backup"
 copyFile $sourceFilePath $destinationFilePath
}
else
{
    copyFile $sourceFilePath $destinationFilePath
}

echo "File Copied to destination $destinationFilePath"
Read-Host

Stop-Transcript





