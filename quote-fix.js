/* Cottonvalle quote redirect + form submit fix
   Copy this file to your site root as /quote-fix.js or /assets/js/quote-fix.js,
   then include it before </body> on every page.
*/
(function () {
  'use strict';

  var QUOTE_URL = '/quote.html';      // If your deployed route is /quote, change to '/quote'
  var THANK_YOU_URL = '/thank-you.html';
  var QUOTE_EMAIL = 'cottonvalle@gmail.com';
  var FORMSUBMIT_ENDPOINT = 'https://formsubmit.co/ajax/' + encodeURIComponent(QUOTE_EMAIL);

  function textOf(el) {
    return (el.textContent || el.value || '').replace(/\s+/g, ' ').trim().toLowerCase();
  }

  function isQuoteText(t) {
    return t === 'get quote' || t === 'request quote' || t === 'quote' || t.indexOf('request a quote') !== -1;
  }

  function normalizeQuoteButtons() {
    document.querySelectorAll('a, button').forEach(function (el) {
      var t = textOf(el);
      if (!isQuoteText(t)) return;

      // Do not change the submit button inside the quote form.
      if (el.closest('form')) return;

      if (el.tagName === 'A') {
        el.setAttribute('href', QUOTE_URL);
        el.removeAttribute('onclick');
      } else {
        el.setAttribute('type', 'button');
        el.addEventListener('click', function (e) {
          e.preventDefault();
          window.location.href = QUOTE_URL;
        });
      }
    });
  }

  function getField(form, names) {
    for (var i = 0; i < names.length; i++) {
      var field = form.querySelector('[name="' + names[i] + '"], #' + names[i]);
      if (field) return field;
    }
    return null;
  }

  function setField(form, names, value) {
    if (!value) return;
    var field = getField(form, names);
    if (field && !field.value) field.value = value;
  }

  function prefillQuoteFormFromUrl(form) {
    var params = new URLSearchParams(window.location.search);
    if (!params.size) return;

    setField(form, ['name', 'full_name', 'fullname'], params.get('name'));
    setField(form, ['email'], params.get('email'));
    setField(form, ['company'], params.get('company'));
    setField(form, ['phone', 'whatsapp', 'whatsapp_phone'], params.get('phone'));
    setField(form, ['quantity', 'target_quantity'], params.get('quantity') || params.get('targetQuantity'));
    setField(form, ['bagType', 'bag_type', 'product', 'product_type'], params.get('bagType') || params.get('bag_type'));
    setField(form, ['message', 'details', 'project_details'], params.get('message') || params.get('details'));

    // Clean the URL so the form does not look like it submitted with GET again.
    if (window.location.pathname.indexOf('/quote') !== -1) {
      window.history.replaceState({}, document.title, window.location.pathname);
    }
  }

  function quoteForms() {
    var onQuotePage = window.location.pathname.indexOf('/quote') !== -1;
    return Array.prototype.slice.call(document.querySelectorAll('form')).filter(function (form) {
      return form.id === 'quoteForm' || form.hasAttribute('data-quote-form') || onQuotePage;
    });
  }

  function formToObject(form) {
    var fd = new FormData(form);
    var obj = {};
    fd.forEach(function (value, key) { obj[key] = value; });
    return obj;
  }

  function buildEmailBody(data) {
    var lines = [
      'New Cottonvalle quote request',
      '',
      'Name: ' + (data.name || data.full_name || ''),
      'Email: ' + (data.email || ''),
      'Company: ' + (data.company || ''),
      'WhatsApp / Phone: ' + (data.phone || data.whatsapp || data.whatsapp_phone || ''),
      'Bag Type: ' + (data.bagType || data.bag_type || data.product || data.product_type || ''),
      'Target Quantity: ' + (data.quantity || data.target_quantity || ''),
      '',
      'Project Details:',
      data.message || data.details || data.project_details || ''
    ];
    return lines.join('\n');
  }

  function attachQuoteSubmit(form) {
    if (form.dataset.quoteFixed === '1') return;
    form.dataset.quoteFixed = '1';
    form.setAttribute('method', 'POST');
    form.setAttribute('action', FORMSUBMIT_ENDPOINT);

    prefillQuoteFormFromUrl(form);

    form.addEventListener('submit', function (e) {
      e.preventDefault();

      var nameField = getField(form, ['name', 'full_name', 'fullname']);
      var emailField = getField(form, ['email']);
      var name = nameField ? nameField.value.trim() : '';
      var email = emailField ? emailField.value.trim() : '';

      if (!name || !email || email.indexOf('@') === -1) {
        alert('Please enter your name and a valid email address.');
        return;
      }

      var submitBtn = form.querySelector('button[type="submit"], input[type="submit"], button:not([type])');
      var oldText = submitBtn ? (submitBtn.textContent || submitBtn.value) : '';
      if (submitBtn) {
        submitBtn.disabled = true;
        if (submitBtn.tagName === 'INPUT') submitBtn.value = 'Submitting...';
        else submitBtn.textContent = 'Submitting...';
      }

      var fd = new FormData(form);
      fd.set('_subject', 'New quote request from Cottonvalle.com');
      fd.set('_template', 'table');
      fd.set('_captcha', 'false');

      fetch(FORMSUBMIT_ENDPOINT, {
        method: 'POST',
        headers: { 'Accept': 'application/json' },
        body: fd
      })
        .then(function (res) {
          if (!res.ok) throw new Error('Form submit failed');
          try { localStorage.setItem('cottonvalle_last_quote', JSON.stringify(formToObject(form))); } catch (err) {}
          window.location.href = THANK_YOU_URL;
        })
        .catch(function () {
          // Fallback: open user's email client so the lead is not lost.
          var data = formToObject(form);
          var subject = encodeURIComponent('New Cottonvalle quote request');
          var body = encodeURIComponent(buildEmailBody(data));
          window.location.href = 'mailto:' + QUOTE_EMAIL + '?subject=' + subject + '&body=' + body;

          if (submitBtn) {
            submitBtn.disabled = false;
            if (submitBtn.tagName === 'INPUT') submitBtn.value = oldText;
            else submitBtn.textContent = oldText;
          }
        });
    });
  }

  document.addEventListener('DOMContentLoaded', function () {
    normalizeQuoteButtons();
    quoteForms().forEach(attachQuoteSubmit);
  });
})();
