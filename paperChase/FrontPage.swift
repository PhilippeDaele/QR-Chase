//
//  FrontPage.swift
//  paperChase
//
//  Created by Philippe Van Daele on 2021-02-20.
//

import SwiftUI

struct FrontPage: View {
    var body: some View {
        ZStack{
            LoopingPlayer()
                .ignoresSafeArea()
                
            VStack(){
                Image("runningman-image")
                    .resizable()
                    .frame(width: 300, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                Text("QR Chaser")
                    .font(.title)
                    .foregroundColor(.white)
                }
                    
            VStack(){
                Spacer()
                    .frame(height:500)
                HStack{
                    Button(action: rulePage) {
                        Text("Start the game!")
                        .fontWeight(.semibold)
                        .font(.title)
                    }
                        .padding()
                        .foregroundColor(.white)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(40)
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
