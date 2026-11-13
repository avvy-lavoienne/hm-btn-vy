#requires -Version 5.1
<#
    Memeriksa SHA-1 disc tanpa mengubah apa pun.
    Berguna sebelum patch dan untuk memastikan disc di laptop sama.
#>
[CmdletBinding()]
param(
    [string]$Path,
    [string]$Directory
)

$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$expectedSha1 = 'CB26381FA1336BDD15F07469E59F1143CCF37B03'

if (-not $Directory) { $Directory = Join-Path $root 'local\disc-original' }

$targets = @()
if ($Path) {
    $targets = @(Get-Item $Path)
}
elseif (Test-Path $Directory) {
    $targets = @(Get-ChildItem $Directory -Filter *.bin -File -ErrorAction SilentlyContinue)
}

if ($targets.Count -eq 0) {
    Write-Host "Tidak ada file .bin di $Directory" -ForegroundColor Yellow
    exit 1
}

foreach ($t in $targets) {
    Write-Host "Memeriksa $($t.Name) ($([math]::Round($t.Length / 1MB, 2)) MB) ..."
    $sha1 = (Get-FileHash $t.FullName -Algorithm SHA1).Hash
    Write-Host "  SHA-1 : $sha1"
    if ($sha1 -eq $expectedSha1) {
        Write-Host '  COCOK - disc USA bersih, siap dipatch.' -ForegroundColor Green
    }
    else {
        Write-Host '  TIDAK COCOK - bukan versi USA bersih atau sudah pernah dipatch.' -ForegroundColor Red
    }
}
