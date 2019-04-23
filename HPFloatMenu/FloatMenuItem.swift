//
//  FloatMenuItem.swift
//  HPFloatMenu
//
//  Created by Hoang on 4/22/19.
//  Copyright © 2019 Quang Hoang. All rights reserved.
//

import UIKit

public class FloatMenuItem: NSObject {

    // MARK: -
    public var iconSize: CGFloat = 12 {
        didSet {
            iconView.snp.updateConstraints { (maker) in
                maker.width.height.equalTo(iconSize)
            }
        }
    }

    public var colorTitle: UIColor = UIColor(hexString: "#CFCFCF")! {
        didSet {
            titleLabel.textColor = colorTitle
        }
    }

    public var colorIcon: UIColor = UIColor(hexString: "#CFCFCF")! {
        didSet {
            iconView.backgroundColor = colorIcon
        }
    }

    public var title: String? {
        didSet {
            self.titleLabel.text = title
        }
    }

    public var icon: UIImage? {
        didSet {
            self.iconView.image = icon
        }
    }

    public var isHidden: Bool = false {
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
    public init(with title: String, icon: UIImage) {
        super.init()

        self.title = title
        self.titleLabel.text = title

        self.icon = icon
        self.iconView.image = icon
        
        self.button.backgroundColor = .clear
        self.iconView.applyRadius(radius: iconSize/2.0)
    }

    public init(with title: String, colorIcon: UIColor) {
        super.init()
        self.title = title
        self.colorIcon = colorIcon

        self.title = title
        self.titleLabel.text = title

        self.colorIcon = colorIcon
        self.iconView.backgroundColor = colorIcon

        self.button.backgroundColor = .clear
        self.iconView.applyRadius(radius: iconSize/2.0)
    }
}
