//
//  Slide.swift
//  MyAnimVue
//
//  Created by Олег Романов on 04.07.2024.
//

import UIKit

struct Slide {
    let title: String
    let description: String
    let isFirstSlide: Bool
    let isLastSlide: Bool
    
#warning("Вынести в константы и добавить локализацию")
    
    static func generateSlides() -> [Slide] {
        let slide1 = Slide(
            title: "Добро пожаловать в MyAnimVue!",
            description: "",
            isFirstSlide: true,
            isLastSlide: false
        )
        let slide2 = Slide(
            title: "MyAnimVue поможет вам:",
            description: "Находить аниме чтобы посмотреть или отложить на будущее.",
            isFirstSlide: false,
            isLastSlide: false
        )
        let slide3 = Slide(
            title: "MyAnimVue поможет вам:",
            description: "Вести статистику уже просмотренного аниме",
            isFirstSlide: false,
            isLastSlide: false
        )
        let slide4 = Slide(
            title: "Вы уже практически готовы начать!",
            description: "Осталось лишь пройти процедуру авторизации, чтобы иметь доступ ко всем функциям MyAnimVue",
            isFirstSlide: false,
            isLastSlide: true
        )
        
        return [slide1, slide2, slide3, slide4]
    }
}
