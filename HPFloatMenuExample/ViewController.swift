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

    @IBOutlet weak var button: UIButton!
    
    lazy var floatMenuView: FloatMenuView = {
        let view = FloatMenuView(frame: .zero)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.button.applyRadius(radius: 30)
        self.setDefaultItems()
    }

    func setDefaultItems() {

        let group = FloatMenuItem(with: "Group", colorIcon: UIColor(hexString: "#CFCFCF")!)
        floatMenuView.addItem(group)

        let watch = FloatMenuItem(with: "Watch", colorIcon: UIColor(hexString: "#969696")!)
        floatMenuView.addItem(watch)

        let settings = FloatMenuItem(with: "Settings", colorIcon: UIColor(hexString: "#6D6C6C")!)
        floatMenuView.addItem(settings)
    }

    // MARK: - Action
    @IBAction private func showMenu(_ sender: Any) {
        self.floatMenuView.showMenu(at: button, with: self.view)
    }
}

