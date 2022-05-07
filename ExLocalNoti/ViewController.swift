//
//  ViewController.swift
//  ExLocalNoti
//
//  Created by 김종권 on 2022/05/07.
//

import UIKit

class ViewController: UIViewController {
  private let button: UIButton = {
    let button = UIButton()
    button.setTitle("노티", for: .normal)
    button.setTitleColor(.systemBlue, for: .normal)
    button.setTitleColor(.blue, for: .highlighted)
    button.addTarget(self, action: #selector(requestNoti), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  private let label: UILabel = {
    let label = UILabel()
    label.text = "login 화면"
    label.textColor = .black
    label.font = .systemFont(ofSize: 30)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
      
    self.view.backgroundColor = .white
    self.view.addSubview(self.button)
    self.view.addSubview(self.label)
    NSLayoutConstraint.activate([
      self.button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
      self.button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
    ])
    NSLayoutConstraint.activate([
      self.label.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60),
      self.label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
    ])
  }
  
  @objc private func requestNoti() {
    let content = UNMutableNotificationContent()
    content.title = "노티 (타이틀)"
    content.body = "노티 (바디)"
    content.sound = .default
    content.badge = 2
    
    let request = UNNotificationRequest(
      identifier: "my-app://main/first?message=deeplink-test-message&desc=test-desc",
      content: content,
      trigger: UNTimeIntervalNotificationTrigger(
        timeInterval: 1.5,
        repeats: false
      )
    )
    
    UNUserNotificationCenter.current()
      .add(request) { error in
        guard let error = error else { return }
        print(error.localizedDescription)
      }
  }
}
