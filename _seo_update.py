import re

pages = {
    'custom-cotton-tote-bags.html': {
        'title': 'Custom Cotton Tote Bags | Promotional Cotton Totes | Cotton Valle',
        'meta': 'Custom lightweight cotton tote bags for bulk promotional orders, events, retail merchandising, and brand campaigns. Logo printing via screen print, DTG, or heat transfer with flexible MOQ and global shipping from Cotton Valle.',
        'product_name': 'Custom Cotton Tote Bag',
        'product_slug': 'custom-cotton-tote-bags',
        'product_desc': 'Lightweight custom cotton tote bags designed for bulk promotional orders, events, retail merchandising, and brand campaigns. Available in 5-8oz cotton with screen print, DTG, or heat transfer logo printing. Flexible MOQ, sampling support, and export-ready packaging included.',
        'category': 'Cotton Tote Bags',
    },
    'canvas-tote-bags.html': {
        'title': 'Canvas Tote Bags | Premium Canvas Bags for Retail | Cotton Valle',
        'meta': 'Structured canvas tote bags for premium retail, museums, bookstores, and lifestyle brands. Bulk orders with custom logo printing, multiple fabric weights, and export-ready packaging from Cotton Valle.',
        'product_name': 'Canvas Tote Bag',
        'product_slug': 'canvas-tote-bags',
        'product_desc': 'Structured canvas tote bags made for premium retail, museums, bookstores, and lifestyle brands. Available in multiple fabric weights with custom logo printing, handle options, and retail-ready packaging.',
        'category': 'Canvas Tote Bags',
    },
    'organic-cotton-bags.html': {
        'title': 'Organic Cotton Bags | Eco-Friendly Cotton Totes | Cotton Valle',
        'meta': 'Custom organic cotton bags for eco-focused brands, green campaigns, and sustainability-led retail collections. Bulk production with logo printing and custom packaging options from Cotton Valle.',
        'product_name': 'Organic Cotton Bag',
        'product_slug': 'organic-cotton-bags',
        'product_desc': 'Custom organic cotton bags designed for eco-focused brands, green campaigns, and sustainability-led retail collections. Soft, natural-feel fabric with custom logo printing, bulk production, and flexible packaging options.',
        'category': 'Organic Cotton Bags',
    },
    'cotton-drawstring-bags.html': {
        'title': 'Cotton Drawstring Bags | Gift &amp; Promotional Pouches | Cotton Valle',
        'meta': 'Custom cotton drawstring bags for gift packaging, beauty sets, accessories, wedding favors, and promotional giveaways. Bulk orders with logo printing, flexible MOQ, and worldwide delivery from Cotton Valle.',
        'product_name': 'Cotton Drawstring Bag',
        'product_slug': 'cotton-drawstring-bags',
        'product_desc': 'Soft cotton drawstring bags for gift packaging, beauty sets, accessories, wedding favors, and promotional giveaways. Custom logo printing, multiple sizes, and flexible MOQ available for bulk orders.',
        'category': 'Drawstring Bags',
    },
    'jute-bags.html': {
        'title': 'Jute Bags | Natural Jute Shopping &amp; Gift Bags | Cotton Valle',
        'meta': 'Custom natural jute bags with cotton handles for grocery retail, coffee shops, eco promotions, and rustic gift packaging. Bulk production with logo printing and custom sizing from Cotton Valle.',
        'product_name': 'Jute Bag',
        'product_slug': 'jute-bags',
        'product_desc': 'Natural jute bags with cotton handles for grocery retail, coffee shops, eco promotions, and rustic gift packaging. Durable, earthy texture with custom logo printing and bulk production support.',
        'category': 'Jute Bags',
    },
    'canvas-zip-pouches.html': {
        'title': 'Canvas Zip Pouches | Custom Cosmetic &amp; Travel Pouches | Cotton Valle',
        'meta': 'Custom canvas zip pouches for cosmetics, stationery, travel kits, checkout retail, and gift-with-purchase programs. Bulk orders with logo printing and custom packaging from Cotton Valle.',
        'product_name': 'Canvas Zip Pouch',
        'product_slug': 'canvas-zip-pouches',
        'product_desc': 'Versatile canvas zip pouches for cosmetics, stationery, travel kits, checkout retail, and gift-with-purchase programs. Custom logo printing, multiple sizes, and bulk production with export-ready packaging.',
        'category': 'Canvas Zip Pouches',
    },
}

faq_schema_items = [
    '{"@type":"Question","name":"Is this product available for wholesale or bulk orders?","acceptedAnswer":{"@type":"Answer","text":"Yes. Cotton Valle supports wholesale and bulk orders for this product. Please share your target quantity, logo artwork, and delivery destination to receive a quotation."}}',
    '{"@type":"Question","name":"Can I customize the logo, size, or packaging for this bag?","acceptedAnswer":{"@type":"Answer","text":"Custom logo printing, size adjustments, and packaging options may be available depending on order quantity and project requirements. Contact Cotton Valle with your specifications for a review."}}',
    '{"@type":"Question","name":"What information should I provide to get a quote?","acceptedAnswer":{"@type":"Answer","text":"Please provide the bag type, estimated order quantity, logo artwork, preferred printing method, packaging requirements, and delivery destination for a faster and more accurate quotation."}}'
]
faq_json = ',\n    '.join(faq_schema_items)

for filename, data in pages.items():
    with open(filename, 'r', encoding='utf-8') as f:
        content = f.read()

    # Update title
    content = re.sub(r'<title>.*?</title>', f'<title>{data["title"]}</title>', content)

    # Update meta description
    content = re.sub(
        r'<meta name="description" content="[^"]*"',
        f'<meta name="description" content="{data["meta"]}"',
        content
    )

    # Build schemas
    schemas = f'''
<script type="application/ld+json">{{
  "@context":"https://schema.org",
  "@type":"Product",
  "name":"{data["product_name"]}",
  "image":["https://www.cottonvalle.com/assets/{data["product_slug"]}-img-001.png"],
  "description":"{data["product_desc"]}",
  "brand":{{"@type":"Brand","name":"Cotton Valle"}},
  "offers":{{"@type":"Offer","url":"https://www.cottonvalle.com/{data["product_slug"]}.html","priceCurrency":"USD","availability":"https://schema.org/InStock","itemCondition":"https://schema.org/NewCondition"}}
}}</script>
<script type="application/ld+json">{{
  "@context":"https://schema.org",
  "@type":"BreadcrumbList",
  "itemListElement":[
    {{"@type":"ListItem","position":1,"name":"Home","item":"https://www.cottonvalle.com/"}},
    {{"@type":"ListItem","position":2,"name":"Products","item":"https://www.cottonvalle.com/products.html"}},
    {{"@type":"ListItem","position":3,"name":"{data["product_name"]}","item":"https://www.cottonvalle.com/{data["product_slug"]}.html"}}
  ]
}}</script>
<script type="application/ld+json">{{
  "@context":"https://schema.org",
  "@type":"FAQPage",
  "mainEntity":[{faq_json}]
}}</script>'''

    # Insert schemas before </head>
    content = content.replace('<script src="/tracking.js" defer>', schemas + '<script src="/tracking.js" defer>')

    with open(filename, 'w', encoding='utf-8') as f:
        f.write(content)

    print(f'Updated {filename}')

print('Done! All 6 product pages updated.')
