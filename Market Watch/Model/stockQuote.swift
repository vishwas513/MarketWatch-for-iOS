//
//  stockQuote.swift
//  Market Watch
//
//  Created by Vishwas Mukund on 7/4/18.
//  Copyright © 2018 Vishwas Mukund. All rights reserved.
//

import Foundation

class stockQuote : NSObject {
    var companyName:String = "";
    var open: Double = 0.0;
    var close: Double = 0.0;
    var high: Double = 0.0;
    var low: Double = 0.0;
    var peRatio: Double = 0.0;
    var currentPrice: Double = 0.0;
}
