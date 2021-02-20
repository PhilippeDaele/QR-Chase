//
//  RunView.swift
//  paperChase
//
//  Created by Philippe Van Daele on 2021-02-20.
//

import SwiftUI
import CodeScanner

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
                    CodeScannerView(codeTypes: [.qr], completion: self.handleScan)
                }
                Spacer()
            }
        }
    }
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>){
        self.isPresentingScanner = false
        
        switch result{
        case .success(let code):
            let details = code.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            
            let startCoord = details[0]
            let endCoord = details[1]
            
            print(startCoord)
            print(endCoord)
            
            
            
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