//
//  PortfolioService.swift
//  GetRestIOS
//
//  Created by 박경선 on 13/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

import Foundation
import Alamofire

struct PortfolioService {
    
    let jwt = UserDefaults.standard.object(forKey: "token") as! String
    let userIdx = UserDefaults.standard.object(forKey: "userIdx") as! Int
    static let shared = PortfolioService()
    
    func getAllPortfolio( completion: @escaping (NetworkResult<Any>) -> Void) {
        let URL = APIConstants.PortfolioURL + "/portfolio"
        print("jwt  : ", jwt)
        let header: HTTPHeaders = [
            "Authorization" : jwt ,
            "Content-Type" : "application/json"
        ]
        
        print("포트폴리오 시작")
        Alamofire.request(URL, method: .get, parameters: nil, headers: header)
            .responseData { response in
                print("response  : ", response)
                switch response.result {
                case .success:
                    print("포트폴리오 시작 response good")
                    if let value = response.result.value {
                        if let status = response.response?.statusCode {
                            print("포트폴리오 시작 상태 : ", status)
                            switch status {
                            case 200:
                                do {
                                    let decoder = JSONDecoder()
                                    let result = try decoder.decode(ResponseArray<PortfolioListModel>.self, from: value)
                                    switch result.success {
                                    case true:
                                        completion(.success(result.data!))
                                    case false:
                                        completion(.requestErr(result.message))
                                    }
                                } catch {
                                    completion(.pathErr)
                                }
                            case 400 :
                                print("조회 실패")
                            case 401 :
                                print("토큰 값 오류")
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
