//
//  RoomViewModel.swift
//  VM
//
//  Created by Nikunj Gangani on 14/10/22.
//

import UIKit

class RoomViewModel {
    var reloadView: (() -> Void)?
    var showLoading: (() -> Void)?
    var hideLoading: (() -> Void)?
    
    var roomList: [Room] = [Room]() {
        didSet {
            self.reloadView?()
        }
    }

    func getRoomListAPI() {
        showLoading?()
        DataService.roomList { response in
            print(response.message)
        } success: { message, items in
            self.roomList = items
            self.hideLoading?()
            self.reloadView?()
        }
    }
    
}
