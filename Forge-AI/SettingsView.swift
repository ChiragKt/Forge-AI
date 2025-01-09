import SwiftUI
import FirebaseFirestore

struct SettingsView: View {
    
    @Binding var appState: Int
    
    let haptics = Haptics()
    let sound = SoundManager()
    
    @AppStorage("isHapticsOn") var isHapticsOn: Bool = true
    @AppStorage("isSoundOn") var isSoundOn: Bool = true
    @AppStorage("isSignedIn") var isSignedIn: Bool = false
    @AppStorage("firstLaunch") var firstLaunch: Bool = true
    @AppStorage("userAge") var userAge: Int = 0
    @AppStorage("userName") var userName: String = ""
    @AppStorage("userGender") var userGender: String = ""
    @AppStorage("selectedAvatar") var selectedAvatar: String?
    
    @State var showSheet: Bool = false
    @State var feedbackText: String = ""

    @StateObject var authManager = FirebaseAuthManager()
    
    
    var body: some View {
        ZStack {
            accent_color_1.ignoresSafeArea()
            
            VStack {
                HStack {
                    Button(action: {
                        appState = 2
                        haptics.haptics(type: "light")
                    }, label: {
                        Image(systemName: "chevron.backward")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.blue)
                        
                    })
                    Spacer()
                    
                    
                    Text("Settings")
                        .font(.system(size: 50))
                        .fontWeight(.bold)
                        .foregroundColor(accent_color_2)
                    
                    Spacer()
                    
                }
                ScrollView {
                    VStack {
                    
                        HStack(spacing: 0) {
                            Text("Haptics")
                                .padding()
                                .foregroundColor(.white)
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            Toggle("", isOn: $isHapticsOn)
                                .padding()
                                .tint(accent_color_2)
                                .onChange(of: isHapticsOn) { _ in
                                    if isSoundOn {
                                        SoundManager.instance.playSound(sound: .click)
                                    }
                                    if isHapticsOn {
                                        haptics.haptics(type: "success")
                                    }
                                }
                        }
                        
                        
                        HStack(spacing: 0) {
                            Text("Sound")
                                .padding()
                                .foregroundColor(.white)
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            Toggle("", isOn: $isSoundOn)
                                .padding()
                                .tint(accent_color_2)
                                .onChange(of: isSoundOn) { _ in
                                    SoundManager.instance.playSound(sound: .click)
                                        haptics.haptics(type: "success")
                                    
                                }
                        }
                        
                        HStack{
                            Button(action: { appState = 9
                                
                                SoundManager.instance.playSound(sound: .click)
                                haptics.haptics(type: "light")
                                
                            }, label: {Text("Change Theme")
                                    .padding()
                                    .foregroundColor(.white)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                
                            })
                            Spacer()
                        }
                        
                        
                        HStack{
                            Button(action: {showSheet = true
                                
                                SoundManager.instance.playSound(sound: .click)
                                haptics.haptics(type: "light")
                            }, label: {Text("Send Feedback")
                                    .padding()
                                    .foregroundColor(.white)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                
                            })
                            Spacer()
                        }
                        
                        Button(action: {
                            appState = 1
                            firstLaunch = true
                            SoundManager.instance.playSound(sound: .click)
                            haptics.haptics(type: "light")
                            
                            userName = ""
                            userGender = ""
                            userAge = 0
                            selectedAvatar = ""
                            
                            accent_color_1 = .black
                            accent_color_2 = .orange
                            
                            
                        }, label: {
                            RoundedRectangle(cornerRadius: 45)
                                .foregroundColor(accent_color_2)
                                .frame(width: 150, height: 55)
                                .overlay(Text("Sign-Out").foregroundColor(.black).font(.headline).fontWeight(.bold))
                        })
                        .padding()
                        
                        Link(destination: URL(string: "https://buymeacoffee.com/chiragkt")!) {
                            Image("buymeacoffee")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 250, height: 35)
                                .cornerRadius(10)
                        }
                    }
                }
            }
        }.sheet(isPresented: $showSheet){
            ZStack {
                Color.black.ignoresSafeArea()
                VStack {
                    
                    
                    
                    RoundedRectangle(cornerRadius: 25.0)
                        .frame(width: 150, height: 5)
                        .foregroundColor(.gray.opacity(0.7))
                        .padding(.top, 20)
                        

                    
                    Spacer()
                    
                    Text("Your feedback is invaluable!")
                        .foregroundColor(accent_color_2)
                        .font(.title)
                        .fontWeight(.bold)
                        .fontDesign(.rounded)
                    
                    
                    TextField("  Send feedback", text: $feedbackText)
                        .foregroundColor(.black)
                        .frame(height: 35)
                        .background(.white)
                        .cornerRadius(10)
                        .padding([.leading, .trailing, .bottom], 50)
                    
                    Button(action: { sendFeedback()
                        showSheet = false
                        SoundManager.instance.playSound(sound: .click)
                            haptics.haptics(type: "light")
                    }, label: {
                        RoundedRectangle(cornerRadius: 25.0)
                            .foregroundColor(accent_color_2)
                            .frame(width: 100, height: 55)
                            .padding()
                            .overlay(
                                Text("Send")
                                    .foregroundColor(.black)
                                    .font(.title3)
                                    .frame(alignment: .center)
                                    .fontWeight(.bold)
                            )
                    })
                    
                    Spacer()
                }
            }
        }.presentationDetents([.medium])
    }
    func sendFeedback() {
        guard !feedbackText.isEmpty else { return }
        let db = Firestore.firestore()
        
        let feedbackData: [String: Any] = ["feedback": feedbackText]

        db.collection("FeedbackRecieved").addDocument(data: feedbackData) { error in
            if let error = error {
                print("Error adding document: \(error.localizedDescription)")
            } else {
                print("Feedback submitted successfully.")
                feedbackText = ""
            }
        }
    }
}

#Preview {
    SettingsView(appState: .constant(2))
}

