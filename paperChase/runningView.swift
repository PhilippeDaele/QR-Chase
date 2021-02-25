//
//  runningView.swift
//  paperChase
//
//  Created by Philippe Van Daele on 2021-02-22.
//

import SwiftUI
import MapKit

struct runningView: View {
    
    @ObservedObject var stopWatchManager = StopWatchManager()
    @Binding var scannedCode: String?
    
    var body: some View {
        VStack{
            Text(String(format: "%.1f", stopWatchManager.secondsElapsed))
                .font(.largeTitle)
                .padding(.top, 200)
                .padding(.bottom, 100)
                .onAppear(perform: {
                    self.stopWatchManager.start()
                })
            
            if stopWatchManager.mode == .running{
                Button(action: { self.stopWatchManager.stop() } ){
                    TimerButton(label: "Stop", ButtonColor: .red)
                }
                
                if stopWatchManager.mode == .stopped{
                    Button(action: { self.stopWatchManager.start() } ){
                        TimerButton(label: "Start", ButtonColor: .blue)
                    }
                }
            }
            
            MapManager()
                .frame(width: 500, height: 500, alignment: .center)
                .padding(.top, 60)
            
            Spacer()
        }
    }
}

struct TimerButton: View{
    let label: String
    let ButtonColor: Color
    
    var body: some View{
        Text(label)
            .foregroundColor(.white)
            .padding(.vertical, 20)
            .padding(.horizontal, 90)
            .background(ButtonColor)
            .cornerRadius(10)
    }
}

struct runningView_Previews: PreviewProvider {
    static var previews: some View {
        runningView(scannedCode: .constant("0"))
    }
}
