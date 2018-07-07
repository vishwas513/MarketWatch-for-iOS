//
//  networkingManager.swift
//  Market Watch
//
//  Created by Vishwas Mukund on 7/4/18.
//  Copyright © 2018 Vishwas Mukund. All rights reserved.
//

import Foundation

class networkingManager{
    
    
    func getDailyData(symbol:String, completionHandler: @escaping (_ stockData: NSDictionary) -> ()){
        //"https://api.iextrading.com/1.0/stock/aapl/batch?types=quote,news,chart&range=1m&last=10"
        //Building the URL https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=MSFT&apikey=demo
        let baseUrl = "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY"
        let baseUrl2 = "https://api.iextrading.com/1.0/stock"
        let url = NSURL(string: baseUrl + "&symbol=" + symbol + "&apikey=JU78DQCHZT7STXGV")!
        let url2 = NSURL(string: baseUrl2 + "/" + symbol + "/" + "batch?types=quote,news,chart&range=1m&last=1")!
        
        //Creating the Request Object with options
        let request = NSMutableURLRequest(url: url2 as URL)
        request.httpMethod = "GET"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        
        // Asynchronously perform GET operation
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            
            
            // Parse into json and then convert into dictionary
            let json = try? JSONSerialization.jsonObject(with: data!, options: [])
            
            let response = json as! NSDictionary
            
            
            
                
                // Send data back to calling function
                completionHandler(response);
            
        }
        task.resume();
    }
    
    func spaceHandler(input:String) -> String{
        
        return input.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
        
        
        
    }
    
    
    
    
}