# HPFloatMenu

[![Platform](http://img.shields.io/badge/platform-iOS-blue.svg?style=flat
)](https://developer.apple.com/iphone/index.action)
[![Language](http://img.shields.io/badge/language-Swift-brightgreen.svg?style=flat
)](https://developer.apple.com/swift)
[![License](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat
)](http://mit-license.org)
[![Issues](https://img.shields.io/github/issues/quanghoang0101/HPFloatMenu.svg?style=flat
)](https://github.com/quanghoang0101/HPFloatMenu/issues?state=open)
![Build](https://travis-ci.com/quanghoang0101/HPFloatMenu.svg?branch=master)
[![codecov](https://codecov.io/gh/quanghoang0101/HPFloatMenu/branch/master/graph/badge.svg)](https://codecov.io/gh/quanghoang0101/HPFloatMenu)

HPFloatMenu with cool animation for your iOS app, easy setup and use!

![sample](https://media.giphy.com/media/mEcFWs5dEvdwSTAfRY/giphy.gif)

# Installation
#### CocoaPods
```
pod 'HPFloatMenu'
```
#### Manually
Copy the `HPFloatMenu` folder to your project.

## Customization

### HPFloatMenuView Customizable
* speed of animation
```Swift
var animationSpeed: Double = 0.1
```
* space of each item in the menu
```Swift
var spacingItem: CGFloat = 15.0
```
* position of the menu
```Swift
var position: MenuPosition = .bottomLeft
```
### FloatMenuItem Customizable
* configation for item
```Swift
public struct ItemConfigation {
    
    public var colorTitle: UIColor!
    public var colorIcon: UIColor!
    public var fontTitle: UIFont!
    public var iconSize: CGFloat!
}
```
* init item with title and icon
```Swift
init(with title: String, icon: UIImage)
```

* init item with title, icon and custom configation
```Swift
init(with title: String, icon: UIImage, config: ItemConfigation)
```

* init item with title and configation
```Swift
init(with title: String, config: ItemConfigation) 
```
### Monitor the states of menu, you can use `FloatMenuDelegate` use this:
```swift
func floatMenuDidOpen(_ menu: FloatMenuView)
func floatMenuDidClose(_ menu: FloatMenuView)
func floatMenuDidSelectItem(_ menu: FloatMenuView, at index: Int)
```

## Usage

### Setup
Add `import HPFloatMenu` in your file

```Swift
lazy var floatMenuView: FloatMenuView = {
    let view = FloatMenuView(frame: .zero)
    view.delegate = self
    return view
}()

func setDefaultItems() {
   let group = FloatMenuItem(with: "Group", config: ItemConfigation(colorIcon: UIColor(hexString: "#CFCFCF")!))
   self.floatMenuView.addItem(group)

   let watch = FloatMenuItem(with: "Watch", config: ItemConfigation(colorIcon: UIColor(hexString: "#969696")!))
   self.floatMenuView.addItem(watch)

   let settings = FloatMenuItem(with: "Settings", config: ItemConfigation(colorIcon: UIColor(hexString: "#6D6C6C")!))
   self.floatMenuView.addItem(settings)
}

override func viewDidLoad() {
   super.viewDidLoad()
   self.setDefaultItems()
}

@objc private func showMenu(_ sender: Any) {
   self.floatMenuView.showMenu(at: sender as! UIButton)
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
```
## Requirements
Swift 5.0

iOS 9.0+

## Contributing
Forks, patches and other feedback are welcome.

## Creator
### HPFloatMenu
[Quang Hoang](https://github.com/quanghoang0101) 

[Blog](https://medium.com/@phanquanghoang)

## License
HPFloatMenu is available under the MIT license. See the [LICENSE](./LICENSE) file for more info.
