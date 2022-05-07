//
//  DeepLink.swift
//  ExLocalNoti
//
//  Created by 김종권 on 2022/05/07.
//

import Foundation

// 예제 딥링크: my-app://main/first?message=deeplink-test-message&desc=test-desc
enum DeepLink {
  case login
  case main(message: String?, desc: String?)
  
  private static var scheme = "my-app"
  private var host: String {
    switch self {
    case .login:
      return "login"
    case .main:
      return "main"
    }
  }
  private var path: String {
    switch self {
    case .login:
      return ""
    case .main:
      return "/first" // 주의: url.path값은 '/'로 시작하므로, path에도 '/'을 붙여주기
    }
  }
  private var url: URL? {
    URL(string: "\(Self.scheme)://\(self.host)\(self.query)")
  }
  private var query: String {
    let queryItems: [URLQueryItem]
    switch self {
    case .login:
      queryItems = []
    case .main(let message, let desc):
      queryItems = [message, desc]
        .compactMap { URLQueryItem(name: String(describing: $0), value: $0) }
    }
    return queryItems.reduce(into: "") {
      guard let value = $1.value else { return }
      $0 += "\($0.isEmpty ? "?" : "&")\($1.name)=\(value)"
    }
  }
  
  init?(string: String) {
    guard
      let url = URL(string: string),
      let scheme = url.scheme,
      Self.scheme == scheme
    else { return nil }
    
    switch url {
    case .login:
      self = .login
    case .main(message: nil, desc: nil):
      self = .main(
        message: url.getQueryParameterValue(name: "message"),
        desc: url.getQueryParameterValue(name: "desc")
      )
    default:
      return nil
    }
  }
  
  static func ~= (lhs: Self, rhs: URL) -> Bool {
    lhs.host == rhs.host && lhs.path == rhs.path
  }
  
}

extension URL {
  func getQueryParameterValue(name: String) -> String? {
    URLComponents(url: self, resolvingAgainstBaseURL: true)?
      .queryItems?
      .first(where: { $0.name == name })?
      .value
  }
}
