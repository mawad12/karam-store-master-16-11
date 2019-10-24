//
//  WebRequests.swift
//  PT
//
//  Created by Musbah on 9/12/18.
//  Copyright © 2018 Musbah. All rights reserved.
//

import Foundation
import Alamofire

struct StatusStruct : Codable{
    let status: Bool?
    let code: Int?
    let message: String?
}

enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
    case delete = "DELETE"
    case put = "PUT"
    case patch = "PATCH"
}

enum DataType: String {
    case json
    case serialize
}

class WebRequests: NSObject {
    
    private static var controller: UIViewController?
    private static var headers = [String : String]()
    var parameters = [String : Any]()
    var ReqMethod: HTTPMethod = HTTPMethod.get
    private var isAuth: Bool = false
    var UrlString: String?
    
    
    
    override init() {}
    static func setup(controller: UIViewController?, headers : [String : String]? = [:]) -> WebRequests {
        print("\r\n---- START OF REQUEST HEADER ----")
        if controller != nil {
            WebRequests.controller = controller
        }else{
            WebRequests.controller = nil
        }
        
        if headers!.count > 0 {
            for (key, value) in headers! {
                WebRequests.headers[key] = value
                print("\(key)=\(value)\r\n")
            }
        }
        print("Accept-Language=\(MOLHLanguage.currentAppleLanguage())\r\n")
        WebRequests.headers["Accept-Language"] = MOLHLanguage.currentAppleLanguage()
        
        return WebRequests.init()
    }
    
    
    func post(query: String, isAuthRequired: Bool = true) -> WebRequests {
        return prepare(query: query, method: HTTPMethod.post, parameters: [:], isAuthRequired: isAuthRequired)
    }
    
    func get(query: String, isAuthRequired: Bool = true) -> WebRequests {
        return prepare(query: query, method: HTTPMethod.get, parameters: [:], isAuthRequired: isAuthRequired)
    }
    
    func prepare(query: String, method: HTTPMethod, parameters: [String: Any]? = nil, dataType: DataType = .serialize, isAuthRequired: Bool = true) -> WebRequests {
        print("\r\n\r\n---- START OF REQUEST URL ----")
        UrlString = TAConstant.APIBaseURL + query
        print(UrlString as Any)
        
        ReqMethod = method
        if isAuthRequired {
            self.isAuth = true
            WebRequests.headers["Authorization"] = "Bearer \(CurrentUser.userInfo?.accessToken ?? "")"
        }
        if parameters != nil {
            self.generateParametersForHttpBody(parameters: parameters!, dataType: dataType)
        }
        return self
        
    }
    
    private func generateParametersForHttpBody(parameters: [String: Any]?, dataType: DataType = .serialize) {
        print("\r\n---- START OF REQUEST PARAMETERS ----")
        
        for (key, value) in parameters! {
            //            postString += "\(key)=\(value)&"
            self.parameters[key] = value
            print("\(key)=\(value)\r\n")
            
        }
    }
    
    func start(completion: @escaping ((DataResponse<Any>,Error?)->Void)) -> WebRequests? {
        var headers: HTTPHeaders!
        headers = WebRequests.headers
        if WebRequests.controller != nil {
            
            WebRequests.controller?.showIndicator()
            
        }
        if ReqMethod == HTTPMethod.post{
            //URLEncoding.default
            Alamofire.request(self.UrlString!, method: .post, parameters: self.parameters, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
                WebRequests.controller?.hideIndicator()
                if(response.result.isSuccess){
                    completion(response,nil)
                    do {
                        let Status =  try JSONDecoder().decode(StatusStruct.self, from: response.data!)
                        if Status.status! == false {
                            WebRequests.controller?.alert(message: Status.message!)
                        }
                    } catch let jsonErr {
                        print("Error serializing  respone json", jsonErr)
                    }
                    
                    print("Success : \r\n----\(response) ----")
                    
                }else{
                    completion(response,response.result.error)
                    print("Error : \r\n----\(response) ----")
                    
                }
            }
            
        }else{
            //URLEncoding.default
            Alamofire.request(self.UrlString!, method: .get, parameters: self.parameters, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
                WebRequests.controller?.hideIndicator()
                if(response.result.isSuccess){
                    completion(response,nil)
                    do {
                        let Status =  try JSONDecoder().decode(StatusStruct.self, from: response.data!)
                        if Status.status! == false {
                            WebRequests.controller?.alert(message: Status.message!)
                        }
                    } catch let jsonErr {
                        print("Error serializing  respone json", jsonErr)
                    }
                    
                    print("Success : \r\n----\(response) ----")
                    
                }else{
                    completion(response,response.result.error)
                    print("Error : \r\n----\(response) ----")
                    
                }
            }
        }
        return self
    }
    
