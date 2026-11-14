//
//  ViewController.swift
//  MusicPlayer
//
//  Created by Sigit on 14/11/26.
//

import UIKit
import SwiftAudioEx

class HomeViewController: HomeBaseViewController {
    
    private let player = AudioPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        setupListener()
    }
    
    func initTableView() {
        tableView.register(HomeMusicCell.self, forCellReuseIdentifier: HomeMusicCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupListener() {
        homeMiniView.playPauseButton.addTarget(
            self,
            action: #selector(didPlayTapped),
            for: .touchUpInside
        )
    }
    
    
    @objc func didPlayTapped() {
        let audioItem = DefaultAudioItem(audioUrl: "https://github.com/rafaelreis-hotmart/Audio-Sample-files/raw/master/sample.mp3", sourceType: .stream)
        player.load(item: audioItem, playWhenReady: true)
    }
    


}


extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeMusicCell.identifier, for: indexPath) as! HomeMusicCell
        
        return cell
    }
}


extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
