//
//  CatClient.swift
//  Catjoy
//
//  Created by Olya Sorokina on 10/29/16.
//  Copyright © 2016 olya. All rights reserved.
//

import UIKit
import AFNetworking
import SWXMLHash

let catConsumerKey = "MTMyMTEw"
let catUrl = "https://thecatapi.com/api/images/get?format=xml&results_per_page=2"

class CatClient: NSObject {
    
    var parser = XMLParser()
    var imageUrl: String!
    
    func getImage(completion: @escaping (String, Error?) -> Void) {
        
        let url = URL(string: catUrl)
        let request = URLRequest(url: url!)
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate:nil,
            delegateQueue:OperationQueue.main
        )
        
        // Display HUD right before the request is made
        //MBProgressHUD.showAdded(to: self.view, animated: true)
        
        let task : URLSessionDataTask = session.dataTask(with: request,completionHandler: { (dataOrNil, response, error) in
            if let data = dataOrNil {
                let responseDictionary = SWXMLHash.parse(data)
                NSLog("response: \(responseDictionary)")
                let images = responseDictionary["response"]["data"]["images"]["image"]
                self.imageUrl = images[0]["url"].element?.text
                
                completion(self.imageUrl, nil)
            }
            
            //MBProgressHUD.hide(for: self.view, animated: true)
            
            if (error != nil)
            {
                //self.errorLabel.text = "⚠︎ Network Error"
                //self.errorLabel.isHidden = false
            }
        });
        task.resume()
    
    }

}
