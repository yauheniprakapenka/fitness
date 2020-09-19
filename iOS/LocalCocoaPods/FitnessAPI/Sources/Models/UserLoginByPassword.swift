//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

public class UserLoginByPassword: APIModel {

    public enum GrantType: String, Codable, Equatable, CaseIterable {
        case password = "password"
    }

    public var grantType: GrantType

    public var email: String

    public var password: String

    public init(grantType: GrantType, email: String, password: String) {
        self.grantType = grantType
        self.email = email
        self.password = password
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: StringCodingKey.self)

        grantType = try container.decode("grant_type")
        email = try container.decode("email")
        password = try container.decode("password")
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: StringCodingKey.self)

        try container.encode(grantType, forKey: "grant_type")
        try container.encode(email, forKey: "email")
        try container.encode(password, forKey: "password")
    }

    public func isEqual(to object: Any?) -> Bool {
      guard let object = object as? UserLoginByPassword else { return false }
      guard self.grantType == object.grantType else { return false }
      guard self.email == object.email else { return false }
      guard self.password == object.password else { return false }
      return true
    }

    public static func == (lhs: UserLoginByPassword, rhs: UserLoginByPassword) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}