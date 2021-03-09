//
//  FrontPage.swift
//  paperChase
//
//  Created by Philippe Van Daele on 2021-02-20.
//

import SwiftUI

struct FrontPage: View {
    var body: some View {
        NavigationView{
            ZStack{
                LoopingPlayer()
                    .ignoresSafeArea()
                    
                VStack{
                    Image("runningman-image")
                        .resizable()
                        .frame(width: 200, height: 200, alignment: .center)
                    
                    Text("QR Chaser")
                        .font(.title)
                        .foregroundColor(.white)
                        
                    Spacer()
                    NavigationLink(destination: MainPage()) {
                            Text("Start the game!")
                                .fontWeight(.semibold)
                                .font(.title)
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.gray, Color.gray]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(15)
                    
                    Spacer()
                }
            }
        }
    }
}

struct FrontPage_Previews: PreviewProvider {
    static var previews: some View {
        FrontPage()
    }
}
