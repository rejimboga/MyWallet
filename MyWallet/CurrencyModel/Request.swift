import Foundation
struct Request : Codable {
	let time : Time?
	let disclaimer : String?
	let chartName : String?
	let bpi : Bpi?

	enum CodingKeys: String, CodingKey {

		case time = "time"
		case disclaimer = "disclaimer"
		case chartName = "chartName"
		case bpi = "bpi"
	}

}
