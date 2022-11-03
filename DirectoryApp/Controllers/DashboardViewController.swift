//
//  DashboardViewController.swift
//  DirectoryApp
//
//  Created by Aarthi on 02/11/22.
//

import UIKit

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var directoryImage: UIImageView!
    @IBOutlet weak var roomsImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        directoryImage.isUserInteractionEnabled = true
        directoryImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(directoryTabSelected)))
        roomsImage.isUserInteractionEnabled = true
        roomsImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(roomsTabSelected)))
    }
    
    @objc func directoryTabSelected() {
        self.performSegue(withIdentifier: "employeeListSegue", sender: self)
    }
    
    @objc func roomsTabSelected() {
        self.performSegue(withIdentifier: "roomListSegue", sender: self)
    }
    
}
