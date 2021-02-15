//
//  ContentView.swift
//  paperChase
//
//  Created by Philippe Van Daele on 2021-02-08.
//

import SwiftUI
import BottomBar_SwiftUI // external API from git
import CodeScanner


struct FrontPage: View{
    var body: some View{
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

struct newPage: View{
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

struct RunView: View {
    @State var isPresentingScanner = false
    @State var scannedCode: String?
    
    var body: some View{
        ZStack{
            Image("city")
                .resizable()
                .zIndex(0)
                .ignoresSafeArea()
                .blur(radius: 10)
            
            VStack(){
                Text("How to")
                    .font(Font.custom("GillSans", size: 33))
                    .foregroundColor(.white)
                    .italic()
                    .underline()
                    .padding()
                Spacer()
                Text("1.Press button\n2.Scan QR Code\n3.Start running\n4.Scan QR code\n5.Run ended")
                    .padding()
                    .foregroundColor(.white)
                    .font(.largeTitle)
                Spacer()
                
                // QRscanner stuff
                if self.scannedCode != nil {
                    NavigationLink("Next page", destination: NextView(), isActive: .constant(true)).hidden()
                }
                
                Button(action: {
                    self.isPresentingScanner = true
                }) {
                    Image(systemName: "qrcode.viewfinder")
                    Text("Scan!")
                    .fontWeight(.semibold)
                    .font(.title)
                }
                    .padding()
                    .foregroundColor(.white)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(40)
                .sheet(isPresented: $isPresentingScanner) {
                    self.scannerSheet
                }
                Spacer()
            }
        }
    }
    
    var scannerSheet : some View {
        CodeScannerView(
            codeTypes: [.qr],
            completion: { result in
                if case let .success(code) = result {
                    self.scannedCode = code
                    self.isPresentingScanner = false
                }
            }
        )
    }
}

struct NextView: View { // this is just for testing
    var body: some View{
        Text("Welcome to next view!")
    }
}

struct CreateView: View {
    var body: some View{
        Text("Testing2")
    }
}

struct ScoreView: View {
    var body: some View{
        Text("Testing3")
    }
}

func rulePage(){
    if let window = UIApplication.shared.windows.first {
            window.rootViewController = UIHostingController(rootView: newPage())
            window.makeKeyAndVisible()
        }
}

struct ContentView: View {
    var body: some View {
        FrontPage()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
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
