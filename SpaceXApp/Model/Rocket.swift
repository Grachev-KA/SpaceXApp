import Foundation

struct Rocket: Decodable {
    let height: Diameter
    let diameter: Diameter
    let mass: Mass
    let firstStage: FirstStage
    let secondStage: SecondStage
    let flickrImages: [String]
    let name: String
    let firstFlight: Date
    let country: String
    let id: String
    let costPerLaunch: Int
}

extension Rocket {
    struct Diameter: Decodable {
        let meters: Double?
        let feet: Double?
    }
}

extension Rocket {
    struct Thrust: Decodable {
        let kN: Int
        let lbf: Int
    }
}

extension Rocket {
    struct FirstStage: Decodable {
        let thrustSeaLevel: Thrust
        let thrustVacuum: Thrust
        let reusable: Bool
        let engines: Int
        let fuelAmountTons: Double
        let burnTimeSec: Int?
    }
}

extension Rocket {
    struct Mass: Decodable {
        let kg: Int
        let lb: Int
    }
}

extension Rocket {
    struct SecondStage: Decodable {
        let thrust: Thrust
        let payloads: Payloads
        let reusable: Bool
        let engines: Int
        let fuelAmountTons: Double
        let burnTimeSec: Int?
    }
}

extension Rocket {
    struct Payloads: Decodable {
        let compositeFairing: CompositeFairing
        let option1: String
    }
}

extension Rocket {
    struct CompositeFairing: Decodable {
        let height: Diameter
        let diameter: Diameter
    }
}
