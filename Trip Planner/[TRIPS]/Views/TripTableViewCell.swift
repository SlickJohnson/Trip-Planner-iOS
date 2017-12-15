import UIKit

/// UITableViewCell used to display trip data.
final class TripTableViewCell: UITableViewCell {
  /// Name of the trip set by user.
  @IBOutlet weak var tripNameLabel: SpacedFontLabel!
  /// List of things to do set by user.
  @IBOutlet weak var tripWaypointTextView: UITextView!
  /// The size of the cell displayed in a UITableView
  static let cellHeight: CGFloat = 166
  /// The visible view of the cell that's animated and customized.
  @IBOutlet weak var nesetedView: UIView!

  override func awakeFromNib() {
    super.awakeFromNib()
    nesetedView.layer.cornerRadius = 5
  }
}
