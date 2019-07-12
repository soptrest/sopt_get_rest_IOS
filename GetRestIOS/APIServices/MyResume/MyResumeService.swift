//
//  MyResumeService.swift
//  GetRestIOS
//
//  Created by 박경선 on 12/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct MyResumeService {
    //    let jwt = UserDefaults.standard.string(forKey: "jwt")
    let jwt = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWR4Ijo0NCwidXNlckVtYWlsIjoidXNlcjEiLCJpYXQiOjE1NjI5MzYxNjQsImV4cCI6MTU2MzEwODk2NCwiaXNzIjoic2FuZ3l1bkxFRSJ9.l-yQn2Z1EvD30kPfFHVG0JsRiM93WWM8uGzxGzE33i4"
    //    let userIdx = UserDefaults.standard.object(forKey: "userIdx")
    let userIdx = 43
    static let shared = MyResumeService()
    
    func getAllResume( completion: @escaping (NetworkResult<Any>) -> Void) {
        let URL = APIConstants.ResumeURL + "/resume"
        let header: HTTPHeaders = [
            "Authorization" : jwt,
            "Content-Type" : "application/json"
        ]
        
        print("나의 자소서 통신 시작")
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default , headers: header)
            .responseData { response in
                print("response  : ", response)
                switch response.result {
                case .success:
                    print("나의 자소서 전체 조회 response good")
                    if let value = response.result.value {
                        if let status = response.response?.statusCode {
                            print("나의 자소서 로딩 상태 : ", status)
                            switch status {
                            case 200:
                                do {
                                    let decoder = JSONDecoder()
                                    let result = try decoder.decode(ResponseArray<MyResumeListModel>.self, from: value)
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
    
    func getDetailResume(resumIdx: Int, questionIdx: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        let URL = APIConstants.ResumeURL + "/resume/\(resumIdx)/\(questionIdx)"
        let header: HTTPHeaders = [
            "Authorization" : jwt,
            "Content-Type" : "application/json"
        ]
        
        let data: Parameters = [
            "resumIdx": resumIdx,
            "questionIdx" : questionIdx
        ]
        
        print("나의 자소서 자세히 보기 통신 시작")
        Alamofire.request(URL, method: .get, parameters: data, encoding: JSONEncoding.default , headers: header)
            .responseData { response in
                switch response.result {
                case .success:
                    print("나의 자소서 자세히 보기 response good")
                    if let value = response.result.value {
                        if let status = response.response?.statusCode {
                            print("나의 자소서 자세히 보기 로딩 상태 : ", status)
                            switch status {
                            case 200:
                                do {
                                    let decoder = JSONDecoder()
                                    let result = try decoder.decode(ResponseResult<MyResumeDetailModel>.self, from: value)
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
                            case 404 :
                                print("회원이 없습니다.")
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
    
    func modifyDetailResume(resumIdx: Int, questionIdx: Int, content: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        let URL = APIConstants.ResumeURL + "/resume/\(resumIdx)/\(questionIdx)"
        let header: HTTPHeaders = [
            "Authorization" : jwt,
            "Content-Type" : "application/json"
        ]
        
        let data: Parameters = [
            "recruitIdx": resumIdx,
            "questionNum" : questionIdx,
            "questionContent" : content
        ]
        
        print("나의 자소서 수정 통신 시작" )
        Alamofire.request(URL, method: .get, parameters: data, encoding: JSONEncoding.default , headers: header)
            .responseData { response in
                switch response.result {
                case .success:
                    print("나의 자소서 수정 response good")
                    if let value = response.result.value {
                        if let status = response.response?.statusCode {
                            print("나의 자소서 수정 로딩 상태 : ", status)
                            switch status {
                            case 200:
                                do {
                                    let decoder = JSONDecoder()
                                    let result = try decoder.decode(DefaultRes.self, from: value)
                                    print("result  : ", result)
                                    switch result.success {
                                    case true:
                                        completion(.success(result))
                                    case false:
                                        completion(.requestErr(result.message))
                                    }
                                } catch {
                                    completion(.pathErr)
                                }
                            case 400 :
                                print("필요한 값이 없습니다.")
                            case 401 :
                                print("토큰 값 오류")
                                completion(.pathErr)
                            case 500 :
                                print("회원을 찾을 수 없습니다")
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
