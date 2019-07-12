//
//  RecruitService.swift
//  GetRestIOS
//
//  Created by 박경선 on 13/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

import Foundation
import Alamofire

struct RecruitService {
    let jwt = UserDefaults.standard.object(forKey: "token") as! String
    let userIdx = UserDefaults.standard.object(forKey: "userIdx") as! Int
    static let shared = RecruitService()
    
    func getAllRecruit(date: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        let URL = APIConstants.RecruitURL
        let header: HTTPHeaders = [
            "Authorization" : jwt ,
            "Content-Type" : "application/json"
        ]
        
        let data: Parameters = [
            "date": "2019/4"
        ]
        
        print("채용정보 통신 시작")
        Alamofire.request(URL, method: .post, parameters: data, headers: header)
            .responseData { response in
                print("response  : ", response)
                switch response.result {
                case .success:
                    print("채용정보 통신 response good")
                    print("response.result  : ", response.result)
                    if let value = response.result.value {
                        if let status = response.response?.statusCode {
                            print("채용정보 통신 시작 상태 : ", status)
                            switch status {
                            case 200:
                                do {
                                    let decoder = JSONDecoder()
                                    let result = try decoder.decode(ResponseArray<RecruitListModel>.self, from: value)
                                    print("result :  ", result)
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
