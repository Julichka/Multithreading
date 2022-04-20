//
//  ViewController.swift
//  Multithreading
//
//  Created by Yuliia Khrupina on 4/19/22.
//

import UIKit

class ViewController: UIViewController {
    
    var names:[String] = []
    var dates:[String] = []
    var icons:[String] = []
    var messages:[String] = []
    
    let parsingGroup = DispatchGroup()
    
    let storeQueue = DispatchQueue.global(qos: .userInteractive)
    let parsingQueue = DispatchQueue.init(label: "parsing", attributes: .concurrent)

    override func viewDidLoad() {
        super.viewDidLoad()
        checkStore()
    }
    
    func checkStore() {
        storeQueue.async {
            if let path = Bundle.main.path(forResource: "UsersData", ofType:"plist"){
                let dict = NSDictionary(contentsOfFile: path) as! [String: Any]
                self.appendDateFromPlistConcurrent(dict)
            }
        }
    }
    
    private func appendDateFromPlistConcurrent(_ dict: [String: Any]) {
        parsingGroup.enter()
        parsingQueue.async {
          sleep(2)
          self.names = dict["allNames"] as! Array<String>
          self.parsingGroup.leave()
        }
     
        parsingGroup.enter()
        parsingQueue.async {
          sleep(2)
          self.dates = dict["allDates"] as! Array<String>
          self.parsingGroup.leave()
        }
     
        parsingGroup.enter()
        parsingQueue.async {
          sleep(2)
          self.icons = dict["allImages"] as! Array<String>
          self.parsingGroup.leave()
        }
     
        parsingGroup.enter()
        parsingQueue.async {
          sleep(2)
          self.messages = dict["allMessages"] as! Array<String>
          self.parsingGroup.leave()
        }
        parsingGroup.wait()
      }
}
