import SwiftUI
import StoreKit

struct AvatarSelectionView: View {
    
    @StateObject var storeVM = StoreVM()
    
    let sound = SoundManager()
    @AppStorage("isSoundOn") var isSoundOn: Bool = true
    
    @State var genderPicker: Int = 1
   
    var filteredAvatars: [Avatar] {
        let gender = genderPicker == 1 ? "Female" : "Male"
        return avatarList.filter { $0.gender == gender }
    }
    @State var showSheet: Bool = false
    
    @AppStorage("isHapticsOn") var isHapticsOn: Bool = true
    @AppStorage("selectedAvatar") var selectedAvatar: String?
    @AppStorage("isPurchased") var isPurchased: Bool = false
    
    
    @Binding var unlockAvatar: Avatar
    @Binding var appState: Int
    
    @State var avatarList: [Avatar] = [
       
        Avatar(avatarName: "AvatarMaker (1)", gender: "Female", isUnlocked: true),
        Avatar(avatarName: "AvatarMaker (2)", gender: "Female", isUnlocked: false),
        Avatar(avatarName: "AvatarMaker (3)", gender: "Female", isUnlocked: true),
        Avatar(avatarName: "AvatarMaker (4)", gender: "Female", isUnlocked: false),
        Avatar(avatarName: "AvatarMaker (5)", gender: "Female", isUnlocked: true),
        Avatar(avatarName: "AvatarMaker (6)", gender: "Female", isUnlocked: false),
        Avatar(avatarName: "AvatarMaker (7)", gender: "Female", isUnlocked: false),
        Avatar(avatarName: "AvatarMaker (8)", gender: "Female", isUnlocked: true),
        Avatar(avatarName: "AvatarMaker (9)", gender: "Female", isUnlocked: false),
        Avatar(avatarName: "AvatarMaker (10)", gender: "Female", isUnlocked: true),
        Avatar(avatarName: "AvatarMaker (11)", gender: "Female", isUnlocked: true),
        Avatar(avatarName: "AvatarMaker (12)", gender: "Female", isUnlocked: true),
        Avatar(avatarName: "AvatarMaker (13)", gender: "Female", isUnlocked: false),
        Avatar(avatarName: "AvatarMaker (14)", gender: "Female", isUnlocked: true),
        Avatar(avatarName: "AvatarMaker (15)", gender: "Female", isUnlocked: false),
        Avatar(avatarName: "AvatarMaker (16)", gender: "Female", isUnlocked: false),
        Avatar(avatarName: "AvatarMaker (17)", gender: "Female", isUnlocked: true),
        Avatar(avatarName: "AvatarMaker (18)", gender: "Female", isUnlocked:
                false),
        Avatar(avatarName: "AvatarMaker (19)", gender: "Female", isUnlocked: true),
        Avatar(avatarName: "AvatarMaker (20)", gender: "Female", isUnlocked: true),
        Avatar(avatarName: "AvatarMaker (21)", gender: "Female", isUnlocked: false),
        Avatar(avatarName: "AvatarMaker (22)", gender: "Female", isUnlocked: true),
        Avatar(avatarName: "AvatarMaker (23)", gender: "Female", isUnlocked: true),
        Avatar(avatarName: "AvatarMaker (24)", gender: "Female", isUnlocked: true),
        Avatar(avatarName: "AvatarMaker (25)", gender: "Female", isUnlocked: false),
        Avatar(avatarName: "AvatarMaker (26)", gender: "Female", isUnlocked: true),
        Avatar(avatarName: "AvatarMaker (27)", gender: "Female", isUnlocked: false),
        Avatar(avatarName: "AvatarMaker (28)", gender: "Female", isUnlocked: true),
        Avatar(avatarName: "AvatarMaker (29)", gender: "Female", isUnlocked: false),
        Avatar(avatarName: "AvatarMaker (30)", gender: "Female", isUnlocked: true),
        Avatar(avatarName: "AvatarMaker (31)", gender: "Female", isUnlocked: false),
        Avatar(avatarName: "AvatarMaker (32)", gender: "Female", isUnlocked: true),
        Avatar(avatarName: "AvatarMaker (33)", gender: "Female", isUnlocked: false),
        Avatar(avatarName: "AvatarMaker (34)", gender: "Female", isUnlocked: true),
        Avatar(avatarName: "AvatarMaker (35)", gender: "Female", isUnlocked: true),
        Avatar(avatarName: "AvatarMaker (36)", gender: "Female", isUnlocked: true),
        Avatar(avatarName: "AvatarMaker (37)", gender: "Female", isUnlocked: true),
        Avatar(avatarName: "AvatarMaker (38)", gender: "Male", isUnlocked: true),
        Avatar(avatarName: "AvatarMaker (39)", gender: "Male", isUnlocked: false),
        Avatar(avatarName: "AvatarMaker (40)", gender: "Male", isUnlocked: false),
        Avatar(avatarName: "AvatarMaker (41)", gender: "Male", isUnlocked: false),
        Avatar(avatarName: "AvatarMaker (42)", gender: "Male", isUnlocked: true),
        Avatar(avatarName: "AvatarMaker (43)", gender: "Male", isUnlocked: true),
        Avatar(avatarName: "AvatarMaker (44)", gender: "Male", isUnlocked: false),
        Avatar(avatarName: "AvatarMaker (45)", gender: "Male", isUnlocked: true),
        Avatar(avatarName: "AvatarMaker (46)", gender: "Male", isUnlocked: true),
        Avatar(avatarName: "AvatarMaker (47)", gender: "Male", isUnlocked: false),
        Avatar(avatarName: "AvatarMaker (48)", gender: "Male", isUnlocked: true),
        Avatar(avatarName: "AvatarMaker (49)", gender: "Male", isUnlocked: true),
        Avatar(avatarName: "AvatarMaker (50)", gender: "Male", isUnlocked: false),
        Avatar(avatarName: "AvatarMaker (51)", gender: "Male", isUnlocked: false),
        Avatar(avatarName: "AvatarMaker (52)", gender: "Male", isUnlocked: false),
        Avatar(avatarName: "AvatarMaker (53)", gender: "Male", isUnlocked: true),
        Avatar(avatarName: "AvatarMaker (54)", gender: "Male", isUnlocked: false),
        Avatar(avatarName: "AvatarMaker (55)", gender: "Male", isUnlocked: true),
        Avatar(avatarName: "AvatarMaker (56)", gender: "Male", isUnlocked: false),
        Avatar(avatarName: "AvatarMaker (57)", gender: "Male", isUnlocked: true),
        Avatar(avatarName: "AvatarMaker (58)", gender: "Male", isUnlocked: false),
        Avatar(avatarName: "AvatarMaker (59)", gender: "Male", isUnlocked: true),
        Avatar(avatarName: "AvatarMaker (60)", gender: "Male", isUnlocked: false),
        Avatar(avatarName: "AvatarMaker (61)", gender: "Male", isUnlocked: true),
        Avatar(avatarName: "AvatarMaker (62)", gender: "Male", isUnlocked: false),
        Avatar(avatarName: "AvatarMaker (63)", gender: "Male", isUnlocked: true)
    ]
    
