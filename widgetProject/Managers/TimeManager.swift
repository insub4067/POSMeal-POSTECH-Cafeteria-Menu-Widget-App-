//
//  TimeManager.swift
//  포스밀
//
//  Created by Kim Insub on 2022/07/24.
//

import Foundation

struct TimeManager {

    let schedule = [
        "BREAKFAST_A" : "~ 09:30",
        "BREAKFAST_B" : "~ 09:30",
        "LUNCH" : "~ 13:30",
        "DINNER" : "~ 19:00",
        "STAFF" : "13:00",
        "INTERNATIONAL" : "13:30"
    ]

    let scheduleMediumSize = [
        "BREAKFAST_A" : "07:30 ~ 09:30",
        "BREAKFAST_B" : "07:30 ~ 09:30",
        "LUNCH" : "11:30 ~ 13:30",
        "DINNER" : "17:30 ~ 19:00",
        "STAFF" : "11:50 ~ 13:00",
        "INTERNATIONAL" : "11:30 ~ 13:30"
    ]

    let mealNameDict = [
        "BREAKFAST_A" : "조식",
        "BREAKFAST_B" : "간단식",
        "LUNCH" : "중식",
        "DINNER" : "석식",
        "STAFF" : "위즈덤",
        "INTERNATIONAL" : "더 블루힐"
    ]
}
