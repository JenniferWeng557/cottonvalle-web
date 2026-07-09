(function () {
  const imageMap = {
    'Custom Cotton Tote Bags': '/assets/images/products/custom-cotton-tote-bags.webp',
    'Canvas Tote Bags': '/assets/images/products/canvas-tote-bags.webp',
    'Organic Cotton Bags': '/assets/images/products/organic-cotton-bags.webp',
    'Jute Bags': '/assets/images/products/jute-bags.webp',
    'Drawstring Bags': '/assets/images/products/drawstring-bags.webp',
    'Zip Pouches': '/assets/images/products/zip-pouches.webp',
    'Canvas Zipper Pouches': '/assets/images/products/zip-pouches.webp'
  };

  const altMap = {
    'Custom Cotton Tote Bags': 'Custom Cotton Tote Bags by CottonValle',
    'Canvas Tote Bags': 'Canvas Tote Bags by CottonValle',
    'Organic Cotton Bags': 'Organic Cotton Bags by CottonValle',
    'Jute Bags': 'Jute Bags by CottonValle',
    'Drawstring Bags': 'Drawstring Bags by CottonValle',
    'Zip Pouches': 'Zip Pouches by CottonValle',
    'Canvas Zipper Pouches': 'Zip Pouches by CottonValle'
  };

  function applyProductImages() {
    document.querySelectorAll('h2,h3,.product-title,.card-title').forEach(titleEl => {
      const title = titleEl.textContent.trim();
      const src = imageMap[title];
      if (!src) return;
      const card = titleEl.closest('a, article, .card, .product-card, .product-item, .collection-card') || titleEl.parentElement;
      if (!card) return;
      const img = card.querySelector('img');
      if (!img) return;
      img.src = src;
      img.srcset = '';
      img.alt = altMap[title] || title;
      img.loading = 'lazy';
      img.decoding = 'async';
      img.style.objectFit = 'cover';
      img.style.objectPosition = 'center';
    });
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', applyProductImages);
  } else {
    applyProductImages();
  }
})();
