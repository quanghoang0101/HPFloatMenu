//
//  FloatMenuView.swift
//  HPFloatMenu
//
//  Created by Hoang on 4/22/19.
//  Copyright © 2019 Quang Hoang. All rights reserved.
//

import UIKit
import SnapKit

public protocol FloatMenuDelegate: class {
    func floatMenuDidOpen(_ menu: FloatMenuView)
    func floatMenuDidClose(_ menu: FloatMenuView)
    func floatMenuDidSelectItem(_ menu: FloatMenuView, at index: Int)
}

public class FloatMenuView: UIView {

    // MARK: -
    public var animationSpeed: Double = 0.1
    public var spacingItem: CGFloat = 15.0
    public var position: MenuPosition = .bottomLeft

    public weak var delegate: FloatMenuDelegate?

    public var colorOverlay: UIColor = UIColor(white: 0, alpha: 0.5) {
        didSet {
            overlayView.backgroundColor = colorOverlay
        }
    }

    public var radialGradientColors: [UIColor] {
        get {
            return radialGradientLayer.colors
        }
        set {
            radialGradientLayer.colors = newValue
        }
    }

    // MARK: - Lazy properties
    private lazy var overlayView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = colorOverlay
        view.layer.insertSublayer(radialGradientLayer, at: 0)
        self.addSubview(view)
        view.snp.makeConstraints { (maker) in
            maker.leading.top.trailing.bottom.equalToSuperview()
        }
        return view
    }()

    private lazy var radialGradientLayer: RadialGradientLayer = {
        let view = RadialGradientLayer()
        view.frame = windowView.bounds
        return view
    }()

    private lazy var mainView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        self.addSubview(view)
        view.snp.makeConstraints { (maker) in
            maker.leading.top.trailing.bottom.equalToSuperview()
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismiss(_ :)))
        view.addGestureRecognizer(tapGesture)
        return view
    }()

    lazy var windowView = {
        return UIApplication.shared.keyWindow!
    }()

    // MARK: - Private properties
    private var items: [FloatMenuItem] = []
    private var senderView: UIView?

    // MARK: - Init
    public convenience init(frame: CGRect, position: MenuPosition) {
        self.init(frame: frame)
        self.position = position
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        self.radialGradientLayer.setNeedsDisplay()
    }

    // MARK: - Public functions
    public func addItem(_ item: FloatMenuItem) {
        items.append(item)
    }

    public func removeAllItems() {
        items.removeAll()
    }

    public func showMenu(at senderView: UIView) {
        // Store sender views
        self.senderView = senderView.snapshotView(afterScreenUpdates: false)

        // Add view
        self.windowView.addSubview(self)
        self.snp.makeConstraints { (maker) in
            maker.leading.top.trailing.bottom.equalToSuperview()
        }

        // Animation for overlay
        self.overlayView.alpha = 0
        UIView.animate(withDuration: 0.25) {[weak self] in
            self?.overlayView.alpha = 1
        }

        // Get new rect of sender view
        let newRect = senderView.convert(senderView.bounds, to: nil)
        self.addSubview(self.senderView!)
        self.senderView?.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview().offset(newRect.minY)
            maker.leading.equalToSuperview().offset(newRect.minX)
            maker.width.equalTo(senderView.frame.width)
            maker.height.equalTo(senderView.frame.height)
        }

        // Dislay menu items
        self.displayMenuItems()

        // Callback did open menu
        self.delegate?.floatMenuDidOpen(self)
    }

    // MARK: - Private functions
    private func displayMenuItems() {
        let animationGroup = DispatchGroup()
        var delay = 0.0
        self.bringSubviewToFront(self.mainView)
        let spacing: CGFloat = spacingItem

        for i in 0..<items.count {
            let item = items[i]
            self.mainView.addSubview(item.containerView)
            item.containerView.layer.transform = CATransform3DIdentity
            item.containerView.alpha = 0
            item.tag = i


            // Callback menu did select item
            item.itemDidSelect = {[weak self] index in
                guard let `self` = self else {return}
                self.delegate?.floatMenuDidSelectItem(self, at: index)
            }

            var previousView: UIView!
            if i == 0 {
                previousView = senderView!
            } else {
                previousView = items[i-1].containerView
            }
            switch self.position {
            case .bottomLeft:
                item.iconAlignment = .left
                item.containerView.snp.makeConstraints { (maker) in
                    maker.bottom.equalTo(previousView!.snp.top).offset(-spacing)
                    maker.leading.equalTo(senderView!.snp.leading).offset(self.senderView!.frame.width/2 - item.config.iconSize/2)
                }
            case .bottomRight:
                item.iconAlignment = .right
                item.containerView.snp.makeConstraints { (maker) in
                    maker.bottom.equalTo(previousView!.snp.top).offset(-spacing)
                    maker.trailing.equalTo(senderView!.snp.trailing).offset(-self.senderView!.frame.width/2 + item.config.iconSize/2)
                }
            case .topLeft:
                item.iconAlignment = .left
                item.containerView.snp.makeConstraints { (maker) in
                    maker.top.equalTo(previousView!.snp.bottom).offset(spacing)
                    maker.leading.equalTo(senderView!.snp.leading).offset(self.senderView!.frame.width/2 - item.config.iconSize/2)
                }
            case .topRight:
                item.iconAlignment = .right
                item.containerView.snp.makeConstraints { (maker) in
                    maker.top.equalTo(previousView!.snp.bottom).offset(spacing)
                    maker.trailing.equalTo(senderView!.snp.trailing).offset(-self.senderView!.frame.width/2 + item.config.iconSize/2)
                }
            }
            animationGroup.enter()
            item.containerView.layer.transform = CATransform3DMakeScale(0.4, 0.4, 1)
            UIView.animate(withDuration: 0.3, delay: delay,
                           usingSpringWithDamping: 0.55,
                           initialSpringVelocity: 0.3,
                           options: UIView.AnimationOptions(), animations: { () -> Void in
                            item.containerView.layer.transform = CATransform3DIdentity
                            item.containerView.alpha = 1
            }, completion: { _ in
                animationGroup.leave()
            })

            delay += animationSpeed
        }
    }

    public func dimissItems() {
        var delay = 0.0
        let animationGroup = DispatchGroup()
        for item in items.reversed() {
            animationGroup.enter()
            UIView.animate(withDuration: 0.15, delay: delay, options: [], animations: { () -> Void in
                item.containerView.layer.transform = CATransform3DMakeScale(0.4, 0.4, 1)
                item.containerView.alpha = 0
            }, completion: { _ in
                animationGroup.leave()
            })
            delay += animationSpeed
        }

        UIView.animate(withDuration: 0.3, animations: {[weak self] in
            self?.overlayView.alpha = 0
        }) {[weak self] _ in
            guard let `self` = self else {return}
            self.senderView?.removeFromSuperview()
            self.removeFromSuperview()
            self.items.forEach {$0.containerView.removeFromSuperview()}

            // Callback menu did close
            self.delegate?.floatMenuDidClose(self)
        }
    }

    @objc func dismiss(_ sender: UITapGestureRecognizer) {
        dimissItems()
    }
}
