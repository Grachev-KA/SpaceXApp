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
        settingsModelMock.settings = [
            SettingsModel(type: .height, units: [.meters, .feet], selectedUnit: .meters),
            SettingsModel(type: .diameter, units: [.meters, .feet], selectedUnit: .meters),
            SettingsModel(type: .weight, units: [.kilograms, .pounds], selectedUnit: .kilograms),
            SettingsModel(type: .payload, units: [.kilograms, .pounds], selectedUnit: .kilograms)
        ]
        
        sut.getSettingsModelAndUserSettings()

        XCTAssertEqual(settingsViewMock.availableSettings, settingsModelMock.settings!)
    }
    
    func testSetSelectedUnit() {
        sut.saveUserSettings(setting: SettingsModel(type: .height, units: [.meters, .feet], selectedUnit: .pounds), unit: .pounds)
        
        XCTAssertEqual(userSettingsMock.savedSettingType, .height)
        XCTAssertEqual(userSettingsMock.savedUnit, .pounds)
    }
    
    func testGetUserSetting() {
        userSettingsMock.getUnit = .pounds
        
        sut.getSettingsModelAndUserSettings()
        
        XCTAssertEqual(settingsViewMock.selectedUnits[0], SettingsModel.Units.pounds)
    }
}

//MARK: - SettingsPresenter Mocks

private extension SettingsPresenterTests {
    final class SettingsModelMock: SettingsModelProtocol {
        var settings: [SettingsModel]?
        
        static func availableSettings() -> [SettingsModel] {
            let mock = SettingsModelMock()
            return mock.settings!
        }
    }
    
    final class UserSettingsMock: UserSettingsProtocol {
        var savedSettingType: SettingsModel.SettingsType?
        var savedUnit: SettingsModel.Units?
        var getUnit: SettingsModel.Units?
        
        func save(setting: SettingsModel.SettingsType, value: SettingsModel.Units) {
            savedSettingType = setting
            savedUnit = value
        }
        
        func get(setting: SettingsModel.SettingsType) -> SettingsModel.Units? {
            getUnit
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
