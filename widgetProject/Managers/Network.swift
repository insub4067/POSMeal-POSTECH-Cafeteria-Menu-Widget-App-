//
//  Network.swift
//  widgetProject
//
//  Created by Kim Insub on 2022/05/04.
//
import SwiftUI

class Network: ObservableObject {
    
    //Define
    @Published var todaysMenus: [Menu] = []
    @Published var tomrrowsMenus: [Menu] = []
    @Published var dayAfterTomorrowMenus: [Menu] = []

    var BREAKFAST_A: [String] = []
    var BREAKFAST_B: [String] = []
    var LUNCH: [String] = []
    var DINNER: [String] = []
    var STAFF: [String] = []
    var INTERNATIONAL: [String] = []
    
    //GET DATE of TODAY || TOMORROW
    @discardableResult
    func getDate(of date: String) -> [String:String]{
        
        //Define
        let calendar = Calendar.current
        let today = Date()
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: today)!
        let dayAfterTomorrow = calendar.date(byAdding: .day, value: 2, to: today)!
        
        let dateDict: [String:Date] = [
            "today" : today,
            "tomorrow" : tomorrow,
            "dayAfterTomorrow" : dayAfterTomorrow
        ]

        let year = String(calendar.component(.year, from: dateDict[date]!))
        let month = calendar.component(.month, from: dateDict[date]!)
        let day = calendar.component(.day, from: dateDict[date]!)
        let weekday = String(calendar.component(.weekday, from: dateDict[date]!))

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
        let result = ["year": year, "month": refinedMonth, "day": refinedDay, "weekday": dayDict[weekday]!]
        UserDefaults(suiteName: "group.com.kim.widgetProject")!.set(result, forKey: "CURRENTDATE")
        
        //Return
        return result
    }
    
    //GET MENUS OF A DAY
    func getMenus(of date: String) -> Void {

        //Define
        let returnedDate = getDate(of: date)
        let year = returnedDate["year"]!
        let month = returnedDate["month"]!
        let day = returnedDate["day"]!

        //URLRequest
        guard let url = URL(string: "https://food.podac.poapper.com/v1/menus/\(year)/\(month)/\(day)") else { fatalError("Missing URL") }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"

        //URLSession
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error != nil {
//                print("Request error: ", error)
                return
            }
            guard let response = response as? HTTPURLResponse else { return }
            
            if response.statusCode == 200 {
                
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        //Decode
                        let decodedMenus = try JSONDecoder().decode([Menu].self, from: data)

                        switch date {
                        case "today":
                            self.todaysMenus = decodedMenus
                            self.saveAtUserDefaults()
                        case "tomorrow":
                            self.tomrrowsMenus = decodedMenus
                        default:
                            self.dayAfterTomorrowMenus = decodedMenus
                        }
                        
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        dataTask.resume()
    }
    //Devide Data
    func saveAtUserDefaults(){
        
        for menu in todaysMenus {
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
