//
//  FloatMenuItem.swift
//  HPFloatMenu
//
//  Created by Hoang on 4/22/19.
//  Copyright © 2019 Quang Hoang. All rights reserved.
//

import UIKit

class FloatMenuItem: NSObject {

    // MARK: -
    var iconSize: CGFloat = 12 {
        didSet {
            iconView.snp.updateConstraints { (maker) in
                maker.width.height.equalTo(iconSize)
            }
        }
    }

    var colorTitle: UIColor = UIColor(hexString: "#CFCFCF")! {
        didSet {
            titleLabel.textColor = colorTitle
        }
    }

    var colorIcon: UIColor = UIColor(hexString: "#CFCFCF")! {
        didSet {
            iconView.backgroundColor = colorIcon
        }
    }

    var title: String? {
        didSet {
            self.titleLabel.text = title
        }
    }

    var icon: UIImage? {
        didSet {
            self.iconView.image = icon
        }
    }

    var isHidden: Bool = false {
        didSet {
            self.containerView.isHidden = isHidden
        }
    }

    var tag: Int = 0 {
        didSet {
            self.button.tag = tag
        }
    }

    // MARK: - Lazy properties
    lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        return view
    }()

    private lazy var iconView: UIImageView = {
        let view = UIImageView(frame: .zero)
        containerView.addSubview(view)
        view.snp.makeConstraints { (maker) in
            maker.width.height.equalTo(self.iconSize)
            maker.centerY.equalToSuperview()
            maker.trailing.equalTo(0)
        }
        view.backgroundColor = colorIcon
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.textColor = colorTitle
        containerView.addSubview(view)
        view.snp.makeConstraints { (maker) in
            maker.leading.top.bottom.equalTo(0)
            maker.trailing.equalTo(iconView.snp.leading).offset(-15)
        }
        return view
    }()

    private lazy var button: UIButton = {
        let view = UIButton(type: .custom)
        containerView.addSubview(view)
        view.snp.makeConstraints { (maker) in
            maker.leading.equalTo(titleLabel.snp.leading)
            maker.trailing.equalTo(iconView.snp.trailing)
            maker.top.bottom.equalToSuperview()
        }
        return view
    }()

    // MARK: - Init
    init(with title: String, icon: UIImage) {
        super.init()
        self.title = title
        self.icon = icon

        self.button.backgroundColor = .clear
        self.iconView.applyRadius(radius: iconSize/2.0)
    }

    init(with title: String, colorIcon: UIColor) {
        super.init()
        self.title = title
        self.colorIcon = colorIcon

        self.title = title
        self.colorIcon = colorIcon
        self.button.backgroundColor = .clear

        self.iconView.applyRadius(radius: iconSize/2.0)
    }
}
