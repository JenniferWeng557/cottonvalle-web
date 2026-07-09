/* Cottonvalle encoding/mojibake cleanup
   Fixes visible replacement characters like � / �� caused by broken UTF-8 punctuation.
   Deploy as /encoding-fix.js and load before </body> on every page. */
(function () {
  const replacements = new Map([
    ['���', '–'],
    ['��', '–'],
    ['�', '–']
  ]);

  const shouldSkip = (node) => {
    const p = node.parentElement;
    if (!p) return false;
    return ['SCRIPT', 'STYLE', 'NOSCRIPT', 'TEXTAREA', 'INPUT', 'SELECT'].includes(p.tagName);
  };

  const cleanTextNode = (node) => {
    if (!node.nodeValue || shouldSkip(node)) return;
    let text = node.nodeValue;
    if (!text.includes('�') && !text.includes('鈥') && !text.includes('欽')) return;

    // Context-aware fixes for known Cottonvalle copy.
    text = text
      .replace(/5\s*�\s*�\s*8oz/gi, '5–8oz')
      .replace(/5\s*���\s*8oz/gi, '5–8oz')
      .replace(/practical\s*�\s*�\s*suitable/gi, 'practical and suitable')
      .replace(/practical\s*���\s*suitable/gi, 'practical and suitable')
      .replace(/needs\s*�\s*�\s*with/gi, 'needs — with')
      .replace(/needs\s*���\s*with/gi, 'needs — with')
      .replace(/needs\s+鈥\?with/gi, 'needs — with')
      .replace(/products\s+鈥\?it/gi, 'products — it');

    // Generic fallback.
    for (const [bad, good] of replacements) {
      text = text.split(bad).join(good);
    }

    node.nodeValue = text;
  };

  const walker = document.createTreeWalker(document.body, NodeFilter.SHOW_TEXT);
  const nodes = [];
  while (walker.nextNode()) nodes.push(walker.currentNode);
  nodes.forEach(cleanTextNode);
})();