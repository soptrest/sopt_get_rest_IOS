//
//  AuthService.swift
//  GetRestIOS
//
//  Created by 박경선 on 12/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

import Foundation
import Alamofire

struct AuthService {
    
    static let shared = AuthService()
    let header: HTTPHeaders = [
        "Content-Type" : "application/json"
    ]
    
    func login(_ id: String, _ password: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let body: Parameters = [
            "userEmail" : id,
            "userPassword" : password,
        ]
        Alamofire.request(APIConstants.LoginURL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header)
            .responseData { response in
                
                switch response.result {
                case .success:
                    if let value = response.result.value {
                        if let status = response.response?.statusCode {
                            print("로그인 상태 : ", status)
                            switch status {
                            case 200:
                                do {
                                    let decoder = JSONDecoder()
                                    let result = try decoder.decode(ResponseResult<SignInModel>.self, from: value)
                                    switch result.success {
                                    case true:
                                        completion(.success(result.data?.userToken))
                                    case false:
                                        completion(.requestErr(result.message))
                                    }
                                } catch {
                                    completion(.pathErr)
                                }
                            case 400:
                                completion(.pathErr)
                            case 404:
                                completion(.pathErr)
                            default:
                                break
                            }
                        }
                    }
                    break
                    
                case .failure(let err):
                    print(err.localizedDescription)
                    completion(.networkFail)
                    break
                }
        }
    }
    
    func signup(id: String,name: String, password: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let body: Parameters = [
            "userEmail" : id,
            "userPassword" : password,
            "userName" : name
        ]
        
        Alamofire.request(APIConstants.SignUpURL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header)
            .responseData { response in
                
                switch response.result {
                    
                case .success:
                    if let value = response.result.value {
                        if let status = response.response?.statusCode {
                            print("회원가입 상태 : ", status)
                            switch status {
                            case 201:
                                do {
                                    let decoder = JSONDecoder()
                                    let result = try decoder.decode(DefaultRes.self, from: value)
                                    switch result.success {
                                    case true:
                                        completion(.success(result))
                                    case false:
                                        completion(.requestErr(result.message))
                                    }
                                } catch {
                                    completion(.pathErr)
                                }
                            case 400:
                                completion(.pathErr)
                            default:
                                break
                            }
                        }
                    }
                    break
                    
                case .failure(let err):
                    print(err.localizedDescription)
                    completion(.networkFail)
                    break
                }
        }
    }
}
