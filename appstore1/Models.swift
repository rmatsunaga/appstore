//
//  Models.swift
//  appstore1
//
//  Created by Rey Matsunaga on 1/30/19.
//  Copyright © 2019 Rey Matsunaga. All rights reserved.
//

import UIKit

class AppCategory: NSObject {
    
    var name: String?
    var apps: [App]?
    var type: String?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "apps" {
            
            apps = [App]()
            for dict in value as! [[String: Any]] {
                let app = App()
                app.setValuesForKeys(dict)
                apps?.append(app)
            }
        } else {
            super.setValue(value, forKey: key)
        }
    }
    
    static func fetchFeaturedApps() {
        
        let urlString = "https://api.letsbuildthatapp.com/appstore/featured"
        
        URLSession.shared.dataTask(with: URL(string: urlString)!) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            do {
                let json = try(JSONSerialization.jsonObject(with: data!, options: .mutableContainers)) as! [String: Any]
                
                var appCategories = [AppCategory]()
                
                for dict in json["categories"] as! [[String: Any]] {
                    let appCategory = AppCategory()
                    appCategory.setValuesForKeys(dict)
                    appCategories.append(appCategory)
                }
                print(appCategories)
            } catch let err {
                print(err)
            }
        }.resume()
    }
    
    static func sampleAppCategories() -> [AppCategory] {
        let bestNewAppsCategory = AppCategory()
        bestNewAppsCategory.name = "Best New Apps"
        
        var apps = [App]()
        
        // logic
        let frozenApp = App()
        frozenApp.name = "Disney Build It: Frozen"
        frozenApp.imageName = "frozen"
        frozenApp.category = "Entertainment"
        frozenApp.price = NSNumber(value: 3.99)
        apps.append(frozenApp)
        
        bestNewAppsCategory.apps = apps
        
        let bestNewGamesCategory = AppCategory()
        bestNewGamesCategory.name = "Best New Games"
        
        var bestNewGamesApps = [App]()
        let telepaint = App()
        telepaint.name = "Telepaint"
        telepaint.imageName = "telepaint"
        telepaint.category = "Games"
        telepaint.price = NSNumber(value: 2.99)
        bestNewGamesApps.append(telepaint)
        
        bestNewGamesCategory.apps = bestNewGamesApps
        
        
        
        return [bestNewAppsCategory, bestNewGamesCategory]
        
        
    }
    
}

class App: NSObject {
    
    var name: String?
    var id: NSNumber?
    var category: String?
    var price: NSNumber?
    var imageName: String?
    
}
