//
// EquipmentUserAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire

open class EquipmentUserAPI {
    /**

     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiEquipmentUserFreeGet(completion: @escaping ((_ data: [EquipmentView]?, _ error: Error?) -> Void)) {
        apiEquipmentUserFreeGetWithRequestBuilder().execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }

    /**
     - GET /api/equipment/user/free
     - 

     - API Key:
       - type: apiKey Authorization 
       - name: Bearer
     - examples: [{contentType=application/json, example=[ {
  "number" : 0,
  "equipmentTypeId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
  "serialNumber" : "serialNumber",
  "children" : [ null, null ],
  "description" : "description",
  "id" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
  "ownerId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
  "equipmentType" : {
    "rootId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
    "description" : "description",
    "id" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
    "shortTitle" : "shortTitle",
    "title" : "title",
    "parentId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91"
  },
  "parentId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91"
}, {
  "number" : 0,
  "equipmentTypeId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
  "serialNumber" : "serialNumber",
  "children" : [ null, null ],
  "description" : "description",
  "id" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
  "ownerId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
  "equipmentType" : {
    "rootId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
    "description" : "description",
    "id" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
    "shortTitle" : "shortTitle",
    "title" : "title",
    "parentId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91"
  },
  "parentId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91"
} ]}]

     - returns: RequestBuilder<[EquipmentView]> 
     */
    open class func apiEquipmentUserFreeGetWithRequestBuilder() -> RequestBuilder<[EquipmentView]> {
        let path = "/api/equipment/user/free"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String: Any]? = nil
        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<[EquipmentView]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    /**

     - parameter userId: (path)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiEquipmentUserUserIdGet(userId: UUID, completion: @escaping ((_ data: [EquipmentView]?, _ error: Error?) -> Void)) {
        apiEquipmentUserUserIdGetWithRequestBuilder(userId: userId).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }

    /**
     - GET /api/equipment/user/{userId}
     - 

     - API Key:
       - type: apiKey Authorization 
       - name: Bearer
     - examples: [{contentType=application/json, example=[ {
  "number" : 0,
  "equipmentTypeId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
  "serialNumber" : "serialNumber",
  "children" : [ null, null ],
  "description" : "description",
  "id" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
  "ownerId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
  "equipmentType" : {
    "rootId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
    "description" : "description",
    "id" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
    "shortTitle" : "shortTitle",
    "title" : "title",
    "parentId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91"
  },
  "parentId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91"
}, {
  "number" : 0,
  "equipmentTypeId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
  "serialNumber" : "serialNumber",
  "children" : [ null, null ],
  "description" : "description",
  "id" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
  "ownerId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
  "equipmentType" : {
    "rootId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
    "description" : "description",
    "id" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
    "shortTitle" : "shortTitle",
    "title" : "title",
    "parentId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91"
  },
  "parentId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91"
} ]}]
     - parameter userId: (path)  

     - returns: RequestBuilder<[EquipmentView]> 
     */
    open class func apiEquipmentUserUserIdGetWithRequestBuilder(userId: UUID) -> RequestBuilder<[EquipmentView]> {
        var path = "/api/equipment/user/{userId}"
        let userIdPreEscape = "\(userId)"
        let userIdPostEscape = userIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{userId}", with: userIdPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String: Any]? = nil
        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<[EquipmentView]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    /**

     - parameter userId: (path)  
     - parameter body: (body)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiEquipmentUserUserIdPost(userId: UUID, body: IdRequest? = nil, completion: @escaping ((_ data: EquipmentView?, _ error: Error?) -> Void)) {
        apiEquipmentUserUserIdPostWithRequestBuilder(userId: userId, body: body).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }

    /**
     - POST /api/equipment/user/{userId}
     - 

     - API Key:
       - type: apiKey Authorization 
       - name: Bearer
     - examples: [{contentType=application/json, example={
  "number" : 0,
  "equipmentTypeId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
  "serialNumber" : "serialNumber",
  "children" : [ null, null ],
  "description" : "description",
  "id" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
  "ownerId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
  "equipmentType" : {
    "rootId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
    "description" : "description",
    "id" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
    "shortTitle" : "shortTitle",
    "title" : "title",
    "parentId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91"
  },
  "parentId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91"
}}]
     - parameter userId: (path)  
     - parameter body: (body)  (optional)

     - returns: RequestBuilder<EquipmentView> 
     */
    open class func apiEquipmentUserUserIdPostWithRequestBuilder(userId: UUID, body: IdRequest? = nil) -> RequestBuilder<EquipmentView> {
        var path = "/api/equipment/user/{userId}"
        let userIdPreEscape = "\(userId)"
        let userIdPostEscape = userIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{userId}", with: userIdPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: body)
        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<EquipmentView>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }
}
