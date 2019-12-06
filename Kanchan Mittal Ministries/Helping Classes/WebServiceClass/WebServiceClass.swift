//  WebServiceClass.swift
import Foundation
import UIKit
import Alamofire
import Security

struct CallBackMethodsNew {
    typealias failure           = (_ failure:Error) -> () // for failure case
    typealias param             = Dictionary<String, String> // for parameter dicts
    typealias responseObject    = Dictionary<String, AnyObject> // for parameter dicts
    typealias SourceCompletionHandler = (_ success:AnyObject) -> () // for success case
    static let notConnectedToInternet  = "Net"
    static let serverError             = "ServerError"
    typealias APIServiceSuccessCallback = ((Any?) -> ())
    typealias APIServiceFailureCallback = ((NetworkErrorReason?, NSError?) -> ())
    typealias progressBlock = ((Float) -> ())?
    typealias saveBlockStatus = ((Bool) -> ())?
}

public enum NetworkErrorReason: Error {
    case FailureErrorCode(code: Int, message: String)
    case InternetNotReachable
    case UnAuthorizedAccess
    case Other
}

struct AlamoManager {

    static let shared: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 120
        let sessionManager = Alamofire.SessionManager(configuration: configuration)
        return sessionManager
    }()
}

class WebServiceClass {
        
    static let sharedInstance = WebServiceClass()
    
