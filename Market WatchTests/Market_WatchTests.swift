//
//  Market_WatchTests.swift
//  Market WatchTests
//
//  Created by Vishwas Mukund on 7/4/18.
//  Copyright © 2018 Vishwas Mukund. All rights reserved.
//

import XCTest
import UIKit
import Foundation
import CoreData

@testable import Market_Watch


class Market_WatchTests: XCTestCase {
    
    
    // TableView delegates conformance test
    func testViewControllerConformsToUITableViewDelegate() {
        
        XCTAssert(ViewController.conforms(to: UITableViewDelegate.self), "ViewController under test does not conform to UITableViewDelegate protocol");
    }
    func testViewControllerConformsToUITableViewDataSource() {
        
        XCTAssert(ViewController.conforms(to: UITableViewDataSource.self), "ViewController under test does not conform to UITableViewDataSource protocol");
    }
    
   // ## Testing the Model
    
    //Test object is as per design
    func testStockObjectPropertiesInitilized(){
        let stock = stockQuote();
        XCTAssertNotNil(stock.open);
        XCTAssertNotNil(stock.close);
        XCTAssertNotNil(stock.high);
        XCTAssertNotNil(stock.low);
        XCTAssertNotNil(stock.chartData);
        XCTAssertNotNil(stock.summary);
        XCTAssertNotNil(stock.peRatio);
        XCTAssertNotNil(stock.currentPrice);

    }
    
    //Networking Tests
    func testNetworking(){
        var res = NSDictionary();
        let testArray = ["quote","news","chart"];
        networkingManager().getDailyData(symbol: "MSFT") { (results) in
            res  = results;
        }
        sleep(1);
        XCTAssertEqual(res.allKeys as! [String], testArray);
    }
    
    func testNetworkingErrorHandling(){
        let tempDict = NSDictionary();
        var res = NSDictionary();
        networkingManager().getDailyData(symbol: "MSFTfdgbdf") { (results) in
            res = results;
        }
        sleep(1);
        XCTAssertEqual(tempDict, res);
    }
    
    // Core Data Test
    func testCoreData(){
       
        coreDataManager().saveData(inputString: "AAPL");
        coreDataManager().saveData(inputString: "FB");
        let current = coreDataManager().getAllResults().count;
        
        coreDataManager().deleteData(inputString: "AAPL");
        coreDataManager().deleteData(inputString: "FB");
        let after = coreDataManager().getAllResults().count;
        
        XCTAssertGreaterThan(current, after);
       
    }
    
    
    
    
    
    
}
