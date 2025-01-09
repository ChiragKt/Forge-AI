import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    @Binding var appState: Int
    let sound = SoundManager()
    
    @AppStorage("isSoundOn") var isSoundOn: Bool = true
    
    @State private var showAlert: Bool = false
    @AppStorage("userAge") var userAge: Int = 0
    @AppStorage("userName") var userName: String = ""
    @AppStorage("userGender") var userGender: String = ""
    @State private var alertMessage: String = ""
    @AppStorage("selectedAvatar") var selectedAvatar: String?
    
    let haptics = Haptics()
    var body: some View {
        ZStack {
            accent_color_1.ignoresSafeArea()
            
            VStack {
                HStack {
                    Button(action: { appState = 2
                        
                        if isSoundOn {
                            SoundManager.instance.playSound(sound: .click)
                        }
                        haptics.haptics(type: "light")}, label: {
                        Image(systemName: "chevron.backward")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .padding()
                            .foregroundColor(.blue)
                    })
                    Spacer()
                }
                
                Spacer()
                
                Button(action: { appState = 10
                    
                    if isSoundOn {
                        SoundManager.instance.playSound(sound: .click)
                    }
                    
                    haptics.haptics(type: "medium")}, label: {
                    
                        if selectedAvatar != nil && selectedAvatar != ""{
                            Image("\(selectedAvatar ?? "")")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                            .frame(width: 200, height: 200)
                            .overlay(
                                VStack {
                                    Spacer()
                                    HStack {
                                        Spacer()
                                        Image(systemName: "pencil.and.outline")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 30, height: 30)
                                            .foregroundColor(Color(red: 255/255, green: 87/255, blue: 51/255))
                                    }
                                }
                            )
                            .padding()
                    } else {
                        Image(systemName: "person.crop.square.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 250, height: 250)
                            .foregroundColor(.white)
                            .overlay(
                                VStack {
                                    Spacer()
                                    HStack {
                                        Spacer()
                                        Image(systemName: "pencil.and.outline")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 30, height: 30)
                                            .foregroundColor(Color(red: 255/255, green: 87/255, blue: 51/255))
                                    }
                                }
                            )
                            .padding()
                    }
                })
                
                Button(action: { appState = 12
                    
                    if isSoundOn {
                        SoundManager.instance.playSound(sound: .click)
                    }
                    haptics.haptics(type: "medium")}, label: {
                    RoundedRectangle(cornerRadius: 25.0)
                        .foregroundColor(.white)
                        .frame(width: 300, height: 55)
                        .overlay(
                            HStack {
                                Text("Name: \(userName)")
                                    .font(.title2)
                                    .foregroundColor(.black)
                                    .padding()
                                    .fontWeight(.bold)
                                Spacer()
                                Image(systemName: "pencil.and.outline")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.black)
                                    .padding()
                            }
                        )
                })
                
                Button(action: { appState = 12
                    haptics.haptics(type: "medium")}, label: {
                    RoundedRectangle(cornerRadius: 25.0)
                        .foregroundColor(.white)
                        .frame(width: 300, height: 55)
                        .overlay(
                            HStack {
                                Text("Age: \(userAge)")
                                    .font(.title2)
                                    .foregroundColor(.black)
                                    .padding()
                                    .fontWeight(.bold)
                                Spacer()
                                Image(systemName: "pencil.and.outline")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.black)
                                    .padding()
                            }
                        )
                })
                
                Button(action: {
                    
                    if isSoundOn {
                        SoundManager.instance.playSound(sound: .click)
                    }
                    
                    haptics.haptics(type: "medium")
                }, label: {
                    RoundedRectangle(cornerRadius: 25.0)
                        .foregroundColor(.white)
                        .frame(width: 300, height: 55)
                        .overlay(
                            HStack {
                                Text("Gender: \(userGender)")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                                    .padding()
                                Spacer()
                                Image(systemName: "pencil.and.outline")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.black)
                                    .padding()
                            }
                        )
                })
            Spacer()
                }
            
                Spacer()
            }.alert(isPresented: $showAlert) {
                Alert(title: Text("Alert"), message: Text(alertMessage), dismissButton: .default(Text("Okay")))
            }
        }
       
}

#Preview {
    ProfileView(
        appState: .constant(2))
}


