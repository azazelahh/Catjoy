//
//  ViewController.swift
//  Catjoy
//
//  Created by Olya Sorokina on 10/29/16.
//  Copyright © 2016 olya. All rights reserved.
//

import UIKit

class CatViewController: UIViewController {
    
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageLabel.text = "Jake rocks!!"
        
        let client: CatClient = CatClient()
        client.getImage(completion: {(imageUrl: String, error: Error?) -> Void in
            if error != nil {
                NSLog(error.debugDescription)
            }
            
            let imageRequest = NSURLRequest(url: NSURL(string: imageUrl)! as URL)
            
            self.pictureView.setImageWith(
                imageRequest as URLRequest,
                placeholderImage: nil,
                success: { (imageRequest, imageResponse, image) -> Void in
                    
                    // imageResponse will be nil if the image is cached
                    if imageResponse != nil {
                        print("Image was NOT cached, fade in image")
                        self.pictureView.alpha = 0.0
                        self.pictureView.image = image
                        UIView.animate(withDuration: 0.3, animations: { () -> Void in
                            self.pictureView.alpha = 1.0
                        })
                    } else {
                        print("Image was cached so just update the image")
                        self.pictureView.image = image
                    }
                },
                failure: { (imageRequest, imageResponse, error) -> Void in
                    // do something for the failure condition
            })
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

