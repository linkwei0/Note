//
//  NoteTests.swift
//  NoteTests
//
//  Created by Артём Бацанов on 16.12.2020.
//  Copyright © 2020 Артём Бацанов. All rights reserved.
//

import XCTest

@testable import Note

class NoteTests: XCTestCase {
    
    var storyboard: UIStoryboard!
    var showvc: ShowViewController!
    var settingsvc: SettingsViewController!

    var menuvc: MenuViewController!
    var navigationController: UINavigationController!
    
    var mainVC: MainViewController!
    
    var notesTableVC: NotesTableVC!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        showvc = storyboard.instantiateViewController(withIdentifier: "show") as? ShowViewController
        menuvc = storyboard.instantiateViewController(withIdentifier: "menuVC") as? MenuViewController
        settingsvc = storyboard.instantiateViewController(withIdentifier: "Settings") as? SettingsViewController
        notesTableVC = storyboard.instantiateViewController(withIdentifier: "Notes") as? NotesTableVC
        mainVC = storyboard.instantiateViewController(withIdentifier: "remid") as? MainViewController

        
        showvc.loadViewIfNeeded()
        settingsvc.loadViewIfNeeded()
        menuvc.loadViewIfNeeded()
        notesTableVC.loadViewIfNeeded()
        mainVC.loadViewIfNeeded()
        
