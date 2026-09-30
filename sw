// =========================================================
// Service Worker for Teacher Salary Slip Portal
// =========================================================

const CACHE_NAME = 'salary-portal-v1';

// इन्स्टॉलेशन इव्हेंट (नवीन अपडेट आल्यास त्वरित सक्रिय करणे)
self.addEventListener('install', (event) => {
  self.skipWaiting();
});

// ॲक्टिव्हेशन इव्हेंट (जुन्या सर्व्हिस वर्करचा ताबा घेणे)
self.addEventListener('activate', (event) => {
  event.waitUntil(self.clients.claim());
});

// नेटवर्क फेच इव्हेंट (PWA इन्स्टॉलेशनच्या निकषांसाठी अनिवार्य)
self.addEventListener('fetch', (event) => {
  event.respondWith(
    fetch(event.request).catch(() => {
      // नेटवर्क ऑफलाइन असल्यास मूलभूत प्रतिसाद
      return new Response('Offline - कृपया इंटरनेट कनेक्शन तपासा');
    })
  );
});