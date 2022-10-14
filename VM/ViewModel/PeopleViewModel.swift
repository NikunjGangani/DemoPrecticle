//
//  PeopleViewModel.swift
//  VM
//
//  Created by Nikunj Gangani on 14/10/22.
//

import UIKit

class PeopleViewModel {
    
    var reloadView: (() -> Void)?
    var showLoading: (() -> Void)?
    var hideLoading: (() -> Void)?
    
    var peopleList: [People] = [People]() {
        didSet {
            self.reloadView?()
        }
    }

    func getPeopleListAPI() {
        showLoading?()
        DataService.peopleList { response in
            print(response.message)
        } success: { message, items in
            self.peopleList = items
            self.hideLoading?()
            self.reloadView?()
        }
    }
}
