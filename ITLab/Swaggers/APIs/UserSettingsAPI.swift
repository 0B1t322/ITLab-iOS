//
// UserSettingsAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire

open class UserSettingsAPI {
    /**

     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiUserSettingsGet(completion: @escaping ((_ data: [UserSettingPresent]?, _ error: Error?) -> Void)) {
        apiUserSettingsGetWithRequestBuilder().execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }

    /**
     - GET /api/user/settings
     - 

     - API Key:
       - type: apiKey Authorization 
       - name: Bearer
     - examples: [{contentType=application/json, example=[ {
  "title" : "title",
  "value" : { }
}, {
  "title" : "title",
  "value" : { }
} ]}]

     - returns: RequestBuilder<[UserSettingPresent]> 
     */
    open class func apiUserSettingsGetWithRequestBuilder() -> RequestBuilder<[UserSettingPresent]> {
        let path = "/api/user/settings"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String: Any]? = nil
        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<[UserSettingPresent]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    /**

     - parameter settingName: (path)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiUserSettingsSettingNameDelete(settingName: String, completion: @escaping ((_ data: Void?, _ error: Error?) -> Void)) {
        apiUserSettingsSettingNameDeleteWithRequestBuilder(settingName: settingName).execute { (_, error) -> Void in
            if error == nil {
                completion((), error)
            } else {
                completion(nil, error)
            }
        }
    }

    /**
     - DELETE /api/user/settings/{settingName}
     - 

     - API Key:
       - type: apiKey Authorization 
       - name: Bearer
     - parameter settingName: (path)  

     - returns: RequestBuilder<Void> 
     */
    open class func apiUserSettingsSettingNameDeleteWithRequestBuilder(settingName: String) -> RequestBuilder<Void> {
        var path = "/api/user/settings/{settingName}"
        let settingNamePreEscape = "\(settingName)"
        let settingNamePostEscape = settingNamePreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{settingName}", with: settingNamePostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String: Any]? = nil
        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "DELETE", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    /**

     - parameter settingName: (path)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiUserSettingsSettingNameGet(settingName: String, completion: @escaping ((_ data: Void?, _ error: Error?) -> Void)) {
        apiUserSettingsSettingNameGetWithRequestBuilder(settingName: settingName).execute { (_, error) -> Void in
            if error == nil {
                completion((), error)
            } else {
                completion(nil, error)
            }
        }
    }

    /**
     - GET /api/user/settings/{settingName}
     - 

     - API Key:
       - type: apiKey Authorization 
       - name: Bearer
     - parameter settingName: (path)  

     - returns: RequestBuilder<Void> 
     */
    open class func apiUserSettingsSettingNameGetWithRequestBuilder(settingName: String) -> RequestBuilder<Void> {
        var path = "/api/user/settings/{settingName}"
        let settingNamePreEscape = "\(settingName)"
        let settingNamePostEscape = settingNamePreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{settingName}", with: settingNamePostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String: Any]? = nil
        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    /**

     - parameter settingName: (path)  
     - parameter body: (body)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiUserSettingsSettingNamePost(settingName: String, body: Any? = nil, completion: @escaping ((_ data: Void?, _ error: Error?) -> Void)) {
        apiUserSettingsSettingNamePostWithRequestBuilder(settingName: settingName, body: body).execute { (_, error) -> Void in
            if error == nil {
                completion((), error)
            } else {
                completion(nil, error)
            }
        }
    }

    /**
     - POST /api/user/settings/{settingName}
     - 

     - API Key:
       - type: apiKey Authorization 
       - name: Bearer
     - parameter settingName: (path)  
     - parameter body: (body)  (optional)

     - returns: RequestBuilder<Void> 
     */
    open class func apiUserSettingsSettingNamePostWithRequestBuilder(settingName: String, body: Any? = nil) -> RequestBuilder<Void> {
        var path = "/api/user/settings/{settingName}"
        let settingNamePreEscape = "\(settingName)"
        let settingNamePostEscape = settingNamePreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{settingName}", with: settingNamePostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: body)
        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }
}
