part of 'go_router_paths.dart';

/// The mixin for all route paths which contain a query
mixin Query<T> {
  /// adds a query to the path
  T query(Map<String, String> queryParameters);
}

/// A mixin that provides functionality to convert an object to a query string.
///
/// Classes that use this mixin must override the [toJson] method to provide
/// a map representation of the object.
///
/// The [toQuery] method converts the map returned by [toJson] into a query
/// string map, where each value is trimmed and empty values are removed.
mixin Queryable {
  /// Converts the object to a JSON map.
  ///
  /// Returns a map where the keys are strings and the values are dynamic.
  @mustBeOverridden
  Map<String, dynamic> toJson();

  /// Converts the object to a query map.
  ///
  /// Returns a map where the keys and values are strings. The values are
  /// trimmed and any entries with empty values are removed.
  Map<String, String> toQuery() {
    final entries = toJson().entries.where((element) => element.value != null);

    return {
      for (final map in entries) map.key: map.value.toString().trim(),
    }..removeWhere((key, value) => value.trim().isEmpty);
  }
}
