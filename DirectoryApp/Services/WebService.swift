//
//  WebService.swift
//  DirectoryApp
//
//  Created by Aarthi on 02/11/22.
//

import Foundation


typealias completionHandler = ([[String: Any]],String?) -> ()

class WebService {
    
    static let sharedInstance = WebService()
    var errorMessage:String?
    var people:[People] = []
    
    func performRequest(baseUrl: String, path: String, completion:@escaping completionHandler) {
        
        guard let urlComponents = URLComponents(string:baseUrl + path) else {
            errorMessage = "URL is not correct"
            return
        }
        
        guard let url = urlComponents.url else {
            errorMessage = "URL is nil"
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _error = error {
                self.errorMessage = "response error \(_error.localizedDescription)"
            }else if let _data = data , let _response = response as? HTTPURLResponse , _response.statusCode == 200 {
                
                let jsonData = try? JSONSerialization.jsonObject(with: _data, options: []) as? [[String:Any]]
                if let rootData = jsonData {
                    completion(rootData, self.errorMessage)
                }
            }
        }.resume()
    }
}
