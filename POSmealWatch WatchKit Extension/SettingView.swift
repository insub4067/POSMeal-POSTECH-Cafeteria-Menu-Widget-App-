//
//  SettingView.swift
//  POSmealWatch WatchKit Extension
//
//  Created by Park Sungmin on 2022/08/10.
//

import SwiftUI

struct SettingView: View {
    
    let mealList = ["조식", "간단식", "중식", "석식", "위즈덤", "더 블루힐"]
    @State var showList = [true, true, true, true, true, true]
    
    var body: some View {
        List {
            VStack(alignment: .center) {
                Text("화면에 표시하고싶은")
                Text("식단을 선택하세요")
            }
            .frame(maxWidth: .infinity)
            .frame(alignment: .center)
            .listRowBackground(EmptyView())
            
            ForEach(mealList.indices) { idx in
                Button {
                    showList[idx].toggle()
                    UserDefaults.standard.set(showList, forKey: "ShowMealList")
                } label: {
                    Text(mealList[idx])
                        .font(.headline)
                }
//                .listRowBackground(showList[idx] ? Color.yellow : Color.orange)
                .listRowBackground(RoundedRectangle(cornerRadius: 5).foregroundColor(showList[idx] ? Color.purple : Color.cardBackground))
            }
        }
        .onAppear {
            self.showList = (UserDefaults.standard.array(forKey: "ShowMealList") ?? [true, true, true, true, true, true, true]) as! [Bool]
        }
        .navigationTitle("설정")
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