    //MARK:- Data task
    open func dataTask(urlName: String, method: String, params: String, completion: @escaping (_ success: Bool, _ object: Any, _ errorMsg: String) -> ()) {
        
        let urlString: URL = URL(string: urlName)!
        print("API Name:- \(urlString) Get body Data: \(params)")
        
        let request = NSMutableURLRequest(url: urlString,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 60.0)
        request.httpMethod = method
        
        request.addValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = params.data(using: String.Encoding.utf8)
        
        let session = URLSession.shared
        
//        if Reachability.isConnectedToNetwork() == false {
//            completion(false, "", AKErrorHandler.CommonErrorMessages.NO_INTERNET_AVAILABLE)
//        }
        
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            DispatchQueue.main.async(execute: {

                if (error != nil) {
                    completion(false, "", error?.localizedDescription ?? "")
                } else {
                    
                    if let response = response as? HTTPURLResponse , 200...501 ~= response.statusCode  {
                        
                        if response.statusCode == 201 || response.statusCode == 200 {
                            
                            // Check Data
                            if let data = data {
                                // Json Response
                                if let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                                    completion(true, jsonResponse, "")
                                } else {
                                    completion(false, "", Constant.Messages.internetError)
                                }
                            } else {
                                completion(false, "", Constant.Messages.internetError)
                            }
                        } else if response.statusCode == 404 {
                            completion(false, "", Constant.Messages.internalServerError)
                        } else {
                            completion(false, "", Constant.Messages.internetError)
                        }
                    } else {
                        completion(false, "", Constant.Messages.errorMessage)
                    }
                }
            })
        })
        dataTask.resume()
    }
    
    // for sending data in header
    static func serviceFunctionWithHeaders(urlName: String, method:HTTPMethod,  params:Dictionary<String, AnyObject>?, header:[String:String]?, completion: @escaping (_ success: Bool, _ object: Any, _ errorMsg: String) -> ()) {
        
        print("Webservice params", params ?? "not found")
        print("Webservice Service URL", urlName)
        print("Webservice headers", header ?? "not found headers")
        
        AlamoManager.shared.request(urlName, method: method, parameters: params, encoding: JSONEncoding.default, headers: header).responseJSON { (response:DataResponse<Any>) in
            switch(response.result) {
            case .success(_):
                let Json = (response.result.value as AnyObject?)
                print(Json ?? "Not Found")
                if let httpStatus = response.response , httpStatus.statusCode == 200 || httpStatus.statusCode == 201 {
                    if response.result.isSuccess {
                        completion(true, Json ?? [:], "")
                    }  else {
                        completion(false, Json ?? [:], "")
                    }
                } else {
                    completion(false, [:], Constant.Messages.internalServerError)
                }
                break
            case .failure(_):
                completion(false, "", response.result.error?.localizedDescription ?? "")
                break
            }
        }
    }
    
    static func dataTask(urlName: String, method: String, params: String, completion: @escaping (_ success: Bool, _ object: AnyObject, _ errorMsg: String) -> ()) {
        
        //let urlNew:String = urlName.trim().replacingOccurrences(of: " ", with: "%20")
        // let URLnew = urlName.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
        
        let URLnew = removeSpecialCharsFromString(text: urlName)
        
        let UrlFinal = URLnew.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
        
        let urlString: URL = URL(string: UrlFinal)!
        
        //let body = self.createMultiPartBody(parameters: params as [[String : AnyObject]])
        print("API Name:- \(urlString) Get body Data: \(params)")
        
        let request = NSMutableURLRequest(url: urlString,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 60.0)
        request.httpMethod = method
        
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = params.data(using: String.Encoding.utf8)
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            DispatchQueue.main.async(execute: {
                
                if (error != nil) {
                    
                    completion(false, "" as AnyObject, Constant.Messages.errorMessage)
                    
                } else {
                    
                    if let response = response as? HTTPURLResponse , 200...422 ~= response.statusCode  {
                        // Check Data
                        if let data = data {
                            
                            // Json Response
                            if let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                                
                                if let jsonResult = jsonResponse as? Dictionary<String, AnyObject> {
                                    
                                    // print(jsonResult)
                                    
                                    if response.statusCode == 201 || response.statusCode == 200 {
                                        
                                        if jsonResult["status"] as? Int == 401 {
                                            completion(false, 401 as AnyObject, "")
                                        } else {
                                            completion(true, jsonResult as AnyObject, "")
                                        }
                                        
                                    } else if response.statusCode == 401 || response.statusCode == 400 ||  response.statusCode == 422 {
                                        
                                        completion(false, jsonResult as AnyObject, "Constant.Messages.internetError")
                                    } else {
                                        completion(false, "" as AnyObject, Constant.Messages.internetError)
                                    }
                                } else {
                                    
                                    completion(false, "" as AnyObject, Constant.Messages.internetError)
                                    
                                }
                            } else {
                                
                                completion(false, "" as AnyObject, Constant.Messages.internetError)
                                
                            }
                            
                        } else {
                            
                            completion(false, "" as AnyObject, Constant.Messages.internetError)
                            
                        }
                        
                    } else {
                        
                        completion(false, "" as AnyObject, Constant.Messages.errorMessage)
                    }
                }
            })
        })
        dataTask.resume()
    }
    
    //MARK: Error Handling
    static private func handleError(response: DataResponse<Any>?, error: NSError, callback:CallBackMethodsNew.APIServiceFailureCallback) {
        if let errorCode = response?.response?.statusCode {
            guard let responseJSON = self.JSONFromData(data: (response?.data)! as NSData) else {
                callback(NetworkErrorReason.FailureErrorCode(code: errorCode, message:""), error)
                debugPrint("Couldn't read the data")
                return
            }
            let message = (responseJSON as? NSDictionary)?["err"] as? String ?? "Something went wrong. Please try again."
            callback(NetworkErrorReason.FailureErrorCode(code: errorCode, message: message), error)
            
        } else {
            let customError = NSError(domain: "Network Error", code: error.code, userInfo: error.userInfo)
            if let errorCode = response?.result.error?.localizedDescription , errorCode == "The Internet connection appears to be offline." {
                callback(NetworkErrorReason.InternetNotReachable, customError)
            }
            else {
                callback(NetworkErrorReason.Other, customError)
            }
        }
    }
    
    //MARK: Data Handling
    // Convert from NSData to json object
    static private func JSONFromData(data: NSData) -> Any? {
        do {
            return try JSONSerialization.jsonObject(with: data as Data, options: .mutableContainers)
        } catch let myJSONError {
            debugPrint(myJSONError)
        }
        return nil
    }
    
    // Convert from JSON to nsdata
    static private func nsdataFromJSON(json: AnyObject) -> NSData?{
        do {
            return try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted) as NSData?
        } catch let myJSONError {
            debugPrint(myJSONError)
        }
        return nil;
    }
    
    static func dataTaskFunctionWithAlamofire(urlName: String,method:HTTPMethod,  params:Dictionary<String, AnyObject>?, completion: @escaping (_ success: Bool, _ object: Any, _ errorMsg: String) -> ()) {
        
        print("Webservice params", params ?? "not found")
        print("Webservice Service URL", urlName)
        
      //Alamofire
        AlamoManager.shared.request(urlName, method: method, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                let Json = (response.result.value as AnyObject?)
                print(Json ?? "Not Found")
                if let err = response.error as? URLError, err.code  == URLError.Code.notConnectedToInternet {
                    completion(false, [:], response.error?.localizedDescription ?? "")
                } else {
                    if let httpStatus = response.response , httpStatus.statusCode == 200 || httpStatus.statusCode == 201 {
                        if response.result.isSuccess {
                            completion(true, Json ?? [:], "")
                        }  else {
                            completion(false, Json ?? [:], "")
                        }
                    } else {
                        completion(false, [:], Constant.Messages.internalServerError)
                    }
                }
                break
            case .failure(let error):
                if let err = error as? URLError, err.code  == URLError.Code.notConnectedToInternet {
                    completion(false, [:], err.localizedDescription)
                } else {
                    completion(false, [:], Constant.Messages.errorMessage)
                }
                break
            }
        }
     }
    
    
    static func uploadObjectToServer(urlName: String, dict:Dictionary<String, AnyObject>, completion: @escaping (_ success: Bool, _ object: Any, _ errorMsg: String) -> ()) {
        
        var request = URLRequest(url: try! urlName.asURL())
                
        request.httpMethod = "POST"
        request.httpBody = try! JSONSerialization.data(withJSONObject: dict)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        AlamoManager.shared.request(request).responseJSON { response in
            
            switch (response.result) {
            case .success:
                
                let Json = (response.result.value as AnyObject?)
                print(Json ?? "Not Found")
                if let err = response.error as? URLError, err.code  == URLError.Code.notConnectedToInternet {
                    completion(false, [:], response.error?.localizedDescription ?? "")
                } else {
                    if let httpStatus = response.response , httpStatus.statusCode == 200 || httpStatus.statusCode == 201 {
                        if response.result.isSuccess {
                            print(response)
                            completion(true, Json ?? [:], "")
                        }  else {
                            completion(false, Json ?? [:], "")
                        }
                    } else {
                        completion(false, [:], Constant.Messages.internalServerError)
                    }
                }
            case .failure(let error):
                
                if let err = error as? URLError, err.code  == URLError.Code.notConnectedToInternet {
                    completion(false, [:], err.localizedDescription)
                } else {
                    completion(false, [:], Constant.Messages.errorMessage)
                }
            }
        }
    }
}

func removeSpecialCharsFromString(text: String) -> String {
    let okayChars : Set<Character> =
        Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890+-*=()?/,.:!_&")
    return String(text.filter {okayChars.contains($0) })
}
