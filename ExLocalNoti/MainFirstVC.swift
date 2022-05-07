//
//  MainFirstVC.swift
//  ExLocalNoti
//
//  Created by 김종권 on 2022/05/07.
//

import UIKit

final class MainFirstVC: UIViewController {
  private let messageLabel: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.font = .systemFont(ofSize: 20)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    return label
  }()
  
  let message: String
  let desc: String
  
  init(message: String, desc: String) {
    self.message = message
    self.desc = desc
    super.init(nibName: nil, bundle: nil)
  }
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .systemBlue
    
    self.view.addSubview(self.messageLabel)
    NSLayoutConstraint.activate([
      self.messageLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 120),
      self.messageLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
    ])
    
    self.messageLabel.text = "메시지=\(message)" + "\n" + "디스크립션=\(desc)"
  }
}
