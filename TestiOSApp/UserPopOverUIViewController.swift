//
//  PopOverUIViewController.swift
//  TestiOSApp
//
//  Created by tai Nguyen on 24/11/2023.
//

import UIKit

class UserPopOverUIViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
//    var userList: [user]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.registerCell(UserSelectionCell.self)
//        tableView.separatorStyle = .none
    }

}

extension UserPopOverUIViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UserSelectionCell = tableView.dequeueReusableCell(cellForRowAt: indexPath)
//        let isNotFirstCell: Bool = indexPath.row > .zero
//        let isNotLastCell: Bool = indexPath.row < getPresenter().getItemList().count - 1
//        cell.initializeCell(data: getPresenter().getItemList()[indexPath.row],
//                            showTopSeparator: isNotFirstCell,
//                            showBottomSeparator: isNotLastCell)
//        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
