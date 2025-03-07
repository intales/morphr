// Copyright (c) 2025 Intales Srl. All rights reserved.
// Use of this source code is governed by a MIT license that can be found
// in the LICENSE file.

mixin CacheableMixin {
  static final Map<Type, Map<String, Map<String, dynamic>>> _globalCaches = {};

  String getCacheId();

  Map<String, dynamic> get _cache {
    final type = runtimeType;
    _globalCaches[type] ??= {};

    final String id = getCacheId();
    _globalCaches[type]![id] ??= {};

    return _globalCaches[type]![id]!;
  }

  T getCached<T>(String key, T Function() compute) {
    if (!_cache.containsKey(key)) {
      _cache[key] = compute();
    }
    return _cache[key] as T;
  }

  void clearCache() {
    _cache.clear();
  }

  static void clearAllCaches<T>() {
    _globalCaches[T]?.clear();
  }

  static void invalidateObjectCache<T>(String objectId) {
    _globalCaches[T]?.remove(objectId);
  }
}
