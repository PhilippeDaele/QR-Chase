//
//  runningView.swift
//  paperChase
//
//  Created by Philippe Van Daele on 2021-02-22.
//

import SwiftUI
import MapKit
import Foundation
import CodeScanner
import Combine

class numSteps: ObservableObject{
    @Published var stepDate = Date()
    @Published var stepTime: Double?
}

struct runningView: View {
    @ObservedObject var stopWatchManager = StopWatchManager()
    @EnvironmentObject var coord: coordinates
    
    //QR-variables
    @State var isPresentingScanner = false
    @State var scannedCode: String?
    
    //pedometer variables
    @EnvironmentObject var dateForNrOfSteps: numSteps
    
    var body: some View {
        GeometryReader{ geometry in
            NavigationView{
                ZStack{
                    MapManager()
                        .edgesIgnoringSafeArea(.all)
                        
                    VStack{
                        HStack{
                            Spacer()
                            
                            Text(timeChanger())
                                .font(.title)
                                .foregroundColor(.white)
                                .background(Color.black)
                                .padding()
                                .onAppear(perform: {
                                    self.stopWatchManager.start()
                                    dateForNrOfSteps.stepDate = Date()
                                })
                            Spacer()
                            
                                Button(action: {
                                    self.stopWatchManager.stop()
                                    dateForNrOfSteps.stepTime = self.stopWatchManager.returnTime()
                                    self.isPresentingScanner = true
                                } ){
                                    Image(systemName: "qrcode.viewfinder")
                                    Text("Scan!")
                                    .fontWeight(.semibold)
                                    .font(.title3)
                                }
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(LinearGradient(gradient: Gradient(colors: [Color.black, Color.blue]), startPoint: .leading, endPoint: .trailing))
                                    .cornerRadius(40)
                            
                            Spacer()
                        }
                        Spacer()
                        if self.scannedCode != nil{
                            NavigationLink("Next page", destination: resultView().environmentObject(self.coord), isActive: .constant(true)).hidden()
                        }
                        
                    }.sheet(isPresented: $isPresentingScanner){
                        CodeScannerView(codeTypes: [.qr], completion: self.handleScan)
                    }
                }
            }.navigationBarHidden(true)
        }
    }
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>){
        self.isPresentingScanner = false
        
        switch result{
        case .success(let code):
            let details = code.components(separatedBy: "\n")
            guard details.count == 4 else { return }
            
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
    
    func timeChanger() -> String {
        let seconds =  Int(stopWatchManager.secondsElapsed)
        let minutes = seconds / 60
        let hours = minutes / 60
        
        let result = String(Int(hours)) + ":" + String(Int(minutes % 60)) + ":" + String(Int(seconds % 60))
        
        return result
    }

}

struct runningView_Previews: PreviewProvider {
    static var previews: some View {
        runningView()
    }
}
