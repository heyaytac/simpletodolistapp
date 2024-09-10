//
//  SimpleToDoListApp.swift
//  SimpleToDoList
//
//  Created by Privat on 10.09.24.
//

import SwiftUI
import Usercentrics
import UsercentricsUI

@main
struct SimpleToDoListApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State private var isReady = false
    
    var body: some Scene {
        WindowGroup {
            if isReady {
                ContentView()
            } else {
                ProgressView()
                    .onAppear(perform: checkConsentStatus)
            }
        }
    }
    
    private func checkConsentStatus() {
        UsercentricsCore.isReady { status in
            if status.shouldCollectConsent {
                collectConsent()
            } else {
                // Apply consent with status.consents
                applyConsents(status.consents)
                isReady = true
            }
        } onFailure: { error in
            print("Usercentrics initialization failed: \(error.localizedDescription)")
            isReady = true // Show the app even if Usercentrics fails
        }
    }
    
    private func collectConsent() {
        let banner = UsercentricsBanner()
        banner.showFirstLayer { userResponse in
            switch userResponse.userInteraction {
            case .acceptAll:
                print("User accepted all")
                let consents = UsercentricsCore.shared.acceptAll(consentType: .explicit_)
                applyConsents(consents)
            case .denyAll:
                print("User denied all")
                let consents = UsercentricsCore.shared.denyAll(consentType: .explicit_)
                applyConsents(consents)
            case .granular:
                print("User chose granular consents")
                applyConsents(userResponse.consents)
            case .noInteraction:
                print("User dismissed the banner")
                // You might want to handle this case according to your privacy policy
            @unknown default:
                break
            }
            isReady = true
        }
    }
    
    private func applyConsents(_ consents: [UsercentricsServiceConsent]) {
        // Apply consents to your services here
        for consent in consents {
            if consent.status {
                print("Consent given for \(consent.templateId)")
                // Enable service
            } else {
                print("Consent denied for \(consent.templateId)")
                // Disable service
            }
        }
    }
}
