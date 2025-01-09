import SwiftUI

struct MainView: View {
    @Binding var finalPrompt: String
    @Binding var appState: Int
    let sound = SoundManager()
    @State var alertMessage: String = ""
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
    @Binding var selectedResolution: String
    @Binding var selectedStyle: String
    @State var userPrompt: String = ""
    @State var promptLetterCount: Int = 0
    @State var selectedTheme: String = ""
    
    @State var b1Selected: Bool = false
    @State var b2Selected: Bool = false
    @State var b3Selected: Bool = false
    
    @AppStorage("isPurchased") var isPurchased: Bool = false
    @AppStorage("isSoundOn") var isSoundOn: Bool = true
    @AppStorage("isHapticsOn") var isHapticsOn: Bool = true
    @AppStorage("selectedAvatar") var selectedAvatar: String?
    
    let imagePrompts = [
        "A futuristic cityscape with towering skyscrapers and flying cars gliding between them.",
        "A majestic lion resting under an acacia tree in the golden glow of an African sunset.",
        "A tranquil Japanese garden with koi ponds, stone lanterns, and cherry blossoms in bloom.",
        "A quaint European village with cobblestone streets and colorful flowers in bloom.",
        "A majestic elephant walking through a lush savanna at sunset.",
        "A sleek spaceship traveling through a galaxy filled with colorful nebulae.",
        "A vibrant carnival scene with bright lights, rides, and people enjoying the festivities.",
        "A lush garden with blooming flowers, butterflies fluttering, and a serene pond.",
        "An ancient ruin surrounded by jungle, with vines creeping over the stones.",
        "A cozy coffee shop with people reading and a barista making latte art.",
        "A dramatic mountain landscape with clouds rolling over the peaks and valleys.",
        "A peaceful zen garden with raked sand, stones, and bonsai trees.",
        "A whimsical treehouse nestled high in the branches of a giant oak tree."
    ]
    
    let imagePromptArray: [ImagePrompt] = [
        
        
        ImagePrompt(title: "Artistic", description: "A creative and expressive image characterized by vibrant colors and imaginative forms, blending different artistic styles to inspire emotion and provoke thought in the viewer.", imageName: "artistic"),
        
        ImagePrompt(title: "Peaceful", description: "A serene and calming image that evokes tranquility, featuring soft light, harmonious colors, and gentle scenes to soothe the viewer.", imageName: "peaceful"),
                    
        ImagePrompt(title: "Cozy", description: "An image that evokes warmth and comfort, with soft textures, inviting spaces, and a peaceful ambiance that makes the viewer feel at home.", imageName: "cozy"),
        
        ImagePrompt(title: "Realistic", description: "A highly detailed, lifelike depiction capturing the nuances of light and shadow, portraying subjects with precision to evoke a sense of authenticity and realism.", imageName: "realistic"),
        
        ImagePrompt(title: "Abstract", description: "A non-representational image that emphasizes shapes, colors, and patterns, encouraging viewers to interpret meaning freely, allowing for a personal connection to the visual experience.", imageName: "abstract"),
        
        ImagePrompt(title: "Surreal", description: "A dreamlike composition that combines unexpected elements and bizarre scenarios, inviting viewers into a whimsical world where imagination reigns and reality is bent.", imageName: "surreal"),
        
        ImagePrompt(title: "Minimalist", description: "A clean and simple image that uses minimal elements to create a strong impact, emphasizing space, form, and color for a powerful visual statement.", imageName: "minimalist"),
        
        ImagePrompt(title: "Futuristic", description: "A visionary depiction of advanced technology and architecture, portraying the possibilities of tomorrow with sleek, innovative designs and a forward-thinking aesthetic.", imageName: "futuristic"),
        
        ImagePrompt(title: "Fantasy", description: "A fantastical scene filled with mythical creatures, magical elements, and epic landscapes that transport the viewer to another realm.", imageName: "fantasy"),
        
        ImagePrompt(title: "Nature", description: "A breathtaking portrayal of the natural world, capturing the beauty and wonder of forests, mountains, and wildlife.", imageName: "nature"),
        
        ImagePrompt(title: "Black and white", description: "black and white image", imageName: "blackandwhite")
        
    ]
    
