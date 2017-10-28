function Set-VsCmd
{
	$targetDir = "C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\Common7\Tools\"
	$vcvars = "C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\Common7\Tools\VsDevCmd.bat"
	
	Push-Location $targetDir
	cmd /c $vcvars + "&set" |
	ForEach-Object {
		if ($_ -match "(.*?)=(.*)")
		{
			Set-Item -force -path "ENV:\$($matches[1])" -value "$($matches[2])"
		}
	}
	Pop-Location
	write-host "Visual Studio 10 Command Prompt variables set" -ForegroundColor Yellow
}

Write-Host "Starting build process" -ForegroundColor Green
git clone https://github.com/robertdavidgraham/masscan.git --depth=1
Set-Location .\masscan
Set-VsCmd
$args = @("/verbosity:minimal", "/t:Build", "/p:Configuration=Release;Platform=x64")
& msbuild ".\vs10\masscan.sln" $args
Set-Location ".."
Move-Item ".\masscan\bin\masscan.exe" ".\masscan.exe"
Remove-Item ".\masscan\" -Force -Recurse
