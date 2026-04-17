$testExecutePath = "C:\Program Files (x86)\SmartBear\TestExecute 15\x64\Bin\TestExecute.exe"
$projectFile = "dummy.pjs"

if (-not (Test-Path $testExecutePath)) {
    Write-Error "TestExecute not found at: $testExecutePath"
    exit 1
}

try {
    Write-Host "Setting execution policy..."
    Start-Process -FilePath "powershell.exe" -ArgumentList "-Command", "Set-ExecutionPolicy -ExecutionPolicy Bypass" -Verb RunAs -Wait

    Write-Host "Running TestExecute in silent mode..."
    $process = Start-Process -FilePath $testExecutePath -ArgumentList $projectFile, "/r", "/e", "/SilentMode", "/ns" -Wait -PassThru -NoNewWindow

    Write-Host "TestExecute completed with exit code: $($process.ExitCode)"
    exit $process.ExitCode
} catch {
    Write-Error "Error running TestExecute: $_"
    exit 1
}
