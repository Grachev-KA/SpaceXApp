struct SpaceRockets: Decodable {
    let height: Diameter
    let diameter: Diameter
    let mass: Mass
    let firstStage: FirstStage
    let secondStage: SecondStage
    let engines: Engines
    let landingLegs: LandingLegs
    let payloadWeights: [PayloadWeight]
    let flickrImages: [String]
    let name: String
    let type: String
    let firstFlight: Date
    let country: String
    let company: String
    let wikipedia: String
    let spaceRocketDescription: String?
    let id: String
    let active: Bool
    let stages: Int
    let boosters: Int
    let costPerLaunch: Int
    let successRatePct: Int
}

extension SpaceRockets {
    struct Date: Decodable {
        let firstFlight: String
    }
}

extension SpaceRockets {
    struct Diameter: Decodable {
        let meters: Double?
        let feet: Double?
    }
}

extension SpaceRockets {
    struct Engines: Decodable {
        let isp: ISP
        let thrustSeaLevel: Thrust
        let thrustVacuum: Thrust
        let number: Int
        let type: String
        let tversion: String?
        let tpropellant1: String?
        let tpropellant2: String?
        let layout: String?
        let engineLossMax: Int?
        let thrustToWeight: Double
    }
}

extension SpaceRockets {
    struct ISP: Decodable {
        let seaLevel: Int
        let vacuum: Int
    }
}

extension SpaceRockets {
    struct Thrust: Decodable {
        let kN: Int
        let lbf: Int
    }
}

extension SpaceRockets {
    struct FirstStage: Decodable {
        let thrustSeaLevel: Thrust
        let thrustVacuum: Thrust
        let reusable: Bool
        let engines: Int
        let fuelAmountTons: Double
        let burnTimeSEC: Int?
    }
}

extension SpaceRockets {
    struct LandingLegs: Decodable {
        let number: Int
        let material: String?
    }
}

extension SpaceRockets {
    struct Mass: Decodable {
        let kg: Int
        let lb: Int
    }
}

extension SpaceRockets {
    struct PayloadWeight: Decodable {
        let id: String
        let name: String
        let kg: Int
        let lb: Int
    }
}

extension SpaceRockets {
    struct SecondStage: Decodable {
        let thrust: Thrust
        let payloads: Payloads
        let reusable: Bool
        let engines: Int
        let fuelAmountTons: Double
        let burnTimeSEC: Int?
    }
}

extension SpaceRockets {
    struct Payloads: Decodable {
        let compositeFairing: CompositeFairing
        let option1: String
    }
}

extension SpaceRockets {
    struct CompositeFairing: Decodable {
        let height: Diameter
        let diameter: Diameter
    }
}
