# Writes draft-1..5.html (the package icon drafts), renders each with headless Chrome at 1024x1024 on a transparent
# background, scales to 256 and builds drafts.png (all five side by side). The plate, rim, grain, divider and
# lettering are those of the bridge's icon (SeneaLUI-PovSkills\icon-src\icon.html, UIDESIGN.md); only the emblem differs.
$here = $PSScriptRoot
$chrome = 'C:\Program Files\Google\Chrome\Application\chrome.exe'

function Page($emblem, $label, $size) {
@"
<!doctype html>
<html><head><meta charset="utf-8">
<style>
@font-face { font-family: Forum; src: url("file:///S:/Valheim-Modding/Decompiled-Vault/SeneaL_UI-1.2.8/SeneaLUI.Fonts.Forum-Regular.ttf"); }
html, body { margin: 0; background: transparent; }
svg { display: block; }
</style></head>
<body>
<svg width="1024" height="1024" viewBox="0 0 1024 1024" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="rim" x1="0" y1="0" x2="1" y2="1">
      <stop offset="0" stop-color="#C9A660"/><stop offset=".5" stop-color="#8E7240"/><stop offset="1" stop-color="#B8954F"/>
    </linearGradient>
    <linearGradient id="plate" x1="0" y1="0" x2="0" y2="1">
      <stop offset="0" stop-color="#26211B"/><stop offset="1" stop-color="#16120F"/>
    </linearGradient>
    <pattern id="grain" width="10" height="10" patternUnits="userSpaceOnUse">
      <rect width="10" height="10" fill="none"/><rect width="2" height="10" fill="#ffffff" opacity=".045"/>
    </pattern>
    <linearGradient id="gold" x1="0" y1="0" x2="0" y2="1">
      <stop offset="0" stop-color="#F4DA97"/><stop offset=".55" stop-color="#E2BE70"/><stop offset="1" stop-color="#B98F48"/>
    </linearGradient>
    <linearGradient id="line" x1="0" y1="0" x2="1" y2="0">
      <stop offset="0" stop-color="#D9B76D" stop-opacity="0"/><stop offset=".25" stop-color="#D9B76D"/>
      <stop offset=".75" stop-color="#D9B76D"/><stop offset="1" stop-color="#D9B76D" stop-opacity="0"/>
    </linearGradient>
    <filter id="shadow" x="-30%" y="-30%" width="160%" height="160%">
      <feDropShadow dx="0" dy="10" stdDeviation="12" flood-color="#000" flood-opacity=".55"/>
    </filter>
    <clipPath id="plateClip"><rect x="32" y="32" width="960" height="960" rx="116"/></clipPath>
  </defs>
  <rect x="32" y="32" width="960" height="960" rx="116" fill="url(#plate)"/>
  <rect x="32" y="32" width="960" height="960" rx="116" fill="url(#grain)" clip-path="url(#plateClip)"/>
  <rect x="32" y="32" width="960" height="960" rx="116" fill="none" stroke="url(#rim)" stroke-width="11"/>
  <rect x="66" y="66" width="892" height="892" rx="90" fill="none" stroke="#D9B76D" stroke-opacity=".28" stroke-width="4"/>
  <g filter="url(#shadow)">
$emblem
  </g>
  <rect x="190" y="756" width="644" height="6" fill="url(#line)"/>
  <rect x="404" y="745" width="28" height="28" transform="rotate(45 418 759)" fill="#E6C67C"/>
  <rect x="490" y="737" width="44" height="44" transform="rotate(45 512 759)" fill="#1C1814" stroke="#E6C67C" stroke-width="7"/>
  <rect x="592" y="745" width="28" height="28" transform="rotate(45 606 759)" fill="#E6C67C"/>
  <text x="512" y="905" text-anchor="middle" font-family="Forum" font-size="$size" letter-spacing="14"
        fill="url(#gold)" stroke="#E2BE70" stroke-width="5" stroke-linejoin="round" filter="url(#shadow)">$label</text>
</svg>
</body></html>
"@
}

$drafts = [ordered]@{}