    var body: some View {
        ZStack {
            accent_color_1.ignoresSafeArea()
            VStack {
                HStack{
        
                    Button(action: { appState = 8
                        if isSoundOn {
                            SoundManager.instance.playSound(sound: .click)
                        }
                    }, label: {
                        Circle()
                            .foregroundColor(.black)
                            .frame(width: 35, height: 35)
                            .overlay(
                                Group {
                                    if selectedAvatar != nil && selectedAvatar != ""{
                                        Circle()
                                            .frame(width: 35, height: 35)
                                            .foregroundColor(.blue)
                                            .overlay(
                                            Image("\(selectedAvatar ?? "")")
                                            .resizable()
                                            .scaledToFit()
                                            .clipShape(.circle)
                                            .frame(width: 35, height: 35)
                                            .foregroundColor(.blue)
                                            
                                            
                                            
                                        )
                                        
                                    } else {
                                        Image(systemName: "person.circle")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 35, height: 35)
                                            .foregroundColor(.blue)
                                    }
                                }
                            )
                    })
                    Spacer()
                    
                    Text("Forge-AI")
                        .foregroundColor(accent_color_2)
                        .font(.system(size: 50))
                        .fontDesign(.rounded)
                        .fontWeight(.bold)
                    
                    Spacer()
                    Button(action: {
                        
                        if isSoundOn {
                            SoundManager.instance.playSound(sound: .click)
                        }
                        
                        appState = 5
                    }, label: {
                        Circle()
                            .foregroundColor(.black)
                            .frame(width: 35, height: 35)
                            .overlay(
                                Image(systemName: "gear")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 35, height: 35)
                                    .foregroundColor(.blue)
                            )
                    })
                    
                    
                }.padding()
              
                    Text("Select Your Theme 🎨")
                        .font(.title)
                        .padding()
                        .fontWeight(.bold)
                        .fontDesign(.rounded)
                        .foregroundColor(.white)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(imagePromptArray, id: \.title) { prompt in
                            VStack {
                                Image(prompt.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 300, height: 300)
                                    .cornerRadius(10)
                                
                                Text(prompt.title)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                                    .fontDesign(.rounded)
                            }
                            .padding()
                            .background(
                                selectedTheme == prompt.title ?
                                ZStack{
                                    accent_color_2.ignoresSafeArea()
                                        .background(.thickMaterial)
                                }
                                
                                :
                                    
                                    ZStack{
                                        Color.black.opacity(0.9).ignoresSafeArea()
                                            .background(.thickMaterial)
                                    }
                            )
                            .cornerRadius(12)
                            .onTapGesture {
                                withAnimation {
                                    selectedTheme = prompt.title
                                    selectedStyle = ""
                                    selectedStyle = prompt.title.capitalized
                                }
                            }
                        }
                    }
                }
                
                Text("Resolution 🖥️")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .fontDesign(.rounded)
                    .font(.title)
                    .padding(.top)
                
                
                HStack{
                    Button(action: {
                        if isSoundOn {
                            SoundManager.instance.playSound(sound: .click)
                        }
                        
                        selectedResolution = "256x256"
                        b1Selected = true
                        b2Selected = false
                        b3Selected = false
                    }, label: {
                        
                        Capsule()
                            .frame(width: 70, height: 30)
                            .foregroundColor(.white)
                            .shadow(color: accent_color_2, radius: b1Selected ?  15 : 0)
                            .overlay(Text("LOW")
                                .foregroundColor(.black)
                                .fontWeight(.bold)
                                .shadow(color: .white, radius: b1Selected ? 10: 0)
                                .fontDesign(.rounded)
                            )
                    }).padding()
                    
                    
                    Button(action: {
                        if isSoundOn {
                            SoundManager.instance.playSound(sound: .click)
                        }
                        
                        selectedResolution = "512x512"
                        b2Selected = true
                        b1Selected = false
                        b3Selected = false
                    }, label: {
                        
                        Capsule()
                            .frame(width: 70, height: 30)
                            .foregroundColor(.white)
                            .shadow(color: accent_color_2, radius: b2Selected ?  15 : 0)
                            .overlay(Text("HD")
                                .foregroundColor(.black)
                                .fontWeight(.bold)
                                .shadow(color: .white, radius: b2Selected ? 10: 0)
                                .fontDesign(.rounded))
                            
                        
                    }).padding()
                   
                    
                    Button(action: {
                        if isSoundOn {
                            SoundManager.instance.playSound(sound: .click)
                        }
                        
                        selectedResolution = "1024x1024"
                        b2Selected = false
                        b1Selected = false
                        b3Selected = true
                    }, label: {
                        
                        
                        
                        Capsule()
                            .frame(width: 70, height: 30)
                            .foregroundColor(.white)
                            .shadow(color: accent_color_2, radius: b3Selected ?  15 : 0)
                            
                            .overlay(Text("PRO")
                                .foregroundColor(.black)
                                .fontWeight(.bold)
                                .shadow(color: .white, radius: b3Selected ? 10: 0)                                .fontDesign(.rounded)
                                
                            )
                        
                    }).padding()
                        
                }
                Spacer()
                
                TextField("Enter your prompt here...", text: $userPrompt, onEditingChanged: { _ in
                    promptLetterCount = letterCount(in: userPrompt)
                    
                        
                })
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.horizontal)
                .foregroundColor(.white)
                
                HStack {
                    
                    Spacer()
                    
                    Text("\(promptLetterCount)/150")
                        .font(.subheadline)
                        .foregroundColor(.white)
    
                    
                    Spacer()
                    
                    Button(action: {
                        if isSoundOn {
                            SoundManager.instance.playSound(sound: .click)
                        }
                        
                        userPrompt = imagePrompts.randomElement() ?? ""
                        promptLetterCount = letterCount(in: userPrompt)
                    }, label: {
                        Image(systemName: "dice")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.white)
                    })
                    
                    Spacer()
                                                           
                                        
                }
                .padding()
                
                Button(action: {
                    
                    if isSoundOn {
                        SoundManager.instance.playSound(sound: .click)
                    }
                    
                    guard !userPrompt.isEmpty else {
                        alertTitle = "Error"
                        alertMessage = "Please enter a prompt."
                        showAlert = true
                        return
                    }
                    finalPrompt = userPrompt + " " + selectedTheme
                    appState = 4
                }) {
                    Text("Generate Image 💣")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding()
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .background(
                            ZStack{
                                accent_color_2.ignoresSafeArea()
                                    .background(.thickMaterial)
                            }
                        )
                       
                        .cornerRadius(10)
                        
                }
                
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Okay")))
            }
        }
    }
    
    func letterCount(in text: String) -> Int {
        let count = text.count
        if count > 150 {
            alertMessage = "Prompt limit exceeded."
            alertTitle = "Over Limit"
            showAlert = true
            
            userPrompt = sliceString(userPrompt, to: 150)
        }
        return count
    }
    
    func sliceString(_ input: String, to length: Int) -> String {
        return String(input.prefix(length))
    }
}

struct ImagePrompt {
    let title: String
    let description: String
    let imageName: String
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(finalPrompt: .constant(""), appState: .constant(0), selectedResolution: .constant("HD"), selectedStyle: .constant("surreal"))
    }
}

