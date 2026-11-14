//
//  HomeServices.swift
//  MusicPlayer
//
//  Created by Sigit on 14/11/26.
//

import Foundation
import Alamofire

protocol HomeServicesProtocol {
    func getSongItunes(keyword: String?, successHandler: @escaping (([HomeSongResult])) -> Void)
}

class HomeServices: HomeServicesProtocol {
    
    
    
    func getSongItunes(keyword: String?, successHandler: @escaping (([HomeSongResult])) -> Void) {
        let url = URL(string: "https://itunes.apple.com/search?term=\(keyword ?? "pop")&entity=song")!
        
        AF.request(url)
            .validate()
            .responseDecodable(of: HomeSongModel.self) { response in
                switch response.result {
                case .success(let songs):
                    successHandler(songs.results)
                case .failure(let error):
                    print("Error: \(error)")
                }
        }
    }
}