        navigationController = UINavigationController(rootViewController: menuvc)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        showvc = nil
        menuvc = nil
        settingsvc = nil
        notesTableVC = nil
        mainVC = nil
    }
    
    func testShowViewController_WhenCreated_TitleFieldHasNil() throws {
        let titleField = try XCTUnwrap(showvc.titleField, "The titleField is not connection to an IBOutlet")
        XCTAssertEqual(titleField.text, "")
    }
    
    func testShowViewController_WhenCreated_BodyFieldHasNil() throws {
        let bodyField = try XCTUnwrap(showvc.bodyField, "The bodyField is not connection to an IBOutlet")
        XCTAssertEqual(bodyField.text, "")
    }
    
    func testShowViewController_WhenAddNewRemider_HasTakeValueFromTitleField() throws {
        let titleField = try XCTUnwrap(showvc.titleField, "The titleField is not connection to an IBOutlet")
        titleField.text = "Buy some milk"
        XCTAssertEqual(titleField.text, "Buy some milk")
    }

    func testShowViewController_WhenAddNewRemider_HasTakeValueFromBodyField() throws {
        let bodyField = try XCTUnwrap(showvc.bodyField, "The bodyField is not connection to an IBOutlet")
        bodyField.text = "Wake up"
        XCTAssertEqual(bodyField.text, "Wake up")
    }
    
    func testShowViewController_WhenAddNewRemider_HasAddButtonAndAction() throws {
        // Given
        let addRemider: UIButton = try XCTUnwrap(showvc.addRemider, "Add button does not have a referencing outlet")
        
        // When
        let addRemiderActions = try XCTUnwrap(addRemider.actions(forTarget: showvc, forControlEvent: .touchUpInside),
                                              "Add button does not have any actions")
        
        // Then
        XCTAssertEqual(addRemiderActions.count, 1)
        XCTAssertEqual(addRemiderActions.first, "pushSaveButton:", "There is no action with a name pushSaveButton assigned to add button")
    }
    
    func testButtonNotes_WhenTapped_NotesTableVCIsPusshed() {
        menuvc.buttonNotes.sendActions(for: .touchUpInside)
        
        RunLoop.current.run(until: Date())
        
        guard let _ = navigationController.topViewController as? NotesTableVC else {
            XCTFail()
            return
        }
    }
    
    func testButtonRemiders_WhenTapped_MainViewControllerIsPusshed() {
        menuvc.buttonRemiders.sendActions(for: .touchUpInside)
        
        RunLoop.current.run(until: Date())
        
        guard let _ = navigationController.topViewController as? MainViewController else {
            XCTFail()
            return
        }
    }
    
    func testButtonFinished_WhenTapped_TrashTableVCIsPushed() {
        let spyNavigationController = SpyNavigationController(rootViewController: menuvc)
        
        menuvc.buttonFinished.sendActions(for: .touchUpInside)
        
        guard let _ = spyNavigationController.pushedViewController as? TrashTableVC else {
            XCTFail()
            return
        }
    }
    
    func testButtonTargets_WhenTapped_TagetsTableVCIsPushed() {
        let spyNavigationController = SpyNavigationController(rootViewController: menuvc)
        
        menuvc.buttonTargets.sendActions(for: .touchUpInside)
        
        guard let _ = spyNavigationController.pushedViewController as? TagetsTableVC else {
            XCTFail()
            return
        }
    }
    
    // Удаление всех заметок
    func testClearTrash_WhenClearAll_HasAddButtonAndAction() throws {
        // Given
        let clearTrash: UIButton = try XCTUnwrap(settingsvc.clearTrash, "Add button does not have a referencing outlet")
        
        // When
        let clearTrashActions = try XCTUnwrap(clearTrash.actions(forTarget: settingsvc, forControlEvent: .touchUpInside),
                                              "Add button does not have any actions")
        
        // Then
        XCTAssertEqual(clearTrashActions.count, 1)
        XCTAssertEqual(clearTrashActions.first, "removeAllNotes", "There is no action with a name removeAllNotes assigned to add button")
    }
    
    // Удаление всех целей
    func testClearTargets_WhenClearAll_HasAddButtonAndAction() throws {
        // Given
        let clearTarget: UIButton = try XCTUnwrap(settingsvc.clearTargets, "Add button does not have a referencing outlet")
        
        // When
        let clearTargetActions = try XCTUnwrap(clearTarget.actions(forTarget: settingsvc, forControlEvent: .touchUpInside),
                                              "Add button does not have any actions")
        
        // Then
        XCTAssertEqual(clearTargetActions.count, 1)
        XCTAssertEqual(clearTargetActions.first, "removeAllTargets", "There is no action with a name removeAllTargets assigned to add button")
    }
    
    // Удаление всех заметок
    func testClearNotes_WhenClearAll_HasAddButtonAndAction() throws {
        // Given
        let clearNote: UIButton = try XCTUnwrap(settingsvc.clearNotes, "Add button does not have a referencing outlet")
        
        // When
        let clearNoteActions = try XCTUnwrap(clearNote.actions(forTarget: settingsvc, forControlEvent: .touchUpInside),
                                              "Add button does not have any actions")
        
        // Then
        XCTAssertEqual(clearNoteActions.count, 1)
        XCTAssertEqual(clearNoteActions.first, "removeAllTrash", "There is no action with a name removeAllTrash assigned to add button")
    }
    
    func testMenuViewController_WhenStartApplication_NoteLabelHasValueZero() throws {
        let noteLabel = try XCTUnwrap(menuvc.NoteLabel, "The titleField is not connection to an IBOutlet")
        XCTAssertEqual(noteLabel.text, "0")
    }
    
    func testMenuViewController_WhenStartApplication_RemidLabelHasValueZero() throws {
        let remidLabel = try XCTUnwrap(menuvc.RemidLabel, "The titleField is not connection to an IBOutlet")
        XCTAssertEqual(remidLabel.text, "0")
    }
    
    func testMenuViewController_WhenStartApplication_NeedLabelHasValueZero() throws {
        let needLabel = try XCTUnwrap(menuvc.NeedLabel, "The titleField is not connection to an IBOutlet")
        XCTAssertEqual(needLabel.text, "0")
    }
    
    func testMenuViewController_WhenStartApplication_CompletedLabelHasValueZero() throws {
        let completedLabel = try XCTUnwrap(menuvc.CompletedLabel, "The titleField is not connection to an IBOutlet")
        XCTAssertEqual(completedLabel.text, "0")
    }
    
    func testMenuViewController_WhenAddNewNote_UpdateValue() throws {
        let noteLabel = try XCTUnwrap(menuvc.NoteLabel, "The titleField is not connection to an IBOutlet")
        noteLabel.text = "1"
        XCTAssertEqual(noteLabel.text, "1")
    }
    
    func testMenuViewController_WhenAddNewRemid_UpdateValue() throws {
        let remidLabel = try XCTUnwrap(menuvc.RemidLabel, "The titleField is not connection to an IBOutlet")
        remidLabel.text = "1"
        XCTAssertEqual(remidLabel.text, "1")
    }
    
    func testMenuViewController_WhenAddNewTarget_UpdateValue() throws {
        let needLabel = try XCTUnwrap(menuvc.NeedLabel, "The titleField is not connection to an IBOutlet")
        needLabel.text = "1"
        XCTAssertEqual(needLabel.text, "1")
    }
    
    func testMenuViewController_WhenAddNewCompleted_UpdateValue() throws {
        let completedLabel = try XCTUnwrap(menuvc.CompletedLabel, "The titleField is not connection to an IBOutlet")
        completedLabel.text = "1"
        XCTAssertEqual(completedLabel.text, "1")
    }
    
    func testNotes_WhenStartApplication_HasCountZero() throws {
        XCTAssertEqual(Notes.count, 0)
    }
    
    func testTarget_WhenStartApplication_HasCountZero() throws {
        XCTAssertEqual(Targets.count, 0)
    }
    
    func testTrash_WhenStartApplication_HasCountZero() throws {
        XCTAssertEqual(Trash.count, 0)
    }
    
    func testNotes_WhenAddNewElement_ChangeValue() throws {
        Notes.removeAll()
        Notes.append(["Name": "Сходить на прогулку и купить хлеб"])
        let currentItem = Notes[0]
        let element = currentItem["Name"] as! String
        XCTAssertEqual(element, "Сходить на прогулку и купить хлеб", "Added item is not equal to - Сходить на прогулку и купить хлеб")
    }
    
    func testTrash_WhenAddNewElement_ChangeValue() throws {
        Trash.removeAll()
        Trash.append(["Name": "Томск - это город."])
        let currentItem = Trash[0]
        let element = currentItem["Name"] as! String
        XCTAssertEqual(element, "Томск - это город.", "Added item is not equal to - Томск - это город.")
    }
    
    func testTarget_WhenAddNewElement_ChangeValue() throws {
        Targets.removeAll()
        Targets.append(["Name": "Сделать домашку"])
        let currentItem = Targets[0]
        let element = currentItem["Name"] as! String
        XCTAssertEqual(element, "Сделать домашку", "Added item is not equal to - Сделать домашку")
    }
    
    func testNotes_WhenRemoveAll_ChangeValue() throws {
        Notes.removeAll()
        XCTAssertEqual(Notes.count, 0)
    }
    
    func testTrash_WhenRemoveAll_ChangeValue() throws {
        Trash.removeAll()
        XCTAssertEqual(Trash.count, 0)
    }
    
    func testTarget_WhenRemoveAll_ChangeValue() throws {
        Targets.removeAll()
        XCTAssertEqual(Targets.count, 0)
    }
    
    func testNotes_WhenCreatedNewElement_HasChangeValue() {
        Notes.removeAll()
        addItem(nameItem: "Москва")
        XCTAssertEqual(Notes.count, 1)
    }
    
    func testTrash_WhenCreatedNewElement_HasChangeValue() {
        Trash.removeAll()
        addItemTrash(nameItem: "Томск")
        XCTAssertEqual(Trash.count, 1)
    }
    
    func testTargets_WhenCreatedNewElement_HasChangeValue() {
        Targets.removeAll()
        addTarget(nameItem: "Питер")
        XCTAssertEqual(Targets.count, 1)
    }
    
    func testNotesAddItem_WhenAddNewElement_ChangeValue() throws {
        Notes.removeAll()
        addItem(nameItem: "Сходить в магазин")
        let currentItem = Notes[0]
        let element = currentItem["Name"] as! String
        XCTAssertEqual(element, "Сходить в магазин", "Added item is not equal to - Сходить в магазин")
    }
    
    func testTrashAddItemTrash_WhenAddNewElement_ChangeValue() throws {
        Trash.removeAll()
        addItemTrash(nameItem: "Купить чипсы")
        let currentItem = Trash[0]
        let element = currentItem["Name"] as! String
        XCTAssertEqual(element, "Купить чипсы", "Added item is not equal to - Купить чипсы")
    }
    
    func testTargetAddTarget_WhenAddNewElement_ChangeValue() throws {
        Targets.removeAll()
        addTarget(nameItem: "Позаниматься спортом")
        let currentItem = Targets[0]
        let element = currentItem["Name"] as! String
        XCTAssertEqual(element, "Позаниматься спортом", "Added item is not equal to - Позаниматься спортом")
    }
    
    func testRemoveItem_WhenRemoveItemInNotes_HasChangeValue() {
        Notes.removeAll()
        addItem(nameItem: "Первый тест")
        addItem(nameItem: "Второй тест")
        removeItem(at: 1)
        XCTAssertEqual(Notes.count, 1)
    }
    
    func testRemoveItemTrash_WhenRemoveItemInTrash_HasChangeValue() {
        Trash.removeAll()
        addItemTrash(nameItem: "Первый тест")
        addItemTrash(nameItem: "Второй тест")
        removeItemTrash(at: 1)
        XCTAssertEqual(Trash.count, 1)
    }
    
    func testRemoveTarget_WhenRemoveItemInTarget_HasChangeValue() {
        Targets.removeAll()
        addTarget(nameItem: "Первый тест")
        addTarget(nameItem: "Второй тест")
        removeTarget(at: 1)
        XCTAssertEqual(Targets.count, 1)
    }
    
    func testTarget_WhenSwap_HasSwapElements() {
        Targets.removeAll()
        addTarget(nameItem: "Первый тест")
        addTarget(nameItem: "Второй тест")
        moveItem(fromIndex: 0, toIndex: 1)
        removeTarget(at: 0)
        let currentItem = Targets[0]
        let element = currentItem["Name"] as! String
        XCTAssertEqual(element, "Первый тест", "Added item is not equal to - Первый тест")
    }
    
    func testTarget_WhenChangeState_HasChangeStateItem() {
        Targets.removeAll()
        addTarget(nameItem: "Артем")
        addTarget(nameItem: "Семен")
        let itemValue = changeState(at: 1)
        XCTAssertTrue(itemValue, "itemValue is not completed")
        //XCTAssertTrue(element, "isCompleted")
    }
    
    func testMainViewController_WhenAddNewReminder_HasChangeCount() {
        mainVC.models.removeAll()
        let title = "Купить соль"
        let newReminder = MyReminder(title: title, date: Date(), identifier: "id_\(title)")
        mainVC.models.append(newReminder)
        XCTAssertEqual(mainVC.models.count, 1)
    }
    
    func testMainViewController_WhenAddNewReminder_CorrectOrNot() {
        mainVC.models.removeAll()
        let title = "Быть дома"
        let newReminder = MyReminder(title: title, date: Date(), identifier: "id_\(title)")
        mainVC.models.append(newReminder)
        XCTAssertEqual(mainVC.models[0].title, "Быть дома")
    }
    
}
