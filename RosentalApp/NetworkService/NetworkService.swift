//
//  NetworkService.swift
//  RosentalApp
//
//  Created by Ваня Сокол on 03.09.2024.
//

import Alamofire
import UIKit

final class NetworkService {
    
    static let shared = NetworkService()
    
    private let jsonDecoder = JSONDecoder()
    private let urlString = "https://test.rozentalgroup.ru/version2/entry.php"
    private let encoder = URLEncodedFormParameterEncoder(encoder: URLEncodedFormEncoder(arrayEncoding: .noBrackets))
    
    private init() { }
    
    public func makeAuthRequest(for username: String, password: String, completion: @escaping (Result<AuthModel, Error>) -> Void) {
        
        let headers: HTTPHeaders = [
            .authorization(username: username, password: password),
        ]
        
        let parameters = [
            "service[0][name]": "login",
            "service[0][attributes][login]": username,
            "service[0][attributes][password]": password,
            "service[1][name]": "customer_navbar"
        ]
        
        AF.request(urlString, method: .post, parameters: parameters, encoder: encoder, headers: headers)
            .validate()
            .response { response in
                if let data = response.data {
                    if let content = try? self.jsonDecoder.decode(AuthModel.self, from: data) {
                        DispatchQueue.main.async {
                            completion(.success(content))
                        }
                    }
                }
            }
    }
    
    public func makedDashboardRequest(for username: String, password: String, completion: @escaping (Result<ProfileModel, Error>) -> Void) {
        
        let headers: HTTPHeaders = [
            .authorization(username: username, password: password),
        ]
        
        let parameters = [
            "service[0][name]": "customer_dashboard",
            "service[1][name]": "my_profile",
            "service[2][name]": "my_new_notifications",
            "service[2][attributes][mode]": "private"
        ]
        
        AF.request(urlString, method: .post, parameters: parameters, encoder: encoder, headers: headers)
            .validate()
            .response { response in
                if let data = response.data {
                    if let content = try? self.jsonDecoder.decode(ProfileModel.self, from: data) {
                        DispatchQueue.main.async {
                            completion(.success(content))
                        }
                    }
                }
            }
    }
    
    public func downloadImage(fromURL url: String, completion: @escaping (UIImage) -> Void) {
        AF.request(url)
            .validate()
            .response { response in
                if let data = response.data,
                   let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        completion(image)
                    }
                }
        }
    }
}
