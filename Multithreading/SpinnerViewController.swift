//
//  SpinnerViewController.swift
//  Multithreading
//
//  Created by Yuliia Khrupina on 4/19/22.
//

import Foundation
import UIKit

class SpinnerViewController: UIViewController {
 
  // Create UI elements
  let rectangleView = UIView()
  let spinner = UIActivityIndicatorView(style: .large)
  let label = UILabel()
 
  override func loadView() {
    // View settings
    view = UIView()
    view.backgroundColor = UIColor(white: 0.6, alpha: 0.7)
 
    // RectangleView settings
    rectangleView.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    rectangleView.layer.cornerRadius = 13
    rectangleView.backgroundColor = UIColor(white: 0.3, alpha: 0.4)
    view.addSubview(rectangleView)
    rectangleView.translatesAutoresizingMaskIntoConstraints = false
    rectangleView.widthAnchor.constraint(equalToConstant: 150).isActive = true
    rectangleView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    rectangleView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    rectangleView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
 
    // Spinner settings
    spinner.translatesAutoresizingMaskIntoConstraints = false
    spinner.startAnimating()
    rectangleView.addSubview(spinner)
    spinner.color = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
 
    // Label settings
    label.text = "Loading chat..."
    label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    label.font = UIFont(name: "Arial", size: 22)
    rectangleView.addSubview(label)
    label.translatesAutoresizingMaskIntoConstraints = false
 
    label.centerXAnchor.constraint(equalTo: rectangleView.centerXAnchor, constant: 0).isActive = true
    label.topAnchor.constraint(equalTo: spinner.bottomAnchor, constant: 10).isActive = true
  }
}
