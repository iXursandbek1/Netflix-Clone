//
//  TitlePreviewViewController.swift
//  Netflix Clone
//
//  Created by Xursandbek Qambaraliyev on 16/08/23.
//

import UIKit
import WebKit

class TitlePreviewViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.text = "Harry poter"
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        label.text = "This is a best movie to watch as a kid"
        return label
    }()
    
    private let dowlandButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitle("Dowland", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    private let webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(webView)
        view.addSubview(titleLabel)
        view.addSubview(overviewLabel)
        view.addSubview(dowlandButton)
        
        configureConstraints()
    }
    
    func configureConstraints() {
        
        let webViewConstraints = [
            webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.heightAnchor.constraint(equalToConstant: 300)
        ]
        
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ]
        
        let overviewLabelConstraints = [
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        let downladButtonConstraints = [
            dowlandButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dowlandButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 25),
            dowlandButton.heightAnchor.constraint(equalToConstant: 40),
            dowlandButton.widthAnchor.constraint(equalToConstant: 140)
        ]
        
        NSLayoutConstraint.activate(webViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(overviewLabelConstraints)
        NSLayoutConstraint.activate(downladButtonConstraints)
    }
    
    func configure(with model: TitlePreviewViewModel) {
        
        titleLabel.text = model.title
        overviewLabel.text = model.titleOverview
        
        guard let videoID = model.youtubeVideo.id.videoID else {return}
        
        guard let url = URL(string: "https://www.youtube.com/embed/\(videoID)") else {
            return
        }
        
        webView.load(URLRequest(url: url))
    }
}
