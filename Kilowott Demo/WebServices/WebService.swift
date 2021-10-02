//
//  WebService.swift
//  Kilowott Demo
//
//  Created by Clorida on 26/08/21.
//

import Foundation
// MARK: Web Services
enum HTTPMethod: String{
    case GET = "GET"
    case POST
    case DELETE
    case PUT
}
class WebService: NSObject {
    static let shared = WebService()
    let session = URLSession.shared
    func makeRequest(urlStr: String, parameter: String, method: HTTPMethod? = .GET, token: String? = nil, callback: @escaping (_ result: Data?, _ error: Error?) -> Void) {
        let url = URL(string: AppConstant.Base_URL+urlStr)
        var request = URLRequest(url: url!)
        request.httpMethod = method?.rawValue
        request.httpBody = parameter.data(using: String.Encoding.utf8)
        request.setValue(token, forHTTPHeaderField: "Authorization")
        let task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                callback( error == nil ? data! : nil, error)
            }
        }
        task.resume()
    }
}

