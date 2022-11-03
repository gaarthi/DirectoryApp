//
//  LoginViewController.swift
//  DirectoryApp
//
//  Created by Aarthi on 03/11/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailIDTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var showPasswordImage: UIImageView!
    
    var employees:[People] = []
    var username: String = ""
    var password: String = ""
    var emails:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initprocess()
    }
    
    func initprocess() {
        loginBtn.customizeButton(radiusValue: 10)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(gesture:)))
        showPasswordImage.addGestureRecognizer(tapGesture)
        showPasswordImage.isUserInteractionEnabled = true
    }
    
    @objc func imageTapped(gesture: UIGestureRecognizer) {
        
        passwordTF.isSecureTextEntry = !passwordTF.isSecureTextEntry
        
        if (gesture.view as? UIImageView) != nil {
            guard showPasswordImage.image == UIImage(named: "eyeview") else {
                return showPasswordImage.image = UIImage(named: "eyeview")
            }
            showPasswordImage.image = UIImage(named: "eyehidden")
        }
    }
    
    @IBAction func loginBtnTapped(_ sender: UIButton) {
        username = emailIDTF.text ?? ""
        password = passwordTF.text ?? ""
        
        if !username.isEmpty && !password.isEmpty {
            employees = []
            emails = []
            webserviceCall()
        } else {
            AlertManager.showBasicAlert(title: "Error!", message: "All fields are mandatory", vc: self)
        }
    }
    
    func checkifUserExists(email: String, password: String) {
        
        for eachemployee in employees {
            emails.append(eachemployee.email!)
        }
        
        if emails.count == employees.count {
            if emails.contains(username)
            {
                if password == LoginManager().password {
                    let dashboardViewController = self.storyboard?.instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
                    self.present(dashboardViewController, animated: true, completion: nil)
                } else {
                    AlertManager.showBasicAlert(title: "Authentication Failed!", message: "Please check your password.", vc: self)
                }
            }
            else {
                AlertManager.showBasicAlert(title: "User Not Found!", message: "User does not exist in the database.", vc: self)
            }
        }
    }
    
    func webserviceCall() {
        WebService.sharedInstance.performRequest(baseUrl: EndPoints.baseUrl.rawValue, path: EndPointsPath.people.rawValue) { employeeData,error  in
            if let _error = error  {
                AlertManager.showBasicAlert(title: "Oops!", message: _error, vc: self)
            } else {
                self.parsePeopleData(data: employeeData)
            }
        }
    }
    
    fileprivate func parsePeopleData(data:[[String : Any]]) {
        for item in data
        {
            let createdAt = item["createdAt"] as! String
            let id = item["id"] as! String
            let firstName = item["firstName"] as! String
            let lastName = item["lastName"] as! String
            let avatar = item["avatar"] as! String
            let email = item["email"] as! String
            let jobTitle = item["jobtitle"] as! String
            let favColor = item["favouriteColor"] as! String
            let employee = People(p_createdat: createdAt, p_firstname: firstName, p_avatar: avatar, p_lastname: lastName, p_email: email, p_jobtitle: jobTitle, p_favouritecolor: favColor, p_id: id)
            employees.append(employee)
        }
        
        DispatchQueue.main.async {
            self.checkifUserExists(email: self.username, password: self.password)
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        
        if let nextResponder = textField.superview?.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        return true
    }
}
