//
//  NoteUITests.swift
//  NoteUITests
//
//  Created by Артём Бацанов on 20.12.2020.
//  Copyright © 2020 Артём Бацанов. All rights reserved.
//

import XCTest

class NoteUITests: XCTestCase {
    
    private var app: XCUIApplication!
    private var clearTargetIdentifier: XCUIElement!
    private var itemButton: XCUIElement!
    private var showNotes: XCUIElement!
    private var showTarget: XCUIElement!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
    
        app = XCUIApplication()
        app.launch()
        
        itemButton = app.buttons["Item"]
        showNotes = app.buttons["Заметки"]
        showTarget = app.buttons["Цели"]
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        app = nil
        itemButton = nil
        clearTargetIdentifier = nil
        showNotes = nil
        showTarget = nil
        try super.tearDownWithError()
    }
    
    func testMenuViewController_WhenViewLoaded_RequiredNoteIsEnabled() throws {
        // UI tests must launch the application that they test.
        let notesButton = app.buttons["Заметки"]

        XCTAssert(notesButton.isEnabled, "Notes Button UIButon is not enabled for user interactions")
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testMenuViewController_WhenViewLoaded_RequiredRemidIsEnabled() throws {
        // UI tests must launch the application that they test.
        let remidButton = app.buttons["Напоминания"]

        XCTAssert(remidButton.isEnabled, "Reminders Button UIButon is not enabled for user interactions")
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testMenuViewController_WhenViewLoaded_RequiredTargetIsEnabled() throws {
        // UI tests must launch the application that they test.
        let targetsButton = app.buttons["Цели"]

        XCTAssert(targetsButton.isEnabled, "Targets Button UIButon is not enabled for user interactions")
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testMenuViewController_WhenViewLoaded_RequiredCompletedIsEnabled() throws {
        // UI tests must launch the application that they test.
        let completedButton = app.buttons["Завершенные"]

        XCTAssert(completedButton.isEnabled, "Completed Button UIButon is not enabled for user interactions")
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testMenuViewController_WhenViewLoaded_RequiredItemIsEnabled() throws {
        // UI tests must launch the application that they test.
        //let itemButton = app.buttons["Item"]

        XCTAssert(itemButton.isEnabled, "Item Button UIButon is not enabled for user interactions")
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testSettingsViewController_WhenRemoveAll_Actions() {
        itemButton.tap()
        let clearTargets = app.buttons["Очистить цели"]
        clearTargets.tap()
        let removeAll = app.buttons["Удалить"]
        removeAll.tap()
    }
    
    func testSettingsViewController_WhenRemoveAllTargets_ShowAlert() {
        itemButton.tap()
        let clearTargets = app.buttons["Очистить цели"]
        clearTargets.tap()
        XCTAssertTrue(app.alerts["successAlertTargets"].waitForExistence(timeout: 1), "A Alert was not presented")
    }
    
    func testSettingsViewController_WhenRemoveAllNotes_ShowAlert() {
        itemButton.tap()
        let clearNotes = app.buttons["Очистить заметки"]
        clearNotes.tap()
        XCTAssertTrue(app.alerts["successAlertTrash"].waitForExistence(timeout: 1), "A Alert was not presented")
    }
    
    func testSettingsViewController_WhenRemoveAllTrash_ShowAlert() {
        itemButton.tap()
        let clearTrash = app.buttons["Очистить корзину"]
        clearTrash.tap()
        XCTAssertTrue(app.alerts["successAlertNotes"].waitForExistence(timeout: 1), "A Alert was not presented")
    }
    
    func testSettingsViewController_WhenRemoveAllTrash_TappedButtonCancel() {
        itemButton.tap()
        let clearTrash = app.buttons["Очистить корзину"]
        clearTrash.tap()
        XCTAssertTrue(app.alerts["successAlertNotes"].waitForExistence(timeout: 1), "A Alert was not presented")
        let tapCancel = app.buttons["Отмена"]
        tapCancel.tap()
    }
    
    func testSettingsViewController_WhenRemoveAllTargets_TappedButtonCancel() {
        itemButton.tap()
        let clearTargets = app.buttons["Очистить цели"]
        clearTargets.tap()
        XCTAssertTrue(app.alerts["successAlertTargets"].waitForExistence(timeout: 1), "A Alert was not presented")
        let tapCancel = app.buttons["Отмена"]
        tapCancel.tap()
    }
    
    func testSettingsViewController_WhenRemoveAllNotes_TappedButtonCancel() {
        itemButton.tap()
        let clearNotes = app.buttons["Очистить заметки"]
        clearNotes.tap()
        XCTAssertTrue(app.alerts["successAlertTrash"].waitForExistence(timeout: 1), "A Alert was not presented")
        let tapCancel = app.buttons["Отмена"]
        tapCancel.tap()
    }
        
    func testSettingsViewController_WhenRemoveAllTrash_TappedButtonOk() {
        itemButton.tap()
        let clearTrash = app.buttons["Очистить корзину"]
        clearTrash.tap()
        XCTAssertTrue(app.alerts["successAlertNotes"].waitForExistence(timeout: 1), "A Alert was not presented")
        let tapCancel = app.buttons["Очистить"]
        tapCancel.tap()
    }
    
    func testSettingsViewController_WhenRemoveAllTargets_TappedButtonOk() {
        itemButton.tap()
        let clearTargets = app.buttons["Очистить цели"]
        clearTargets.tap()
        XCTAssertTrue(app.alerts["successAlertTargets"].waitForExistence(timeout: 1), "A Alert was not presented")
        let tapCancel = app.buttons["Удалить"]
        tapCancel.tap()
    }
    
    func testSettingsViewController_WhenRemoveAllNotes_TappedButtonOk() {
        itemButton.tap()
        let clearNotes = app.buttons["Очистить заметки"]
        clearNotes.tap()
        XCTAssertTrue(app.alerts["successAlertTrash"].waitForExistence(timeout: 1), "A Alert was not presented")
        let tapCancel = app.buttons["Удалить"]
        tapCancel.tap()
    }
        
    func testSettingsViewController_WhenRemoveAllTrash_TappedButtonBackToMenu() {
        itemButton.tap()
        let clearTrash = app.buttons["Очистить корзину"]
        clearTrash.tap()
        XCTAssertTrue(app.alerts["successAlertNotes"].waitForExistence(timeout: 1), "A Alert was not presented")
        let tapCancel = app.buttons["Очистить"]
        tapCancel.tap()
        let menuButton = app.buttons["Меню"]
        menuButton.tap()
    }
    
    func testSettingsViewController_WhenRemoveAllTargets_TappedButtonBackToMenu() {
        itemButton.tap()
        let clearTargets = app.buttons["Очистить цели"]
        clearTargets.tap()
        XCTAssertTrue(app.alerts["successAlertTargets"].waitForExistence(timeout: 1), "A Alert was not presented")
        let tapCancel = app.buttons["Удалить"]
        tapCancel.tap()
        let menuButton = app.buttons["Меню"]
        menuButton.tap()
    }
    
    func testSettingsViewController_WhenRemoveAllNotes_TappedButtonBackToMenu() {
        itemButton.tap()
        let clearNotes = app.buttons["Очистить заметки"]
        clearNotes.tap()
        XCTAssertTrue(app.alerts["successAlertTrash"].waitForExistence(timeout: 1), "A Alert was not presented")
        let tapCancel = app.buttons["Удалить"]
        tapCancel.tap()
        let menuButton = app.buttons["Меню"]
        menuButton.tap()
    }
            
    func testNotesTableVC_WhenAddNewNote_ShowAlert() {
        showNotes.tap()
        let addNote = app.buttons["Item"]
        addNote.tap()
        XCTAssertTrue(app.alerts["successAlertAddNote"].waitForExistence(timeout: 1), "A Alert was not presented")
    }
    
    func testNotesTableVC_WhenAddNewNoteAndEmptyUITextField_ShowAlertWithError() {
        showNotes.tap()
        let addNote = app.buttons["Item"]
        addNote.tap()
        XCTAssertTrue(app.alerts["successAlertAddNote"].waitForExistence(timeout: 1), "A Alert was not presented")
        let okButton = app.buttons["Ок"]
        okButton.tap()
        XCTAssertTrue(app.alerts["errorAlertAddNote"].waitForExistence(timeout: 1), "A Alert was not presented")
    }
    
    func testNotesTableVC_WhenAddNewTarget_ShowAlert() {
        showTarget.tap()
        let addTarget = app.buttons["Add"]
        addTarget.tap()
        XCTAssertTrue(app.alerts["successAlertAddTarget"].waitForExistence(timeout: 1), "A Alert was not presented")
        let okButton = app.buttons["Добавить"]
        okButton.tap()
    }
    
    func testRemind_WhenAddNewRemind_BackToMainControllerWithReminder() {
        let button1 = app.buttons["Напоминания"]
        button1.tap()
        let button2 = app.buttons["Add"]
        button2.tap()
        let button3 = app.buttons["Save"]
        button3.tap()
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
