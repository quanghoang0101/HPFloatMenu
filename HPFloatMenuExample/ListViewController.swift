//
//  ListViewController.swift
//  HPFloatMenuExample
//
//  Created by Hoang on 4/24/19.
//  Copyright © 2019 Quang Hoang. All rights reserved.
//

import UIKit

enum MenuStyle: Int {
    case topLeft = 0
    case topRight
    case bottomLeft
    case bottomRight

    var title: String {
        switch self {
        case .topLeft: return "Top Left"
        case .topRight: return "Top Right"
        case .bottomLeft: return "Bottom Left"
        case .bottomRight: return "Bottom Right"
        }
    }

    static let count: Int = {
        var max: Int = 0
        while let _ = MenuStyle(rawValue: max) { max += 1 }
        return max
    }()
}

class ListViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuStyle.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = MenuStyle(rawValue: indexPath.row)!.title
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let style = MenuStyle(rawValue: indexPath.row)!
        self.performSegue(withIdentifier: "Detail", sender: style)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let destinationController = segue.destination as! ViewController
        destinationController.menuStyle = sender as? MenuStyle
    }

}
