// =========================================================
// Service Worker for Teacher Salary Slip Portal
// =========================================================

const CACHE_NAME = 'salary-portal-v2';

// इन्स्टॉलेशन इव्हेंट
self.addEventListener('install', (event) => {
  self.skipWaiting();
});

// ॲक्टिव्हेशन इव्हेंट (जुन्या व्हर्जन्सचा ताबा सोडवणे)
self.addEventListener('activate', (event) => {
  event.waitUntil(
    caches.keys().then((cacheNames) => {
      return Promise.all(
        cacheNames.map((cache) => {
          if (cache !== CACHE_NAME) {
            return caches.delete(cache);
          }
        })
      );
    }).then(() => self.clients.claim())
  );
});

// नेटवर्क फेच इव्हेंट (PWA Install पात्रता पूर्ण करणारा सुरक्षित कोड)
self.addEventListener('fetch', (event) => {
  // केवळ GET प्रकारच्या आणि HTTP/HTTPS विनंत्यांवर काम करणे
  if (event.request.method !== 'GET' || !event.request.url.startsWith('http')) {
    return;
  }

  event.respondWith(
    fetch(event.request).catch(() => {
      // नेटवर्क बंद असल्यास साधा संदेश
      return new Response('Offline - कृपया इंटरनेट कनेक्शन तपासा', {
        headers: { 'Content-Type': 'text/plain; charset=utf-8' }
      });
    })
  );
});
