//
//  OnBoardingLastPageView.swift
//  widgetProject
//
//  Created by Kim Insub on 2022/05/05.
//

import SwiftUI

struct OnBoardingLastPageView: View {
    let imageName: String
        let title: String
        let subtitle: String
        
        @Binding var isFirstLaunching: Bool
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
        
            Button {
                isFirstLaunching.toggle()
            } label: {
                Text("시작하기")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(width: 200, height: 50)
                    .background(Color.blue)
                    .cornerRadius(6)
            }
            .padding()
        }
    }
}
//
//struct OnBoardingLastPageView_Previews: PreviewProvider {
//    static var previews: some View {
//        OnBoardingLastPageView()
//    }
//}
