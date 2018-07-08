//
//  ViewController.swift
//  Market Watch
//
//  Created by Vishwas Mukund on 7/4/18.
//  Copyright © 2018 Vishwas Mukund. All rights reserved.
//

import UIKit

struct stock{
   let symbol : String
   let net : Float
    
}

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}




class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, LineChartDelegate {
    
    func didSelectDataPoint(_ x: CGFloat, yValues: [CGFloat]) {
        label.text = "currentPrice: \(yValues)"
    }
    
    var label = UILabel()
    var lineChart: LineChart!
    
    //private let stocks = ["APPL","FB","GOOG"]
    fileprivate var stocks: [(String,Double)] = []
    fileprivate var stockDetails = [String : stockQuote]();
    var appDel: AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
   // var detailsArray = [String,NSArray]();
    
    @IBOutlet weak var addStockView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var stockInput: UITextField!
  
    @IBOutlet weak var openLabel: UILabel!
    @IBOutlet weak var closeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var lowLabel: UILabel!
    @IBOutlet weak var peRatio: UILabel!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var graphView: UIView!
    @IBOutlet weak var newsView: UIView!
    @IBOutlet weak var headLine: UILabel!
    @IBOutlet weak var newsArticle: UILabel!
    
    @IBOutlet weak var changePage: UISegmentedControl!
    @IBAction func changePage(_ sender: Any) {
        let selection = changePage.selectedSegmentIndex;
        
        if(selection == 0){
            graphView.isHidden = true;
            newsView.isHidden = true;
        }
        if(selection == 1){
            graphView.isHidden = false;
            newsView.isHidden = true;
            UIView.transition(with: graphView, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil);
        }
        if(selection == 2){
            newsView.isHidden = false;
            graphView.isHidden = true;
            UIView.transition(with: graphView, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil);
            
        }
        
    }
    
    @IBAction func closeGraph(_ sender: Any) {
        graphView.isHidden = true;
    }
    
    @IBAction func addSymbol(_ sender: Any) {
        
        if(stockInput.text != "" && stockInput != nil){
            
            let currentSymbol = stockInput.text;
            coreDataManager().saveData(inputString: stockInput.text!);
            networkingManager().getDailyData(symbol: stockInput.text!) { (results) in
                
                let quote = results["quote"] as! NSDictionary;
                let changePercent = quote["changePercent"] as! Double
                let currentStock = (currentSymbol, changePercent * 100);
                self.stocks.append(currentStock as! (String, Double));
                let stock = stockQuote();
                
                stock.companyName = quote["companyName"] as! String;
                stock.high = quote["high"] as! Double;
                stock.low = quote["low"] as! Double;
                stock.open = quote["open"] as! Double;
                stock.close = quote["close"] as! Double;
                stock.peRatio = quote["peRatio"] as! Double;
                stock.currentPrice = quote["latestPrice"] as! Double;
                
                self.stockDetails[currentSymbol!] = stock;
               // print(self.stockDetails);
                
                DispatchQueue.main.async {
                    self.tableView.reloadData();
                }
            }
            addStockView.isHidden = true;
            
            
            
        }
    }
    
    @IBAction func addStock(_ sender: Any) {
        if(addStockView.isHidden == false){
            addStockView.isHidden = true;
        }
        else if(addStockView.isHidden == true){
            addStockView.isHidden = false;
            
            
            
            
            
            
            
        }
        
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad();
        
        graphView.isHidden = true;
        addStockView.isHidden = true;
        newsView.isHidden = true;
        
        addStockView.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.5);
        graphView.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.9);
        newsView.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.9);
        let storedSymbols = coreDataManager().getAllResults();
        var i = 0;
        
