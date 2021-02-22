//
//  CreateView.swift
//  paperChase
//
//  Created by Philippe Van Daele on 2021-02-20.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct CreateView: View {
    
    @State private var startLongitude = ""
    @State private var startLatitude = ""
    @State private var endLongitude = ""
    @State private var endLatitude = ""
    
    @State private var showingAlert = false
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View{
            VStack{
                Text("Enter coordinates")
                    .font(.title)
                Text("start coordinates")
                
                TextField("Longitude", text: $startLongitude)
                    .textContentType(.location)
                    .font(.title)
                    .padding(.horizontal)
                
                TextField("Latitude", text: $startLatitude)
                    .textContentType(.location)
                    .font(.title)
                    .padding([.horizontal,.bottom])
                
                Text("End coordinates")
                
                TextField("Longitude", text: $endLongitude)
                    .textContentType(.location)
                    .font(.title)
                    .padding(.horizontal)
                
                TextField("Latitude", text: $endLatitude)
                    .textContentType(.location)
                    .font(.title)
                    .padding([.horizontal,.bottom])
                
                Image(uiImage: generateQRCode(from: "\(startLongitude)\n\(startLatitude)\n\(endLongitude)\n\(endLatitude)"))
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                
               
                Button(action: {
                    showingAlert = true
                    UIImageWriteToSavedPhotosAlbum( generateQRCode(from: "\(startLongitude)\n\(startLatitude)\n\(endLongitude)\n\(endLatitude)"), nil, nil, nil)
                }) {
                    Image(systemName: "qrcode.viewfinder")
                    Text("Save!")
                    .fontWeight(.semibold)
                    .font(.title)
                }
                    .padding()
                    .foregroundColor(.white)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(40)
                
                    .alert(isPresented: $showingAlert, content: {
                        Alert(title: Text("QR code"), message: Text("QR code is now saved!"), dismissButton: .cancel())
                    })
                
            }
        }
    
    func generateQRCode(from string: String) -> UIImage {
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")

        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }

        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView()
    }
}
