#requires -Version 5.1
<#
    Membungkus folder kerja menjadi zip portable untuk dipindah ke laptop.
    Hasil: dist\hm-btn-vy-portable.zip
#>
[CmdletBinding()]
param(
    [string]$Output
)

$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot

foreach ($need in @('emulator', 'local\disc-patched')) {
    if (-not (Test-Path (Join-Path $root $need))) {
        throw "Folder $need belum ada. Jalankan scripts\setup.ps1 dan scripts\apply-patch.ps1 lebih dulu."
    }
}

$staging = Join-Path $root 'dist\_staging'
if (Test-Path $staging) { Remove-Item $staging -Recurse -Force }
New-Item -ItemType Directory -Force -Path $staging | Out-Null

$copy = @('emulator', 'tools', 'patch', 'bios', 'docs')
foreach ($c in $copy) {
    $src = Join-Path $root $c
    if (Test-Path $src) {
        Copy-Item $src -Destination (Join-Path $staging $c) -Recurse -Force
    }
}

New-Item -ItemType Directory -Force -Path (Join-Path $staging 'local') | Out-Null
Copy-Item (Join-Path $root 'local\disc-patched') -Destination (Join-Path $staging 'local\disc-patched') -Recurse -Force
Copy-Item (Join-Path $root 'PLAY.bat') -Destination $staging -Force
Copy-Item (Join-Path $root 'README.md') -Destination $staging -Force
Remove-Item (Join-Path $staging 'emulator\cache') -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item (Join-Path $staging 'emulator\updater.exe') -Force -ErrorAction SilentlyContinue
Remove-Item (Join-Path $staging 'emulator\uninstaller.exe') -Force -ErrorAction SilentlyContinue

if (-not $Output) {
    New-Item -ItemType Directory -Force -Path (Join-Path $root 'dist') | Out-Null
    $Output = Join-Path $root 'dist\hm-btn-vy-portable.zip'
}

if (Test-Path $Output) { Remove-Item $Output -Force }
Compress-Archive -Path (Join-Path $staging '*') -DestinationPath $Output -CompressionLevel Optimal
Remove-Item $staging -Recurse -Force

$z = Get-Item $Output
Write-Host "Zip    : $($z.FullName)"
Write-Host "Ukuran : $([math]::Round($z.Length / 1MB, 1)) MB"
Write-Host "SHA256 : $((Get-FileHash $z.FullName -Algorithm SHA256).Hash)"
