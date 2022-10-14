//
//  RoomsViewController.swift
//  VM
//
//  Created by Nikunj Gangani on 14/10/22.
//

import UIKit

class RoomsViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel = RoomViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
    }
}

// MARK: - Helper Methods

extension RoomsViewController {
    func setupData() {
        title = "Rooms"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "RoomCell", bundle: nil), forCellReuseIdentifier: "RoomCell")
        tableView.reloadData()
        viewModel.getRoomListAPI()
        initViewModel()
    }
}

// MARK: - ViewModel Methods

extension RoomsViewController {
    func initViewModel() {
        viewModel.reloadView = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        viewModel.showLoading = {
            self.startIndicator()
        }
        viewModel.hideLoading = {
            self.dismissIndicator()
        }
    }
}

// MARK: - TableView Delegate & Data source Methods
extension RoomsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.roomList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RoomCell", for: indexPath) as? RoomCell else { return UITableViewCell() }
        cell.set(room: viewModel.roomList[indexPath.row])
        return cell
    }
}

