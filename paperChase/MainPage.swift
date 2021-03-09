//
//  newPage.swift
//  paperChase
//
//  Created by Philippe Van Daele on 2021-02-20.
//

import SwiftUI

struct MainPage: View {
    var body: some View{
        GeometryReader{ geometry in
            NavigationView{
                ZStack{
                    Image("running1")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height+200, alignment: .center)
                        
                    VStack{
                        Spacer()
                            
                        Text("Welcome to QR Chaser")
                            .font(Font.custom("GillSans", size: 33))
                            .foregroundColor(.white)
                            .italic()
                            
                        Spacer()
                        
                        VStack{
                            NavigationLink(destination: RunView()){
                                Image(systemName: "figure.walk")
                                    .font(.system(size: 40, weight: .medium))
                                    .frame(width: 100, height: 100)
                                    .foregroundColor(Color.black)
                                    .background(Color(red: 19 / 255, green: 64 / 255, blue: 116 / 255))
                                    .clipShape(Circle())
                            }
                            .isDetailLink(false)
                            
                            Text("Run")
                                .font(.title3)
                                .foregroundColor(.white)
                        }
                                
                        HStack{
                            Spacer()
                            VStack{
                                NavigationLink(destination: CreateView()){
                                    Image(systemName: "plus")
                                        .font(.system(size: 40, weight: .medium))
                                        .frame(width: 100, height: 100)
                                        .foregroundColor(Color.black)
                                        .background(Color(red: 141 / 255, green: 169 / 255, blue: 196 / 255))
                                        .clipShape(Circle())
                                }
                                .isDetailLink(false)
                                
                                
                                
                                Text("Create")
                                    .font(.title3)
                                    .foregroundColor(.white)
                            }
                            
                            Spacer()
                            
                            VStack{
                                NavigationLink(destination: ScoreView()){
                                    Image(systemName: "list.bullet")
                                        .font(.system(size: 40, weight: .medium))
                                        .frame(width: 100, height: 100)
                                        .foregroundColor(Color.black)
                                        .background(Color(red: 238 / 255, green: 244 / 255, blue: 237 / 255))
                                        .clipShape(Circle())
                                }
                                .isDetailLink(false)
                                
                                Text("Score")
                                    .font(.title3)
                                    .foregroundColor(.white)
                            }
                            Spacer()
                        }
                        Spacer()
                    }
                }
            }.navigationBarHidden(true)
        }
    }
}

struct newPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
