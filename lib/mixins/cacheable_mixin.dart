// Copyright (c) 2025 Intales Srl. All rights reserved.
// Use of this source code is governed by a MIT license that can be found
// in the LICENSE file.

mixin CacheableMixin {
  final Map<String, dynamic> _cache = {};

  T getCached<T>(String key, T Function() compute) {
    if (!_cache.containsKey(key)) {
      _cache[key] = compute();
    }
    return _cache[key] as T;
  }

  void clearCache() {
    _cache.clear();
  }

  void invalidateCache([String? keyPattern]) {
    if (keyPattern == null) {
      clearCache();
      return;
    }

    _cache.removeWhere((key, _) => key.contains(keyPattern));
  }

  bool hasCached(String key) {
    return _cache.containsKey(key);
  }

  void setCached<T>(String key, T value) {
    _cache[key] = value;
  }
}
