//
//  RoomListViewController.swift
//  DirectoryApp
//
//  Created by Aarthi on 02/11/22.
//

import UIKit

class RoomListViewController: UIViewController {
    
    @IBOutlet weak var vacantRoomsSelectionBtn: UIButton!
    @IBOutlet weak var roomListTableView: UITableView!
    @IBOutlet weak var backBtnImage: UIImageView!
    
    var rooms:[Rooms] = []
    var filteredRooms:[Rooms] = []
    var showOnlyVacantRooms = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initProcess()
        webserviceCall()
    }
    
    func initProcess() {
        vacantRoomsSelectionBtn.setImage(UIImage(named: "unchecked"), for: .normal)
        backBtnImage.isUserInteractionEnabled = true
        backBtnImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backBtnTapped)))
        roomListTableView.register(UINib(nibName: "RoomTableViewCell", bundle: nil), forCellReuseIdentifier: "roomListCell")
    }
    
    @objc func backBtnTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func vacantRoomSelectionBtn(_ sender: UIButton) {
        if sender.imageView?.image == UIImage(named: "unchecked") {
            sender.setImage(UIImage(named: "checked"), for: .normal)
            showOnlyVacantRooms = true
        } else {
            sender.setImage(UIImage(named: "unchecked"), for: .normal)
            showOnlyVacantRooms = false
        }
        filterRooms()
    }
    
    func filterRooms() {
        if showOnlyVacantRooms == true {
            filteredRooms = rooms.filter { $0.isOccupied == false}
        } else {
            filteredRooms = rooms
        }
        self.roomListTableView.reloadData()
    }
    
    func webserviceCall() {
        WebService.sharedInstance.performRequest(baseUrl: EndPoints.baseUrl.rawValue, path: EndPointsPath.rooms.rawValue) { roomData,error  in
            if let _error = error  {
                AlertManager.showBasicAlert(title: "Oops!", message: _error, vc: self)
            } else {
                self.parseRoomData(data: roomData)
            }
        }
    }
    
    fileprivate func parseRoomData(data:[[String : Any]]) {
        
        for item in data
        {
            let createdAt = item["createdAt"] as! String
            let id = item["id"] as! String
            let isOccupied = item["isOccupied"] as! Bool
            let maxOccupancy = item["maxOccupancy"] as! Int64
            let room = Rooms(r_createdat: createdAt, r_isoccupied: isOccupied, r_maxoccupancy: maxOccupancy, r_id: id)
            rooms.append(room)
        }
        
        DispatchQueue.main.async {
            self.filteredRooms = self.rooms
            self.filteredRooms.sort { a, b in
                return Int(a.id!)! < Int(b.id!)!
            }
            self.roomListTableView.reloadData()
        }
    }
}

extension RoomListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredRooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = roomListTableView.dequeueReusableCell(withIdentifier: "roomListCell", for: indexPath) as! RoomTableViewCell
        cell.roomID.text = "Room ID: \(filteredRooms[indexPath.row].id!)"
        cell.maxOccupancy.text = "Maximum Occupancy: \(filteredRooms[indexPath.row].maxOccupancy!)"
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