//        print(coreDataManager().getAllResults());
     
        while(i < storedSymbols.count){
            var currentSymbol = storedSymbols[i];
          //  print(currentSymbol);
           
            
        //    coreDataManager().deleteData(inputString: "APPL");
        //    coreDataManager().deleteData(inputString: "AAPL");
         //   coreDataManager().deleteData(inputString: "RY");
         //   coreDataManager().deleteData(inputString: "GOOG");
         //   coreDataManager().deleteData(inputString: "HPQ");
         //   coreDataManager().deleteData(inputString: "SBUX");
         //   coreDataManager().deleteData(inputString: "INFY");
         //   coreDataManager().deleteData(inputString: "FB");
         //   coreDataManager().deleteData(inputString: "");
         //   coreDataManager().deleteData(inputString: "XOM");
         //   coreDataManager().deleteData(inputString: "FB");
         //   coreDataManager().deleteData(inputString: "MSFT");
         //  coreDataManager().deleteData(inputString: "NIFTY")
         
            
            
            networkingManager().getDailyData(symbol: storedSymbols[i]) { (results) in
                
                let quote = results["quote"] as! NSDictionary;
                let chart = results["chart"] as! NSArray;
                let news = results["news"] as! NSArray;
                let changePercent = quote["changePercent"] as! Double
                let currentStock = (currentSymbol, changePercent * 100);
                self.stocks.append(currentStock);
                
                print(chart[chart.count - 1]);
                var i = chart.count - 1;
                var count = 0;
                var chartArray = [CGFloat]();
                chartArray.append(0);
                while(i > 0 && count < 7){
                    
                    let day = chart[i] as! NSDictionary;
                    let open = day["open"] as! CGFloat;
                    chartArray.append(open);
                    i -= 1;
                    count += 1;
                }
                
                let latestNews = news[0] as! NSDictionary;
                
                
    
                let stock = stockQuote();
                
                stock.companyName = quote["companyName"] as! String;
                stock.high = quote["high"] as! Double;
                stock.low = quote["low"] as! Double;
                stock.open = quote["open"] as! Double;
                stock.close = quote["close"] as! Double;
                stock.peRatio = quote["peRatio"] as! Double;
                stock.currentPrice = quote["latestPrice"] as! Double;
                stock.chartData = chartArray as [CGFloat];
                stock.headLine = latestNews["headline"] as! String;
                stock.summary = latestNews["summary"] as! String;
                
                self.stockDetails[currentSymbol] = stock;
                
                print(self.stockDetails);
                DispatchQueue.main.async {
                    self.tableView.reloadData();
                }
              
                
            }
            i += 1;
        }
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "cellId")
        //cell.textLabel.text = stocks[indexPath.row]
        cell.textLabel!.text = stocks[indexPath.row].0 //position 0 of the tuple: The Symbol "APPL"
        cell.detailTextLabel!.text = "\(stocks[indexPath.row].1)" + "%" //position 1 of the tuple: The value "99" into String
        cell.selectionStyle = UITableViewCellSelectionStyle.none;
        
        let indexPath = IndexPath(row: 0, section: 0)
        let currentSymbol = self.stocks[0].0 as String;
        let object : stockQuote = self.stockDetails[currentSymbol]!;
        
        openLabel.text = object.open.description;
        closeLabel.text = object.close.description;
        highLabel.text = object.high.description;
        lowLabel.text = object.low.description;
        companyName.text = object.companyName.description;
        peRatio.text = object.peRatio.description;
        priceLabel.text = object.currentPrice.description;
        
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .bottom);
        
        return cell
    }
    
    //UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row;
        let currentSymbol = self.stocks[index].0 as String;
        let object : stockQuote = self.stockDetails[currentSymbol]!;

        openLabel.text = object.open.description;
        closeLabel.text = object.close.description;
        highLabel.text = object.high.description;
        lowLabel.text = object.low.description;
        companyName.text = object.companyName.description;
        peRatio.text = object.peRatio.description;
        priceLabel.text = object.currentPrice.description;
        headLine.text = object.headLine.description;
        newsArticle.text = object.summary.description;

    
        prepareGraph(dataSet: object.chartData);
        
    }
    
    //Customize the cell
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch stocks[indexPath.row].1 {
        case let x where x < 0.0:
            cell.backgroundColor = UIColor(red: 255.0/255.0, green: 59.0/255.0, blue: 48.0/255.0, alpha: 1.0)
        case let x where x > 0.0:
            cell.backgroundColor = UIColor(red: 76.0/255.0, green: 217.0/255.0, blue: 100.0/255.0, alpha: 1.0)
        case _:
            cell.backgroundColor = UIColor(red: 44.0/255.0, green: 186.0/255.0, blue: 231.0/255.0, alpha: 1.0)
        }
        
        cell.textLabel!.textColor = UIColor.white
        cell.detailTextLabel!.textColor = UIColor.white
        cell.textLabel!.font = UIFont(name: "HelveticaNeue-CondensedBold", size: 48)
        cell.detailTextLabel!.font = UIFont(name: "HelveticaNeue-CondensedBold", size: 48)
        cell.textLabel!.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25)
        cell.textLabel!.shadowOffset = CGSize(width: 0, height: 1)
        cell.detailTextLabel!.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25)
        cell.detailTextLabel!.shadowOffset = CGSize(width: 0, height: 1)
    }
    
    //Customize the height of the cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
           // coreDataManager().deleteData(inputString: (stocks[indexPath.row].0));
           // stocks.remove(at: indexPath.row);
           // tableView.reloadData();
        }
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { (action, indexPath) in
            coreDataManager().deleteData(inputString: (self.stocks[indexPath.row].0));
            self.stocks.remove(at: indexPath.row);
            tableView.reloadData();
        }
        
        delete.backgroundColor = UIColor.black
        
        return [delete];
    }
    
    func prepareGraph(dataSet : [CGFloat]){
        var views: [String: AnyObject] = [:]
        label.text = "Click on point at view information at that day"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = NSTextAlignment.center
        label.textColor = .white;
        self.graphView.addSubview(label);
        
        views["label"] = label
        graphView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[label]-|", options: [], metrics: nil, views: views))
        graphView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-80-[label]", options: [], metrics: nil, views: views))
        
        // simple arrays
       // let data: [CGFloat] = [3, 4, -2, 11, 13, 15]
        let data: [CGFloat] = dataSet;
        
        // simple line with custom x axis labels
        let xLabels: [String] = ["Jan", "Feb", "Mar", "Apr", "May", "Jun","July"]
        lineChart = LineChart();
       
        lineChart.animation.enabled = true
        lineChart.area = true
        lineChart.x.labels.visible = true
        lineChart.x.grid.count = 7
        lineChart.y.grid.count = 5
        lineChart.x.labels.values = xLabels
        lineChart.y.labels.visible = true
        
        lineChart.addLine(data)
        lineChart.lineWidth = 1;

        
        lineChart.translatesAutoresizingMaskIntoConstraints = false
        lineChart.delegate = self
        graphView.clipsToBounds = true;
        self.graphView.addSubview(lineChart)
        

        views["chart"] = lineChart
        graphView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[chart]-|", options: [], metrics: nil, views: views))
        graphView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[label]-[chart(==200)]", options: [], metrics: nil, views: views))
        
    }
    
}
