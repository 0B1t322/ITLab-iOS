//
// UserAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire

open class UserAPI {
    /**

     - parameter email: (query)  (optional)
     - parameter firstname: (query)  (optional)
     - parameter lastname: (query)  (optional)
     - parameter middleName: (query)  (optional)
     - parameter vkId: (query)  (optional)
     - parameter match: (query)  (optional)
     - parameter count: (query)  (optional, default to 5)
     - parameter offset: (query)  (optional, default to 0)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiUserGet(email: String? = nil, firstname: String? = nil, lastname: String? = nil, middleName: String? = nil, vkId: String? = nil, match: String? = nil, count: Int? = nil, offset: Int? = nil, completion: @escaping ((_ data: [UserView]?, _ error: Error?) -> Void)) {
        apiUserGetWithRequestBuilder(email: email, firstname: firstname, lastname: lastname, middleName: middleName, vkId: vkId, match: match, count: count, offset: offset).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }

    /**
     - GET /api/User
     - 

     - API Key:
       - type: apiKey Authorization 
       - name: Bearer
     - examples: [{contentType=application/json, example=[ {
  "firstName" : "firstName",
  "lastName" : "lastName",
  "phoneNumber" : "phoneNumber",
  "middleName" : "middleName",
  "id" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
  "email" : "email",
  "properties" : [ {
    "userPropertyType" : {
      "isLocked" : true,
      "instancesCount" : 0,
      "description" : "description",
      "id" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
      "title" : "title"
    },
    "value" : "value",
    "status" : "status"
  }, {
    "userPropertyType" : {
      "isLocked" : true,
      "instancesCount" : 0,
      "description" : "description",
      "id" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
      "title" : "title"
    },
    "value" : "value",
    "status" : "status"
  } ]
}, {
  "firstName" : "firstName",
  "lastName" : "lastName",
  "phoneNumber" : "phoneNumber",
  "middleName" : "middleName",
  "id" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
  "email" : "email",
  "properties" : [ {
    "userPropertyType" : {
      "isLocked" : true,
      "instancesCount" : 0,
      "description" : "description",
      "id" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
      "title" : "title"
    },
    "value" : "value",
    "status" : "status"
  }, {
    "userPropertyType" : {
      "isLocked" : true,
      "instancesCount" : 0,
      "description" : "description",
      "id" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
      "title" : "title"
    },
    "value" : "value",
    "status" : "status"
  } ]
} ]}]
     - parameter email: (query)  (optional)
     - parameter firstname: (query)  (optional)
     - parameter lastname: (query)  (optional)
     - parameter middleName: (query)  (optional)
     - parameter vkId: (query)  (optional)
     - parameter match: (query)  (optional)
     - parameter count: (query)  (optional, default to 5)
     - parameter offset: (query)  (optional, default to 0)

     - returns: RequestBuilder<[UserView]> 
     */
    open class func apiUserGetWithRequestBuilder(email: String? = nil, firstname: String? = nil, lastname: String? = nil, middleName: String? = nil, vkId: String? = nil, match: String? = nil, count: Int? = nil, offset: Int? = nil) -> RequestBuilder<[UserView]> {
        let path = "/api/User"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String: Any]? = nil
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems([
                        "email": email,
                        "firstname": firstname,
                        "lastname": lastname,
                        "middleName": middleName,
                        "vkId": vkId,
                        "match": match,
                        "count": count?.encodeToJSON(),
                        "offset": offset?.encodeToJSON()
        ])

        let requestBuilder: RequestBuilder<[UserView]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    /**

     - parameter _id: (path)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiUserIdGet(_id: UUID, completion: @escaping ((_ data: UserView?, _ error: Error?) -> Void)) {
        apiUserIdGetWithRequestBuilder(_id: _id).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }

    /**
     - GET /api/User/{id}
     - 

     - API Key:
       - type: apiKey Authorization 
       - name: Bearer
     - examples: [{contentType=application/json, example={
  "firstName" : "firstName",
  "lastName" : "lastName",
  "phoneNumber" : "phoneNumber",
  "middleName" : "middleName",
  "id" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
  "email" : "email",
  "properties" : [ {
    "userPropertyType" : {
      "isLocked" : true,
      "instancesCount" : 0,
      "description" : "description",
      "id" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
      "title" : "title"
    },
    "value" : "value",
    "status" : "status"
  }, {
    "userPropertyType" : {
      "isLocked" : true,
      "instancesCount" : 0,
      "description" : "description",
      "id" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
      "title" : "title"
    },
    "value" : "value",
    "status" : "status"
  } ]
}}]
     - parameter _id: (path)  

     - returns: RequestBuilder<UserView> 
     */
    open class func apiUserIdGetWithRequestBuilder(_id: UUID) -> RequestBuilder<UserView> {
        var path = "/api/User/{id}"
        let _idPreEscape = "\(_id)"
        let _idPostEscape = _idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{id}", with: _idPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String: Any]? = nil
        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<UserView>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    /**

     - parameter body: (body)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiUserPost(body: InviteUserRequest? = nil, completion: @escaping ((_ data: Void?, _ error: Error?) -> Void)) {
        apiUserPostWithRequestBuilder(body: body).execute { (_, error) -> Void in
            if error == nil {
                completion((), error)
            } else {
                completion(nil, error)
            }
        }
    }

    /**
     - POST /api/User
     - 

     - API Key:
       - type: apiKey Authorization 
       - name: Bearer
     - parameter body: (body)  (optional)

     - returns: RequestBuilder<Void> 
     */
    open class func apiUserPostWithRequestBuilder(body: InviteUserRequest? = nil) -> RequestBuilder<Void> {
        let path = "/api/User"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: body)
        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }
}
