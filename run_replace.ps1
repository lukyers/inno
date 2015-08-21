$IniFile_NME = "C:\Users\zhangr32\Desktop\inno\config.ini"
$DesFile_NME = "C:\Users\zhangr32\Desktop\inno\Install.ps1"
#$IniFile_NME = ".\config.ini"
#$DesFile_NME = ".\Install.ps1"
$config = @{}

Get-Content $IniFile_NME | foreach {
    $line = $_.split("=")
    $config.($line[0]) = $line[1]
}

$RemoteHost = $config.("RemoteHost")
$RemoteSoftwareRepo = $config.("RemoteSoftwareRepo")
$username = $config.("Username")
$password = $config.("password")

$FileIpy = $config.("FileIpy")
$FolderIpybot = $config.("FolderIpybot")
$FolderElementTree = $config.("FolderElementTree")
$FilePython = $config.("FilePython")
$FilePythonPip = $config.("FilePythonPip")
$FileWxPython = $config.("FileWxPython")

$PythonPipPackages = $config.("PythonPipPackages")

Write-Host "RemoteHost = " $RemoteHost
Write-Host "RemoteSoftwareRepo = " $RemoteSoftwareRepo
Write-Host "username = " $username
Write-Host "password = " $password

Write-Host "FileIpy = " $FileIpy
Write-Host "FolderIpybot = " $FolderIpybot
Write-Host "FolderElementTree = " $FolderElementTree
Write-Host "FilePython = " $FilePython
Write-Host "FilePythonPip = " $FilePythonPip
Write-Host "FileWxPython = " $FileWxPython

Write-Host "PythonPipPackages = " $PythonPipPackages

Write-Host 'Press Any Key!' -NoNewline
$null = [Console]::ReadKey('?')