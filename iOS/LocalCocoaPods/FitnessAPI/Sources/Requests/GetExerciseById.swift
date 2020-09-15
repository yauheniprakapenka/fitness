//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension FitnessAPI {

    /** Get info about exercise */
    public enum GetExerciseById {

        public static let service = APIService<Response>(id: "getExerciseById", tag: "", method: "GET", path: "/api/v1/exercises/{id}", hasBody: false, securityRequirements: [])

        public final class Request: APIRequest<Response> {

            public struct Options {

                /** id */
                public var id: Int

                /** value should be bearer: #{token_id} */
                public var authorization: String

                public init(id: Int, authorization: String) {
                    self.id = id
                    self.authorization = authorization
                }
            }

            public var options: Options

            public init(options: Options) {
                self.options = options
                super.init(service: GetExerciseById.service)
            }

            /// convenience initialiser so an Option doesn't have to be created
            public convenience init(id: Int, authorization: String) {
                let options = Options(id: id, authorization: authorization)
                self.init(options: options)
            }

            public override var path: String {
                return super.path.replacingOccurrences(of: "{" + "id" + "}", with: "\(self.options.id)")
            }

            override var headerParameters: [String: String] {
                var headers: [String: String] = [:]
                headers["authorization"] = options.authorization
                return headers
            }
        }

        public enum Response: APIResponseValue, CustomStringConvertible, CustomDebugStringConvertible {
            public typealias SuccessType = ExerciseGetInfoResponse

            /** return info aboun exercise */
            case status200(ExerciseGetInfoResponse)

            public var success: ExerciseGetInfoResponse? {
                switch self {
                case .status200(let response): return response
                }
            }

            public var response: Any {
                switch self {
                case .status200(let response): return response
                }
            }

            public var statusCode: Int {
                switch self {
                case .status200: return 200
                }
            }

            public var successful: Bool {
                switch self {
                case .status200: return true
                }
            }

            public init(statusCode: Int, data: Data, decoder: ResponseDecoder) throws {
                switch statusCode {
                case 200: self = try .status200(decoder.decode(ExerciseGetInfoResponse.self, from: data))
                default: throw APIClientError.unexpectedStatusCode(statusCode: statusCode, data: data)
                }
            }

            public var description: String {
                return "\(statusCode) \(successful ? "success" : "failure")"
            }

            public var debugDescription: String {
                var string = description
                let responseString = "\(response)"
                if responseString != "()" {
                    string += "\n\(responseString)"
                }
                return string
            }
        }
    }
}
