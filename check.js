const { chromium } = require('playwright');
(async () => {
  const browser = await chromium.launch();
  const page = await browser.newPage();
  page.on('console', msg => console.log('PAGE LOG:', msg.text()));
  page.on('pageerror', err => console.log('PAGE ERROR:', err));
  await page.goto('file:///Users/brainiac/Documents/renace.tech/pescaderia-altamar/index.html');
  await page.evaluate(() => window.scrollBy(0, 100));
  await page.waitForTimeout(500);
  await browser.close();
})();
