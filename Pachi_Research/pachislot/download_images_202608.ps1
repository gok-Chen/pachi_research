# Download images for pachislot 202608 new machines
# Machine: スマスロ とある魔術の禁書目録2 (ID: 5053) -> 09_toaru_index2

$ErrorActionPreference = "Stop"

$machines = @(
    @{ id = "5053"; folder = "09_toaru_index2" }
)

foreach ($m in $machines) {
    $dir = Join-Path $PSScriptRoot "images\$($m.folder)"
    if (-not (Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
    }

    # cabinet.jpg
    $url = "https://cdn.p-town.dmm.com/machines/$($m.id)/filters:format(webp):no_upscale()/image.jpg"
    $out = Join-Path $dir "cabinet.jpg"
    Write-Host "Downloading cabinet for $($m.folder)..."
    Invoke-WebRequest -Uri $url -OutFile $out -UseBasicParsing

    # game_flow.jpg
    $url = "https://p-town.dmm.com/upload/machines/$($m.id)/flow.jpg"
    $out = Join-Path $dir "game_flow.jpg"
    Write-Host "Downloading game_flow for $($m.folder)..."
    Invoke-WebRequest -Uri $url -OutFile $out -UseBasicParsing

    # hit_rate.jpg (some machines use bonus.jpg instead)
    $out = Join-Path $dir "hit_rate.jpg"
    $url = "https://p-town.dmm.com/upload/machines/$($m.id)/hit_rate.jpg"
    try {
        Write-Host "Downloading hit_rate for $($m.folder)..."
        Invoke-WebRequest -Uri $url -OutFile $out -UseBasicParsing
    } catch {
        Write-Host "hit_rate.jpg not found, trying bonus.jpg..."
        $url = "https://p-town.dmm.com/upload/machines/$($m.id)/bonus.jpg"
        Invoke-WebRequest -Uri $url -OutFile $out -UseBasicParsing
    }
}

Write-Host "All downloads complete!"
