//
//  FloatMenuItem.swift
//  HPFloatMenu
//
//  Created by Hoang on 4/22/19.
//  Copyright © 2019 Quang Hoang. All rights reserved.
//

import UIKit

enum ItemIconAlignment: Int {
    case left = 0
    case right
}

public struct ItemConfigation {
    
    public var colorTitle: UIColor!
    public var colorIcon: UIColor!
    public var fontTitle: UIFont!
    public var iconSize: CGFloat!

    public init(colorTitle: UIColor = UIColor(hexString: "#CFCFCF")!,
                colorIcon: UIColor = UIColor(hexString: "#CFCFCF")!,
                fontTitle: UIFont = UIFont.systemFont(ofSize: 17),
                iconSize: CGFloat = 12) {
        self.colorTitle = colorTitle
        self.colorIcon = colorIcon
        self.fontTitle = fontTitle
        self.iconSize = iconSize
    }
}

public class FloatMenuItem: NSObject {

    // MARK: - Public properties
    public var config: ItemConfigation = ItemConfigation() {
        didSet {
            titleLabel.textColor = config.colorTitle
            titleLabel.font = config.fontTitle
            iconView.backgroundColor = config.colorIcon
            iconView.snp.updateConstraints { (maker) in
                maker.width.height.equalTo(config.iconSize)
            }
        }
    }

    public var title: String?
    public var icon: UIImage?
    public var isHidden: Bool = false 

    var tag: Int = 0 {
        didSet {
            self.button.tag = tag
        }
    }

    var iconAlignment: ItemIconAlignment = .right {
        didSet {
            alignIcon(with: iconAlignment)
        }
    }

    // MARK: - Lazy properties
    lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        return view
    }()

    public lazy var iconView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFit
        containerView.addSubview(view)
        view.snp.makeConstraints { (maker) in
            maker.width.height.equalTo(self.config.iconSize)
            maker.trailing.equalToSuperview()
            maker.top.bottom.equalToSuperview()
        }
        view.backgroundColor = self.config.colorIcon
        return view
    }()

    public lazy var titleLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.textColor = self.config.colorTitle
        containerView.addSubview(view)
        view.snp.makeConstraints { (maker) in
            maker.leading.top.bottom.equalToSuperview()
            maker.trailing.equalTo(iconView.snp.leading).offset(-15)
        }
        return view
    }()

    private lazy var button: UIButton = {
        let view = UIButton(type: .custom)
        containerView.addSubview(view)
        view.snp.makeConstraints { (maker) in
            maker.top.bottom.leading.trailing.equalToSuperview()
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
        self.iconView.applyRadius(radius: self.config.iconSize/2.0)
    }

    public init(with title: String, icon: UIImage, config: ItemConfigation = ItemConfigation()) {
        super.init()
        self.config = config

        self.title = title
        self.titleLabel.text = title
        self.titleLabel.textColor = config.colorTitle
        self.titleLabel.font = config.fontTitle

        self.icon = icon
        self.iconView.image = icon
        self.iconView.backgroundColor = config.colorIcon
        self.iconView.snp.updateConstraints { (maker) in
            maker.width.height.equalTo(config.iconSize)
        }
        self.button.backgroundColor = .clear
        self.iconView.applyRadius(radius: self.config.iconSize/2.0)
    }

    public init(with title: String, config: ItemConfigation = ItemConfigation()) {
        super.init()
        self.config = config

        self.title = title
        self.titleLabel.text = title
        self.titleLabel.textColor = config.colorTitle
        self.titleLabel.font = config.fontTitle

        self.iconView.backgroundColor = config.colorIcon
        self.iconView.snp.updateConstraints { (maker) in
            maker.width.height.equalTo(config.iconSize)
        }
        self.button.backgroundColor = .clear
        self.iconView.applyRadius(radius: self.config.iconSize/2.0)
    }

    // MARK: - Helpers
    private func alignIcon(with alignment: ItemIconAlignment) {
        iconView.snp_removeConstraints()
        titleLabel.snp_removeConstraints()
        switch alignment {
        case .left:
            iconView.snp.makeConstraints { (maker) in
                maker.width.height.equalTo(self.config.iconSize)
                maker.leading.equalTo(0)
                maker.top.bottom.equalToSuperview().priorityMedium()
                maker.center.equalToSuperview().priorityMedium()
            }
            titleLabel.snp.makeConstraints { (maker) in
                maker.trailing.top.bottom.equalTo(0)
                maker.leading.equalTo(iconView.snp.trailing).offset(15)
            }
        case .right:
            iconView.snp.makeConstraints { (maker) in
                maker.width.height.equalTo(self.config.iconSize)
                maker.trailing.equalTo(0)
                maker.top.bottom.equalToSuperview().priorityMedium()
                maker.center.equalToSuperview().priorityMedium()
            }
            titleLabel.snp.makeConstraints { (maker) in
                maker.leading.top.bottom.equalTo(0)
                maker.trailing.equalTo(iconView.snp.leading).offset(-15)
            }
        }
    }
}
