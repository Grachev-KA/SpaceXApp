struct RocketLaunches: Decodable {
    let fairings: Fairings?
    let links: Links
    let staticFireDateUTC: String?
    let details: String?
    let launchLibraryID: String?
    let staticFireDateUnix: Int?
    let window: Int?
    let net: Bool
    let success: Bool?
    let upcoming: Bool
    let autoUpdate: Bool
    let tbd: Bool
    let rocket: String
    let name: String
    let dateUTC: String?
    let id: String
    let launchpad: String
    let datePrecision: String
    let dateLocal: String
    let failures: [Failure]
    let crew: [String]
    let ships: [String]
    let capsules: [String]
    let payloads: [String]
    let flightNumber: Int
    let dateUnix: Int
    let cores: [Core]
}

extension RocketLaunches {
    struct Core: Decodable {
        let core: String?
        let landingType: String?
        let landpad: String?
        let flight: Int?
        let gridfins: Bool?
        let legs: Bool?
        let reused: Bool?
        let landingAttempt: Bool?
        let landingSuccess: Bool?
    }
}

extension RocketLaunches {
    struct Failure: Decodable {
        let time: Int
        let altitude: Int?
        let reason: String
    }
}

extension RocketLaunches {
    struct Fairings: Decodable {
        let reused: Bool?
        let recoveryAttempt: Bool?
        let recovered: Bool?
        let ships: [String]
    }
}

extension RocketLaunches {
    struct Links: Decodable {
        let patch: Patch
        let reddit: Reddit
        let flickr: Flickr
        let presskit: String?
        let webcast: String?
        let youtubeID: String?
        let article: String?
        let wikipedia: String?
    }
}

extension RocketLaunches {
    struct Flickr: Decodable {
        let small: [String]
        let original: [String]
    }
}

extension RocketLaunches {
    struct Patch: Decodable {
        let smalle: String?
        let large: String?
    }
}

extension RocketLaunches {
    struct Reddit: Decodable {
        let campaign: String?
        let launch: String?
        let media: String?
        let recovery: String?
    }
}
