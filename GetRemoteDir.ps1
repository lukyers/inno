$RemoteHost = "10.102.6.183"
$RemoteSoftwareRepo = "\\$RemoteHost\Softwares"
$username = "Administrator"
$password = "Password123!"
$RemoteSoftwareRepoPath = $RemoteSoftwareRepo + "\"

$ConfigxmlPath = ".\install_config.xml"

net use $RemoteSoftwareRepo $password /USER:$username /PERSISTENT:NO | Out-Null
#$RemoteSoftwareRepoPath = "c:\Softwares"
$dirs = Dir -name $RemoteSoftwareRepoPath

$FileIpy = $dirs | Where-Object {$_ -match "^IronPython.*-32bit.*.msi"}
$FolderIpybot = $dirs | Where-Object {$_ -match "^robotframework.*\d"}
$FolderElementTree = $dirs | Where-Object {$_ -match "^elementtree.*\d"}
$FilePython = $dirs | Where-Object {$_ -match "^python.*-32bit.*.msi"}
$FilePythonPip = $dirs | Where-Object {$_ -match "^get-pip.py"}
$FileWxPython = $dirs | Where-Object {$_ -match "^wxpython.*-win32.*.msi"}

Write-Host $FileIpy
Write-Host $FolderIpybot
Write-Host $FolderElementTree
Write-Host $FilePython
Write-Host $FilePythonPip
Write-Host $FileWxPython

net use $RemoteSoftwareRepo /DELETE | Out-Null

function GetXmlContent($xmlpath, $Elements, $contents)
{
    $xmldata = [xml](Get-Content $xmlpath)
    $newitem = $xmldata.CreateElement($Elements)

    $nodes = @()
    $array = New-Object System.Collections.Arraylist
    foreach ($node in $xmldata.Setup.$Elements){        
        $array.add($node)  | Out-Null 
    }
    $contents | foreach{
        $conte = $_
        $array | foreach {
            if ($_ -eq $conte) {
                
            }
            else
            {
                $newitem.set_InnerXML($conte) 
                $xmldata.Setup.AppendChild($newitem)  | Out-Null     
                #$xmldata.Items.ReplaceChild($newitem, $_)     
            }
        }
    }
    $xmldata.Save($xmlpath)
}

function GetInstallConfig
{
    GetXmlContent $ConfigxmlPath "FileIpy" $FileIpy
    GetXmlContent $ConfigxmlPath "FolderIpybot" $FolderIpybot
    GetXmlContent $ConfigxmlPath "FolderElementTree" $FolderElementTree
    GetXmlContent $ConfigxmlPath "FilePython" $FilePython
    GetXmlContent $ConfigxmlPath "FilePythonPip" $FilePythonPip
    GetXmlContent $ConfigxmlPath "FileWxPython" $FileWxPython
}

Write-Host Update install_config.xml
GetInstallConfig
Write-Host Finish Update install_config.xml