# 1. The mended node: SeneaL's hex, cracked by the update, held shut by three brass staples.
$drafts['1'] = @(@'
    <polygon points="512,205 707,318 707,542 512,655 317,542 317,318" fill="#1B1713" stroke="url(#gold)" stroke-width="20" stroke-linejoin="round"/>
    <polyline points="548,212 478,322 552,430 474,538 520,648" fill="none" stroke="#D9B76D" stroke-opacity=".85" stroke-width="9" stroke-linejoin="round" stroke-linecap="round"/>
    <g fill="url(#gold)" stroke="#5E4419" stroke-opacity=".5" stroke-width="5">
      <rect x="436" y="306" width="150" height="32" rx="16" transform="rotate(-8 511 322)"/>
      <rect x="437" y="414" width="150" height="32" rx="16" transform="rotate(6 512 430)"/>
      <rect x="436" y="522" width="150" height="32" rx="16" transform="rotate(-8 511 538)"/>
    </g>
'@, 'UI', 150)

# 2. Wrench and rising chevrons: a repair that follows the game upward.
$drafts['2'] = @(@'
    <g transform="rotate(45 470 440)">
      <rect x="436" y="330" width="68" height="330" rx="34" fill="url(#gold)" stroke="#5E4419" stroke-opacity=".5" stroke-width="5"/>
      <circle cx="470" cy="286" r="104" fill="url(#gold)" stroke="#5E4419" stroke-opacity=".5" stroke-width="5"/>
      <rect x="432" y="160" width="76" height="140" rx="14" fill="#211C17"/>
      <circle cx="470" cy="616" r="15" fill="#211C17"/>
    </g>
    <g fill="none" stroke="url(#gold)" stroke-width="34" stroke-linecap="round" stroke-linejoin="round">
      <polyline points="586,560 676,470 766,560"/>
      <polyline points="586,668 676,578 766,668"/>
    </g>
'@, 'PATCH', 118)

# 3. The update cycle around SeneaL's diamond.
$drafts['3'] = @(@'
    <g id="arc">
      <path d="M305,394 A210,210 0 0 1 719,394" fill="none" stroke="url(#gold)" stroke-width="38" stroke-linecap="round"/>
      <polygon points="731,476 778,384 664,404" fill="#E2BE70" stroke="#E2BE70" stroke-width="14" stroke-linejoin="round"/>
    </g>
    <use href="#arc" transform="rotate(180 512 430)"/>
    <rect x="442" y="360" width="140" height="140" transform="rotate(45 512 430)" fill="url(#gold)" stroke="#5E4419" stroke-opacity=".5" stroke-width="5"/>
    <polygon points="512,331 611,430 512,430" fill="#FFF0C4" opacity=".35"/>
    <polygon points="512,529 413,430 512,430" fill="#7A5726" opacity=".3"/>
'@, 'UI', 150)

# 4. The missing piece: a SeneaL panel with one corner gone and the brass piece coming back to it.
$drafts['4'] = @(@'
    <rect x="262" y="262" width="450" height="388" rx="30" fill="#1B1713" stroke="url(#gold)" stroke-width="18"/>
    <line x1="300" y1="346" x2="560" y2="346" stroke="#D9B76D" stroke-opacity=".6" stroke-width="6"/>
    <rect x="296" y="296" width="22" height="22" transform="rotate(45 307 307)" fill="#E6C67C"/>
    <g stroke="#7A6842" stroke-width="16" stroke-linecap="round" opacity=".9">
      <line x1="312" y1="420" x2="560" y2="420"/><line x1="312" y1="490" x2="660" y2="490"/><line x1="312" y1="560" x2="600" y2="560"/>
    </g>
    <rect x="590" y="230" width="150" height="150" fill="#221D18"/>
    <rect x="600" y="262" width="112" height="112" rx="14" fill="none" stroke="#D9B76D" stroke-opacity=".75" stroke-width="8" stroke-dasharray="4 22" stroke-linecap="round"/>
    <rect x="668" y="172" width="120" height="120" rx="16" fill="url(#gold)" stroke="#5E4419" stroke-opacity=".5" stroke-width="5"/>
    <polygon points="668,188 684,172 788,172 788,232" fill="#FFF0C4" opacity=".3"/>
'@, 'PATCH', 118)

# 5. The link put back: two worn links and the bright one that joins them.
$drafts['5'] = @(@'
    <g transform="rotate(-18 512 430)">
      <rect x="196" y="364" width="250" height="132" rx="66" fill="none" stroke="#9A7E48" stroke-width="30"/>
      <rect x="578" y="364" width="250" height="132" rx="66" fill="none" stroke="#9A7E48" stroke-width="30"/>
      <rect x="372" y="358" width="280" height="144" rx="72" fill="none" stroke="#211C17" stroke-width="64"/>
      <rect x="372" y="358" width="280" height="144" rx="72" fill="none" stroke="url(#gold)" stroke-width="40"/>
      <rect x="392" y="372" width="240" height="40" rx="20" fill="none" stroke="#FFF0C4" stroke-opacity=".35" stroke-width="6"/>
    </g>
    <rect x="495" y="212" width="34" height="34" transform="rotate(45 512 229)" fill="#E6C67C"/>
    <rect x="495" y="614" width="34" height="34" transform="rotate(45 512 631)" fill="#E6C67C"/>
'@, 'UI', 150)

Add-Type -AssemblyName System.Drawing
$sheet = New-Object System.Drawing.Bitmap (5 * 276 + 20), 316
$g = [System.Drawing.Graphics]::FromImage($sheet)
$g.Clear([System.Drawing.Color]::FromArgb(255, 48, 48, 52))
$g.InterpolationMode = 'HighQualityBicubic'
$font = New-Object System.Drawing.Font 'Segoe UI', 16
$n = 0
foreach ($key in $drafts.Keys) {
    $html = "$here\draft-$key.html"; $big = "$here\draft-$key-1024.png"; $small = "$here\draft-$key-256.png"
    [IO.File]::WriteAllText($html, (Page $drafts[$key][0] $drafts[$key][1] $drafts[$key][2]))
    & $chrome --headless=new --disable-gpu --hide-scrollbars --default-background-color=00000000 --window-size=1024,1024 "--screenshot=$big" ("file:///" + $html.Replace('\', '/')) 2>$null | Out-Null
    for ($w = 0; $w -lt 40 -and -not (Test-Path $big); $w++) { Start-Sleep -Milliseconds 250 }
    $src = [System.Drawing.Image]::FromFile($big)
    $out = New-Object System.Drawing.Bitmap 256, 256
    $og = [System.Drawing.Graphics]::FromImage($out); $og.InterpolationMode = 'HighQualityBicubic'; $og.PixelOffsetMode = 'HighQuality'
    $og.DrawImage($src, 0, 0, 256, 256); $og.Dispose(); $src.Dispose()
    $out.Save($small, [System.Drawing.Imaging.ImageFormat]::Png)
    $g.DrawImage($out, 20 + $n * 276, 12, 256, 256)
    $g.DrawString("Draft $key", $font, [System.Drawing.Brushes]::Gainsboro, 20 + $n * 276 + 88, 276)
    $out.Dispose(); $n++
}
$g.Dispose(); $sheet.Save("$here\drafts.png", [System.Drawing.Imaging.ImageFormat]::Png); $sheet.Dispose()
"written: $here\drafts.png"
