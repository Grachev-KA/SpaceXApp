import Foundation

struct Rocket: Decodable, Equatable {
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
    struct Diameter: Decodable, Equatable {
        let feet: Double?
    }
    
    struct Mass: Decodable, Equatable {
        let lb: Int
    }

    struct FirstStage: Decodable, Equatable {
        let engines: Int
        let fuelAmountTons: Double
        let burnTimeSec: Int?
    }

    struct SecondStage: Decodable, Equatable {
        let engines: Int
        let fuelAmountTons: Double
        let burnTimeSec: Int?
    }

    struct CompositeFairing: Decodable, Equatable {
        let height: Diameter
        let diameter: Diameter
    }
}
