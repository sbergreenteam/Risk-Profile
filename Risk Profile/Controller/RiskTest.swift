
//
// RiskTest.swift
// RiskProfile
//
// Created by Daniel Koryagin on 16.11.19.
// Copyright © 2019 Daniel Koryagin. All rights reserved.
//

import Foundation

// MARK: - КОД ДАНИИЛА КОРЯГИНА

//print(RiskTest.assessAnswers(mas: ["d", "b", "c", "d", "d", "c", "b", "b", "b"]))

class RiskTest {
   
    static func assessAnswers(mas: [String]) -> String {
        var sum = 0
//        let mas = ["d", "b", "c", "d", "d", "c", "b", "b", "b"]
        
        for i in 0 ..< 6 {
        
        switch mas[i] {
        case "a":
            sum += 1
        case "b":
            sum += 3
        case "c":
            if (i == 1 || i == 2) {
                sum += 7
            } else {
                sum += 5
            }
        case "d":
            if (i == 1 || i == 2) {
                sum += 9
            } else {
                sum += 7
            }
        case "e":
            sum += 9
        default:
            return "default case"
        }
    }
    //print(sum)
    
    /*
     Эта часть кода определяет риск-профиль инвестора. Вместо print() можно создавать новую переменную типа string и присваиваивать
     ей такое значение, а потом возвращать эту переменную из метода и использовать дальше, либо создать переменную заранее и изменять ее значение,
     это на свое усмотрение. Смысл в том, чтобы потом, опираясь на эту переменную - показатель профиля, выводить пользователю советы
     с https://assetallocation.ru/merrill-edge-investor-profile/ (пункт описание инвестора)
     */
    
    if sum >= 6 && sum <= 15 {
        
        if mas[2] != "a" && mas[6] == "c" {
            return "Умеренно консервативный"
        } else {
            return "Консервативный"
        }
        
    } else if sum >= 16 && sum <= 25 {
        
        if mas[0] == "a"  &&  mas[6] == "a" || mas[6] == "b" {
            
            return "Консервативный"
            
        } else if mas[0] == "e" && mas[6] == "c"{
            
            return "Умеренный"
            
        } else {
            
            return "Умеренно консервативный"
            
        }
        
    } else if sum >= 26 && sum <= 34 {
        
        if mas[0] == "a" || mas[0] == "b" || mas[0] == "c" && mas[6] == "a" || mas[0] == "b" {
            
            return "Умеренно консервативный"
            
        } else if mas[0] == "d" || mas[0] == "e" && mas[6] == "c" {
            
            return "Умеренно агрессивный"
            
        } else {
            return "Умеренный"
        }
        
    } else if sum >= 35 && sum <= 44 {
        
        if mas[7] == "a" {
            
            switch mas[6] {
            case "a":
                return "Умеренный"
            case "b":
                return "Умеренно агрессивный"
            case "c":
                return "Агрессивный"
            default:
                return "Unsupported"
            }
        } else {
            
            if mas[8] == "a" && mas[6] == "b" || mas[8] == "b" && mas[6] == "c" {
                
                return "Умеренно агрессивный"
                
            } else if mas[8] == "a" && mas[6] == "c" {
                
                return "Агрессивный"
                
            } else {
                
                return "Умеренный"
                
            }
        }
        
    } else if sum >= 45 && sum <= 54 {
        
        switch mas[6] {
        case "a":
            return "Умеренный"
        case "b":
            return "Агрессивный"
        case "c":
            return "Агрессивный"
        default:
            return "Unsupported"
        }
        
    }
    return "Error"
    }

}
