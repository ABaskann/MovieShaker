//
//  HTTPMethod.swift
//  MovieShaker
//
//  Created by Armağan Başkan on 15.04.2025.
//


import Foundation

enum HTTPMethod: String {
    case GET, POST, PUT, DELETE
}

struct APIService {
    static func performRequest<T: Decodable>(
        url: String,
        method: HTTPMethod,
        body: [String: Any]? = nil,
        headers: [String: String]? = nil,
        responseType: T.Type
    ) async throws -> T {
        
        guard let requestURL = URL(string: url) else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let body = body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        // ✅ Handle HTTP Errors
        try handleHTTPResponse(httpResponse, data: data)
        
        
        // ✅ Handle Plain Text Response
        if responseType == String.self, let stringResponse = String(data: data, encoding: .utf8) {
            return stringResponse as! T
        }
        
        // ✅ Handle JSON Response
        return try JSONDecoder().decode(responseType, from: data)
    }
    
    private static func handleHTTPResponse(_ response: HTTPURLResponse, data: Data) throws {
        switch response.statusCode {
        case 200...299:
            return
        case 400:
            let errorMessage = try? JSONDecoder().decode(APIErrorResponse.self, from: data)
            throw APIError.badRequest(errorMessage?.statusMessage ?? "Bad Request")
        case 401:
            let errorMessage = try? JSONDecoder().decode(APIErrorResponse.self, from: data)
            throw APIError.unauthorized(errorMessage?.statusMessage ?? "Unauthorized")
        case 403:
            throw APIError.forbidden
        case 404:
            let errorMessage = try? JSONDecoder().decode(APIErrorResponse.self, from: data)
            throw APIError.notFound(errorMessage?.statusMessage ?? "Not Found")
        case 500...599:
            let errorMessage = try? JSONDecoder().decode(APIErrorResponse.self, from: data)
            throw APIError.serverError(errorMessage?.statusMessage ?? "Server Error")
        default:
            throw APIError.unknownError
        }
    }
}

enum APIError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case badRequest(String)
    case unauthorized(String)
    case forbidden
    case notFound(String)
    case serverError(String)
    case decodingError(String)
    case unknownError
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .invalidResponse:
            return "Invalid response received."
        case .badRequest(let error):
            return error
        case .unauthorized(let error):
            return error
        case .forbidden:
            return "Access denied."
        case .notFound(let error):
            return error
        case .serverError(let error):
            return error
        case .decodingError(let error):
            return error
        case .unknownError:
            return "An unknown error occurred."
        }
    }
}

struct APIErrorResponse: Decodable {
    let statusCode: Int
    let statusMessage: String
    let success: Bool?

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case statusMessage = "status_message"
        case success
    }
}




