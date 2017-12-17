import Foundation

/// Used for De/Encoding User documents.
struct User: Codable {
  /// User's email.
  var email = ""
  /// User's password.
  var password = ""
  /// User's created trips.
  var trips: [Trip]?
}
