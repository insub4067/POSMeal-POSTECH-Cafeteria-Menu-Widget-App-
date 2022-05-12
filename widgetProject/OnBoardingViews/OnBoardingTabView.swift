//
//  OnBoardingTabView.swift
//  widgetProject
//
//  Created by Kim Insub on 2022/05/05.
//

import SwiftUI

struct OnBoardingTabView: View {
    
    @Binding var isFirstLaunching: Bool
    
    var body: some View {
        TabView{
            OnBoardingPageView(
                imageName: "arrow.left.arrow.right",
                title: "넘기기",
                subtitle: "총 3일치의 메뉴를 보여드립니다. 페이지를 넘겨서 확인하세요."
            )
            OnBoardingPageView(
                imageName: "gear",
                title: "설정",
                subtitle: "하단 \"위젯설정\"을 눌러 위젯에 보일 내용을 선택하세요. 선택하셨다면 위젯을 지웠다 다시 추가하세요."
            )
            OnBoardingLastPageView(
                imageName: "iphone.homebutton",
                title: "위젯",
                subtitle: "앱에 들어오지 않고도 원하는 식당의 메뉴를 확인 하실수 있습니다.",
                isFirstLaunching: $isFirstLaunching
            )
        }
        .tabViewStyle(PageTabViewStyle())
    }
}

//struct OnBoardingTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        OnBoardingTabView()
//    }
//}
