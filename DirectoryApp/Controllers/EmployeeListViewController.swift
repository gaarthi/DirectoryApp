//
//  EmployeeListViewController.swift
//  DirectoryApp
//
//  Created by Aarthi on 02/11/22.
//

import UIKit

class EmployeeListViewController: UIViewController {
    
    @IBOutlet weak var employeeListTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var backBtnImage: UIImageView!
    
    var employees:[People] = []
    var filteredEmployees:[People] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initProcess()
        webserviceCall()
    }
    
    func initProcess() {
        backBtnImage.isUserInteractionEnabled = true
        backBtnImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backBtnTapped)))
        employeeListTableView.register(UINib(nibName: "EmployeeTableViewCell", bundle: nil), forCellReuseIdentifier: "employeeCell")
    }
    
    @objc func backBtnTapped() {
        self.dismiss(animated: true, completion: nil)
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
            self.filteredEmployees = self.employees
            self.filteredEmployees.sort { a, b in
                return (a.firstName!) < (b.firstName!)
            }
            self.employeeListTableView.reloadData()
        }
    }
}

extension EmployeeListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredEmployees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = employeeListTableView.dequeueReusableCell(withIdentifier: "employeeCell", for: indexPath) as! EmployeeTableViewCell
        cell.nameLabel.text = (filteredEmployees[indexPath.row].firstName)! + " " + (filteredEmployees[indexPath.row].lastName)!
        cell.jobTitleLabel.text = filteredEmployees[indexPath.row].jobtitle
        cell.profileImage.imageFromServerURL(urlString: filteredEmployees[indexPath.row].avatar!, placeHolderImage: UIImage.init(named: "profile")!)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EmployeeDetailViewController") as! EmployeeDetailViewController
        vc.selectedEmployee = filteredEmployees[indexPath.row]
        self.present(vc, animated: true, completion: nil)
    }
}

extension EmployeeListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            filteredEmployees = self.employees
            filteredEmployees.sort { a, b in
                return (a.firstName!) < (b.firstName!)
            }
            employeeListTableView.reloadData()
            return
        }
        filteredEmployees = employees.filter({
            ($0.firstName!.prefix(searchText.count) == searchText)
        })
        employeeListTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = nil
        filteredEmployees = employees
        filteredEmployees.sort { a, b in
            return (a.firstName!) < (b.firstName!)
        }
        employeeListTableView.reloadData()
    }
}


