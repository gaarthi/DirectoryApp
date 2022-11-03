//
//  EmployeeDetailViewController.swift
//  DirectoryApp
//
//  Created by Aarthi on 02/11/22.
//

import UIKit

class EmployeeDetailViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var backBtnImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var designationLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var emailIDLabel: UILabel!
    @IBOutlet weak var favColorLabel: UILabel!
    
    var selectedEmployee = People(p_createdat: "", p_firstname: "", p_avatar: "", p_lastname: "", p_email: "", p_jobtitle: "", p_favouritecolor: "", p_id: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        backBtnImage.isUserInteractionEnabled = true
        backBtnImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backBtnTapped)))
        
        profileImageView.roundedImage()
        profileImageView.imageFromServerURL(urlString: selectedEmployee.avatar!, placeHolderImage: UIImage.init(named: "profile")!)
        
        nameLabel.text = selectedEmployee.firstName! + " " + selectedEmployee.lastName!
        designationLabel.text = selectedEmployee.jobtitle
        idLabel.text = selectedEmployee.id
        emailIDLabel.text = selectedEmployee.email
        favColorLabel.text = selectedEmployee.favouriteColor
    }
    
    @objc func backBtnTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
