#requires -Version 5.1
<#
    Menyiapkan folder kerja: emulator, patcher, xdelta3, dan file patch v1.6.
    Tidak mengunduh file game. Disc dan BIOS harus disediakan sendiri.
#>
[CmdletBinding()]
param(
    [switch]$Force
)

$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot

$dirs = @(
    'emulator', 'tools', 'patch', 'bios', 'downloads',
    'local\disc-original', 'local\disc-patched'
)
foreach ($d in $dirs) {
    New-Item -ItemType Directory -Force -Path (Join-Path $root $d) | Out-Null
}

$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$items = @(
    @{
        Name    = 'duckstation.zip'
        Url     = 'https://github.com/stenzek/duckstation/releases/download/latest/duckstation-windows-x64-release.zip'
        Sha256  = 'CA02E8EAC40C0C6DE801638F6B16BEC80B605B5DF32E406FE2FBA7F21016B14B'
        Strict  = $false
        Note    = 'rolling release, hash bisa berubah'
    },
    @{
        Name    = 'deltapatcher.zip'
        Url     = 'https://github.com/marco-calautti/DeltaPatcher/releases/download/v3.1.6/windows_bin_x86_64.zip'
        Sha256  = '6FAE5D8AF839339A9ADAF053F30D9444476EE2CA45CB0F38049F7C82BA5C01BE'
        Strict  = $true
        Note    = ''
    },
    @{
        Name    = 'xdelta3.zip'
        Url     = 'https://github.com/jmacd/xdelta/releases/download/v3.2.2/xdelta3-3.2.2-windows-x86_64.zip'
        Sha256  = 'D48F7651D86B78FDCA397057B46601F89131F37219675DF736DB70AF44EC3379'
        Strict  = $true
        Note    = ''
    }
)

foreach ($it in $items) {
    $out = Join-Path $root ('downloads\' + $it.Name)
    if ((Test-Path $out) -and -not $Force) {
        Write-Host "[skip] $($it.Name) sudah ada"
    }
    else {
        Write-Host "[get ] $($it.Name)"
        Invoke-WebRequest -Uri $it.Url -OutFile $out -UseBasicParsing
    }

    $got = (Get-FileHash $out -Algorithm SHA256).Hash
    if ($got -ne $it.Sha256) {
        if ($it.Strict) {
            throw "Hash tidak cocok untuk $($it.Name). Hapus file itu lalu ulangi dengan -Force."
        }
        Write-Warning "Hash $($it.Name) berbeda dari catatan ($($it.Note)). Lanjut."
    }
    else {
        Write-Host "[ok  ] $($it.Name) terverifikasi"
    }
}

Write-Host '[ext] emulator'
Expand-Archive -Path (Join-Path $root 'downloads\duckstation.zip') -DestinationPath (Join-Path $root 'emulator') -Force
Set-Content -Path (Join-Path $root 'emulator\portable.txt') -Value '' -Encoding ASCII

Write-Host '[ext] tools'
Expand-Archive -Path (Join-Path $root 'downloads\deltapatcher.zip') -DestinationPath (Join-Path $root 'tools') -Force
Expand-Archive -Path (Join-Path $root 'downloads\xdelta3.zip') -DestinationPath (Join-Path $root 'tools\xdelta3') -Force

$patchFile = Join-Path $root 'patch\Harvest.Moon.Back.To.Nature.Plus.v1.6.xdelta'
if (-not (Test-Path $patchFile)) {
    Write-Host '[get ] patch v1.6'
    $patchUrl = 'https://github.com/Fragrant-radish/HM-back-to-nature-plus/releases/download/v1.6/Harvest.Moon.Back.To.Nature.Plus.v1.6.xdelta'
    Invoke-WebRequest -Uri $patchUrl -OutFile $patchFile -UseBasicParsing
    $ph = (Get-FileHash $patchFile -Algorithm SHA256).Hash
    if ($ph -ne '270BFA11140E9A26B378626D513595798C5E41DCE0D207A92180B2CBD3A3A978') {
        throw 'Hash file patch tidak cocok. Unduhan mungkin rusak, ulangi dengan -Force.'
    }
    Write-Host '[ok  ] patch v1.6 terverifikasi'
}
else {
    Write-Host '[skip] patch v1.6 sudah ada'
}

$biosSrc = Get-ChildItem (Join-Path $root 'bios') -Filter *.bin -File -ErrorAction SilentlyContinue | Select-Object -First 1
if ($biosSrc) {
    New-Item -ItemType Directory -Force -Path (Join-Path $root 'emulator\bios') | Out-Null
    Copy-Item $biosSrc.FullName -Destination (Join-Path $root 'emulator\bios\scph5501.bin') -Force
    Write-Host "[ok  ] BIOS disalin ke emulator\bios: $($biosSrc.Name)"
}
else {
    Write-Warning 'Belum ada BIOS di folder bios\. Letakkan scph5501.bin di sana, lalu jalankan ulang skrip ini.'
}

Write-Host ''
Write-Host 'Selesai. Langkah berikutnya:'
Write-Host '  1. Taruh disc bersih (.bin + .cue) di local\disc-original\'
Write-Host '  2. Taruh BIOS USA di bios\scph5501.bin'
Write-Host '  3. powershell -ExecutionPolicy Bypass -File .\scripts\apply-patch.ps1'
Write-Host '  4. Jalankan PLAY.bat'
