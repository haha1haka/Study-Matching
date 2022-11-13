//
//  AppDelegate.swift
//  Study-Matching
//
//  Created by HWAKSEONG KIM on 2022/11/07.
//


/*
 해야할일
 0.
 1. FCM 설치 + 유저디폴트 저장
 2. 토큰 리프레시 로직
 3. 모든 User 정보 저장 및 쓰기
 4. 서버로 올리기 --> 그전에, 빌드 네임 수정!!!! -->
 5. 시작 화면 바꿔주기
 6. statuscode error case 추상화 시키기
 */


import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

