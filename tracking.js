// GA4 Tracking — CottonValle
(function(){
  var gaId = 'G-5LM7XBNGSS';

  function safeSessionGet(key) {
    try { return sessionStorage.getItem(key); } catch (err) { return null; }
  }

  function safeSessionRemove(key) {
    try { sessionStorage.removeItem(key); } catch (err) {}
  }

  var s = document.createElement('script');
  s.async = true;
  s.src = 'https://www.googletagmanager.com/gtag/js?id=' + gaId;
  document.head.appendChild(s);

  s.onload = function(){
    window.dataLayer = window.dataLayer || [];
    function gtag(){dataLayer.push(arguments);}
    gtag('js', new Date());
    gtag('config', gaId);

    // All quote-entry clicks, including the floating button and normal CTAs.
    document.addEventListener('click', function(e){
      var el = e.target.closest('a[href*="quote"], .floating-quote-btn, .card-quote-btn, .product-quote-btn');
      if (el && !el.closest('form')) {
        gtag('event', 'quote_cta_click', {
          link_url: el.getAttribute('href') || '',
          link_text: (el.textContent || '').replace(/\s+/g, ' ').trim(),
          page_location: window.location.href
        });
      }
    });

    // WhatsApp click
    document.addEventListener('click', function(e){
      var el = e.target.closest('a[href*="wa.me"]');
      if (el) { gtag('event', 'whatsapp_click', { event_category: 'engagement' }); }
    });

    document.addEventListener('cottonvalle_quote_form_start', function(){
      gtag('event', 'quote_form_start', { form_name: 'quote_form' });
    });

    document.addEventListener('cottonvalle_quote_form_error', function(e){
      gtag('event', 'quote_form_error', {
        form_name: 'quote_form',
        error_type: e.detail && e.detail.type ? e.detail.type : 'unknown'
      });
    });

    // Email click (mailto links)
    document.addEventListener('click', function(e){
      var el = e.target.closest('a[href^="mailto:"]');
      if (el) { gtag('event', 'email_click', { event_category: 'engagement' }); }
    });

    document.addEventListener('click', function(e){
      var el = e.target.closest('a[href^="tel:"]');
      if (el) { gtag('event', 'phone_click', { event_category: 'engagement' }); }
    });

    // The successful form submission stores a one-time marker before redirecting.
    // Fire the lead on the thank-you page so navigation cannot cancel the hit.
    if (/\/thank-you(?:\.html)?\/?$/.test(window.location.pathname) && safeSessionGet('cottonvalle_pending_lead') === '1') {
      var leadCleared = false;
      var clearLeadMarker = function(){
        if (leadCleared) return;
        leadCleared = true;
        safeSessionRemove('cottonvalle_pending_lead');
      };
      gtag('event', 'generate_lead', {
        form_name: 'quote_form',
        currency: 'USD',
        value: 0,
        transport_type: 'beacon',
        event_callback: clearLeadMarker,
        event_timeout: 2000
      });
      window.setTimeout(clearLeadMarker, 2200);
    }
  };
})();
