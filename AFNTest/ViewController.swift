//
//  ViewController.swift
//  AFNTest
//
//  Created by 王亚威 on 2023/6/15.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        NetworkingTool.shareInstance.request(methodType: RequestType.POST, urlString: "http://httpbin.org/post", parameters: ["name": "andy", "age": "20"]) { result, error in
            if let error = error {
                print("error---", error)
            } else {
                print("result--", result)
            }
        }
        
        
        
        
    }

}

