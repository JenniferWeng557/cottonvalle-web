$pages = @(
    @{
        file = "custom-cotton-tote-bags.html"
        title = "Custom Cotton Tote Bags | Promotional Cotton Totes | Cotton Valle"
        meta = "Custom lightweight cotton tote bags for bulk promotional orders, events, retail merchandising, and brand campaigns. Logo printing via screen print, DTG, or heat transfer with flexible MOQ and global shipping from Cotton Valle."
        pname = "Custom Cotton Tote Bag"
        pslug = "custom-cotton-tote-bags"
        pdesc = "Lightweight custom cotton tote bags designed for bulk promotional orders, events, retail merchandising, and brand campaigns. Available in 5-8oz cotton with screen print, DTG, or heat transfer logo printing. Flexible MOQ, sampling support, and export-ready packaging included."
    },
    @{
        file = "canvas-tote-bags.html"
        title = "Canvas Tote Bags | Premium Canvas Bags for Retail | Cotton Valle"
        meta = "Structured canvas tote bags for premium retail, museums, bookstores, and lifestyle brands. Bulk orders with custom logo printing, multiple fabric weights, and export-ready packaging from Cotton Valle."
        pname = "Canvas Tote Bag"
        pslug = "canvas-tote-bags"
        pdesc = "Structured canvas tote bags made for premium retail, museums, bookstores, and lifestyle brands. Available in multiple fabric weights with custom logo printing, handle options, and retail-ready packaging."
    },
    @{
        file = "organic-cotton-bags.html"
        title = "Organic Cotton Bags | Eco-Friendly Cotton Totes | Cotton Valle"
        meta = "Custom organic cotton bags for eco-focused brands, green campaigns, and sustainability-led retail collections. Bulk production with logo printing and custom packaging options from Cotton Valle."
        pname = "Organic Cotton Bag"
        pslug = "organic-cotton-bags"
        pdesc = "Custom organic cotton bags designed for eco-focused brands, green campaigns, and sustainability-led retail collections. Soft, natural-feel fabric with custom logo printing, bulk production, and flexible packaging options."
    },
    @{
        file = "cotton-drawstring-bags.html"
        title = "Cotton Drawstring Bags | Gift &amp; Promotional Pouches | Cotton Valle"
        meta = "Custom cotton drawstring bags for gift packaging, beauty sets, accessories, wedding favors, and promotional giveaways. Bulk orders with logo printing, flexible MOQ, and worldwide delivery from Cotton Valle."
        pname = "Cotton Drawstring Bag"
        pslug = "cotton-drawstring-bags"
        pdesc = "Soft cotton drawstring bags for gift packaging, beauty sets, accessories, wedding favors, and promotional giveaways. Custom logo printing, multiple sizes, and flexible MOQ available for bulk orders."
    },
    @{
        file = "jute-bags.html"
        title = "Jute Bags | Natural Jute Shopping &amp; Gift Bags | Cotton Valle"
        meta = "Custom natural jute bags with cotton handles for grocery retail, coffee shops, eco promotions, and rustic gift packaging. Bulk production with logo printing and custom sizing from Cotton Valle."
        pname = "Jute Bag"
        pslug = "jute-bags"
        pdesc = "Natural jute bags with cotton handles for grocery retail, coffee shops, eco promotions, and rustic gift packaging. Durable, earthy texture with custom logo printing and bulk production support."
    },
    @{
        file = "canvas-zip-pouches.html"
        title = "Canvas Zip Pouches | Custom Cosmetic &amp; Travel Pouches | Cotton Valle"
        meta = "Custom canvas zip pouches for cosmetics, stationery, travel kits, checkout retail, and gift-with-purchase programs. Bulk orders with logo printing and custom packaging from Cotton Valle."
        pname = "Canvas Zip Pouch"
        pslug = "canvas-zip-pouches"
        pdesc = "Versatile canvas zip pouches for cosmetics, stationery, travel kits, checkout retail, and gift-with-purchase programs. Custom logo printing, multiple sizes, and bulk production with export-ready packaging."
    }
)

$faqItems = @'
    {"@type":"Question","name":"Is this product available for wholesale or bulk orders?","acceptedAnswer":{"@type":"Answer","text":"Yes. Cotton Valle supports wholesale and bulk orders for this product. Please share your target quantity, logo artwork, and delivery destination to receive a quotation."}},
    {"@type":"Question","name":"Can I customize the logo, size, or packaging for this bag?","acceptedAnswer":{"@type":"Answer","text":"Custom logo printing, size adjustments, and packaging options may be available depending on order quantity and project requirements. Contact Cotton Valle with your specifications for a review."}},
    {"@type":"Question","name":"What information should I provide to get a quote?","acceptedAnswer":{"@type":"Answer","text":"Please provide the bag type, estimated order quantity, logo artwork, preferred printing method, packaging requirements, and delivery destination for a faster and more accurate quotation."}}
'@

foreach ($p in $pages) {
    $content = Get-Content $p.file -Raw -Encoding UTF8

    # Update title
    $content = $content -replace '<title>.*?</title>', "<title>$($p.title)</title>"

    # Update meta description
    $content = $content -replace '<meta name="description" content="[^"]*"', "<meta name=`"description`" content=`"$($p.meta)`""

    # Build schemas block
    $schemas = @"

<script type="application/ld+json">{
  "@context":"https://schema.org",
  "@type":"Product",
  "name":"$($p.pname)",
  "image":["https://www.cottonvalle.com/assets/$($p.pslug)-img-001.png"],
  "description":"$($p.pdesc)",
  "brand":{"@type":"Brand","name":"Cotton Valle"},
  "offers":{"@type":"Offer","url":"https://www.cottonvalle.com/$($p.pslug).html","priceCurrency":"USD","availability":"https://schema.org/InStock","itemCondition":"https://schema.org/NewCondition"}
}</script>
<script type="application/ld+json">{
  "@context":"https://schema.org",
  "@type":"BreadcrumbList",
  "itemListElement":[
    {"@type":"ListItem","position":1,"name":"Home","item":"https://www.cottonvalle.com/"},
    {"@type":"ListItem","position":2,"name":"Products","item":"https://www.cottonvalle.com/products.html"},
    {"@type":"ListItem","position":3,"name":"$($p.pname)","item":"https://www.cottonvalle.com/$($p.pslug).html"}
  ]
}</script>
<script type="application/ld+json">{
  "@context":"https://schema.org",
  "@type":"FAQPage",
  "mainEntity":[$faqItems]
}</script>
"@

    # Insert schemas before tracking.js script
    $content = $content -replace '<script src="/tracking.js" defer>', "$schemas`r`n<script src=`"/tracking.js`" defer>"

    Set-Content -Path $p.file -Value $content -NoNewline -Encoding UTF8
    Write-Output "Updated: $($p.file)"
}

Write-Output "Done! All 6 product pages updated."
