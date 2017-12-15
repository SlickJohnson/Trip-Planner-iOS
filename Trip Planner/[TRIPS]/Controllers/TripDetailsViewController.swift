import UIKit

/// Shows the details of the selected/new trip.
class TripDetailsViewController: UIViewController {
  /// Shows the trip's waypoints
  @IBOutlet weak var waypointsTableView: UITableView!

  @IBOutlet weak var popupView: UIView!
  override func viewDidLoad() {
    super.viewDidLoad()

    waypointsTableView.delegate = self
    waypointsTableView.dataSource = self

    popupView.layer.cornerRadius = 10
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  @IBAction func dismiss(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }

}

// MARK: - UITableViewDataSource
extension TripDetailsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: "WaypointCell") as? WaypointTableViewCell {
      cell.waypointTextField.text = "\u{2022} Explore the best museum"
      return cell
    }

    return UITableViewCell()
  }
}

// MARK: - UITableViewDelegate
extension TripDetailsViewController: UITableViewDelegate {

}

