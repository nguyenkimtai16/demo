//
//  BaseNibView.swift
//  Suntory
//
//  Created by KhoiKB.APL on 30/05/2023.
//

import UIKit

protocol NibLoadable {
    static func getNibName() -> String
    static func getNib() -> UINib
}

extension NibLoadable where Self: UIView {
    static func getNibName() -> String {
        String(describing: self)
    }

    static func getNib() -> UINib {
        let mainBundle = Bundle.main
        return UINib(nibName: self.getNibName(), bundle: mainBundle)
    }
}

class BaseNibView: UIView, NibLoadable {
    private var contentView: UIView?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func loadNibFile(nibName: String) -> UIView {
        let bundle: Bundle = Bundle(for: type(of: self))
        guard let contentView: UIView = bundle.loadNibNamed(nibName, owner: self, options: nil)!.first as? UIView else {
            return UIView(frame: frame)
        }
        return contentView
    }
}

extension BaseNibView {
    func loadViewFromNibFile(_ nibName: String) {
        backgroundColor = .clear
        if contentView == nil {
            contentView = loadNibFile(nibName: nibName)
            contentView?.frame = self.bounds
            contentView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            addSubview(contentView!)
        }
    }
}
