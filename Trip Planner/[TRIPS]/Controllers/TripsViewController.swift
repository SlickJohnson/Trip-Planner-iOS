import UIKit

/// Shows all the trips created by the user in UITableView
class TripsViewController: UIViewController {
  /// Displays all trips that belong to the logged in user.
  @IBOutlet weak var tripsTableView: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()

    tripsTableView.delegate = self
    tripsTableView.dataSource = self
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}

// MARK: - UITableViewDatasource
extension TripsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: "TripCell") as? TripTableViewCell {
      cell.tripNameLabel.text = "Trip 2017"
      cell.tripWaypointTextView.text = "\u{2022} Explore the best museum\n\u{2022} Explore the best museum"

      return cell
    }

    return UITableViewCell()
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    UIView.animate(withDuration: 0.25) {
      if let cell = tableView.cellForRow(at: indexPath) as? TripTableViewCell {
        cell.roundedView.transform = .init(scaleX: 1.05, y: 1.05)
//        cell.roundedView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
      }
    }
  }

  func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    UIView.animate(withDuration: 0.25) {
      if let cell = tableView.cellForRow(at: indexPath) as? TripTableViewCell {
        cell.roundedView.transform = .identity
//        cell.contentView.backgroundColor = .clear
      }
    }
  }

}

// MARK: - UITableViewDelegate
extension TripsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return TripTableViewCell.cellHeight
  }
}


