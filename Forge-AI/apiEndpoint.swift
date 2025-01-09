import Foundation

enum EndPoint: String {
    case generations
    
    func getURLForEndPoint(_ baseURL: URL) -> URL {
        return baseURL.appendingPathComponent(self.rawValue)
    }
}

import Foundation

class OpenAINetworkManager {
    static let shared = OpenAINetworkManager()
    
    private lazy var encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        return encoder
    }()
    
    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    private let baseURL = URL(string: "https://api.openai.com/v1/images/")!
    private let apiKey = "YOUR-API-KEY"
    
    func generateImage(from prompt: String, imageSize: ImageSize) async throws -> [AIImage] {
        let url = EndPoint.generations.getURLForEndPoint(baseURL)
        var request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        request.httpMethod = "POST"
        
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = OpenAIRequest(prompt: prompt, size: imageSize)
        let bodyRequest = try encoder.encode(body)
        request.httpBody = bodyRequest
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
      
        if let responseString = String(data: data, encoding: .utf8) {
            print("API Response: \(responseString)")
        }
        
        let apiResponse = try decoder.decode(OpenAIResponse.self, from: data)
        
        let aiImages: [AIImage] = apiResponse.data.compactMap { response in
            guard let url = URL(string: response.url) else { return nil }
            return AIImage(imageURL: url, prompt: prompt)
        }
        return aiImages
    }
}

struct OpenAIResponse: Decodable {
    let data: [OpenAIImageResponse]
}

struct OpenAIImageResponse: Decodable {
    let url: String
}

enum ImageSize: String, Encodable {
    case small = "256x256"
    case medium = "512x512"
    case large = "1024x1024"
}

struct OpenAIRequest: Encodable {
    let prompt: String
    let n: Int = 1
    let size: ImageSize
}

struct AIImage: Identifiable {
    let id = UUID()
    let imageURL: URL
    let prompt: String
}