    func startWithoutIndicator(completion: @escaping ((DataResponse<Any>,Error?)->Void)) -> WebRequests? {
        var headers: HTTPHeaders!
        headers = WebRequests.headers
        if WebRequests.controller != nil {
            
            //   WebRequests.controller?.showIndicator()
            
        }
        if ReqMethod == HTTPMethod.post{
            //URLEncoding.default
            Alamofire.request(self.UrlString!, method: .post, parameters: self.parameters, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
                // WebRequests.controller?.hideIndicator()
                if(response.result.isSuccess){
                    completion(response,nil)
                    do {
                        let Status =  try JSONDecoder().decode(StatusStruct.self, from: response.data!)
                        if Status.status! == false {
                            WebRequests.controller?.alert(message: Status.message!)
                        }
                    } catch let jsonErr {
                        print("Error serializing  respone json", jsonErr)
                    }
                    
                    print("Success : \r\n----\(response) ----")
                    
                }else{
                    completion(response,response.result.error)
                    print("Error : \r\n----\(response) ----")
                    
                }
            }
            
        }else{
            //URLEncoding.default
            Alamofire.request(self.UrlString!, method: .get, parameters: self.parameters, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
                //  WebRequests.controller?.hideIndicator()
                if(response.result.isSuccess){
                    completion(response,nil)
                    do {
                        let Status =  try JSONDecoder().decode(StatusStruct.self, from: response.data!)
                        if Status.status! == false {
                            WebRequests.controller?.alert(message: Status.message!)
                        }
                    } catch let jsonErr {
                        print("Error serializing  respone json", jsonErr)
                    }
                    
                    print("Success : \r\n----\(response) ----")
                    
                }else{
                    completion(response,response.result.error)
                    print("Error : \r\n----\(response) ----")
                    
                }
            }
        }
        return self
    }
    
    
    static func sendPostMultipartWithImagesAndVideo(url: String,
                                            parameters: [String:String],
                                            imgsJobs: [UIImage],
                                            withJobsName: String,
                                            imgsCertificates: [UIImage],
                                            withCertificatesName: String,
                                            img:UIImage,
                                            imgName:String,
                                            video:Data?,
                                            completion: @escaping ((DataResponse<Any>,Error?)->Void)){
        
        
        var imagesJobsData: [Data] = []
        var imagesCertificatesData: [Data] = []

        for i in imgsJobs{
            let imageData = i.jpegData(compressionQuality: 0.5)
            imagesJobsData.append(imageData!)
        }
        
        for i in imgsCertificates{
            let imageData = i.jpegData(compressionQuality: 0.5)
            imagesCertificatesData.append(imageData!)
        }
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            var Jobsindx: Int = 0
            for imageData in imagesJobsData {
                multipartFormData.append(imageData, withName: "\(withJobsName)[\(Jobsindx)]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                Jobsindx += 1
            }
            
            var CertificatesIndx: Int = 0
            for imageData in imagesCertificatesData {
                multipartFormData.append(imageData, withName: "\(withCertificatesName)[\(CertificatesIndx)]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                CertificatesIndx += 1
            }
            
            for (key, value) in parameters {
                multipartFormData.append(value.data(using: .utf8)!, withName: key)
                
            }
            
            let imageProfile = img.jpegData(compressionQuality: 0.4)
            
            multipartFormData.append(imageProfile!, withName: imgName, fileName: "image_\(Date().toMillis() ?? 0).jpeg", mimeType: "image/jpeg")
            
            if let videoData = video{
                multipartFormData.append(videoData, withName: "video", fileName: "video.mp4", mimeType: "video/mp4")
            }
            
        }, to: url,method: .post,
           headers: ["Authorization": "Bearer " + Helper.user_token, "Accept": "application/json", "Content-Type": "application/x-www-form-urlencoded"])
            //    ,"Accept-Language": Language.currentLanguage()])
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (Progress) in
                    print("Upload Progress: \(Progress.fractionCompleted)")
                })
                
                upload.responseJSON { response in
                    if let JSON = response.result.value {
                        print("JSON: \(JSON)")
                        completion(response,nil)
                    }else{
                        completion(response,response.result.error)
                        print(response.error?.localizedDescription ?? "" )
                    }
                }
                
            case .failure(let encodingError):
                print(encodingError)
            }
        }
    }
    
    
    
    
    func start(url:String, params: [String:Any], isAuth: Bool , completion: @escaping ((DataResponse<Any>,Error?)->Void)){
        
        var headers: HTTPHeaders!
        headers = WebRequests.headers
        
        
        //URLEncoding.default
        Alamofire.request(self.UrlString!, method: .get, parameters: params, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            
            if(response.result.isSuccess){
                completion(response,nil)
            }else{
                completion(response,response.result.error)
            }
        }
    }
    
    //POST REQUESTS
    static func sendDeleteRequest(url:String, params: [String:Any], isAuth: Bool , completion: @escaping ((DataResponse<Any>,Error?)->Void)){
        
        var headers: HTTPHeaders!
        
        if isAuth{
            let apiToken = Helper.user_token
            headers = ["Authorization": "Bearer \(apiToken)",
                "Content-Type": "application/x-www-form-urlencoded",
                "Accept": "application/json",
                "Accept-Language": MOLHLanguage.currentAppleLanguage()]
        }else{
            headers = ["Content-Type": "application/x-www-form-urlencoded",
                       "Accept": "application/json",
                       "Accept-Language": MOLHLanguage.currentAppleLanguage()]
        }
        
        //URLEncoding.default
        Alamofire.request(url, method: .delete, parameters: params, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            
            if(response.result.isSuccess){
                completion(response,nil)
            }else{
                completion(response,response.result.error)
            }
        }
    }
    
    
    //POST REQUESTS
    static func sendPostRequestJSONEncode(url:String, params: [String:Any], isAuth: Bool , completion: @escaping ((DataResponse<Any>,Error?)->Void)){
        
        var headers: HTTPHeaders!
        
        if isAuth{
            let apiToken = Helper.user_token
            headers = ["Authorization": "Bearer \(apiToken)",
                "Content-Type": "application/x-www-form-urlencoded",
                "Accept-Language": MOLHLanguage.currentAppleLanguage(),
                "Accept": "application/json"]
        }else{
            
            headers = ["Content-Type": "application/x-www-form-urlencoded",
                       "Accept": "application/json",
                       "Accept-Language": MOLHLanguage.currentAppleLanguage()]
        }
        //URLEncoding.default
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            
            if(response.result.isSuccess){
                completion(response,nil)
            }else{
                completion(response,response.result.error)
            }
        }
    }
    
    //GET REQUESTS
    static func sendGetRequest(url: String, isAuth: Bool, completion: @escaping ((DataResponse<Any>,Error?)->Void)){
        
        var headers: HTTPHeaders?
        
        if isAuth{
            let apiToken = Helper.user_token
            //Helper.save_user_currency = country.currency_iso
            
            headers = [
                "Authorization": "Bearer \(apiToken)",
                "Accept": "application/json",
                "Content-Type": "application/x-www-form-urlencoded",
                "Accept-Language": MOLHLanguage.currentAppleLanguage()]
        }else{
            headers = ["Accept": "application/json",
                       "Content-Type": "application/json",
                       "Accept-Language": MOLHLanguage.currentAppleLanguage()]
        }
        
        Alamofire.request(url, method: .get, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            
            if(response.result.isSuccess){
                completion(response,nil)
            }else{
                completion(response,response.result.error)
            }
        }
    }
    
    //
    //    static func uploadImageDataWithHeaders(inputUrl: String, parameters: [String:Any], img: UIImage, completion: @escaping(_:Any)->Void) {
    //        let image = UIImageJPEGRepresentation(img , 0.5)
    //        Alamofire.uploadmul
    //
    //
    //
    //    }
    
    
    
    static func uploadImageData(inputUrl: String, parameters: [String:Any], img: UIImage, completion: @escaping(_:Any)->Void) {
        let image = img.jpegData(compressionQuality: 0.5)
        
        
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            multipartFormData.append(image!, withName: "image", fileName: "\(arc4random_uniform(100)).jpeg", mimeType: "image/jpeg")
            
            for key in parameters.keys{
                let name = String(key)
                if let val = parameters[name] as? String{
                    multipartFormData.append(val.data(using: .utf8)!, withName: name)
                }
            }
        }, to:inputUrl)
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (Progress) in
                    print(Progress)
                })
                
                upload.responseJSON { response in
                    print(response)
                    if let JSON = response.result.value {
                        completion(JSON)
                    }else{
                        completion(response.result.error?.localizedDescription ?? "")
                    }
                }
                
            case .failure(let encodingError):
                completion(encodingError)
            }
            
        }
        
    }
    
    
    
    static func uploadImageSingle(inputUrl: String, imageName: String, imageFile: UIImage, completion: @escaping(_:Any)->Void) {
        let imageData = imageFile.jpegData(compressionQuality: 0.5)
        
        //        let imageData = UIImageJPEGRepresentation(imageFile, 0.5)
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            multipartFormData.append(imageData!, withName: imageName, fileName: "ios_\(arc4random_uniform(100)).jpeg", mimeType: "image/jpeg")
            
        }, to:inputUrl)
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (Progress) in
                    print(Progress)
                })
                
                upload.responseJSON { response in
                    
                    if let JSON = response.result.value {
                        completion(JSON)
                    }else{
                        completion(response.result.error?.localizedDescription ?? "")
                    }
                }
                
            case .failure(let encodingError):
                completion(encodingError)
            }
            
        }
        
    }
    
    
    class func postRequest (url:String, paramerts:[String:Any], isAuth: Bool, complet: @escaping ((Any)->Void) , error : @escaping ((Bool)->Void)) {
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.httpBody = try! JSONSerialization.data(withJSONObject: paramerts)
        
        var headers: HTTPHeaders?
        
        if isAuth{
            let apiToken = Helper.user_token
            headers = ["Authorization": "Bearer \(apiToken)"]
        }else{
            headers = ["Accept": "application/json"]
        }
        
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        request.allHTTPHeaderFields = headers
        
        Alamofire.request(request).responseJSON {  responseData  in
            
            switch responseData.result {
            case .success:
                
                complet(responseData.result.value!)
                
            case .failure(_):
                
                print(error)
                error(true)
                
            }
        }
    }
    
    
    
    static func sendPostMultipartRequest(url:String, parameters: [String:String], img: UIImage , completion: @escaping ((DataResponse<Any>,Error?)->Void)){
        
        //        let imageData = UIImageJPEGRepresentation(img, 0.5)
        let imageData = img.jpegData(compressionQuality: 0.5)
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                multipartFormData.append(value.data(using: .utf8)!, withName: key)
            }
            
            multipartFormData.append(imageData!, withName: "image", fileName: "swift_file\(Date().toMillis() ?? 0).jpeg", mimeType: "image/jpeg")
        }, to: url,method: .post,
           headers: ["Authorization": "Bearer \(Helper.user_token)", "Accept": "application/json", "Content-Type": "application/x-www-form-urlencoded"])
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (Progress) in
                    print("Upload Progress: \(Progress.fractionCompleted)")
                })
                
                upload.responseJSON { response in
                    //print(response.request)  // original URL request
                    //print(response.response) // URL response
                    //print(response.data)     // server data
                    //print(response.result)   // result of response serialization
                    if let JSON = response.result.value {
                        print("JSON: \(JSON)")
                        completion(response, nil)
                        //                    guard let dict = JSON as? NSDictionary else { return }
                        //                    let status = dict.value(forKey: "status") as? Bool ?? false
                        //                    if status{
                        //                        guard let items = dict.value(forKey: "items") as? NSDictionary else { return }
                        //                        self.dismiss(animated: true, completion: {
                        //                            self.delegate?.didAddStudentPressed(std: StudentStruct.init(dict: items))
                        //                        })
                        //                    }
                        //                     print(dict)
                    }else{
                        completion(response, response.error)
                        print(response.error?.localizedDescription ?? "" )
                    }
                }
                
            case .failure(let encodingError):
                //                completion(DataResponse, encodingError)
                print(encodingError)
            }
            
        }
        
    }
    
    
    static func sendPostMultipartRequestWithoutParam(url:String, img: UIImage, withName: String, completion: @escaping ((Any,Error?)->Void)){
        
        //        let imageData = UIImageJPEGRepresentation(img, 0.5)
        let imageData = img.jpegData(compressionQuality: 0.5)
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            multipartFormData.append(imageData!, withName: withName, fileName: "image\(Date().toMillis() ?? 0).jpeg", mimeType: "image/png")
        }, to: url,method: .post,
           headers: ["Authorization": "Bearer \(Helper.user_token)",
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded"])
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (Progress) in
                    print("Upload Progress: \(Progress.fractionCompleted)")
                })
                
                upload.responseJSON { response in
                    //print(response.request)  // original URL request
                    //print(response.response) // URL response
                    //print(response.data)     // server data
                    //print(response.result)   // result of response serialization
                    if let JSON = response.result.value {
                        print("JSON: \(JSON)")
                        completion(JSON, nil)
                    }else{
                        completion("", response.error)
                        print(response.error?.localizedDescription ?? "" )
                    }
                }
                
            case .failure(let encodingError):
                completion(NSNull(), encodingError)
                print(encodingError)
            }
            
        }
        
    }
    
    static func sendPostMultipartRequestWithMultiImgParam(url:String, parameters: [String:String], imges: [UIImage], withName: String, completion: @escaping ((DataResponse<Any>,Error?)->Void)){
        
        //        let imageData = UIImageJPEGRepresentation(img, 0.5)
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                multipartFormData.append(value.data(using: .utf8)!, withName: key)
            }
            for i in 0..<imges.count{
                
                //            for img in imges{
                let imageData = imges[i].jpegData(compressionQuality: 0.1)
                
                multipartFormData.append(imageData!, withName: withName + "[\(i)]", fileName: "image_\(Date().toMillis() ?? 0).jpeg", mimeType: "image/jpeg")
            }
        }, to: url,method: .post,
           headers: ["Authorization": "Bearer \(CurrentUser.userInfo?.accessToken ?? "")", "Accept": "application/json", "Content-Type": "application/json"])
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (Progress) in
                    print("Upload Progress: \(Progress.fractionCompleted)")
                })
                
                upload.responseJSON { response in
                    if let JSON = response.result.value {
                        print("JSON: \(JSON)")
                        completion(response, nil)
                    }else{
                        completion(response, response.error)
                        print(response.error?.localizedDescription ?? "" )
                    }
                }
                
            case .failure(let encodingError):
                //                completion(NSNull(), encodingError)
                print(encodingError)
            }
            
        }
        
    }
    
    static func sendPostMultipartRequestWithImgParam(url:String, parameters: [String:String], img: UIImage, withName: String, completion: @escaping ((DataResponse<Any>,Error?)->Void)){
        
        //        let imageData = UIImageJPEGRepresentation(img, 0.5)
        let imageData = img.jpegData(compressionQuality: 0.1)
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                multipartFormData.append(value.data(using: .utf8)!, withName: key)
            }
            
            multipartFormData.append(imageData!, withName: withName, fileName: "image_\(Date().toMillis() ?? 0).jpeg", mimeType: "image/jpeg")
        }, to: url,method: .post,
           headers: ["Authorization": "Bearer \(CurrentUser.userInfo?.accessToken ?? "")", "Accept": "application/json", "Content-Type": "application/json"])
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (Progress) in
                    print("Upload Progress: \(Progress.fractionCompleted)")
                })
                
                upload.responseJSON { response in
                    if let JSON = response.result.value {
                        print("JSON: \(JSON)")
                        completion(response, nil)
                    }else{
                        completion(response, response.error)
                        print(response.error?.localizedDescription ?? "" )
                    }
                }
                
            case .failure(let encodingError):
                //                completion(NSNull(), encodingError)
                print(encodingError)
            }
            
        }
        
    }
    
    
    
    static func sendPostMultipartRequestWithImgParam1(url:String, parameters: [String:String], img: UIImage, withName: String, completion: @escaping ((DataResponse<Any>,Error?)->Void)){
        
        //        let imageData = UIImageJPEGRepresentation(img, 0.5)
        let imageData = img.jpegData(compressionQuality: 0.1)
        
        print(url)
        print(parameters)
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                multipartFormData.append(value.data(using: .utf8)!, withName: key)
            }
            
            multipartFormData.append(imageData!, withName: withName, fileName: "image_\(Date().toMillis() ?? 0).jpeg", mimeType: "image/jpeg")
            
        }, to: url,method: .post,
           headers: ["Authorization": "Bearer \(CurrentUser.userInfo?.accessToken ?? "")", "Accept": "application/json", "Content-Type": "application/json","Accept-Language": Language.currentLanguage()])
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (Progress) in
                    print("Upload Progress: \(Progress.fractionCompleted)")
                })
                
                upload.responseJSON { response in
                    if let JSON = response.result.value {
                        print("JSON: \(JSON)")
                        completion(response, nil)
                    }else{
                        completion(response, response.error)
                        print(response.error?.localizedDescription ?? "" )
                    }
                }
                
            case .failure(let encodingError):
                //                completion(NSNull(), encodingError)
                print(encodingError)
            }
            
        }
        
    }
    
    static func sendPostMultipartWithImages(url: String, parameters: [String:String], imgs: [UIImage], withName: String,img:UIImage,logoName:String,video:Data?, completion: @escaping ((DataResponse<Any>,Error?)->Void)){
        
        var imagesData: [Data] = []
        
        for i in imgs{
            let imageData = i.jpegData(compressionQuality: 0.5)
            imagesData.append(imageData!)
        }
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            var indx: Int = 0
            
            for imageData in imagesData {
                multipartFormData.append(imageData, withName: "\(withName)[\(indx)]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                indx += 1
            }
            
            for (key, value) in parameters {
                multipartFormData.append(value.data(using: .utf8)!, withName: key)
                
            }
            let imageLogo = img.jpegData(compressionQuality: 0.4)
            
            if imageLogo != nil{
            multipartFormData.append(imageLogo ?? Data(), withName: logoName, fileName: "image_\(Date().toMillis() ?? 0).jpeg", mimeType: "image/jpeg")
            }
            
            if let videoData = video {
                multipartFormData.append(videoData, withName: "video", fileName: "video.mp4", mimeType: "video/mp4")
            }
            
            
        }, to: url,method: .post,
           headers: ["Authorization": "Bearer \(CurrentUser.userInfo?.accessToken ?? "")", "Accept": "application/json", "Content-Type": "application/x-www-form-urlencoded"])
            //    ,"Accept-Language": Language.currentLanguage()])
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (Progress) in
                    print("Upload Progress: \(Progress.fractionCompleted)")
                })
                
                upload.responseJSON { response in
                    if let JSON = response.result.value {
                        print("JSON: \(JSON)")
                        completion(response, nil)
                    }else{
                        completion(response, response.error)
                        print(response.error?.localizedDescription ?? "" )
                    }
                }
                
            case .failure(let encodingError):
            //    completion(NSNull(), encodingError)
                print(encodingError)
            }
        }
    }
    static func sendPostMultipartRequestWithoutParam(url:String, img: UIImage, withName: String,completion: @escaping ((DataResponse<Any>,Error?)->Void)){
        
        let imageData = img.jpegData(compressionQuality: 0.4)
        let apiToken = CurrentUser.userInfo?.accessToken
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            multipartFormData.append(imageData!, withName: withName, fileName: "image\(Date().toMillis() ?? 0).jpeg", mimeType: "image/png")
        }, to: url,method: .post,
           headers: ["Authorization": "Bearer " +  apiToken!,
                     "Accept": "application/json", "Accept-Language": "en",
                     "Content-Type": "application/x-www-form-urlencoded"])
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (Progress) in
                    print("Upload Progress: \(Progress.fractionCompleted)")
                })
                
                upload.responseJSON { response in
                    
                    if let JSON = response.result.value {
                        print("JSON: \(JSON)")
                        completion(response, nil)
                    }else{
                        completion(response, response.error)
                        print(response.error?.localizedDescription ?? "" )
                    }
                }
                
            case .failure(let encodingError):
                // completion(NSNull(), encodingError)
                print(encodingError)
            }
            
        }
        
    }
    
    
    static func uploadImageSingle(inputUrl: String, imageName: String, imageFile: UIImage,isAuth: Bool, completion: @escaping(_:Any)->Void) {
        if isAuth{
            let apiToken = CurrentUser.userInfo?.accessToken
            headers = ["Authorization": "Bearer" + apiToken!,
                       "Content-Type": "application/x-www-form-urlencoded",
                       // "Accept-Language": Language.currentLanguage(),
                "Accept": "application/json"]
        }else{
            
            headers = ["Content-Type": "application/x-www-form-urlencoded",
                       "Accept": "application/json"]
            // "Accept-Language": Language.currentLanguage()]
        }
        
        let imageData = imageFile.jpegData(compressionQuality: 0.5)
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            multipartFormData.append(imageData!, withName: imageName, fileName: "ios_\(arc4random_uniform(100)).jpeg", mimeType: "image/jpeg")
            
        }, to:inputUrl)
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (Progress) in
                    print(Progress)
                })
                
                upload.responseJSON { response in
                    
                    if let JSON = response.result.value {
                        completion(JSON)
                    }else{
                        completion(response.result.error?.localizedDescription ?? "")
                    }
                }
                
            case .failure(let encodingError):
                completion(encodingError)
            }
            
        }
        
    }
    
    
    
    
    
    
    
    
    

    
}









