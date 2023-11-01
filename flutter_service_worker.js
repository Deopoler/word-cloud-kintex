'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"main.dart.js": "7b9f5ec6dc631142af724b41e0646df2",
"assets/AssetManifest.json": "c1fd1b818d9d62e9706bd9176a677c66",
"assets/assets/example1.png": "ad2b8a2a62f76476bc30a279fafd03c6",
"assets/assets/example2.png": "5f10c0f14a78d7840ca04bf63832eb09",
"assets/assets/logo.png": "b5f123db2aad1fefaf856c89a1c73d87",
"assets/assets/example3.png": "748355f233e501a49c647e6ef5810925",
"assets/AssetManifest.bin": "1b976f86e75fd9069b9ee3955ecceb0c",
"assets/fonts/MaterialIcons-Regular.otf": "99f5e2a93562ba25742101de557738a9",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/NOTICES": "fa4f4b27fb8cf450496f76491d186dbc",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"manifest.json": "96ab23ae058e634314b2f1ea2c3863e9",
"index.html": "74245771193037a16925ab3b4f542ad3",
"/": "74245771193037a16925ab3b4f542ad3",
"icons/browserconfig.xml": "653d077300a12f09a69caeea7a8947f8",
"icons/ms-icon-310x310.png": "b62d1a7fb2fa0707c3e19d431047ce40",
"icons/android-icon-144x144.png": "6bd5bc87dc0a32a08cec138bcdcba411",
"icons/android-icon-192x192.png": "7003428c01004c2fa836d870574bc87d",
"icons/favicon-96x96.png": "dff6fe53eb4859ead7ee833485f845f0",
"icons/apple-icon-60x60.png": "7dd3f934124f4c5a017ce7c829544eb5",
"icons/apple-icon-72x72.png": "2f25fcce519e855f5be51f20bbd2a065",
"icons/ms-icon-70x70.png": "64c0fcaed1a3cab43c198b492359e1f4",
"icons/android-icon-96x96.png": "dff6fe53eb4859ead7ee833485f845f0",
"icons/favicon-32x32.png": "8c520e70108cb605afc84bb10aac83ab",
"icons/apple-icon-144x144.png": "6bd5bc87dc0a32a08cec138bcdcba411",
"icons/apple-icon-120x120.png": "5dc66b1bd6cb7ef6fdcbce6a1ec66415",
"icons/apple-icon-76x76.png": "8bad886386b747a67527d4e100ca9713",
"icons/apple-icon-57x57.png": "91b18a4e4473d301abf8edecc1d4feef",
"icons/android-icon-36x36.png": "ea8c954fcdecba4572595e4170cac74d",
"icons/apple-icon-precomposed.png": "a2507f79a1721ae79372c4e418b208ac",
"icons/android-icon-72x72.png": "2f25fcce519e855f5be51f20bbd2a065",
"icons/ms-icon-144x144.png": "6bd5bc87dc0a32a08cec138bcdcba411",
"icons/apple-icon.png": "a2507f79a1721ae79372c4e418b208ac",
"icons/apple-icon-180x180.png": "14fa413eae54055b7c46502efc0b68ed",
"icons/apple-icon-114x114.png": "a70eee0ef53f9a819456507b32d6f612",
"icons/ms-icon-150x150.png": "72a23c28957188efa1e3145deb03a55f",
"icons/favicon-16x16.png": "0d233d441be4e07deeee10ecc8e85590",
"icons/android-icon-48x48.png": "fbc1728bf65c471e2b917c47df5793d1",
"icons/apple-icon-152x152.png": "fe4dbf9f8269e8120be60ef0f0ee26e7",
"version.json": "64b50cdd7695809f88fc1ec9d73e2a9d",
"canvaskit/canvaskit.wasm": "42df12e09ecc0d5a4a34a69d7ee44314",
"canvaskit/skwasm.worker.js": "51253d3321b11ddb8d73fa8aa87d3b15",
"canvaskit/chromium/canvaskit.wasm": "be0e3b33510f5b7b0cc76cc4d3e50048",
"canvaskit/chromium/canvaskit.js": "96ae916cd2d1b7320fff853ee22aebb0",
"canvaskit/skwasm.wasm": "1a074e8452fe5e0d02b112e22cdcf455",
"canvaskit/canvaskit.js": "bbf39143dfd758d8d847453b120c8ebb",
"canvaskit/skwasm.js": "95f16c6690f955a45b2317496983dbe9",
"flutter.js": "6fef97aeca90b426343ba6c5c9dc5d4a"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
