import Foundation

class ImageGeneratorViewModel: ObservableObject {
    @Published var images: [AIImage] = []
    @Published var isLoading: Bool = false
    private let networkManager = OpenAINetworkManager.shared
    
    func getImagesFrom(_ prompt: String, imagSize: ImageSize) {
        isLoading = true
        Task {
            let images = try? await networkManager.generateImage(from: prompt, imageSize: imagSize)
            
            DispatchQueue.main.async {
                self.images = images ?? []
                self.isLoading = false
            }
        }
    }
}

