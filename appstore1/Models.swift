//
//  Models.swift
//  appstore1
//
//  Created by Rey Matsunaga on 1/30/19.
//  Copyright © 2019 Rey Matsunaga. All rights reserved.
//

import UIKit
import Foundation

struct AppCategories {
    let appCategories: [AppCategory]
    
    struct AppCategoriesCodingKeys: CodingKey {
        let stringValue: String
        
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        var intValue: Int? { return nil }
        
        init?(intValue: Int) { return nil }
        
        static let categories = AppCategoryCodingKeys(stringValue: "categories")!
        
    }
    
    enum AppCategoryCodingKeys: CodingKey {
        case name
        case apps
        case type
    }
}

class AppCategory {
    
    var name: String?
    var apps: [App]?
    var type: String?
    
    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AppCategoryCodingKeys.self)
    }
    
    static func fetchFeaturedApps() {
        guard let appStoreUrl = URL(string: "https://api.letsbuildthatapp.com/appstore/featured") else { return }
        
        URLSession.shared.dataTask(with:appStoreUrl) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            
            guard let data = data else { return }
                
            do {
                let decoder = JSONDecoder()
                
                decoder.keyDecodingStrategy = .useDefaultKeys
                let appStoreData = try decoder.decode([String : AppCategory].self, from: data)
                
                DispatchQueue.main.async {
                    print(appStoreData)
                }
            } catch let jsonError {
                print(jsonError)
            }
        }.resume()
    }
    

//    static func sampleAppCategories() -> [AppCategory] {
//        let bestNewAppsCategory = AppCategory()
//        bestNewAppsCategory.name = "Best New Apps"
//        var apps = [App]()
//        // logic
//        let frozenApp = App()
//        frozenApp.name = "Disney Build It: Frozen"
//        frozenApp.imageName = "frozen"
//        frozenApp.category = "Entertainment"
//        frozenApp.price = Double(3.99)
//        apps.append(frozenApp)
//
//        bestNewAppsCategory.apps = apps
//
//        let bestNewGamesCategory = AppCategory()
//        bestNewGamesCategory.name = "Best New Games"
//
//        var bestNewGamesApps = [App]()
//        let telepaint = App()
//        telepaint.name = "Telepaint"
//        telepaint.imageName = "telepaint"
//        telepaint.category = "Games"
//        telepaint.price = Double(2.99)
//        bestNewGamesApps.append(telepaint)
//        bestNewGamesCategory.apps = bestNewGamesApps
//        return [bestNewAppsCategory, bestNewGamesCategory]
//    }
    
}

class App: NSObject, Decodable {
    
    var name: String?
    var id: Int?
    var category: String?
    var price: Double?
    var imageName: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case category = "Category"
        case price = "Price"
        case id = "Id"
        case imageName = "ImageName"
    }
    
}


//extension AppCategory: Decodable {
//    required convenience init(from decoder: Decoder) throws {
//        let outerContainer = try decoder.container(keyedBy: OuterCodingKeys.self)
//        let innerContainer = try outerContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .categories)
//
//        self.name = try innerContainer.decode(String.self, forKey: .name)
//        self.apps = try innerContainer.decode([App].self, forKey: .apps)
//        self.type = try innerContainer.decode(String.self, forKey: .type)
//    }
//}
