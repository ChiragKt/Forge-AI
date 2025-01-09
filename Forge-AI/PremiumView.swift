import SwiftUI
import StoreKit

struct PremiumView: View {
    @StateObject var storeVM = StoreVM()
    @Binding var appState: Int
    @AppStorage("isPurchased") var isPurchased = false
    @AppStorage("isSignedIn") var isSignedIn: Bool = false
    @State var subscriptionSegmentation: Int = 1
    

    
    let darkGreen = Color(red: 0.0, green: 0.39, blue: 0.0)
    let basicPlan: [String: Bool] = ["Save/Download Images": false, "Superfast processing": false, "No watermark": true , "150 Generations/Day": true, "Premium AI Models": true,  "Ad-Free": true]
    
    let professionalPlan: [String: Bool] = ["Save/Download Images": true, "Superfast processing": true, "No watermark": true , "150 Generations/Day": true, "Premium AI Models": true,  "Ad-Free": true]
    
    let columns = Array(repeating: GridItem(.flexible()), count: 8)
    
    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea()
            VStack{
                HStack{
                    Button(action: {
                        appState = 2
                    
                        
                    }, label: {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 20)
                            .foregroundColor(.blue)
                    }).padding()
                    Spacer()
                    Picker("Subscripion", selection: $subscriptionSegmentation){
                        Text("Weekly").tag(1)
                        Text("Yearly").tag(2)
                    }.pickerStyle(.segmented)
                        .background(.orange)
                        .frame(width: 200, height: 30)
                        .cornerRadius(100.0)
                    
                    Spacer()
                }
                Spacer()
                if subscriptionSegmentation == 1{
                    VStack{
                        ScrollView(.horizontal){
                            HStack{
                                RoundedRectangle(cornerRadius: 25.0)
                                    .foregroundColor(.white)
                                    .frame(width: UIScreen.main.bounds.width - 70, height: UIScreen.main.bounds.height - 200)
                                
                                    .overlay(
                                        VStack{
                                            Text("Basic")
                                                .foregroundColor(.indigo)
                                                .font(.system(size: 50))
                                                .fontDesign(.rounded)
                                                .fontWeight(.bold)
                                                .padding(.top)
                                            
                                            
                                            ForEach(basicPlan.keys.sorted(), id: \.self){
                                                key in
                                                
                                                if let value = basicPlan[key] {
                                                    
                                                    HStack{
                                                        Text("\(key)")
                                                            .foregroundColor(.black)
                                                            .font(.title2)
                                                            .fontWeight(.bold)
                                                            .fontDesign(.rounded)
                                                        
                                                        Spacer()
                                                        
                                                        if value{
                                                            Image(systemName: "checkmark.seal.fill")
                                                                .resizable()
                                                                .scaledToFit()
                                                                .foregroundColor(.green)
                                                                .frame(width: 30, height: 30)
                                                            
                                                        }else{
                                                            Image(systemName: "xmark.seal")
                                                                    .resizable()
                                                                .scaledToFit()
                                                                .foregroundColor(.red)
                                                                .frame(width: 30, height: 30)
                                                        }
                                                    }
                                                }
                                            }.padding()
                                            
                                            Spacer()
                                            
                                            Text("Only $2.99")
                                                .foregroundColor(darkGreen)
                                                .font(.title)
                                                .fontWeight(.bold)
                                                .fontDesign(.rounded)
                                            
                                            Button(action: {
                                               
                                                Task {
                                                    if let product = storeVM.getProductById("subscription.weekly.basic") {
                                                        await buy(product: product)
                                                    } else {
                                                        print("Product not found")
                                                    }
                                                }
                                                
                                            }, label: {
                                                RoundedRectangle(cornerRadius: 25.0)
                                                    .foregroundColor(.indigo)
                                                    .overlay(
                                                        VStack{
                                                            Text("Subscribe")
                                                                .foregroundColor(.white)
                                                                .font(.largeTitle)
                                                                .fontWeight(.bold)
                                                                .fontDesign(.rounded)
                                                            
                                                        })
                                                
                                                
                                            })
                                        }
                                    )
                                RoundedRectangle(cornerRadius: 25.0)
                                    .foregroundColor(.white)
                                    .frame(width: UIScreen.main.bounds.width - 70
                                           ,height: UIScreen.main.bounds.height - 200)
                                    .overlay(
                                        VStack{
                                            Text("Professional")
                                                .foregroundColor(.orange)
                                                .font(.system(size: 50))
                                                .fontDesign(.rounded)
                                                .fontWeight(.bold)
                                                .padding(.top)
                                            
                                            
                                            ForEach(professionalPlan.keys.sorted(), id: \.self){
                                                key in
                                                
                                                if let value = professionalPlan[key] {
                                                    
                                                    HStack{
                                                        Text("\(key)")
                                                            .foregroundColor(.black)
                                                            .font(.title2)
                                                            .fontWeight(.bold)
                                                            .fontDesign(.rounded)
                                                        
                                                        Spacer()
                                                        if value{
                                                            Image(systemName: "checkmark.seal.fill")
                                                                .resizable()
                                                                .scaledToFit()
                                                                .foregroundColor(.green)
                                                                .frame(width: 30, height: 30)
                                                            
                                                        }else{
                                                            Image(systemName: "xmark.seal")
                                                                .resizable()
                                                                .scaledToFit()
                                                                .foregroundColor(.red)
                                                                .frame(width: 30, height: 30)
                                                        }
                                                    }
                                                }
                                            }.padding()
                                            
                                            
                                            
                                            Spacer()
                                            
                                            
                                            Text("Only $5.99")
                                                .foregroundColor(darkGreen)
                                                .font(.title)
                                                .fontWeight(.bold)
                                                .fontDesign(.rounded)
                                            
                                            Button(action: {
                                             
                                                Task {
                                                    
                                                    if let product = storeVM.getProductById("subscription.weekly.professional") {
                                                        await buy(product: product)
                                                    } else {
                                                        print("Product not found")
                                                    }
                                                }
                                                
                                            }, label: {
                                                RoundedRectangle(cornerRadius: 25.0)
                                                    .foregroundColor(.orange)
                                                    .overlay(
                                                        VStack{
                                                            Text("Subscribe")
                                                                .foregroundColor(.white)
                                                                .font(.largeTitle)
                                                                .fontWeight(.bold)
                                                                .fontDesign(.rounded)
                                                            
                                                        })
                                            })
                                        }
                                    )
                            }
                        }
                        
                    }
                }else{
                    VStack{
                        ScrollView(.horizontal){
                            HStack{
                                RoundedRectangle(cornerRadius: 25.0)
                                    .foregroundColor(.white)
                                    .frame(width: UIScreen.main.bounds.width - 70, height: UIScreen.main.bounds.height - 200)
                                
                                    .overlay(
                                        VStack{
                                            Text("Basic")
                                                .foregroundColor(.indigo)
                                                .font(.system(size: 50))
                                                .fontDesign(.rounded)
                                                .fontWeight(.bold)
                                                .padding(.top)
                                            
                                            
                                            ForEach(basicPlan.keys.sorted(), id: \.self){
                                                key in
                                                
                                                if let value = basicPlan[key] {
                                                    
                                                    HStack{
                                                        Text("\(key)")
                                                            .foregroundColor(.black)
                                                            .font(.title2)
                                                            .fontWeight(.bold)
                                                            .fontDesign(.rounded)
                                                        
                                                        Spacer()
                                                        
                                                        if value{
                                                            Image(systemName: "checkmark.seal.fill")
                                                                .resizable()
                                                                .scaledToFit()
                                                                .foregroundColor(.green)
                                                                .frame(width: 30, height: 30)
                                                            
                                                        }else{
                                                            Image(systemName: "xmark.seal")
                                                                .resizable()
                                                                .scaledToFit()
                                                                .foregroundColor(.red)
                                                                .frame(width: 30, height: 30)
                                                        }
                                                    }
                                                }
                                            }.padding()
                                            
                                            Spacer()
                                            
                                            Text("Only $29.99")
                                                .foregroundColor(darkGreen)
                                                .font(.title)
                                                .fontWeight(.bold)
                                                .fontDesign(.rounded)
                                            
                                            Button(action:
                                            
                                                   {
                                                Task {
                                                    if let product = storeVM.getProductById("subscription.yearly.basic") {
                                                        await buy(product: product)
                                                    } else {
                                                        print("Product not found")
                                                    }
                                                }
                                            }, label: {
                                                RoundedRectangle(cornerRadius: 25.0)
                                                    .foregroundColor(.indigo)
                                                    .overlay(
                                                        VStack{
                                                            Text("Subscribe")
                                                                .foregroundColor(.white)
                                                                .font(.largeTitle)
                                                                .fontWeight(.bold)
                                                                .fontDesign(.rounded)
                                                            
                                                        })
                                                
                                                
                                            })
                                        }
                                    )
                                RoundedRectangle(cornerRadius: 25.0)
                                    .foregroundColor(.white)
                                    .frame(width: UIScreen.main.bounds.width - 70
                                           ,height: UIScreen.main.bounds.height - 200)
                                    .overlay(
                                        VStack{
                                            Text("Professional")
                                                .foregroundColor(.orange)
                                                .font(.system(size: 50))
                                                .fontDesign(.rounded)
                                                .fontWeight(.bold)
                                                .padding(.top)
                                            
                                            
                                            ForEach(professionalPlan.keys.sorted(), id: \.self){
                                                key in
                                                
                                                if let value = professionalPlan[key] {
                                                    
                                                    HStack{
                                                        Text("\(key)")
                                                            .foregroundColor(.black)
                                                            .font(.title2)
                                                            .fontWeight(.bold)
                                                            .fontDesign(.rounded)
                                                        
                                                        Spacer()
                                                        if value{
                                                            Image(systemName: "checkmark.seal.fill")
                                                                .resizable()
                                                                .scaledToFit()
                                                                .foregroundColor(.green)
                                                                .frame(width: 30, height: 30)
                                                            
                                                        }else{
                                                            Image(systemName: "xmark.seal")
                                                                .resizable()
                                                                .scaledToFit()
                                                                .foregroundColor(.red)
                                                                .frame(width: 30, height: 30)
                                                        }
                                                    }
                                                }
                                            }.padding()
                                            
                                            Spacer()
 
                                            Text("Only $89.99")
                                                .foregroundColor(darkGreen)
                                                .font(.title)
                                                .fontWeight(.bold)
                                                .fontDesign(.rounded)
                                            
                                            Button(action: {
                                                
                                                Task {
                                                    if let product = storeVM.getProductById("subscription.yearly.professional") {
                                                        await buy(product: product)
                                                    } else {
                                                        print("Product not found")
                                                    }
                                                }
                                            }, label: {
                                                RoundedRectangle(cornerRadius: 25.0)
                                                    .foregroundColor(.orange)
                                                    .overlay(
                                                        VStack{
                                                            
                                                            Text("Subscribe")
                                                                .foregroundColor(.white)
                                                                .font(.largeTitle)
                                                                .fontWeight(.bold)
                                                                .fontDesign(.rounded)
                                                            
                                                            
                                                        })

                                            })
 
                                        })}}
                    }
                    
                }
                HStack{
                    Text("Cancel Anytime")
                        .foregroundColor(.white)
                        .font(.caption2)
                        .fontWeight(.bold)
                    Image(systemName: "smallcircle.filled.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.white)
                        .frame(width: 10, height: 10)
                    Text("Privacy Policy")
                        .foregroundColor(.white)
                        .font(.caption2)
                        .fontWeight(.bold)
                    
                    Image(systemName: "smallcircle.filled.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.white)
                        .frame(width: 10, height: 10)
                    
                    
                    Text("Terms of use")
                        .foregroundColor(.white)
                        .font(.caption2)
                        .fontWeight(.bold)
                    
                }.padding()
            }
            
        }
    }
    func buy(product: Product) async {
        if isSignedIn {
            do {
                
                let purchaseResult = try await storeVM.purchase(product)
                if purchaseResult != nil {
                    isPurchased = true
                    appState = 2
                    print("Purchase successful: \(product.id)")
                } else {
                    print("Purchase was not completed")
                }
            } catch let purchaseError {
                
                print("Purchase failed with error: \(purchaseError.localizedDescription)")
            }
        } else {
            
            appState = 2
            print("User is not signed in, appState updated to 2")
        }
    }
}

#Preview {
    PremiumView(appState: .constant(2))
}


