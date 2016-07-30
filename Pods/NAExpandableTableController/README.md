# NAExpandableTableController

[![Version](https://img.shields.io/cocoapods/v/NAExpandableTableController.svg?style=flat)](http://cocoapods.org/pods/NAExpandableTableController)
[![License](https://img.shields.io/cocoapods/l/NAExpandableTableController.svg?style=flat)](http://cocoapods.org/pods/NAExpandableTableController)
[![Platform](https://img.shields.io/cocoapods/p/NAExpandableTableController.svg?style=flat)](http://cocoapods.org/pods/NAExpandableTableController)

![Demo](http://g.recordit.co/UsDQ3oI0wg.gif)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## How to Use

This is a straightforward library to use - just set your UITableView's delegate and dataSource to a NAExpandableTableController object and implement the NAExpandableTableViewDataSource & NAExpandableTableViewDelegate protocols.

```swift
self.expandableController = NAExpandableTableController(dataSource: self, delegate: self)
self.tableView.dataSource = self.expandableController
self.tableView.delegate = self.expandableController
```

Voila!

#### Note

It's important to retain the expandableController object reference for your UITableView's dataSource & delegate otherwise it will be deallocated once it goes out of scope and your tableView will be empty.

## Installation

NAExpandableTableController is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "NAExpandableTableController"
```

## Author

Nick A, narciero

## License

NAExpandableTableController is available under the MIT license. See the LICENSE file for more info.
