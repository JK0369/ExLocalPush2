//
//  MainVC.swift
//  ExLocalNoti
//
//  Created by 김종권 on 2022/05/07.
//

import UIKit

final class MainVC: UIViewController {
  private let label: UILabel = {
    let label = UILabel()
    label.text = "main 화면"
    label.textColor = .black
    label.font = .systemFont(ofSize: 30)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let message: String?
  let desc: String?
  
  init(message: String?, desc: String?) {
    self.message = message
    self.desc = desc
    super.init(nibName: nil, bundle: nil)
  }
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    
    self.view.addSubview(self.label)
    
    NSLayoutConstraint.activate([
      self.label.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60),
      self.label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
    ])
  }
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    guard
      let message = self.message,
      let desc = self.desc
    else { return }

    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
      let vc = MainFirstVC(message: message, desc: desc)
      self.present(vc, animated: true)
    }
  }
}
