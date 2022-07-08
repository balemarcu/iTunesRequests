import UIKit

var urlComponents = URLComponents(string:
   "https://itunes.apple.com/search")!
urlComponents.queryItems = [
    "term": "Apple"
//    "entity": "allArtist",
//    "attribute": "allArtistTerm"
].map { URLQueryItem(name: $0.key, value: $0.value) }

Task {
    let (data, response) = try await URLSession.shared.data(from:
       urlComponents.url!)
    
    if let httpResponse = response as? HTTPURLResponse,
       httpResponse.statusCode == 200{
        data.prettyPrintedJSONString()
    }
}

extension Data {
    func prettyPrintedJSONString() {
        guard
            let jsonObject = try?
               JSONSerialization.jsonObject(with: self,
               options: []),
            let jsonData = try?
               JSONSerialization.data(withJSONObject:
               jsonObject, options: [.prettyPrinted]),
            let prettyJSONString = String(data: jsonData,
               encoding: .utf8) else {
                print("Failed to read JSON Object.")
                return
        }
        print(prettyJSONString)
    }
}

struct Media: Codable {
    let country: String
    let artistName: String
    let collectionName: String
    let trackId: Int
    
    enum CodingKeys: String, CodingKey {
        case country
        case artistName
        case collectionName
        case trackId
    }
}





