//
//  newPage.swift
//  paperChase
//
//  Created by Philippe Van Daele on 2021-02-20.
//

import SwiftUI

struct MainPage: View {
    var body: some View{
        GeometryReader { geometry in
            NavigationView{
                ZStack{
                    Image("city")
                        .resizable()
                        .zIndex(0)
                        .ignoresSafeArea()
                        .blur(radius: 10)
                    
                    
                    VStack{
                        Image("runningman-image")
                            .resizable()
                            .frame(width: 200, height: 200, alignment: .center)
                            
                        Text("Welcome to QR Chaser")
                            .font(Font.custom("GillSans", size: 33))
                            .foregroundColor(.white)
                            .italic()
                            .padding()
                            
                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum")
                            .padding(.horizontal)
                            .foregroundColor(.white)
                        
                        Spacer()
                    
                        HStack {
                            NavigationLink(
                                destination: RunView(),
                                label: {
                                    TabBarIcon(width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "figure.walk", tabName: "Run")
                                        .foregroundColor(.black)
                                })

                            NavigationLink(
                                destination: CreateView(),
                                label: {
                                    TabBarIcon(width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "plus", tabName: "Create")
                                        .foregroundColor(.black)
                                })
                             NavigationLink(
                                destination: ScoreView(),
                                label: {
                                    TabBarIcon(width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "list.bullet", tabName: "Score")
                                        .foregroundColor(.black)
                                })
                             
                         }
                        .frame(width: geometry.size.width, height: geometry.size.height/8)
                        .background(Color("Color").shadow(radius: 2))
                     }
                        .zIndex(1)
                        .edgesIgnoringSafeArea(.bottom)
                }
                }
                
         }
    }
}

struct TabBarIcon: View {
     
     let width, height: CGFloat
     let systemIconName, tabName: String
     
     
     var body: some View {
         VStack {
             Image(systemName: systemIconName)
                 .resizable()
                 .aspectRatio(contentMode: .fit)
                 .frame(width: width, height: height)
                 .padding(.top, 10)
             Text(tabName)
                 .font(.footnote)
             Spacer()
         }
     }
 }

struct newPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
