$logoUrl = "/assets/logo.png"
$faviconTag = "<link rel=`"icon`" type=`"image/png`" href=`"$logoUrl`">"

Get-ChildItem -Filter *.html | Where-Object { $_.Name -ne 'thank-you.html' } | ForEach-Object {
    $content = Get-Content $_.FullName -Raw -Encoding UTF8
    $changed = $false

    # 1. Fix REPLACE_LOGO_URL in schema
    if ($content -match 'REPLACE_LOGO_URL') {
        $content = $content -replace 'REPLACE_LOGO_URL', $logoUrl
        $changed = $true
    }

    # 2. Add favicon before </head> if not already present
    if ($content -notmatch 'rel="icon"') {
        $content = $content -replace '(<script src="/tracking.js" defer>)', "$faviconTag`r`n`$1"
        $changed = $true
    }

    # 3. Replace text logo with image in header
    # Pattern: <a href="index.html" class="logo">Cottonvalle</a>
    if ($content -match '<a href="index\.html" class="logo">Cottonvalle</a>') {
        $content = $content -replace '<a href="index\.html" class="logo">Cottonvalle</a>',
            "<a href=`"index.html`" class=`"logo`"><img src=`"$logoUrl`" alt=`"Cotton Valle`" class=`"logo-img`"></a>"
        $changed = $true
    }

    # 4. Add CSS for logo-img if not present
    if ($content -notmatch '\.logo-img') {
        $content = $content -replace '(\.logo\{font-family)', ".logo-img{height:44px;vertical-align:middle}`$1"
        $changed = $true
    }

    if ($changed) {
        Set-Content -Path $_.FullName -Value $content -NoNewline -Encoding UTF8
        Write-Output "Updated: $($_.Name)"
    } else {
        Write-Output "Skip: $($_.Name)"
    }
}

Write-Output "`nDone!"
