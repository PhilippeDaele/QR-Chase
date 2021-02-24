//
//  stopWatchManager.swift
//  paperChase
//
//  Created by Philippe Van Daele on 2021-02-22.
//

import SwiftUI

class StopWatchManager: ObservableObject{
    @Published var mode: stopWatchMode = .stopped
    @Published var secondsElapsed = 0.00
    var timer = Timer()
    
    func start() {
        mode = .running
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true){ timer in
            self.secondsElapsed = self.secondsElapsed + 0.1
        }
    }
    
    func stop(){
        timer.invalidate()
        print(secondsElapsed)
//        secondsElapsed = 0
        mode = .stopped
    }
}

enum stopWatchMode {
    case running
    case stopped
    case paused
}
