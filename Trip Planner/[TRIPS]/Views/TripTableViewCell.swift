import UIKit

/// UITableViewCell used to display trip data.
final class TripTableViewCell: UITableViewCell {
  /// Name of the trip set by user.
  @IBOutlet weak var tripNameLabel: SpacedFontLabel!
  /// List of things to do set by user.
  @IBOutlet weak var tripWaypointTextView: UITextView!
  /// The size of the cell displayed in a UITableView
  static let cellHeight: CGFloat = 166

  @IBOutlet weak var roundedView: UIView!

  override func awakeFromNib() {
    super.awakeFromNib()
    roundedView.layer.cornerRadius = 5
  }
}
