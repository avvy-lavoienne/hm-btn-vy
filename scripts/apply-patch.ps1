#requires -Version 5.1
<#
    Memverifikasi disc bersih lalu menerapkan patch v1.6.
    Sumber tidak pernah diubah. Hasil ditulis ke local\disc-patched\.
#>
[CmdletBinding()]
param(
    [string]$Source,
    [switch]$Force
)

$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot

$expectedSha1 = 'CB26381FA1336BDD15F07469E59F1143CCF37B03'

if (-not $Source) {
    $bins = @(Get-ChildItem (Join-Path $root 'local\disc-original') -Filter *.bin -File -ErrorAction SilentlyContinue)
    if ($bins.Count -eq 0) {
        throw "Tidak ada .bin di local\disc-original\. Taruh disc bersih di sana atau pakai -Source <path>."
    }
    if ($bins.Count -gt 1) {
        throw "Ada lebih dari satu .bin. Tentukan dengan -Source <path>."
    }
    $Source = $bins[0].FullName
}

if (-not (Test-Path $Source)) { throw "File tidak ditemukan: $Source" }

$sourceItem = Get-Item $Source
$sha1 = (Get-FileHash $Source -Algorithm SHA1).Hash
Write-Host "Sumber      : $($sourceItem.Name)"
Write-Host "Ukuran      : $([math]::Round($sourceItem.Length / 1MB, 2)) MB"
Write-Host "SHA-1       : $sha1"

if ($sha1 -ne $expectedSha1) {
    if (-not $Force) {
        throw 'Disc bukan versi USA bersih (SLUS-01115). Patch akan gagal. Pakai -Force untuk tetap mencoba.'
    }
    Write-Warning 'Hash tidak cocok, lanjut karena -Force.'
}

$xdelta = Get-ChildItem (Join-Path $root 'tools\xdelta3') -Filter xdelta3.exe -File -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1
if (-not $xdelta) {
    throw 'xdelta3.exe tidak ditemukan. Jalankan scripts\setup.ps1 lebih dulu.'
}

$patch = Join-Path $root 'patch\Harvest.Moon.Back.To.Nature.Plus.v1.6.xdelta'
if (-not (Test-Path $patch)) {
    throw 'File patch tidak ditemukan. Jalankan scripts\setup.ps1 lebih dulu.'
}

$outDir = Join-Path $root 'local\disc-patched'
New-Item -ItemType Directory -Force -Path $outDir | Out-Null
$target = Join-Path $outDir 'HARVESTMOON.bin'

Write-Host ''
Write-Host 'Menerapkan patch...'
& $xdelta.Source -d -f -s $Source $patch $target
if ($LASTEXITCODE -ne 0) { throw "xdelta3 gagal dengan kode $LASTEXITCODE" }

$cue = @(
    'FILE "HARVESTMOON.bin" BINARY'
    '  TRACK 01 MODE2/2352'
    '    INDEX 01 00:00:00'
)
Set-Content -Path (Join-Path $outDir 'HARVESTMOON.cue') -Value $cue -Encoding ASCII

$outItem = Get-Item $target
Write-Host ''
Write-Host "Hasil       : $($outItem.FullName)"
Write-Host "Ukuran      : $([math]::Round($outItem.Length / 1MB, 2)) MB"
Write-Host "SHA-1       : $((Get-FileHash $target -Algorithm SHA1).Hash)"
Write-Host ''
Write-Host 'Siap dimainkan. Jalankan PLAY.bat.'
