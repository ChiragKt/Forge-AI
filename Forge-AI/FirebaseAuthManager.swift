import FirebaseAuth

class FirebaseAuthManager: ObservableObject {
    @Published var user: User?
    
    init() {
        self.user = Auth.auth().currentUser
    }
    
    func signIn(email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            self.user = authResult?.user
            completion(error)
        }
    }
    
    func signOut() {
        try? Auth.auth().signOut()
        self.user = nil
    }
    
    func register(email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            self.user = authResult?.user
            completion(error)
        }
    }
    
}
