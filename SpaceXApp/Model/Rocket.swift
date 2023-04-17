import Foundation

struct Rocket: Decodable, Equatable {
    let height: Diameter
    let diameter: Diameter
    let mass: Mass
    let payloadWeights: [PayloadWeight]
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
        let meters: Double
        let feet: Double
    }
    
    struct Mass: Decodable, Equatable {
        let kg: Int
        let lb: Int
    }
    
    struct PayloadWeight: Decodable, Equatable {
        let kg: Int
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
}
