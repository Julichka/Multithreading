//
//  ViewController.swift
//  Multithreading
//
//  Created by Yuliia Khrupina on 4/19/22.
//

import UIKit

class ViewController: UIViewController {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? ListItem else { return  UITableViewCell() }
        clearRow(cell)
     
        // Create group notify - when group is completed then cell get rows
        parsingGroup.notify(queue: .main) {
            cell.username?.text = self.names[indexPath.row]
            cell.icon?.image = UIImage(named: self.icons[indexPath.row])
            cell.date?.text = self.dates[indexPath.row]
            cell.message?.text = self.messages[indexPath.row]
     
          // Stop spinner work
            self.stopIndicator()
        }
        return cell
    }
    
    
    @IBOutlet weak var table: UITableView!
    
    let cellReuseIdentifier = "cell"
    
    var names:[String] = []
    var dates:[String] = []
    var icons:[String] = []
    var messages:[String] = []
    
    let parsingGroup = DispatchGroup()
    
    let childView = SpinnerViewController()
    
    let storeQueue = DispatchQueue.global(qos: .userInteractive)
    let parsingQueue = DispatchQueue.init(label: "parsing", attributes: .concurrent)

    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        table.register(ListItem.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        checkStore()
        moveIndicator()
    }
    
    func checkStore() {
        storeQueue.async {
            if let path = Bundle.main.path(forResource: "UsersData", ofType:"plist"){
                let dict = NSDictionary(contentsOfFile: path) as! [String: Any]
                self.appendDateFromPlistConcurrent(dict)
                DispatchQueue.main.async {
                    print("2...\(self.icons.count)")
                    self.table.reloadData()
                }
            }
        }
        print("1...\(self.icons.count)")
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
    
    func stopIndicator() {
        self.childView.willMove(toParent: nil)
        self.childView.view.removeFromSuperview()
        self.childView.removeFromParent()
    }
    
    func moveIndicator() {
        addChild(childView)
        childView.view.frame = view.frame
        view.addSubview(childView.view)
        childView.didMove(toParent: self)
      }
    
    private func clearRow(_ cell: ListItem) {
        cell.username?.text = ""
        cell.date?.text = ""
        cell.message?.text = ""
      }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return icons.count
    }
}
