//
//  Network.swift
//  widgetProject
//
//  Created by Kim Insub on 2022/05/04.
//
import SwiftUI

class Network: ObservableObject {
    
    //Define
    @Published var menus: [Menu] = []
    var BREAKFAST_A: [String] = []
    var BREAKFAST_B: [String] = []
    var LUNCH: [String] = []
    var DINNER: [String] = []
    var STAFF: [String] = []
    var INTERNATIONAL: [String] = []
    
    //CURRENT DATE
    func currentDate() -> [String: String]{
        //Define
        let calendar = Calendar.current
        let date = Date()

        let year = String(calendar.component(.year, from: date))
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let weekday = String(calendar.component(.weekday, from: date))

        var refinedMonth = String(month)
        var refinedDay = String(day)
        
        let dayDict = [
            "1" : "(일)",
            "2" : "(월)",
            "3" : "(화)",
            "4" : "(수)",
            "5" : "(목)",
            "6" : "(금)",
            "7" : "(토)"
        ]
        
        //formatting
        if month < 10 {
            refinedMonth = "0" + String(month)
        }
        
        if day < 10 {
            refinedDay = "0" + String(day)
        }
        
        //Store UserDefault Data
        let dateDict = ["year": year, "month": refinedMonth, "day": refinedDay, "weekday": dayDict[weekday]!]
        UserDefaults(suiteName: "group.com.kim.widgetProject")!.set(dateDict, forKey: "CURRENTDATE")
        
        //Return
        return dateDict
    }
    
    //GET MENUS OF A DAY
    func getMenus() {
        
        //Define
        let date = currentDate()
        let year = date["year"]!
        let month = date["month"]!
        let day = date["day"]!

        //Request
        guard let url = URL(string: "https://food.podac.poapper.com/v1/menus/\(year)/\(month)/\(day)") else { fatalError("Missing URL") }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"

        //Decode
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }

            guard let response = response as? HTTPURLResponse else { return }
            
            if response.statusCode == 200 {
                
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let decodedMenus = try JSONDecoder().decode([Menu].self, from: data)
                        self.menus = []
                        self.menus = decodedMenus
                        self.devideData()
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        dataTask.resume()
    }
    
    //Devide Data
    func devideData(){
        for menu in menus {
            //BREAKFAST_A
            if menu.type == "BREAKFAST_A"{
                BREAKFAST_A.removeAll()
                for food in menu.foods{
                    let check = food.isMain == true ? "*" : ""
                    BREAKFAST_A.append(food.name_kor + check)
                }
            }
            //BREAKFAST_B
            else if menu.type == "BREAKFAST_B"{
                BREAKFAST_B.removeAll()
                for food in menu.foods{
                    let check = food.isMain == true ? "*" : ""
                    BREAKFAST_B.append(food.name_kor + check)
                }
            }
            //LUNCH
            else if menu.type == "LUNCH"{
                LUNCH.removeAll()
                for food in menu.foods{
                    let check = food.isMain == true ? "*" : ""
                    LUNCH.append(food.name_kor + check)
                }
            }
            //DINNER
            else if menu.type == "DINNER"{
                DINNER.removeAll()
                for food in menu.foods{
                    let check = food.isMain == true ? "*" : ""
                    DINNER.append(food.name_kor + check)
                }
            }
            //STAFF
            else if menu.type == "STAFF"{
                STAFF.removeAll()
                for food in menu.foods{
                    let check = food.isMain == true ? "*" : ""
                    STAFF.append(food.name_kor + check)
                }
            }
            //INTERNATIONAL
            else if menu.type == "INTERNATIONAL"{
                INTERNATIONAL.removeAll()
                for food in menu.foods{
                    let check = food.isMain == true ? "*" : ""
                    INTERNATIONAL.append(food.name_kor + check)
                }
            }
        }
        
        //Store Datas
        UserDefaults(suiteName: "group.com.kim.widgetProject")!.set(BREAKFAST_A, forKey: "BREAKFAST_A")
        UserDefaults(suiteName: "group.com.kim.widgetProject")!.set(BREAKFAST_B, forKey: "BREAKFAST_B")
        UserDefaults(suiteName: "group.com.kim.widgetProject")!.set(LUNCH, forKey: "LUNCH")
        UserDefaults(suiteName: "group.com.kim.widgetProject")!.set(DINNER, forKey: "DINNER")
        UserDefaults(suiteName: "group.com.kim.widgetProject")!.set(STAFF, forKey: "STAFF")
        UserDefaults(suiteName: "group.com.kim.widgetProject")!.set(INTERNATIONAL, forKey: "INTERNATIONAL")
    }
}
