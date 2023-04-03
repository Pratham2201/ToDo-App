//
//  ApiCallViewModel.swift
//  Todo
//
//  Created by Pratham Gupta on 30/03/23.
//

import Foundation

// {"id":1,"name":"Quatar Airways","country":"Quatar","logo":"https://upload.wikimedia.org/wikipedia/en/thumb/9/9b/Qatar_Airways_Logo.svg/300px-Qatar_Airways_Logo.svg.png","slogan":"Going Places Together","head_quaters":"Qatar Airways Towers, Doha, Qatar","website":"www.qatarairways.com","established":"1994"}

struct Airlines : Decodable {
    let id: Decimal?
    let name: String?
    let country: String?
    let logo: String?
    let slogan: String?
    let head_quaters: String?
    let website: String?
    let established: String?
}

class ApiCallViewModel {
    
    func getAirlinesData() {
        
        let urlString = "https://api.instantwebtools.net/v1/airlines"
        guard let url = URL(string: urlString) else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        let session = URLSession.shared.dataTask(with: urlRequest, completionHandler: { data, response, error in
            
            let statusCode = (response as? URLResponse)
            
            let decoder = JSONDecoder()
            
            if let safeData = data {
                do {
                    let decodedData = try decoder.decode([Airlines].self, from: safeData)
                    print(decodedData[0].id!)
                } catch {
                    print("Error occured in APi cAll")
                }
            }
        })
        session.resume()
    }
}
