import XCTest
@testable import SpaceXApp

final class SettingsPresenterTests: XCTestCase {
    private var sut: SettingsPresenter!
    private var settingsModelMock: SettingsModelMock!
    private var userSettingsMock: UserSettingsMock!
    private var settingsViewMock: SettingsViewMock!
    
    override func setUp() {
        super.setUp()
        settingsViewMock = SettingsViewMock()
        userSettingsMock = UserSettingsMock()
        sut = SettingsPresenter(view: settingsViewMock, userSettings: userSettingsMock)
        settingsModelMock = SettingsModelMock()
    }
    
    override func tearDown() {
        sut = nil
        settingsModelMock = nil
        userSettingsMock = nil
        settingsViewMock = nil
        super.tearDown()
    }
    
    func testGetAvailableSettings() {
        sut.getSettingsModelAndUserSettings()
        
        let actualAvailableSettings = settingsViewMock.availableSettings
        let expectedAvailableSettings = [
            SettingsModel(type: .height, units: [.meters, .feet], selectedUnit: .meters),
            SettingsModel(type: .diameter, units: [.meters, .feet], selectedUnit: .meters),
            SettingsModel(type: .weight, units: [.kilograms, .pounds], selectedUnit: .kilograms),
            SettingsModel(type: .payload, units: [.kilograms, .pounds], selectedUnit: .kilograms)
        ]
        XCTAssertEqual(actualAvailableSettings, expectedAvailableSettings)
    }
    
    func testSetSelectedUnit() {
        sut.saveUserSettings(setting: SettingsModel(type: .height, units: [.meters, .feet], selectedUnit: .pounds), unit: .pounds)
        
        let actualSetting = userSettingsMock.savedSettingType
        let expectedSettingType = SettingsModel.SettingsType.height
        let actualUnit = userSettingsMock.savedUnit
        let expectedUnit = SettingsModel.Units.pounds
        XCTAssertEqual(actualSetting, expectedSettingType)
        XCTAssertEqual(actualUnit, expectedUnit)
    }
    
    func testGetUserSetting() {
        userSettingsMock.save(setting: .height, value: .pounds)
        
        sut.getSettingsModelAndUserSettings()
        
        let actualSelectedUnit = settingsViewMock.selectedUnits
        let expectedSelectedUnit = SettingsModel.Units.pounds
        XCTAssertEqual(actualSelectedUnit[0], expectedSelectedUnit)
    }
}

private extension SettingsPresenterTests {
    final class SettingsModelMock: SettingsModelProtocol {
        static func availableSettings() -> [SettingsModel] {
            [
                SettingsModel(type: .height, units: [.meters, .feet], selectedUnit: .meters),
                SettingsModel(type: .diameter, units: [.meters, .feet], selectedUnit: .meters),
                SettingsModel(type: .weight, units: [.kilograms, .pounds], selectedUnit: .kilograms),
                SettingsModel(type: .payload, units: [.kilograms, .pounds], selectedUnit: .kilograms)
            ]
        }
    }
    
    final class UserSettingsMock: UserSettingsProtocol {
        var savedSettingType: SettingsModel.SettingsType?
        var savedUnit: SettingsModel.Units?
        
        func save(setting: SettingsModel.SettingsType, value: SettingsModel.Units) {
            savedSettingType = setting
            savedUnit = value
        }
        
        func get(setting: SettingsModel.SettingsType) -> SettingsModel.Units? {
            savedUnit
        }
    }
    
    final class SettingsViewMock: SettingsViewProtocol {
        var availableSettings = [SettingsModel]()
        var selectedUnits = [SettingsModel.Units?]()
        
        func present(availableSettings: [SettingsModel], selectedUnits: [SettingsModel.Units?]) {
            self.availableSettings = availableSettings
            self.selectedUnits = selectedUnits
        }
    }
}
