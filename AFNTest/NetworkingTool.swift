//
//  NetworkingTool.swift
//  AFNTest
//
//  Created by 王亚威 on 2023/6/15.
//

import UIKit
import AFNetworking

enum RequestType {
    case GET
    case POST
}

class NetworkingTool: AFHTTPSessionManager {
    static let shareInstance: NetworkingTool = {
        let tool = NetworkingTool()
        tool.responseSerializer.acceptableContentTypes?.insert("text/html")
        return tool
    }()
}

extension NetworkingTool {
    func request(methodType: RequestType, urlString: String, parameters: [String: String], finished: @escaping ((_ result: Any?, _ error: Error?)->())) {
        if methodType == .GET {
            get(urlString, parameters: parameters, headers: nil, progress: nil) { task, result in
                finished(result, nil)
            } failure: { task, error in
                finished(nil, error)
            }
        } else {
            post(urlString, parameters: parameters, headers: nil, progress: nil) { task, result in
                finished(result, nil)
            } failure: { task, error in
                finished(nil, error)
            }
        }
    }
    
    func download(urlString: String) {
        downloadTask(with: URLRequest(url: URL(fileURLWithPath: urlString))) { progress in
            
        } destination: { url, response in
            let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first!
            let fullpath = (path as NSString).appendingPathComponent(response.suggestedFilename!)
            return URL(fileURLWithPath: fullpath)
        } completionHandler: { response, url, error in
            
        }.resume()
    }
    
    //不推荐使用
    func upload1(urlString: String) {
        var request = URLRequest(url: URL(fileURLWithPath: urlString))
        request.httpMethod = "post"
        //[self.request setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@", self.boundary] forHTTPHeaderField:@"Content-Type"]
        request.setValue("multipart/form-data; boundary=0", forHTTPHeaderField: "Content-Type")
        uploadTask(with: request, from: Data()) { progress in
            
        } completionHandler: { response, responseObject, error in
            
        }

    }
    
    func upload2(urlString: String) {
        post("http://xxxxx", parameters: nil, headers: nil) { formData in
            guard let image = UIImage.init(named: "123"), let imageData = image.pngData() else { return }
            formData.appendPart(withFileData: imageData, name: "file", fileName: "123.png", mimeType: "image/png")
        } progress: { progress in
            
        } success: { task, responseObj in
            
        } failure: { task, error in
            
        }
    }
}
