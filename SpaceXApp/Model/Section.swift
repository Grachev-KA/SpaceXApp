import Foundation

struct Section: Equatable {
    let type: SectionType
    let cells: [CellType]
}

extension Section {
    enum SectionType: Hashable {
        case imageAndTitle
        case orthogonal
        case vertical(title: String?)
        case button
    }
}

extension Section {
    enum CellType: Hashable {
        case header(image: URL, title: String)
        case info(title: String, value: String)
        case button
    }
}
