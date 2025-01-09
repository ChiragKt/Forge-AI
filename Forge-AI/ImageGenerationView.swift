import SwiftUI

struct ImageGenerationView: View {
    @StateObject var imageViewModel = ImageGeneratorViewModel()
    
    @AppStorage("isHapticsOn") var isHapticsOn: Bool = true
    @AppStorage("isSoundOn") var isSoundOn: Bool = true
    @AppStorage("isSignedIn") var isSignedIn: Bool = false
    let sound = SoundManager()
    @State var generatedImage: UIImage?
    @Binding var appState: Int
    @Binding var finalPrompt: String
    @Binding var selectedResolution: String
    @Binding var selectedStyle: String
    
    
    
    var body: some View {
        ZStack {
            accent_color_1.ignoresSafeArea()
            
            VStack {
                HStack {
                    Button(action: {
                        appState = 2
                        
                       
                    }, label: {
                        Image(systemName: "chevron.backward")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.blue)
                            .padding()
                    })
                    Spacer()
                    
                }
                Spacer()
                
                
                if selectedStyle == ""{
                    Text("Selected Style: None)")
                        .font(.title)
                        .foregroundColor(accent_color_2)
                        .fontWeight(.bold)
                }else{
                    Text("Selected Style: \(selectedStyle)")
                        .font(.title)
                        .foregroundColor(accent_color_2)
                        .fontWeight(.bold)
                }
                
                
                Text("Selected Resolution: \(selectedResolution)")
                    .font(.title)
                    .foregroundColor(accent_color_2)
                    .fontWeight(.bold)
                
                
                RoundedRectangle(cornerRadius: 25.0)
                    .frame(width: 350, height: 350)
                    .foregroundColor(.gray)
                    .overlay(
                        Group {
                            if imageViewModel.isLoading {
                                ProgressView()
                                
                            } else if let firstImage = imageViewModel.images.first {
                                AsyncImage(url: firstImage.imageURL) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .onAppear {
                                                if let uiImage = image as? UIImage {
                                                    generatedImage = uiImage
                                                }
                                            }

                                    case .failure:
                                        Image(systemName: "photo")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .foregroundColor(.red)
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                            }
                        }
                    )
    
                if imageViewModel.isLoading{
                    Text("We are working on your image... 😋")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.title3 )
                        .fontDesign(.rounded)
                }
                Spacer()
                Button(action: {
                    let imageSize = ImageSize(rawValue: selectedResolution) ?? .medium
                    imageViewModel.getImagesFrom(finalPrompt, imagSize: imageSize)
                    
                    
                }, label: {
                    RoundedRectangle(cornerRadius: 25.0)
                        .foregroundColor(accent_color_2)
                        .frame(width: 150, height: 55)
                        .overlay(
                            Text(imageViewModel.isLoading ? "Generating..." : "Generate 💣")
                                .foregroundColor(.black)
                                .fontWeight(.bold)
                                .fontDesign(.rounded)
                        )
                })
            }
        }
    }
}

#Preview {
    ImageGenerationView(
        appState: .constant(2),
        finalPrompt: .constant("Red wooden toy car"),
        selectedResolution: .constant("medium"), selectedStyle: .constant("surreal")
    )
}

