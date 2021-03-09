//
//  resultView.swift
//  paperChase
//
//  Created by Philippe Van Daele on 2021-03-03.
//

import SwiftUI
import CoreMotion

struct resultView: View {
    //Core Data variables
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [])
    var QRResults: FetchedResults<Saves>
    
    //Pedometer variables
    let pedometer = CMPedometer()
    @EnvironmentObject var DateOfNrOfSteps: numSteps
    @State var nrofSteps: Int?
    
    //Other variables
    @State var nextViewBool = false
    
    var body: some View {
        GeometryReader{ geometry in
            NavigationView{
                ZStack{
                    Image("runDone")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                        .blur(radius: 3)
                        .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                        
                    VStack(){
                        Spacer()
                        Text("Congratulations!")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                        Spacer()
                        HStack{
                            Text("Time:")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                            Text("\(timeChanger())")
                                .font(.title)
                                .foregroundColor(.white)
                        }
                        
                        Text(nrofSteps != nil ? "\(nrofSteps!) steps taken" : "data error")
                            .foregroundColor(.white)
                            .font(.title2)
                            .onAppear{
                                initializePedometer()
                            }
                        
                        Spacer()
                        
                        Button(action: {
                            addData()
                            nextViewBool = true
                        }, label: {
                            Text("Return to home!")
                                .fontWeight(.semibold)
                                .font(.title)
                        }).padding()
                        .foregroundColor(.white)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.black, Color.blue]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(15)
                        
                        if nextViewBool == true{
                            NavigationLink("Next view", destination: MainPage(), isActive:.constant(true)).hidden()
                        }
                        
                        Spacer()
                    }
                }
            }.navigationBarHidden(true)
        }
    }
    
    private func saveContext(){
        do {
            try viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("Unresolved error: \(error)")
        }
    }
    
    private func addData(){
        let newData = Saves(context: viewContext)
        newData.steps = Int64(nrofSteps ?? 9999)
        newData.date = Date()
        newData.time = timeChanger()
        newData.id = UUID()
        
        saveContext()
        print("run saved")
    }
    
    var isPedometerAvailable: Bool{
        return CMPedometer.isPedometerEventTrackingAvailable() && CMPedometer.isDistanceAvailable() && CMPedometer.isStepCountingAvailable()
    }
        
    func setPedometerData(data: CMPedometerData){
        nrofSteps = data.numberOfSteps.intValue
    }
    
    func initializePedometer(){
        if CMPedometer.isStepCountingAvailable(){
            
            pedometer.queryPedometerData(from: DateOfNrOfSteps.stepDate, to: Date()){ (pedometerData, error) in
                guard let pedometerData = pedometerData, error == nil else {
                    return print("SOMETHING WENT WRONG")
                }

                nrofSteps = pedometerData.numberOfSteps.intValue
            }
        }
        else{
            print("Pedometer is not available")
        }
    }
    
    func timeChanger() -> String {
        let seconds =  Int(DateOfNrOfSteps.stepTime!)
        let minutes = seconds / 60
        let hours = minutes / 60
        
        let result = String(Int(hours)) + ":" + String(Int(minutes % 60)) + ":" + String(Int(seconds % 60))
        
        return result
    }
}

struct resultView_Previews: PreviewProvider {
    static var previews: some View {
        resultView()
    }
}
