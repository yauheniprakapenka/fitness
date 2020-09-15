//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

/** Json body to use when create exercise */
public class ExerciseCreationBody: APIModel {

    public var name: String

    public var userId: String

    public var description: String?

    public var equipment: String?

    public var videoUrl: String?

    public init(name: String, userId: String, description: String? = nil, equipment: String? = nil, videoUrl: String? = nil) {
        self.name = name
        self.userId = userId
        self.description = description
        self.equipment = equipment
        self.videoUrl = videoUrl
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: StringCodingKey.self)

        name = try container.decode("name")
        userId = try container.decode("user_id")
        description = try container.decodeIfPresent("description")
        equipment = try container.decodeIfPresent("equipment")
        videoUrl = try container.decodeIfPresent("videoUrl")
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: StringCodingKey.self)

        try container.encode(name, forKey: "name")
        try container.encode(userId, forKey: "user_id")
        try container.encodeIfPresent(description, forKey: "description")
        try container.encodeIfPresent(equipment, forKey: "equipment")
        try container.encodeIfPresent(videoUrl, forKey: "videoUrl")
    }

    public func isEqual(to object: Any?) -> Bool {
      guard let object = object as? ExerciseCreationBody else { return false }
      guard self.name == object.name else { return false }
      guard self.userId == object.userId else { return false }
      guard self.description == object.description else { return false }
      guard self.equipment == object.equipment else { return false }
      guard self.videoUrl == object.videoUrl else { return false }
      return true
    }

    public static func == (lhs: ExerciseCreationBody, rhs: ExerciseCreationBody) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}
