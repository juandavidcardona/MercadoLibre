//
//  ServicesManager.swift
//  MercadoLibre
//
//  Created by Juan on 17/16/22.
//

import Foundation

enum HTTPMethod: String {
    case delete = "DELETE"
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case put = "PUT"
}

enum NetworkServiceError: Error {
    case decodingError
    case invalidURL
    case notKnownResponseCode
    case notParsedParameters
    case refreshTokenFailed
    case retryFailed
    case unpreparableRequest
}

enum NetworkServiceStatus: Int {
    case success
    case fail
    case notFound
}

typealias NetworkServiceCompletion<T: Codable> = (NetworkServiceStatus, T?) -> Void

class ServicesManager: NSObject {
    var endpoint = ""
    var host = ""
    var replaceHeaders = false
    var headers: [String: String] = [:]
    var method: HTTPMethod = .get
    var parameters: [String: Any] = [:]
    var request: URLRequest = URLRequest(url: URL(fileURLWithPath: ""))
    var retriable = true
    var retryCount = 0
    static var isSSLPinningEnabled = false

    override init() {
        
    }
    
    func callCore<T: Codable> (modelType: T.Type, completion: @escaping NetworkServiceCompletion<T>) {
       
        do {
            try prepareRequest()
        } catch {
            completion(.fail, nil)
        }
        
        let configuration: URLSessionConfiguration = {
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = 180
            configuration.timeoutIntervalForResource = 180
            return configuration
        }()
        
        let task = URLSession(configuration: configuration, delegate: self, delegateQueue: OperationQueue.main).dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                do {
                    let responseCode = (response as? HTTPURLResponse)?.statusCode ?? 0
                    var parametersSent = ""
                    if let method = self.request.httpMethod {
                        switch method {
                        case "GET":
                            self.parameters.forEach { (key: String, value: Any) in
                                parametersSent += "\(key) => \(value)\n"
                            }
                        default :
                            parametersSent = String(data: self.request.httpBody ?? Data(), encoding: .utf8) ?? ""
                        }
                    }
                    guard error == nil else {
                        completion(.fail, nil)
                        return
                    }
                    if let availableData = data {
                        if responseCode == 401 {
                        } else if (200...299).contains(responseCode) {
                            try self.handleSuccessResponse(modelType: modelType, data: availableData, completion: completion)
                        } else if responseCode == 404 {
                            completion(.notFound, nil)
                        } else {
                            completion(.fail, nil)
                        }
                    } else {
                        self.handleRetry(modelType: modelType, completion: completion)
                    }
                } catch {
                    completion(.fail, nil)
                }
            }
        }
        task.resume()
    }

    private func preparePOSTParameters() throws {
        do {
            if replaceHeaders {
                let data: Data = "grant_type=client_credentials".data(using: .utf8) ?? Data()
                request.httpBody = data
            } else {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            }
        } catch {
            throw(NetworkServiceError.notParsedParameters)
        }
    }

    private func prepareRequest() throws {
        do {
            var url = try prepareURL()
            request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            switch method {
            case .get:
                url = try prepareURL(parametersInURL: true)
            case .delete, .patch, .post, .put:
                try preparePOSTParameters()
            }
            request.url = url
            prepareHeaders()
        } catch let error {
            throw(error)
        }
    }

    private func prepareURL(parametersInURL: Bool = false) throws -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = endpoint
        if components.path.contains("%@") {
            parameters.forEach({ components.path = components.path.replacingOccurrences(of: "%@\($0.key)", with: "\($0.value)") })
        }
        if parametersInURL {
            components.queryItems = parameters.compactMap({return URLQueryItem(name: $0.key, value: "\($0.value)")})
        }
        if let url = components.url {
            return url
        } else {
            throw(NetworkServiceError.invalidURL)
        }
    }
    
    private func prepareHeaders() {
        var requestHeaders = request.allHTTPHeaderFields ?? [:]
        
        if !replaceHeaders {
            requestHeaders["Content-type"] = "application/json"
            requestHeaders["Accept"] = "application/json"
            requestHeaders["User-Agent"] = ""
        }
        
        headers.forEach { (key: String, value: String) in
            requestHeaders[key] = value
        }
        
        request.allHTTPHeaderFields = requestHeaders
    }
    
    private func handleRetry<T: Codable> (modelType: T.Type, completion: @escaping NetworkServiceCompletion<T>) {
        if retryCount < 3  && retriable {
            retryCount += 1
            callCore(modelType: modelType, completion: completion)
        } else {
            completion(.fail, nil)
        }
    }
    
    private func handleSuccessResponse<T: Codable>(modelType: T.Type, data: Data, completion: @escaping NetworkServiceCompletion<T>) throws {
        if retryCount != 0 {
            retryCount = 0
        }
        do {
            let decodedData = try JSONDecoder().decode(modelType.self, from: data)
            completion(.success, decodedData)
        } catch {
            throw(NetworkServiceError.decodingError)
        }
    }
    
}

extension ServicesManager: URLSessionDelegate {
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        guard let serverTrust = challenge.protectionSpace.serverTrust else { return }
        let credential:URLCredential = URLCredential(trust: serverTrust)
        completionHandler(.useCredential, credential)
    }
}

