import SwiftUI


var accent_color_1: Color = .black
var accent_color_2: Color = .orange

struct ThemeView: View {
    @Binding var appState: Int
    
    let haptics = Haptics()
    let sound = SoundManager()
    
    @AppStorage("isHapticsOn") var isHapticsOn: Bool = true
    @AppStorage("isSoundOn") var isSoundOn: Bool = true
    
    @AppStorage("selectedTheme") var selectedTheme: Int = 1
    
    var body: some View {
        ZStack{
            accent_color_1.ignoresSafeArea()
            
            VStack{
                
                HStack{
                    Button(action: { appState = 2 }) {
                        Image(systemName: "chevron.backward")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.blue)
                    }
                    Spacer()
                    
                    Text("Themes")
                        .font(.system(size: 50))
                        .fontWeight(.bold)
                        .fontDesign(.rounded)
                        .foregroundColor(accent_color_2)
                    
                    Spacer()
                    
                    
                }.padding()
                
                ScrollView(){
                    VStack(spacing: 50){
                        
                       
                            
                            Button(action: {
                                
                                
                                SoundManager.instance.playSound(sound: .click)
                                    haptics.haptics(type: "success")
                                
                                changeTheme(colorCode: "default")
                                
                                appState = 2
                                
                            },
                                   label: {
                                
                               
                                    
                                    Text("Default 🛠️")
                                        .foregroundColor(.white)
                                        .font(.title)
                                        .fontWeight(.bold)
                                    
                                    Spacer()
                                    
                                    RoundedRectangle(cornerRadius: 25.0)
                                        .frame(width: 100, height: 40)
                                        .foregroundColor(.gray)
                                        .overlay(
                                            HStack(spacing: 0){
                                                Rectangle()
                                                    .foregroundColor(.black)
                                                    .frame(width: 30, height: 20)
                                                
                                                Rectangle()
                                                    .foregroundColor(.orange)
                                                    .frame(width: 30, height: 20)
                                            })
                            }
                            )
                        
                      
                           
                            Button(action: {
                                
                                
                                SoundManager.instance.playSound(sound: .click)
                                    haptics.haptics(type: "success")
                                
                                changeTheme(colorCode: "sky")
                                
                                appState = 2
                                
                            },
                                   label: {
                                
                                HStack{
                                    Text("Sky 🌌")
                                        .foregroundColor(.white)
                                        .font(.title)
                                        .fontWeight(.bold)
                                    
                                    Spacer()
                                    RoundedRectangle(cornerRadius: 25.0)
                                        .frame(width: 100, height: 40)
                                        .foregroundColor(.gray)
                                        .overlay(
                                            HStack(spacing: 0){
                                                Rectangle()
                                                    .foregroundColor(Color(red: 22/255, green: 50/255, blue: 91/255))
                                                    .frame(width: 30, height: 20)
                                                
                                                Rectangle()
                                                    .foregroundColor(Color(red: 255/255, green: 220/255, blue: 127/255))
                                                    .frame(width: 30, height: 20)
                                            })
                                }}
                            )
                        
                     
                            
                            Button(action: {
                                
                                
                                SoundManager.instance.playSound(sound: .click)
                                    haptics.haptics(type: "success")
                                
                                changeTheme(colorCode: "coffee")
                                
                                appState = 2
                                
                            },
                                   label: {
                                HStack{
                                    Text("Coffee ☕️")
                                        .foregroundColor(.white)
                                        .font(.title)
                                        .fontWeight(.bold)
                                    
                                    Spacer()
                                    
                                    RoundedRectangle(cornerRadius: 25.0)
                                        .frame(width: 100, height: 40)
                                        .foregroundColor(.gray)
                                        .overlay(
                                            HStack(spacing: 0){
                                                Rectangle()
                                                    .foregroundColor(Color(red: 26/255, green: 18/255, blue: 11/255))
                                                    .frame(width: 30, height: 20)
                                                
                                                Rectangle()
                                                    .foregroundColor(Color(red: 229/255, green: 229/255, blue: 203/255))
                                                    .frame(width: 30, height: 20)
                                            })
                                }}
                            )
                        
                      
                            
                            Button(action: {
                                
                                
                                SoundManager.instance.playSound(sound: .click)
                                    haptics.haptics(type: "success")
                                
                                changeTheme(colorCode: "vampire")
                                
                                appState = 2
                                
                            },
                                   label: {
                                HStack{
                                    Text("Vampire 🧛🏼")
                                        .foregroundColor(.white)
                                        .font(.title)
                                        .fontWeight(.bold)
                                    
                                    Spacer()
                                    
                                    RoundedRectangle(cornerRadius: 25.0)
                                        .frame(width: 100, height: 40)
                                        .foregroundColor(.gray)
                                        .overlay(
                                            HStack(spacing: 0){
                                                Rectangle()
                                                    .foregroundColor(Color(red: 0/255, green: 0/255, blue: 0/255))
                                                    .frame(width: 30, height: 20)
                                                Rectangle()
                                                    .foregroundColor(Color(red: 255/255, green: 0/255, blue: 0/255))
                                                    .frame(width: 30, height: 20)
                                            })
                                }}
                            )
                        
                        
                      
                            
                            Button(action: {
                                
                                SoundManager.instance.playSound(sound: .click)
                                    haptics.haptics(type: "success")
                                
                                changeTheme(colorCode: "nature")
                                
                                appState = 2
                                
                            },
                                   label: {
                                HStack{
                                    Text("Nature 🏔️")
                                        .foregroundColor(.white)
                                        .font(.title)
                                        .fontWeight(.bold)
                                    
                                    Spacer()
                                    
                                    RoundedRectangle(cornerRadius: 25.0)
                                        .frame(width: 100, height: 40)
                                        .foregroundColor(.gray)
                                        .overlay(
                                            HStack(spacing: 0){
                                                Rectangle()
                                                    .foregroundColor(Color(red: 26/255, green: 54/255, blue: 54/255))
                                                    .frame(width: 30, height: 20)
                                                
                                                Rectangle()
                                                    .foregroundColor(Color(red: 214/255, green: 189/255, blue: 152/255))
                                                    .frame(width: 30, height: 20)
                                            })
                                }}
                            )
                        
                    
                            
                            
                            Button(action: {
                                
                                SoundManager.instance.playSound(sound: .click)
                                    haptics.haptics(type: "success")
                                
                                changeTheme(colorCode: "royalty")
                                
                                appState = 2
                            },
                                   label: {
                                
                                HStack{
                                    Text("Royalty 🌂")
                                        .foregroundColor(.white)
                                        .font(.title)
                                        .fontWeight(.bold)
                                    
                                    Spacer()
                                    
                                    RoundedRectangle(cornerRadius: 25.0)
                                        .frame(width: 100, height: 40)
                                        .foregroundColor(.gray)
                                        .overlay(
                                            HStack(spacing: 0){
                                                Rectangle()
                                                    .foregroundColor(Color(red: 59/255, green: 30/255, blue: 84/255))
                                                    .frame(width: 30, height: 20)
                                                
                                                Rectangle()
                                                    .foregroundColor(Color(red: 238/255, green: 238/255, blue: 238/255))
                                                    .frame(width: 30, height: 20)
                                            })
                                }}
                            )
                  
                            
                            Button(action: {
                                
                                SoundManager.instance.playSound(sound: .click)
                                    haptics.haptics(type: "success")
                                
                                changeTheme(colorCode: "oldmoney")
                                
                                appState = 2
                            },
                                   label: {
                                
                                
                                HStack{
                                    Text("Old Money 💸")
                                        .foregroundColor(.white)
                                        .font(.title)
                                        .fontWeight(.bold)
                                    
                                    Spacer()
                                    
                                    RoundedRectangle(cornerRadius: 25.0)
                                        .frame(width: 100, height: 40)
                                        .foregroundColor(.gray)
                                        .overlay(
                                            HStack(spacing: 0){
                                                Rectangle()
                                                    .foregroundColor(Color(red: 36/255, green: 54/255, blue: 66/255))
                                                    .frame(width: 30, height: 20)
                                                
                                                Rectangle()
                                                    .foregroundColor(Color(red: 98/255, green: 149/255, blue: 132/255))
                                                    .frame(width: 30, height: 20)
                                            })
                                }}
                            )
                    }
                }

            }.padding()
        }
    }
    
    func changeTheme(colorCode: String){
        switch(colorCode){
        case "default":
            
            accent_color_1 = .black
            accent_color_2 = .orange
            
            selectedTheme = 1
            
        case "sky":
            
            accent_color_1 = Color(red: 22/255, green: 50/255, blue: 91/255)
            accent_color_2 = Color(red: 255/255, green: 220/255, blue: 127/255)
            
            
            selectedTheme = 2
            
        case "coffee":
            
            accent_color_1 = Color(red: 26/255, green: 18/255, blue: 11/255)
            accent_color_2 = Color(red: 229/255, green: 229/255, blue: 203/255)
            
            
            selectedTheme = 3
            
        case "vampire":
            
            accent_color_1 = Color(red: 0/255, green: 0/255, blue: 0/255)
            accent_color_2 = Color(red: 255/255, green: 0/255, blue: 0/255)
            
            selectedTheme = 4
            
        case "nature":
            
            accent_color_1 = Color(red: 26/255, green: 54/255, blue: 54/255)
            accent_color_2 = Color(red: 214/255, green: 189/255, blue: 152/255)
            
            selectedTheme = 5
            
        case "royalty":
            
            accent_color_1 = Color(red: 59/255, green: 30/255, blue: 84/255)
            accent_color_2 = Color(red: 238/255, green: 238/255, blue: 238/255)
            
            selectedTheme = 6
            
        case "oldmoney":
            
            accent_color_1 = Color(red: 36/255, green: 54/255, blue: 66/255)
            accent_color_2 = Color(red: 98/255, green: 149/255, blue: 132/255)
            
            selectedTheme = 7
            
        default:
            
            accent_color_1 = .black
            accent_color_2 = .orange
            
            selectedTheme = 1
        }
    }
}

#Preview {
    ThemeView(appState: .constant(2))
}
