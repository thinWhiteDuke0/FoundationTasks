//
//  ThemeSettingsViewController.swift
//  NotificationTasks4
//
//  Created by Giorgi Manjavidze on 30.07.25.
//


import UIKit

final class ThemeSettingsViewController: UIViewController {

    private let segmentedControl = UISegmentedControl(items: ["Light", "Dark"])

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Theme Settings"

        setupSegmentedControl()
        applySavedSelection()
    }

    private func setupSegmentedControl() {
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addTarget(self, action: #selector(themeChanged(_:)), for: .valueChanged)
        view.addSubview(segmentedControl)

        NSLayoutConstraint.activate([
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentedControl.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            segmentedControl.widthAnchor.constraint(equalToConstant: 200)
        ])
    }

    private func applySavedSelection() {
        let savedTheme = ThemeManager.shared.currentTheme
        segmentedControl.selectedSegmentIndex = savedTheme == .light ? 0 : 1
    }

    @objc private func themeChanged(_ sender: UISegmentedControl) {
        let selectedTheme: Theme = sender.selectedSegmentIndex == 0 ? .light : .dark
        ThemeManager.shared.applyTheme(selectedTheme)
    }
}
