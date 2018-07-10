# Features

- Get Stock information for any Stock Symbol in real time.
- Able to store symbols in Core Data
- Able to delete symbols in Core Data.
- Graph of last 7 trading days is shown.
- Real time news for each symbol is shown. 
- Unique intutive representation of gain or loss.
- Get relavent details for each Symbol.
- Dark Frosted glass effect for subviews.
- Works well with all sized devices including the smaller screen sized iPhone SE to the largest sized iPad Pro.
- Optmized for the iPhone X.
- Offers a full test suite covering all the critical areas of the software.
- Refresh button added which fetches the latest stock,news and chart Information.




![](https://github.com/vishwas513/MarketWatch-for-iOS/blob/master/headerImage.png)

# Manual

'+' Button : 
This button toggles the addStockView which contains :
 - stockInput text field => Input of Stock Symbol
 - Add Stock Button => To process the symbol and update thee UI
 - Error display message => Gets activated when current symbol does not exist. 
 - Automatically closes addStock view if stock is successfully added.

Refresh Button :
- Deleted all the values and fetches latest values in real time.
- Works on values like, open, price, high also graphs and even news.
- To most effectively view this feature, please try during trading hours.

Details Page : 
- Shows names of companies, open,close,high low, current price, peRatio

Graph Page : 
- Shows last 7 trading days opening price.
- Can click on a point to view information on that day. 
- The open source graph API i used wouldn't provide more resolution.
- Since Yahoo and Google dont have finance APis anymore, i had to use a completely different one which did not provide information for weekly and monthly charts(This was the plan). The only one i have implemented is daily.
- Refresh button updates the charts. 

News Page : 
- Shows headline of latest news article in real time
- Shows summary of latest news in real time.
- Its possible for the API to return no summary.
- Refresh button updates the news.


TableView : 
- Click on row after adding symbols to show infomration about that symbol.
- swipe from right to left to bring up delete option. 
- keep swiping from right to left to directly delete the record.
- Green row indicates gain, red row indicates loss and light blue for no change.

# Project Information
- Build on Xcode Version 9.4.1 and written in Swift 4.1
- Haven't used any pods to prevent problems with dependecies.
- Autolayout is used to make it work on multiple sized devices. 
- The warnings regarding Autolayout containts does not impact the functionality of the application.
- Has been tested on actual iPhone 7, but unfortunately no other devices due to unavailability.
- Has been tested on all devices on the simulator.

# How to run
- Git clone or download zip 
- run Market Watch.xcodproj fill and press the play button to run on simulator or device.

Please feel free to contact me anytime if there is some issue, or if you need more information. Thanks.



