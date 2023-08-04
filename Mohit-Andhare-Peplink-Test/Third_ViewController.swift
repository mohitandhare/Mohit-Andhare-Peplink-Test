//
//  Third_ViewController.swift
//  Mohit-Andhare-Peplink-Test
//
//  Created by Mohit Andhare on 2023-08-04.
//

import UIKit
import Alamofire
class Third_ViewController: UIViewController, URLSessionDelegate {
    
    @IBOutlet weak var domainTextField: UITextField!
    @IBOutlet weak var connectionStatusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func connectButtonTapped(_ sender: UIButton) {
        if let domain = domainTextField.text, !domain.isEmpty {
           
            connectionStatusLabel.text = "Connecting..."
            
            DispatchQueue.global().async {
              
                NetworkManager.shared.connectToServer(domain: domain) { success in
                
                    DispatchQueue.main.async {
                       
                        if success {
                            self.connectionStatusLabel.text = "Connection successful"
                        } else {
                            self.connectionStatusLabel.text = "Connection failed"
                        }
                    }
                }
            }
        }
    }
}



class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func connectToServer(domain: String, completion: @escaping (Bool) -> Void) {
        let url = URL(string: "https://" + domain + ":37985")!
        
        let config = URLSessionConfiguration.default
        config.tlsMaximumSupportedProtocolVersion = .TLSv13
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Connection failed: \(error)")
                completion(false)
            } else {
                print("Connection successful")
                completion(true)
            }
        }
        task.resume()
    }
}
