//
//  OnBoardingPageView.swift
//  widgetProject
//
//  Created by Kim Insub on 2022/05/05.
//

import SwiftUI

struct OnBoardingPageView: View {
    
    let imageName: String
    let title: String
    let subtitle: String
    
    var body: some View {
        VStack {
              Image(systemName: imageName)
                  .font(.system(size: 100))
                  .padding()
              Text(title)
                  .font(.largeTitle)
                  .fontWeight(.bold)
                  .padding()
              Text(subtitle)
                  .font(.title2)
          }
    }
}

struct OnBoardingPageView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingPageView(
            imageName: "gear", title: "위젯 설정", subtitle: "위젯에 보일 내용을 선택 후 위젯을 지웠다 추가해주세요."
        )
    }
}
