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
    let jwt = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWR4Ijo0MywidXNlckVtYWlsIjoiamVhbiIsImlhdCI6MTU2MjkyNzk3NiwiZXhwIjoxNTYzMTAwNzc2LCJpc3MiOiJzYW5neXVuTEVFIn0.uOSQKqYfgH7zj-1-M2l_YJUWywsz6S0HtTHWsjdc8Cs"
    
    static let shared = HomeMainService()
    
    func getGraphData( completion: @escaping (NetworkResult<Any>) -> Void) {
        let URL = APIConstants.HomeURL
        
        let header: HTTPHeaders = [
            "Authorization" : jwt,
            "Content-Type" : "application/json"
        ]
        
        Alamofire.request(URL, method: .get, parameters: [:], encoding: JSONEncoding.default, headers: header)
            .responseData { response in
                switch response.result {
                case .success:
                    if let value = response.result.value {
                        if let status = response.response?.statusCode {
                            print("그래프 로딩 상태 : ", status)
                            switch status {
                            case 200:
                                do {
                                    let decoder = JSONDecoder()
                                    let result = try decoder.decode(ResponseArray<HomeGraphModel>.self, from: value)
                                    switch result.success {
                                    case true:
                                        completion(.success(result.data!))
                                    case false:
                                        completion(.requestErr(result.message))
                                    }
                                } catch {
                                    completion(.pathErr)
                                }
                            case 204 :
                                print("작성한 포트폴리오가 없어요!")
                            case 403 :
                                print("토큰 값 오류")
                                completion(.pathErr)
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
    
    
    func getDetailTableData(date: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        let URL = APIConstants.HomeURL + "/portfolio"
        
        let header: HTTPHeaders = [
            "Authorization" : jwt,
            "Content-Type" : "application/json"
        ]
        
        let body: Parameters = [
            "date" : date
        ]
        
        
        Alamofire.request(URL, method: .get, parameters: body, encoding: JSONEncoding.default, headers: nil)
            .responseData { response in
                print("response : ", response)
                switch response.result {
                case .success:
                    if let value = response.result.value {
                        print("value : ", value)
                        if let status = response.response?.statusCode {
                            print("그래프 디테일 테이블 뷰 로딩 상태 : ", status)
                            switch status {
                            case 200:
                                do {
                                    let decoder = JSONDecoder()
                                    let result = try decoder.decode(ResponseArray<HomeGraphDetailModel>.self, from: value)
                                    print("result : ", result)
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
                            case 403:
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
