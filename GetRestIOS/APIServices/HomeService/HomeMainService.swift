//
//  HomeMainService.swift
//  GetRestIOS
//
//  Created by 박경선 on 11/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

import Foundation
import Alamofire

struct HomeMainService {
    
    static let shared = HomeMainService()
    
    func getGraphData(authorization: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        let URL = APIConstants.HomeURL
        
        let header: HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        
        print(URL)
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
            .responseData { response in
                print("response")
                switch response.result {
                case .success:
                    if let value = response.result.value {
                        print("value")
                        if let status = response.response?.statusCode {
                            switch status {
                            case 200:
                                do {
                                    let decoder = JSONDecoder()
//                                    print(ResponseArray<HomeGraphModel>.self)
                                    let result = try decoder.decode(ResponseArray<HomeGraphModel>.self, from: value)
                                    print("result")
                                    
                                    switch result.success {
                                    case true:
                                        completion(.success(result.data!))
                                    case false:
                                        completion(.requestErr(result.message))
                                    }
                                } catch {
                                    completion(.pathErr)
                                }
                            case 400:
                                completion(.pathErr)
                            case 500:
                                completion(.serverErr)
                                
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
