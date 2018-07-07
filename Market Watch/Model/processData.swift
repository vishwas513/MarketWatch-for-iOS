//
//  processData.swift
//  Market Watch
//
//  Created by Vishwas Mukund on 7/4/18.
//  Copyright © 2018 Vishwas Mukund. All rights reserved.
//

import Foundation

extension String {
    var doubleValue: Double {
        return (self as NSString).doubleValue
    }
}

class processData {
    
    func getGainOrLoss(dailyQuotes :NSDictionary) -> Double{
        
        let arrayDates = dailyQuotes.allKeys;
        let sortedArrayDates = arrayDates.sorted { ($0 as AnyObject).localizedCaseInsensitiveCompare($1 as! String) == ComparisonResult.orderedAscending }
        let length = sortedArrayDates.count;
        let recent = sortedArrayDates[length - 1] as! String;
        let secondRecent = sortedArrayDates[length - 2] as! String;
        let recentTrade: NSDictionary = dailyQuotes[recent]! as! NSDictionary;
        let previousDayTrade : NSDictionary = dailyQuotes[secondRecent]! as! NSDictionary;
        let openingValue:String = recentTrade["1. open"]! as! String;
        let closingValue:String = previousDayTrade["4. close"]! as! String;
        var net = openingValue.doubleValue - closingValue.doubleValue  ;
        print("Net",net, openingValue,closingValue);
        var returnString = round(100*net)/100;
        
        return returnString
    }
}
