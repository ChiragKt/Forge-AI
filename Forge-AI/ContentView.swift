import SwiftUI


struct ContentView: View {
    
    @AppStorage("selectedTheme") var selectedTheme: Int = 1
    @AppStorage("isSignedIn") var isSignedIn: Bool = false
    @AppStorage("isSoundOn") var isSoundOn: Bool = true
    @AppStorage("isHapticsOn") var isHapticsOn: Bool = true
    
    @AppStorage("firstLaunch") var firstLaunch: Bool = true
    
    @AppStorage("selectedAvatar") var selectedAvatar: String?
    
    @State var unlockAvatar: Avatar
    
    @State private var appState: Int = 1
    @State var finalPrompt: String = ""
    @State var selectedResolution: String = ".medium"
    @State var selectedStyle: String
   
    var body: some View {
        ZStack {
            
            accent_color_1.ignoresSafeArea()
            
            if appState == 1 {
                accent_color_1.ignoresSafeArea()
                VStack {
                    Spacer()
                    Text("Forge-AI")
                        .fontWeight(.black)
                        .fontDesign(.rounded)
                        .font(.system(size: 65.0))
                        .foregroundColor(accent_color_2)
        
                    Button(action: {
                        if firstLaunch {
                            appState = 7
                            firstLaunch = false
                        } else {
                            appState = 2
                        }
                    }) {
                        RoundedRectangle(cornerRadius: 25.0)
                            .frame(width: 200, height: 55)
                            .overlay(Text("Let's Go")
                                .foregroundColor(.black))
                            .fontWeight(.bold)
                            .foregroundColor(accent_color_2)
                    }
                    
                    Spacer()
                }
            } else {
                switch appState {
                case 2:
                    MainView(finalPrompt: $finalPrompt, appState: $appState, selectedResolution: $selectedResolution, selectedStyle: $selectedStyle)
                case 4:
                    ImageGenerationView(appState: $appState, finalPrompt: $finalPrompt, selectedResolution: $selectedResolution, selectedStyle: $selectedStyle)
                case 5:
                    SettingsView(appState: $appState)
                case 6:
                    PremiumView(appState: $appState)
                case 7:
                    AnimationView(appState: $appState)
                case 8:
                    ProfileView(appState: $appState)
                case 9:
                    ThemeView(appState: $appState)
                case 10:
                    AvatarSelectionView(unlockAvatar: $unlockAvatar, appState: $appState)
                case 12:
                    GuestView(appState: $appState)
                
                default:
                    EmptyView()
                }
            }
        }
    }
}

#Preview {
    ContentView(unlockAvatar: Avatar(avatarName: "", gender: "male", isUnlocked: true), selectedStyle: "surreal")
}

