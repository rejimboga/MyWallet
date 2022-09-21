import Foundation
struct Time : Codable {
	let updated : String?
	let updatedISO : String?
	let updateduk : String?

	enum CodingKeys: String, CodingKey {

		case updated = "updated"
		case updatedISO = "updatedISO"
		case updateduk = "updateduk"
	}

}
