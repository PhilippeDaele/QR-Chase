//
//  RunView.swift
//  paperChase
//
//  Created by Philippe Van Daele on 2021-02-20.
//

import SwiftUI
import CodeScanner

class coordinates: ObservableObject{
    
    @Published var startLat = 0.0
    @Published var startLong = 0.0
    @Published var endLat = 0.0
    @Published var endLong = 0.0
}


struct RunView: View {
    @State var isPresentingScanner = false
    @State var scannedCode: String?
    @StateObject var coord = coordinates()
       
    var body: some View{
        NavigationView{
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
                        CodeScannerView(codeTypes: [.qr], completion: self.handleScan)
                    }
                    
                    if self.scannedCode != nil{
                        NavigationLink("Next page", destination: runningView().environmentObject(self.coord), isActive: .constant(true)).hidden()
                    }
                    
                    Spacer()
                }
            }
        }
        .navigationBarHidden(true)
    }
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>){
        self.isPresentingScanner = false
        
        switch result{
        case .success(let code):
            let details = code.components(separatedBy: "\n")
            guard details.count == 4 else { return }
            
            coord.startLat = Double(details[0]) ?? 0
            coord.startLong = Double(details[1]) ?? 0
            coord.endLat = Double(details[2]) ?? 0
            coord.endLong = Double(details[3]) ?? 0
            
            
            let startLat = details[0]
            let startLong = details[1]
            let endLat = details[2]
            let endLong = details[3]

            let coords = startLat + "\n" + startLong + "\n" + endLat + "\n" + endLong
            scannedCode = coords
            
        case .failure(let error):
            print("Scanning failed!")
            print(error)
        }
    }
}


struct RunView_Previews: PreviewProvider {
    static var previews: some View {
        RunView()
    }
}
