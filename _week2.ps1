$pages = @{
    "retail-brands" = @{
        title = "Retail Cotton Bags | Custom Totes for Bookstores &amp; Lifestyle Brands | Cotton Valle"
        meta = "Custom cotton and canvas bags for bookstores, museums, lifestyle shops, and retail brands. Bulk logo printing with flexible MOQ, sampling, and retail-ready packaging from Cotton Valle."
        name = "Retail Brands"
    }
    "events-trade-shows" = @{
        title = "Event Cotton Bags | Bulk Promotional Totes for Trade Shows | Cotton Valle"
        meta = "Custom promotional cotton bags for conferences, trade shows, exhibitions, and brand campaigns. Large-volume logo printing with reliable bulk production and export support from Cotton Valle."
        name = "Events &amp; Trade Shows"
    }
    "corporate-gifts" = @{
        title = "Corporate Gift Cotton Bags | Custom Welcome Kits &amp; Merch | Cotton Valle"
        meta = "Custom cotton bags for corporate welcome kits, seasonal gifting, employee appreciation, and client merch programs. Bulk orders with logo printing, custom packaging, and global delivery from Cotton Valle."
        name = "Corporate Gifts"
    }
    "coffee-shops-bakeries" = @{
        title = "Coffee Shop Cotton Bags | Reusable Totes for Cafes &amp; Bakeries | Cotton Valle"
        meta = "Custom reusable cotton bags for coffee shops, bakeries, coffee roasters, and food lifestyle brands. Warm natural-fiber packaging with logo printing and bulk production from Cotton Valle."
        name = "Coffee Shops &amp; Bakeries"
    }
    "fabric-weight-guide" = @{
        title = "Cotton Bag Fabric Weight Guide | 5oz 6oz 8oz Canvas GSM | Cotton Valle"
        meta = "Choose the right cotton bag fabric weight. Compare 5oz, 6oz, and 8oz cotton and canvas by feel, structure, print quality, and best use cases. A practical guide from Cotton Valle."
        name = "Fabric Weight Guide"
    }
    "printing-methods" = @{
        title = "Cotton Bag Printing Methods | Screen Print, DTG &amp; Heat Transfer | Cotton Valle"
        meta = "Compare cotton bag logo printing methods: screen print, DTG, heat transfer, and embroidery. Learn which method suits your artwork, fabric type, order quantity, and budget from Cotton Valle."
        name = "Printing Methods"
    }
    "handles-details" = @{
        title = "Cotton Bag Handles &amp; Construction | Custom Details Guide | Cotton Valle"
        meta = "Explore cotton bag construction options: handle length, reinforcement, gussets, pockets, zippers, linings, and closures. Customize every detail with Cotton Valle for bulk orders."
        name = "Handles &amp; Details"
    }
    "retail-packaging" = @{
        title = "Cotton Bag Retail Packaging | Hangtags, Labels &amp; Carton Marks | Cotton Valle"
        meta = "Custom retail-ready packaging for cotton bags: individual polybags, hangtags, barcode labels, carton marks, and display-ready packing. Bulk packaging options from Cotton Valle."
        name = "Retail Packaging"
    }
    "sewing-workshop" = @{
        title = "Cotton Bag Sewing Workshop | Production &amp; Manufacturing | Cotton Valle"
        meta = "Inside the Cotton Valle sewing workshop: organized production lines, skilled operators, and quality-focused cotton bag manufacturing. Learn about our production capability for bulk orders."
        name = "Sewing Workshop"
    }
    "printing-quality-control" = @{
        title = "Cotton Bag Printing QC | Logo Placement &amp; Quality Inspection | Cotton Valle"
        meta = "How Cotton Valle ensures print quality: logo placement review, color accuracy checks, and inspection processes before packing. Reliable printing quality control for bulk cotton bag orders."
        name = "Printing &amp; Quality Control"
    }
    "sample-room" = @{
        title = "Cotton Bag Sample Room | Pre-Production Samples &amp; Display | Cotton Valle"
        meta = "View Cotton Valle sample room with pre-production samples, fabric swatches, and finished product displays. Request samples to verify quality before bulk cotton bag production."
        name = "Sample Room"
    }
    "factory-workflow" = @{
        title = "Cotton Bag Factory Workflow | Order to Export Process | Cotton Valle"
        meta = "The complete Cotton Valle factory workflow: from inquiry, sampling, and bulk production to quality inspection, packing, and export shipping. A clear 7-step process for bulk cotton bag orders."
        name = "Factory Workflow"
    }
    "eco-materials" = @{
        title = "Eco-Friendly Cotton Bag Materials | Cotton, Canvas, Organic &amp; Jute | Cotton Valle"
        meta = "Explore eco-friendly cotton bag materials from Cotton Valle: natural cotton, canvas, organic cotton, and jute. Learn the sustainability benefits and best use cases for each material."
        name = "Eco Materials"
    }
    "reusable-packaging" = @{
        title = "Reusable Cotton Bag Packaging | Sustainable Brand Solutions | Cotton Valle"
        meta = "Design cotton bags people keep and reuse. Cotton Valle helps brands create reusable packaging that reduces single-use waste while strengthening brand visibility and customer loyalty."
        name = "Reusable Packaging"
    }
    "sustainability-material-guide" = @{
        title = "Sustainable Cotton Bag Material Guide | Cost, Feel &amp; Use Comparison | Cotton Valle"
        meta = "Compare sustainable cotton bag materials by cost, feel, structure, print quality, and best use case. A practical buyer guide from Cotton Valle for choosing the right eco-friendly fabric."
        name = "Sustainability Material Guide"
    }
    "industries" = @{
        title = "Cotton Bag Industries | Retail, Events, Gifts &amp; Hospitality | Cotton Valle"
        meta = "Cotton Valle serves multiple industries with custom cotton and canvas bags: retail brands, events and trade shows, corporate gifting, and hospitality. Explore industry-specific bag solutions."
        name = "Industries"
    }
    "custom-options" = @{
        title = "Custom Cotton Bag Options | Fabric, Printing, Handles &amp; Packaging | Cotton Valle"
        meta = "Explore all custom cotton bag options from Cotton Valle: fabric weight, printing methods, handle details, and retail packaging. Configure your ideal bag for bulk production and wholesale orders."
        name = "Custom Options"
    }
    "factory" = @{
        title = "Cotton Bag Factory | Production Workshop, QC &amp; Workflow | Cotton Valle"
        meta = "Tour the Cotton Valle cotton bag factory: sewing workshop, printing quality control, sample room, and complete order workflow. Reliable manufacturing for bulk and custom cotton bag orders."
        name = "Factory"
    }
    "sustainability" = @{
        title = "Sustainable Cotton Bags | Eco Materials &amp; Reusable Packaging | Cotton Valle"
        meta = "Cotton Valle commitment to sustainable cotton bags: eco-friendly materials, reusable packaging design, and practical material guides for buyers who want lower-waste bag solutions."
        name = "Sustainability"
    }
    "blog" = @{
        title = "Cotton Bag Guides &amp; Resources | Fabric, Printing &amp; MOQ Tips | Cotton Valle"
        meta = "Read Cotton Valle blog guides on cotton bag fabric weight, logo printing methods, MOQ and sampling explained. Practical resources for buyers sourcing custom cotton and canvas bags."
        name = "Blog"
    }
}

