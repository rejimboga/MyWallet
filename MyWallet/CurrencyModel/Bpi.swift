import Foundation
struct Bpi : Codable {
	let usd : USD?
	let gbp : GBP?
	let eur : EUR?

	enum CodingKeys: String, CodingKey {

		case usd = "USD"
		case gbp = "GBP"
		case eur = "EUR"
	}

}
