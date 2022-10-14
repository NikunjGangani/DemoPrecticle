//
//  PeopleViewController.swift
//  VM
//
//  Created by Nikunj Gangani on 14/10/22.
//

import UIKit

class PeopleViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    var viewModel = PeopleViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
    }
}

// MARK: - Helper Methods

extension PeopleViewController {
    func setupData() {
        title = "People"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PeopleCell", bundle: nil), forCellReuseIdentifier: "PeopleCell")
        tableView.reloadData()
        viewModel.getPeopleListAPI()
        initViewModel()
    }
}

// MARK: - ViewModel Methods

extension PeopleViewController {
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
extension PeopleViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.peopleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PeopleCell", for: indexPath) as? PeopleCell else { return UITableViewCell() }
        cell.set(people: viewModel.peopleList[indexPath.row])
        return cell
    }
}
