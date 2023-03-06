//
//  MemeService.swift
//  WidgetApp
//
//  Created by Najla on 12/09/2022.
//

import Foundation

final class MemeService {
    static let shared = MemeService()
    let url = URL(string:"https://meme-api.herokuapp.com/gimme/wholesomememes")!
    
    private init(){ }
    
    public func getMeme() async throws -> Meme{
        let (data , _) = try await URLSession.shared.data(from: url)
        
        let meme = try JSONDecoder().decode(Meme.self , from: data)
        return meme
    }
}
