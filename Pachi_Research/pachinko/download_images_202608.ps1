# Download images for pachinko 202608 new machines
# Machine 1: e SAO Alicization Yozora (ID: 5034) -> 08_sao_alicization
# Machine 2: e Gundam SEED CLIMAX (ID: 5045) -> 09_gundam_seed_climax

$ErrorActionPreference = "Stop"

$machines = @(
    @{ id = "5034"; folder = "08_sao_alicization" },
    @{ id = "5045"; folder = "09_gundam_seed_climax" }
)

foreach ($m in $machines) {
    $dir = Join-Path $PSScriptRoot "images\$($m.folder)"
    if (-not (Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
    }

    # cabinet.jpg
    $url = "https://cdn.p-town.dmm.com/machines/$($m.id)/filters:format(webp):no_upscale()/image.jpg"
    $out = Join-Path $dir "cabinet.jpg"
    if (-not (Test-Path $out)) {
        Write-Host "Downloading cabinet for $($m.folder)..."
        Invoke-WebRequest -Uri $url -OutFile $out -UseBasicParsing
    }

    # game_flow.jpg
    $url = "https://p-town.dmm.com/upload/machines/$($m.id)/flow.jpg"
    $out = Join-Path $dir "game_flow.jpg"
    if (-not (Test-Path $out)) {
        Write-Host "Downloading game_flow for $($m.folder)..."
        Invoke-WebRequest -Uri $url -OutFile $out -UseBasicParsing
    }

    # hit_rate.jpg (some machines use bonus.jpg instead)
    $out = Join-Path $dir "hit_rate.jpg"
    if (-not (Test-Path $out)) {
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
}

Write-Host "All downloads complete!"
