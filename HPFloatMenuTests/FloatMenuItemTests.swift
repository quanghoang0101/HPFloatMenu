//
//  FloatMenuItemTests.swift
//  HPFloatMenuTests
//
//  Created by Hoang on 4/24/19.
//  Copyright © 2019 Quang Hoang. All rights reserved.
//

import XCTest
@testable import HPFloatMenu

class FloatMenuItemTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInit() {
        let menuItem2 = FloatMenuItem(with: "Test", icon: UIImage())
        XCTAssert(menuItem2 != nil, "menuItem2 is nil")
    }
}
