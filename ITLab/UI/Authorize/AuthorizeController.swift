//
//  AuthorizeController.swift
//  ITLab
//
//  Created by Mikhail Ivanov on 28.09.2020.
//

import UIKit
import SwiftUI
import AppAuth

class AuthorizeController : UIViewController {
    
    @IBOutlet private weak var ClickButton: UIButton!
    
    private var appAuthInteraction : AppAuthInteraction?
    
    
    struct UserInfo: Codable {
        let userId: UUID
        
        public enum CodingKeys: String, CodingKey {
            case userId = "sub"
        }
    }
    
    private var userInfo: UserInfo?
    
    public func getUserInfo() -> UserInfo? {
        return self.userInfo
    }
    
    public func getAccsesToken() -> String{
        return self.appAuthInteraction?.getAuthState()?.lastTokenResponse?.accessToken ?? ""
    }
    
    public func isAuthorize() -> Bool {
        return self.appAuthInteraction?.getAuthState()?.isAuthorized ?? false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.appAuthInteraction = AppAuthInteraction(view: self)
        
        appAuthInteraction?.loadState()
        appAuthInteraction?.stateChanged()
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if((appAuthInteraction?.getAuthState()?.isAuthorized) ?? false)
        {
            self.logIn()
        }
        
    }
}

extension AuthorizeController {
    
    @IBAction func authWithAutoCodeExchange(_ sender: UIButton) {

        self.appAuthInteraction?.authorization()
    }
}

extension AuthorizeController {
    
    public func logOut() {
        
        self.dismiss(animated: true, completion: nil)
        self.appAuthInteraction?.logOut()
    }
    
    func logIn() {
        getUserInfoReq()
        
        let menuView = UIHostingController(rootView: MainMenu())
        
        menuView.modalPresentationStyle = .fullScreen
        
        self.present(menuView, animated: false, completion: nil)
    }
    
    func performAction(freshTokens: @escaping OIDAuthStateAction)
    {
        appAuthInteraction?.getAuthState()?.performAction(freshTokens: freshTokens)
    }
    
    func getUserInfoReq() {
        appAuthInteraction?.getAuthState()?.performAction(freshTokens: { (accessToken, _, error) in
            
            if error != nil  {
               print("Error fetching fresh tokens: \(error?.localizedDescription ?? "ERROR")")
                return
            }
            
            guard let accessToken = accessToken else {
                print("Error getting accessToken")
                return
            }
            
            guard let userinfoEndpoint = self.appAuthInteraction?.getAuthState()?.lastAuthorizationResponse.request.configuration.discoveryDocument?.userinfoEndpoint else {
                print("Userinfo endpoint not declared in discovery document")
                return
            }
            
            var urlRequest = URLRequest(url: userinfoEndpoint)
            print(userinfoEndpoint)
            urlRequest.allHTTPHeaderFields = ["Authorization":"Bearer \(accessToken)"]
            
            let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                
                DispatchQueue.main.async {
                    
                    guard error == nil else {
                        print("HTTP request failed \(error?.localizedDescription ?? "ERROR")")
                        return
                    }

                    guard let response = response as? HTTPURLResponse else {
                        print("Non-HTTP response")
                        return
                    }

                    guard let data = data else {
                        print("HTTP response data is empty")
                        return
                    }

                    var json: [AnyHashable: Any]?

                    do {
                        json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    } catch {
                        print("JSON Serialization Error")
                    }

                    
                    if response.statusCode != 200 {
                        // server replied with an error
                        let responseText: String? = String(data: data, encoding: String.Encoding.utf8)
                        
                        if response.statusCode == 401 {
                            // "401 Unauthorized" generally indicates there is an issue with the authorization
                            // grant. Puts OIDAuthState into an error state.
                            let oauthError = OIDErrorUtilities.resourceServerAuthorizationError(withCode: 0,
                                                                                                errorResponse: json,
                                                                                                underlyingError: error)
                            self.appAuthInteraction?.getAuthState()?.update(withAuthorizationError: oauthError)
                            print("Authorization Error (\(oauthError)). Response: \(responseText ?? "RESPONSE_TEXT")")
                        } else {
                            print("HTTP: \(response.statusCode), Response: \(responseText ?? "RESPONSE_TEXT")")
                        }

                        return
                    }
                        
                    guard let user: UserInfo = try? JSONDecoder().decode(UserInfo.self, from: data) else {
                        print("JSON serialization error in UserInfo")
                        return
                    }
                        self.userInfo = user
                    print("Success: \(self.userInfo?.userId)")
                }
            }
            
            task.resume()
        })
    }
}