    let columns = [
        GridItem(.adaptive(minimum: 100)) ]
    
    
    let columnLayout = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            
            accent_color_1.ignoresSafeArea()
            
            VStack {
                HStack{
                    Button(action: { appState = 2 }) {
                        Image(systemName: "chevron.backward")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.blue)
                    }
                    Spacer()
                    
                }
                .padding()
                
                Text("Avatar Selection")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Picker("Select Gender", selection: $genderPicker) {
                    Text("Male").tag(0)
                    Text("Female").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .foregroundColor(.black)
                .background(accent_color_2)
                .padding()
                
                ScrollView {
                    LazyVGrid(columns: columnLayout, spacing: 16) {
                        ForEach(filteredAvatars) { indexedAvatar in
                            Button(action: {
                                
                                if indexedAvatar.isUnlocked || isPurchased{
                                    print("Selected \(indexedAvatar.avatarName)")
                                    selectedAvatar = indexedAvatar.avatarName
                                   
                                   
                                    appState = 2
                                }else{
                                    SoundManager.instance.playSound(sound: .click)
                                    
                                    unlockAvatar = indexedAvatar
                                        showSheet = true
                                }
                            }) {
                                if indexedAvatar.isUnlocked || isPurchased{
                                    Image(indexedAvatar.avatarName)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .clipShape(Circle())
                                        .frame(width: 100, height: 100)
                                    
                                }else{
                                    Image(indexedAvatar.avatarName)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .clipShape(Circle())
                                        .frame(width: 100, height: 100)
                                        .overlay(
                                            VStack{
                                                Spacer()
                                                HStack{
                                                    Spacer()
                                                    Image(systemName: "lock.fill")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 30, height: 30)
                                                    .foregroundColor(Color(red: 255/255, green: 87/255, blue: 51/255))}
                                            })
                                }}
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding()
            }
        }.sheet(isPresented: $showSheet){
            
            ZStack{
                Color.black.ignoresSafeArea()
                
                VStack{
                    Text("Avatar is Locked 🔒")
                        .foregroundColor(.white)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Image(unlockAvatar.avatarName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .frame(width: 200, height: 200)
                    
                    Button(action: {
                        appState = 6
                        }, label:
                            {
                        RoundedRectangle(cornerRadius: 25.0)
                            .frame(width: 200, height: 55)
                            .foregroundColor(.yellow)
                            .overlay(Text("Buy premium 🌟")
                                .foregroundColor(.white)
                                .font(.headline)
                                .fontWeight(.bold))
                    })
                    
                }
            }.presentationDetents([.medium])
                .presentationDragIndicator(.visible)
            
        }
    }
}
#Preview {
    AvatarSelectionView(unlockAvatar: .constant(Avatar(avatarName: "AVATAR(1)", gender: "MALE", isUnlocked: true)), appState: .constant(4))
}

struct Avatar: Identifiable {
    let id = UUID()
    let avatarName: String
    let gender: String
    var isUnlocked: Bool
}

