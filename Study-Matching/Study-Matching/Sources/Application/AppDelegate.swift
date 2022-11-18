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
import FirebaseMessaging


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication,didFinishLaunchingWithOptions
                     launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        FirebaseApp.configure()
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: { _, _ in })
        } else {
            let settings: UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
        Messaging.messaging().delegate = self
        
        return true
    }
}


extension AppDelegate: UNUserNotificationCenterDelegate {
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken
                     deviceToken: Data)
    {
        Messaging.messaging().apnsToken = deviceToken
    }
}


extension AppDelegate: MessagingDelegate {
    // FCM 토큰 (현재)
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken
                   fcmToken: String?)
    {
        guard let fcmToken = fcmToken else { return }
        let dataDict: [String: String] = ["token": fcmToken]
        NotificationCenter.default.post( name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)

        UserDefaultsManager.standard.FCMToken = fcmToken
        print("🌟 Firebase registration FCMToken:  \(UserDefaultsManager.standard.FCMToken)")
    }
}
