// GA4 Tracking — CottonValle
(function(){
  var gaId = 'G-5LM7XBNGSS';

  var s = document.createElement('script');
  s.async = true;
  s.src = 'https://www.googletagmanager.com/gtag/js?id=' + gaId;
  document.head.appendChild(s);

  s.onload = function(){
    window.dataLayer = window.dataLayer || [];
    function gtag(){dataLayer.push(arguments);}
    gtag('js', new Date());
    gtag('config', gaId);

    // Floating quote button click
    document.addEventListener('click', function(e){
      var el = e.target.closest('.floating-quote-btn');
      if (el) { gtag('event', 'floating_quote_click', { event_category: 'engagement', event_label: el.getAttribute('href') }); }
    });

    // WhatsApp click
    document.addEventListener('click', function(e){
      var el = e.target.closest('a[href*="wa.me"]');
      if (el) { gtag('event', 'whatsapp_click', { event_category: 'engagement' }); }
    });

    // Product card quote button click
    document.addEventListener('click', function(e){
      var el = e.target.closest('.card-quote-btn, .product-quote-btn');
      if (el) { gtag('event', 'product_quote_click', { event_category: 'conversion', event_label: el.closest('.card,.product-card') ? (el.closest('.card,.product-card').querySelector('h2,h3')||{}).textContent||'' : '' }); }
    });

    // Count a lead only after the quote endpoint confirms success.
    document.addEventListener('cottonvalle_quote_success', function(){
      gtag('event', 'generate_lead', { event_category: 'conversion' });
    });

    // Email click (mailto links)
    document.addEventListener('click', function(e){
      var el = e.target.closest('a[href^="mailto:"]');
      if (el) { gtag('event', 'email_click', { event_category: 'engagement' }); }
    });
  };
})();
