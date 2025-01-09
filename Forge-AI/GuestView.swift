
import SwiftUI
import FirebaseAuth

struct GuestView: View {
    let haptics = Haptics()
    let sound = SoundManager() 
    @Binding var appState: Int
    @AppStorage("isSoundOn") var isSoundOn: Bool = true
    
    @AppStorage("userAge") var userAge: Int = 0
    @AppStorage("userName") var userName: String = ""
    @AppStorage("userGender") var userGender: String = ""

    @State private var selectedName: String = ""
    @State private var selectedAge: Int = 18
    @State private var selectedGender: String = "Female"
    
    @AppStorage("selectedTheme") var selectedTheme: String?
    let genders = ["Male", "Female", "Other"]
    
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    var body: some View {
        ZStack {
            accent_color_1.ignoresSafeArea()
           
            VStack {
                Spacer()
                
                Text("Name:")
                    .foregroundColor(accent_color_2)
                    .font(.title)
                    .fontWeight(.bold)
                
                TextField("  Enter your name", text: $selectedName)
                    .foregroundColor(.black)
                    .frame(height: 35)
                    .background(.white)
                    .cornerRadius(10)
                    .padding([.leading, .trailing, .bottom], 50)
                
                Text("Age:")
                    .foregroundColor(accent_color_2)
                    .font(.title)
                    .fontWeight(.bold)
                
                Picker("Age", selection: $selectedAge) {
                    ForEach(1..<100, id: \.self) { age in
                        Text("\(age)")
                            .foregroundColor(accent_color_2)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(height: 150)
                .clipped()
                .padding(.horizontal, 50)
                
                Text("Gender:")
                    .foregroundColor(accent_color_2)
                    .font(.title)
                    .fontWeight(.bold)
                
                Picker("Gender", selection: $selectedGender) {
                    ForEach(genders, id: \.self) { gender in
                        Text(gender)
                            .foregroundColor(.pink)
                    }
                }
                .pickerStyle(.segmented)
                .background(Color(colorForGender(gender: selectedGender)))
                .frame(width: 250, height: 35)
                
                Button(action: {
                    verifyGuest()
                    if alertMessage.isEmpty {
                        updateUser()
                        appState = 2 
                        haptics.haptics(type: "success")
                        SoundManager.instance.playSound(sound: .click)
                    } else {
                        haptics.haptics(type: "warning")
                        showAlert = true
                    }
                }, label: {
                    RoundedRectangle(cornerRadius: 25.0)
                        .frame(width: 100, height: 40)
                        .foregroundColor(.green)
                        .padding()
                        .overlay(
                            Text("Save")
                                .foregroundColor(.black)
                        )
                })
                
                Spacer()
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Alert"), message: Text(alertMessage), dismissButton: .default(Text("Okay")))
        }
    }
    
    private func verifyGuest() {
        alertMessage = ""
        if selectedName.isEmpty {
            alertMessage = "Enter your name."
        }
        if selectedAge == 0 {
            alertMessage += "\nEnter your age."
        }
        if selectedGender.isEmpty {
            alertMessage += "\nEnter your gender."
        }
    }
    
    func updateUser() {
        userAge = selectedAge
        userName = selectedName
        userGender = selectedGender
    }
    
    private func colorForGender(gender: String) -> Color {
        switch gender {
        case "Male":
            return .blue
        case "Female":
            return .pink
        default:
            return .yellow
        }
    }
}

#Preview {
    GuestView(
        appState: .constant(12)
    )
}

