//
//  HomeMiniPlayerView.swift
//  MusicPlayer
//
//  Created by Sigit on 14/11/26.
//

import UIKit

enum HomeMiniState {
    case play
    case paused
    case stopped
}

class HomeMiniPlayerView: UIView {
    
    let currentState: HomeMiniState = .stopped

    override init(frame: CGRect) {
        super.init(frame: frame)
        initConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupState(_ state: HomeMiniState) {
        switch state {
        case .play:
            playPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        case .paused:
            playPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        case .stopped:
            playPauseButton.setImage(UIImage(systemName: "stop.fill"), for: .normal)
        }
    }
    
    private func initConstraint() {
        addSubview(vStackContainer)
        NSLayoutConstraint.activate([
            vStackContainer.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            vStackContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            vStackContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            vStackContainer.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
        
        addSubview(slider)
        NSLayoutConstraint.activate([
            slider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            slider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            slider.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
    
    lazy var vStackContainer : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 10, left: 20, bottom: 20, right: 20)
        stack.addArrangedSubview(hStackAction)
        return stack
    }()
    
    lazy var hStackAction: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 20
        stack.addArrangedSubview(backwardButton)
        stack.addArrangedSubview(playPauseButton)
        stack.addArrangedSubview(forwardButton)
        return stack
    }()
    
    lazy var backwardButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "backward.end.alt.fill"), for: .normal)
        
//        button.addTarget(self, action: #selector(), for: .touchUpInside)
        return button
    }()
    
    lazy var playPauseButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        return button
    }()
    
    lazy var forwardButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "forward.end.alt.fill"), for: .normal)
        return button
    }()
    
    lazy var slider: UISlider = {
        let view = UISlider()
        view.minimumTrackTintColor = .systemBlue
        view.maximumTrackTintColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 6).isActive = true
        return view
    }()

}
