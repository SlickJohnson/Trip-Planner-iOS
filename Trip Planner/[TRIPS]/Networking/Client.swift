import Foundation

/**

 */
enum Result<T> {
  case success(T)
  case failure(Error)
}

/**
 Error cases that will be handled by the Client.

 - couldNotParse: Error occurs when that data retrieved can't be converted into a swift model.
 - noData: Error occurs when there is no response data.
 */
enum ResourceError: Error {
  case couldNotParse
  case noData
}

/// Used to send HTTP requests to the [TRIPS] server.
final class Client {
  /// The URLSession to be used by the client.
  let urlSession = URLSession.shared
  /// The baseURL of the server.
  let baseURL = "https://vybe-trip-planner.herokuapp.com/"
  /// Shared instance of Client.
  static let shared = Client()
  /// Signed in user.
  var user: User?
}

// MARK: - Requests
extension Client {
  /**
   Sends an HTTP request to the server.

   Parameters:
   - resource: A Resource object used to construct the HTTP request.
   - completion: The completion handler used to access the data in the response.
   */
  func request(with resource: Resource, completion: @escaping (Result<Any>) -> Void) {
    urlSession.dataTask(with: getURLRequest(for: resource)) { data, response, error in
      if let error = error {
        return completion(Result.failure(error))
      }
      
      guard let data = data else {
        return completion(Result.failure(ResourceError.noData))
      }

      if let result = try? JSONDecoder().decode(User.self, from: data) {
        return completion(Result.success(result))
      }

      return completion(Result.failure(ResourceError.couldNotParse))
      }.resume()
  }
}

// MARK: - Helper functions.
private extension Client {
  /**
   Constructs an HTTP request using the given resource object.

   - Parameters:
   - resource: Used to construct the request.
   - id: An optional used to construct the HTTP request params.

   - Returns: An URLRequest used to interact with the Resource of interest.
   */
  func getURLRequest(for resource: Resource, with email: String? = nil) -> URLRequest {
    let params = resource.getParams(email: email ?? "")

    print("\(resource.getPath())?\(resource.stringFrom(params))")
    let fullURL = URL(string: baseURL.appending("\(resource.getPath())?\(resource.stringFrom(params))"))!

    var request = URLRequest(url: fullURL)
    request.httpMethod = resource.getHTTPMethod().rawValue
    request.allHTTPHeaderFields = resource.getHeaders()

    return request
  }
}
