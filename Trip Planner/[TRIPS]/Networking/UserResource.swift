import Foundation

/**
 HTTP methods used in this app.
 
 - get: An HTTP GET request.
 - post: An HTTP POST request.
 - patch: An HTTP PATCH request.
 - del: An HTTP DELETE request.
 */
enum HTTPMethod: String {
  case get = "GET"
  case post = "POST"
  case patch = "PATCH"
  case del = "DELETE"
}

/**
 Used to construct the HTTP request for the User resource.
 
 - login: A GET request that checks to see if there is a matching user.
 - signup: A POST request that creates a new user document in the database.
 - update: A PATCH request that updates the user's information (email, password, etc.)
 - delete: A DELETE request that completely removes the user from the database.
 */
enum UserResource: Resource {
  case login(email: String, password: String)
  case signup(email: String, password: String)
  case update(email: String, password: String)
  case delete(email: String, password: String)

  func getHTTPMethod() -> HTTPMethod {
    switch self {
    case .login:
      return .get
    case .signup:
      return .post
    case .update:
      return .patch
    case .delete:
      return .del
    }
  }

  func getHeaders() -> [String: String] {
    switch self {
    case let .login(email, password), let .update(email, password), let .delete(email, password):
      let loginString = "\(email):\(password)"
      let loginData = loginString.data(using: String.Encoding.utf8)!
      let base64LoginString = loginData.base64EncodedString()

      return [
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Basic \(base64LoginString)",
      ]
    default:
      return ["":""]
    }
  }

  func getParams(email: String) -> [String: String] {
    return ["email": email]
  }

  func stringFrom(_ parameters: [String: String]) -> String {
    let parameterArray = parameters.map { key, value in
      return "\(key)=\(value)"
    }

    return parameterArray.joined(separator: "&")
  }

  func getPath() -> String {
    return "user"
  }
}
