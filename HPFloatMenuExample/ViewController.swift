//
//  ViewController.swift
//  HPFloatMenuExample
//
//  Created by Hoang on 4/22/19.
//  Copyright © 2019 Quang Hoang. All rights reserved.
//

import UIKit
import SnapKit
import HPFloatMenu

class ViewController: UIViewController {

    lazy var button: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Menu", for: .normal)
        button.addTarget(self, action: #selector(showMenu(_:)), for: .touchUpInside)
        return button
    }()

    lazy var floatMenuView: FloatMenuView = {
        let view = FloatMenuView(frame: .zero)
        view.delegate = self
        return view
    }()

    open var menuStyle: MenuStyle!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setDefaultItems()
        self.view.addSubview(button)

        switch menuStyle! {
        case .topLeft:
            self.button.snp.makeConstraints { (maker) in
                maker.top.equalToSuperview().offset(100)
                maker.leading.equalToSuperview().offset(50)
                maker.width.height.equalTo(60)
            }
        case .topRight:
            self.button.snp.makeConstraints { (maker) in
                maker.top.equalToSuperview().offset(100)
                maker.trailing.equalToSuperview().offset(-50)
                maker.width.height.equalTo(60)
            }
        case .bottomLeft:
            self.button.snp.makeConstraints { (maker) in
                maker.bottom.equalToSuperview().offset(-100)
                maker.leading.equalToSuperview().offset(50)
                maker.width.height.equalTo(60)
            }
        case .bottomRight:
            self.button.snp.makeConstraints { (maker) in
                maker.bottom.equalToSuperview().offset(-100)
                maker.trailing.equalToSuperview().offset(-50)
                maker.width.height.equalTo(60)
            }
        }

        self.button.applyRadius(radius: 30)
    }

    func setDefaultItems() {

        let group = FloatMenuItem(with: "Group", config: ItemConfigation(colorIcon: UIColor(hexString: "#CFCFCF")!))
        floatMenuView.addItem(group)

        let watch = FloatMenuItem(with: "Watch", config: ItemConfigation(colorIcon: UIColor(hexString: "#969696")!))
        floatMenuView.addItem(watch)

        let settings = FloatMenuItem(with: "Settings", config: ItemConfigation(colorIcon: UIColor(hexString: "#6D6C6C")!))
        floatMenuView.addItem(settings)
    }

    // MARK: - Action
    @objc private func showMenu(_ sender: Any) {
        switch menuStyle! {
        case .topLeft:
            self.floatMenuView.position = .topLeft
        case .topRight:
            self.floatMenuView.position = .topRight
        case .bottomLeft:
            self.floatMenuView.position = .bottomLeft
        case .bottomRight:
            self.floatMenuView.position = .bottomRight
        }

        self.floatMenuView.showMenu(at: sender as! UIButton)
    }
}

extension ViewController: FloatMenuDelegate {
    func floatMenuDidOpen(_ menu: FloatMenuView) {
        print("FLoat menu did open\n")
    }

    func floatMenuDidClose(_ menu: FloatMenuView) {
        print("Float menu did close\n")
    }

    func floatMenuDidSelectItem(_ menu: FloatMenuView, at index: Int) {
        print("Did select item at index \(index)\n")
        menu.dimissItems()
    }
}

