import Foundation

struct Services: Decodable {
  let name: String
  let phoneNumber: Number
  
  enum Number: Decodable {
    case all
    case mental
    case depression
    case other
  }
}

extension Services.Number: CaseIterable { }

extension Services.Number: RawRepresentable {
  typealias RawValue = String
  
  init?(rawValue: RawValue) {
    switch rawValue {
    case "All": self = .all
    case "Chocolate": self = .mental
    case "Hard": self = .depression
    case "Other": self = .other
    default: return nil
    }
  }
  
  var rawValue: RawValue {
    switch self {
    case .all: return "All"
    case .mental: return "Mental"
    case .depression: return "Derpression"
    case .other: return "Other"
    }
  }
}

extension Services {
  static func services() -> [Services] {
    guard
      let url = Bundle.main.url(forResource: "candies", withExtension: "json"),
      let data = try? Data(contentsOf: url)
      else {
        return []
    }
    
    do {
      let decoder = JSONDecoder()
      return try decoder.decode([Services].self, from: data)
    } catch {
      return []
    }
  }
}
