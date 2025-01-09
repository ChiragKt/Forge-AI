import SwiftUI

struct AnimationView: View {
    @State private var scale: CGFloat = 0.1
    @State private var showText1 = false
    @State private var showText2 = false
    @State private var showText3 = false
    
    @Binding var appState: Int
    
    var body: some View {
        ZStack {
            Color.orange
                .edgesIgnoringSafeArea(.all)
           
            Circle()
                .fill(Color.black)
                .scaleEffect(scale)
                .onAppear {
                    withAnimation(.easeInOut(duration: 4.0)) {
                        scale = 10.0
                    }
                    
                   
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        withAnimation {
                            showText1 = true
                        }
                        
                      
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
                            withAnimation {
                                showText1 = false
                                showText2 = true
                            }
                            
                           
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                                withAnimation {
                                    showText2 = false
                                    showText3 = true
                                }
                                
                               
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                   appState = 2
                                }
                            }
                        }
                    }
                }
                .frame(width: 200, height: 200)

           
            if showText1 {
                Text("Welcome")
                    .font(.largeTitle)
                    .foregroundColor(.orange)
                    .transition(.opacity)
                    .fontWeight(.bold)
                    .fontDesign(.rounded)
                    .shadow(color: .orange, radius: 3)
            }
            if showText2 {
                Text("To")
                    .font(.largeTitle)
                    .foregroundColor(.orange)
                    .transition(.opacity)
                    .fontWeight(.bold)
                    .fontDesign(.rounded)
                    .shadow(color: .orange, radius: 3)
            }
            if showText3 {
                Text("Forge-AI")
                    .font(.system(size: 55))
                    .foregroundColor(.orange)
                    .transition(.opacity)
                    .fontWeight(.bold)
                    .fontDesign(.rounded)
                    .shadow(color: .orange, radius: 3)
            }
        }
    }
}

struct AnimationView_Previews: PreviewProvider {
    @State static var appState: Int = 1
    
    static var previews: some View {
        AnimationView(appState: $appState)
    }
}

