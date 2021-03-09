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
    
    var QRcodeToSave: some View{
        ZStack{
            Image(uiImage: generateQRCode(from: "\(startLongitude)\n\(startLatitude)\n\(endLongitude)\n\(endLatitude)"))
                .interpolation(.none)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
        }
    }
    
    var body: some View{
        GeometryReader{ geo in
            ZStack{
               Image("running4")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    .frame(width: geo.size.width, height: geo.size.height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                ScrollView(.vertical){
                    VStack{
                        Text("Enter coordinates")
                            .font(.title)
                            .foregroundColor(.black)
                        Text("start coordinates")
                            .foregroundColor(.black)
                        
                        TextField("Longitude", text: $startLongitude)
                            .keyboardType(.numbersAndPunctuation)
                            .font(.title)
                            .padding(.horizontal)
                            .textFieldStyle(OvalTextFieldStyle())
                            
                        
                        TextField("Latitude", text: $startLatitude)
                            .keyboardType(.numbersAndPunctuation)
                            .font(.title)
                            .padding([.horizontal,.bottom])
                            .accentColor(.black)
                            .textFieldStyle(OvalTextFieldStyle())
                        
                        Text("End coordinates")
                            .foregroundColor(.black)
                        
                        TextField("Longitude", text: $endLongitude)
                            .keyboardType(.numbersAndPunctuation)
                            .font(.title)
                            .padding(.horizontal)
                            .accentColor(.black)
                            .textFieldStyle(OvalTextFieldStyle())
                        
                        TextField("Latitude", text: $endLatitude)
                            .keyboardType(.numbersAndPunctuation)
                            .font(.title)
                            .padding([.horizontal,.bottom])
                            .accentColor(.black)
                            .textFieldStyle(OvalTextFieldStyle())
                        
                        Image(uiImage: generateQRCode(from: "\(startLongitude)\n\(startLatitude)\n\(endLongitude)\n\(endLatitude)"))
                            .interpolation(.none)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                        
                        Button(action: {
                            showingAlert = true
                            QRcodeToSave.saveAsImage(width: 200, height: 200) { image in
                                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                            }
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
                                Alert(title: Text("QR code"), message: Text("QR code is now saved!"), dismissButton: .cancel(Text("OK!")))
                            })
                    }
                }
            }
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

struct OvalTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(2)
            .background(LinearGradient(gradient: Gradient(colors: [Color.gray, Color.gray]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(10)
            .shadow(color: .gray, radius: 10)
    }
}


extension View {
    func saveAsImage(width: CGFloat, height: CGFloat, _ completion: @escaping (UIImage) -> Void) {
        let size = CGSize(width: width, height: height)
        
        let controller = UIHostingController(rootView: self.frame(width: width, height: height))
        controller.view.bounds = CGRect(origin: .zero, size: size)
        let image = controller.view.asImage()
        
        completion(image)
    }
}

extension UIView {
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: self.bounds.size)
        return renderer.image { ctx in
            self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        }
    }
}


struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView()
    }
}
