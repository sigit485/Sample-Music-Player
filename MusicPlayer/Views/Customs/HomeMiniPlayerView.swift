//
//  HomeMiniPlayerView.swift
//  MusicPlayer
//
//  Created by Sigit on 14/11/26.
//

import UIKit

class HomeMiniPlayerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        initConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initConstraint() {
        addSubview(vStackContainer)
        NSLayoutConstraint.activate([
            vStackContainer.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            vStackContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            vStackContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            vStackContainer.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
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

}
