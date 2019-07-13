//
//  PortfolioDetailService.swift
//  GetRestIOS
//
//  Created by 최리안 on 13/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//


import Foundation
import Alamofire

struct PortfolioDetailService {
    
    let jwt = UserDefaults.standard.object(forKey: "token") as! String
    let userIdx = UserDefaults.standard.object(forKey: "userIdx") as! Int
    static let shared = PortfolioDetailService()
    
    func getPortfolioDetail(rcvIdx: Int,  completion: @escaping (NetworkResult<Any>) -> Void) {
        let URL = APIConstants.PortfolioURL + "/portfolio/\(rcvIdx)"
        print("jwt  : ", jwt)
        let header: HTTPHeaders = [
            "Authorization" : jwt ,
            "Content-Type" : "application/json"
        ]
        let body: Parameters = [
            "portfolioIdx" : "\(rcvIdx)"
        ]
        print("포트폴리오 디테일 뷰 시작")
        print(rcvIdx)
        Alamofire.request(URL, method: .get, parameters: body, encoding: JSONEncoding.default, headers: header)
            .responseData { response in
                print("response  : ", response)
                switch response.result {
                case .success:
                    print("포트폴리오 디테일 뷰 시작 response good")
                    if let value = response.result.value {
                        if let status = response.response?.statusCode {
                            print("포트폴리오 시작 상태 : ", status)
                            switch status {
                            case 200:
                                do {
                                    let decoder = JSONDecoder()
                                    let result = try decoder.decode(ResponseResult<PortfolioDetail>.self, from: value)
                                    print("result  : ", result)
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

