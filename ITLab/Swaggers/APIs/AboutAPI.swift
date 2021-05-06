//
// AboutAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire

open class AboutAPI {
    /**
     Get build information

     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiAboutBuildGet(completion: @escaping ((_ data: BuildInformation?, _ error: Error?) -> Void)) {
        apiAboutBuildGetWithRequestBuilder().execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }

    /**
     Get build information
     - GET /api/about/build
     - 

     - API Key:
       - type: apiKey Authorization 
       - name: Bearer
     - examples: [{contentType=application/json, example={
  "buildDateString" : "buildDateString",
  "buildId" : "buildId"
}}]

     - returns: RequestBuilder<BuildInformation> 
     */
    open class func apiAboutBuildGetWithRequestBuilder() -> RequestBuilder<BuildInformation> {
        let path = "/api/about/build"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String: Any]? = nil
        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<BuildInformation>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
}
