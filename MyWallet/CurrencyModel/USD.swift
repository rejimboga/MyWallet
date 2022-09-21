import Foundation
struct USD : Codable {
	let code : String?
	let symbol : String?
	let rate : String?
	let description : String?
	let rateFloat : Double?

	enum CodingKeys: String, CodingKey {

		case code = "code"
		case symbol = "symbol"
		case rate = "rate"
		case description = "description"
		case rateFloat = "rate_float"
	}

}
