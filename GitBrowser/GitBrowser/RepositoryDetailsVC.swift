//
//  RepositoryDetailsVC.swift
//  GitBrowser
//
//  Created by Prashant Rane
//  Copyright © 2019 prrane. All rights reserved.
//

import UIKit
import WebKit

class RepositoryDetailsVC: UIViewController, WKNavigationDelegate {
    var stackView: UIStackView!
    var imageView: UIImageView!
    var titleLabel: UILabel!
    var separatorLine: UIView!
    var bodyLabel: UILabel!
    var secondStackView: UIStackView!
    var starView1: UIStackView!
    var starView2: UIStackView!
    var horizontalSeparator: UIView!
    var webView: WKWebView!
    var customView: UIView!
    
  var repoDetails: RepositoryDetailsViewModel? {
    didSet {
      // FIXME: use this details to populate detail view
      debugPrint(repoDetails)
      configureView()
    }
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // Update UI as per model data
    configureView()
  }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.customView.layoutIfNeeded()
        print("heightttt: \(self.customView.frame.size.height)")
//        webView.frame = self.view.bounds
    }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  private func configureView() {
    
      
      self.stackView = UIStackView()
      stackView.axis = .vertical
      stackView.alignment = .center
      stackView.spacing = 10  // Adjust this value as needed
      stackView.translatesAutoresizingMaskIntoConstraints = false
      
      // Circular image view
      self.imageView = UIImageView()
      if let url = self.repoDetails?.avatarURL {
          CacheManager.shared.avatarImage(for: self.repoDetails?.repositoryID ?? 0 , avatarSourceURL: url) { image in
              DispatchQueue.main.async {
                  self.imageView.image = image
              }
          }
      }// Replace "your_image" with your image name
      imageView.contentMode = .scaleAspectFill
      imageView.layer.cornerRadius = imageView.frame.size.width / 2
      imageView.clipsToBounds = true
      imageView.translatesAutoresizingMaskIntoConstraints = false
      imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
      imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
      
      // Title label
      self.titleLabel = UILabel()
      titleLabel.text = self.repoDetails?.userName
      titleLabel.font = UIFont.boldSystemFont(ofSize: 18) // Adjust font and size as needed
      titleLabel.translatesAutoresizingMaskIntoConstraints = false
      
      // Separator line
      self.separatorLine = UIView()
      separatorLine.backgroundColor = UIColor.gray
      separatorLine.translatesAutoresizingMaskIntoConstraints = false
      separatorLine.heightAnchor.constraint(equalToConstant: 5).isActive = true
      
      // Body label
      self.bodyLabel = UILabel()
      bodyLabel.text = self.repoDetails?.details
      bodyLabel.numberOfLines = 0 // Allows multiple lines if needed
      bodyLabel.translatesAutoresizingMaskIntoConstraints = false
      
      // Add subviews to the stack view
      stackView.addArrangedSubview(imageView)
      stackView.addArrangedSubview(titleLabel)
      stackView.addArrangedSubview(separatorLine)
      stackView.addArrangedSubview(bodyLabel)
      
      self.starView1 = UIStackView()
      starView1.axis = .horizontal
      starView1.alignment = .center
      starView1.spacing = 10  // Adjust this value as needed
      starView1.translatesAutoresizingMaskIntoConstraints = false
      
      
      let star1ImageView = UIImageView()
      star1ImageView.contentMode = .scaleAspectFill
      star1ImageView.layer.cornerRadius = imageView.frame.size.width / 2
      star1ImageView.clipsToBounds = true
      star1ImageView.translatesAutoresizingMaskIntoConstraints = false
      star1ImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
      star1ImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
      
      let star1Label = UILabel()
      star1Label.text = "Stars \(String(describing: self.repoDetails?.forksCount ?? 0))"
      star1Label.font = UIFont.boldSystemFont(ofSize: 12) // Adjust font and size as needed
      star1Label.translatesAutoresizingMaskIntoConstraints = false
      star1ImageView.image = UIImage(named: "stars")
      
      starView1.addArrangedSubview(star1ImageView)
      starView1.addArrangedSubview(star1Label)
      
      
      self.starView2 = UIStackView()
      starView2.axis = .horizontal
      starView2.alignment = .center
      starView2.spacing = 10  // Adjust this value as needed
      starView2.translatesAutoresizingMaskIntoConstraints = false
      
      
      let star2ImageView = UIImageView()// Replace "your_image" with your image name
      star2ImageView.contentMode = .scaleAspectFill
      star2ImageView.layer.cornerRadius = imageView.frame.size.width / 2
      star2ImageView.clipsToBounds = true
      star2ImageView.translatesAutoresizingMaskIntoConstraints = false
      star2ImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
      star2ImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
      star2ImageView.image = UIImage(named: "forks")
      
      let star2Label = UILabel()
      star2Label.text = "Forks \(String(describing: self.repoDetails?.forksCount ?? 0))"
      star2Label.font = UIFont.boldSystemFont(ofSize: 12) // Adjust font and size as needed
      star2Label.translatesAutoresizingMaskIntoConstraints = false
      
      starView1.addArrangedSubview(star2ImageView)
      starView1.addArrangedSubview(star2Label)
      
      
      self.secondStackView = UIStackView()
      self.secondStackView.addArrangedSubview(starView1)
      self.secondStackView.addArrangedSubview(starView2)
      self.secondStackView.layer.borderWidth = 1.0
      self.secondStackView.layer.borderColor = UIColor.gray.cgColor
      // Add stack view to your view controller's view
      
      self.stackView.addArrangedSubview(secondStackView)
      
     
      view.addSubview(stackView)
      
      // Set constraints for the stack view
      NSLayoutConstraint.activate([
        stackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
        stackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20.0),
        stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20.0),
      ])
      
      // Create and add the custom view below the stack view
      customView = UIView()
      customView.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(customView)

      // Set constraints for the custom view below the stack view
      NSLayoutConstraint.activate([
          customView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
          customView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20.0),
          customView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20.0), // Place it below the stack view
          customView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20.0),
      ])
      
      self.webView = WKWebView()
      webView.navigationDelegate = self
      customView.addSubview(webView)

      // Set constraints for the WKWebView inside the customView
      webView.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
          webView.leadingAnchor.constraint(equalTo: customView.leadingAnchor),
          webView.trailingAnchor.constraint(equalTo: customView.trailingAnchor),
          webView.topAnchor.constraint(equalTo: customView.topAnchor),
          webView.bottomAnchor.constraint(equalTo: customView.bottomAnchor),
      ])
       // Load a web page
      
      if let readmeURL = self.repoDetails?.readmeSourceURL {
          CacheManager.shared.readmeURL(for: self.repoDetails?.repositoryID ?? 0, readmeSourceURL: readmeURL) { readmeurl in
              if let url = URL(string: readmeurl ?? "") {
                  let request = URLRequest(url: url)
                  DispatchQueue.main.async {
                      self.webView.load(request)
                  }
              }
          }
      }
  }
  
}


