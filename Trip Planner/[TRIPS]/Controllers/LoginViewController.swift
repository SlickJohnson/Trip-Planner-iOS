import UIKit

/// First screen to show when there is no user signed in
class LoginViewController: UIViewController {
  /// Email required to login.
  @IBOutlet weak var userEmailTextField: SpacedFontTextField!
  /// Password required to login.
  @IBOutlet weak var userPasswordTextField: SpacedFontTextField!

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  /// IBAction for login/signup button. Triggers a post/get request.
  @IBAction func loginUserButton(_ sender: UIButton) {
    guard let email = userEmailTextField.text, let password = userPasswordTextField.text else {
      return
    }

    let resource = UserResource.login(email: email, password: password)

    Client.shared.request(with: resource) { (result) in
      switch result {
      case let .success(user):
        Client.shared.user = user as? User

      case let .failure(error):
        dump(error)
      }

      let storyboard = UIStoryboard(name: "Main", bundle: nil)

      DispatchQueue.main.async {
        self.present(storyboard.instantiateInitialViewController()!, animated: true, completion: {
          UserDefaults.standard.set("email", forKey: "email")
          UserDefaults.standard.set("password", forKey: "password")
        })
      }
    }
  }

  @IBAction func signupUserButton(_ sender: UIButton) {
    guard let email = userEmailTextField.text, let password = userPasswordTextField.text else {
      return
    }

    let resource = UserResource.signup(email: email, password: password)

    Client.shared.request(with: resource) { (result) in
      switch result {
      case let .success(user):
        Client.shared.user = user as? User

      case let .failure(error):
        dump(error)
      }

      let storyboard = UIStoryboard(name: "Main", bundle: nil)

      DispatchQueue.main.async {
        self.present(storyboard.instantiateInitialViewController()!, animated: true, completion: {
          UserDefaults.standard.set("email", forKey: "email")
          UserDefaults.standard.set("password", forKey: "password")
        })
      }
    }
  }

}
