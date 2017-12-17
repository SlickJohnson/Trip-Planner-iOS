import Foundation

/// Used to De/Encode User's trip data.
struct Trip: Codable {
  /// Trip's name.
  var name: String = ""
  /// Todo's for the trip.
  var waypoints: [String]?
  /// Whether or not the trip has been completed.
  var completed: Bool = false
}
