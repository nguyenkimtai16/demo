//
//  UITableViewExtension.swift
//  Suntory
//
//  Created by duonglp3.fa.g0 on 05/06/2023.
//

import UIKit

extension UITableView {
    func registerCell<T: UITableViewCell>(_ tableViewCellType: T.Type) {
        let nibCell = UINib(nibName: String(describing: tableViewCellType), bundle: nil)
        self.register(nibCell, forCellReuseIdentifier: String(describing: tableViewCellType))
    }

    func getAllCells() -> [UITableViewCell] {
        var cells = [UITableViewCell]()
        for index in 0..<self.numberOfSections {
            for innerIndex in 0..<self.numberOfRows(inSection: index) {
                if let cell = cellForRow(at: IndexPath(row: innerIndex, section: index)) {
                    cells.append(cell)
                }
            }
        }
        return cells
    }

    func dequeueReusableCell<T: UITableViewCell>(cellForRowAt indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as? T else {
            fatalError("Unable to Dequeue Table View Cell")
        }
        return cell
    }

    func hasRowAtIndexPath(indexPath: IndexPath) -> Bool {
        indexPath.section < numberOfSections && indexPath.row < numberOfRows(inSection: indexPath.section)
    }

    func scrollToTop(animated: Bool) {
        let indexPath: IndexPath = IndexPath(row: 0, section: 0)
        if hasRowAtIndexPath(indexPath: indexPath) {
            scrollToRow(at: indexPath, at: .top, animated: animated)
        }
    }
}
