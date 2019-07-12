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
//    let jwt = UserDefaults.standard.string(forKey: "jwt")
    let jwt = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWR4Ijo3LCJ1c2VyRW1haWwiOiJ3aW5uZXJ5OTMzQGdtYWlsLmNvbSIsImlhdCI6MTU2MjgyNTg4MSwiZXhwIjoxNTYyOTEyMjgxLCJpc3MiOiJzYW5neXVuTEVFIn0.DrTFR2-ue4CmaGjWifdW6F_hjEOXKsKzn6Q95C1OzwQ"
    
    static let shared = HomeMainService()
    
    func getGraphData( completion: @escaping (NetworkResult<Any>) -> Void) {
        let URL = APIConstants.HomeURL
        
        let header: HTTPHeaders = [
            "Authorization" : jwt,
            "Content-Type" : "application/json"
        ]
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
            .responseData { response in
                switch response.result {
                case .success:
                    if let value = response.result.value {
                        print("value")
                        if let status = response.response?.statusCode {
                            print("status : ", status)
                            switch status {
                            case 200:
                                do {
                                     print("hi")
                                    let decoder = JSONDecoder()
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
