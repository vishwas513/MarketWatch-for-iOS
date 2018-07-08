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
        let baseUrl2 = "https://api.iextrading.com/1.0/stock"
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
            if(json != nil){
                
                let response = json as! NSDictionary
                completionHandler(response);
            }else {
                let tempDict = NSDictionary();
                completionHandler(tempDict);
            }
            
            
            
            
            
            
            
                
                // Send data back to calling function
            
            
        }
        task.resume();
    }
    
    func spaceHandler(input:String) -> String{
        
        return input.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
        
        
        
    }
    
    
    
    
}
