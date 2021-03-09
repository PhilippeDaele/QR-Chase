//
//  ScoreView.swift
//  paperChase
//
//  Created by Philippe Van Daele on 2021-02-22.
//

import SwiftUI

struct ScoreView: View {

    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Saves.date, ascending: false)])
    var QRResults: FetchedResults<Saves>
    
    var body: some View {
        List{
            ForEach(QRResults, id: \.self){ results in
                HStack{
                    ZStack{// Image
                        Text("\(results.steps) steps")
                            .font(.system(size: 20, weight: .medium))
                            .frame(width: 100, height: 100, alignment: .center)
                            .foregroundColor(Color.white)
                            .background(
                                LinearGradient(gradient: Gradient(colors: [Color(red: 255 / 255, green: 105 / 255, blue: 97 / 255), Color(red: 226 / 255, green: 80 / 255, blue: 75 / 255)]), startPoint: .top, endPoint: .trailing))
                            .clipShape(Circle())
                    }.frame(width: 120, height: 120, alignment: .center)
                    
                    VStack(alignment: .leading, spacing: 8){
                        HStack{
                            Image(systemName: "calendar")
                                .font(.subheadline)
                            
                            Text(changeDateFormat(date: results.date ?? Date()))
                                .bold()
                                .font(.subheadline)
                                .lineLimit(1)
                        }
                        
                        HStack{
                            Image(systemName: "timer")
                                .font(.subheadline)
                            Text(results.time ?? "HH/MM/SS")
                                .bold()
                                .font(.subheadline)
                        }
                    }
                }
            }.onDelete(perform: self.deleteItem)
        }.listStyle(DefaultListStyle())
        .navigationTitle("Scoreboard")
    }
    
    private func saveContext(){
        do {
            try viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("Unexpected Error: \(error)")
        }
    }
    
    private func deleteItem(offsets: IndexSet){
        offsets.map{QRResults[$0]}.forEach(viewContext.delete)
        saveContext()
    }
    
    func changeDateFormat(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm dd/MM-yyyy"
            
        return dateFormatter.string(from: date)
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView()
    }
}
