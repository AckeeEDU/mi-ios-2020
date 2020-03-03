import UIKit
import PlaygroundSupport

//: [Previous](@previous)
//:
//: # Task
//: Given `RecipesViewController` from [UI](UI) create `RecipeDetailViewController` which will display recipe detail fetched from [this endpoint](https://cookbook3.docs.apiary.io/#reference/0/recipe-detail/get-recipe).
//:
//: - first we need to add `didSelect` callback to `RecivesViewController`
//: - next we pass selected `Recipe` to `RecipeDetailViewController`
//: - then we fetch `Recipe` detail
//: - when fetched we can fill the UI

let recipesVC = RecipesViewController()
recipesVC.title = "Recipes"
PlaygroundPage.current.liveView = UINavigationController(rootViewController: recipesVC)

//: [Next](@next)