$breadcrumb = @"
<script type="application/ld+json">{
  "@context":"https://schema.org",
  "@type":"BreadcrumbList",
  "itemListElement":[
    {"@type":"ListItem","position":1,"name":"Home","item":"https://www.cottonvalle.com/"},
    {"@type":"ListItem","position":2,"name":"REPLACE_NAME","item":"https://www.cottonvalle.com/REPLACE_FILE.html"}
  ]
}</script>
"@

foreach ($key in $pages.Keys) {
    $file = "$key.html"
    if (-not (Test-Path $file)) { Write-Output "SKIP $file (not found)"; continue }
    
    $data = $pages[$key]
    $content = Get-Content $file -Raw -Encoding UTF8
    
    # Update title
    $content = $content -replace '<title>.*?</title>', "<title>$($data.title)</title>"
    
    # Update meta description
    $content = $content -replace '<meta name="description" content="[^"]*"', "<meta name=`"description`" content=`"$($data.meta)`""
    
    # Add breadcrumb schema if none exists
    if ($content -notmatch 'BreadcrumbList') {
        $bc = $breadcrumb -replace 'REPLACE_NAME', $data.name -replace 'REPLACE_FILE', $key
        $content = $content -replace '<script src="/tracking.js" defer>', "$bc`r`n<script src=`"/tracking.js`" defer>"
    }
    
    Set-Content -Path $file -Value $content -NoNewline -Encoding UTF8
    Write-Output "OK $file"
}

Write-Output "`nDone! All 20 pages updated."
