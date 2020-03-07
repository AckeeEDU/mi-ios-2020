//
//  PhotosService.swift
//  FITogram
//
//  Created by Pacek on 20/04/2019.
//

import UIKit

class PhotosService: PhotosServicing {
    
    static let shared: PhotosServicing = PhotosService()

    func fetchPhotos(completion: @escaping ([Photo]) -> Void) {
        // authors
        let tmbk = Author(username: "tmbkofficial", name: "TMBK", avatarId: "tmbk")
        let dan = Author(username: "danbilzerian", name: "Dan Bilzerian", avatarId: "dan")
        let taylor = Author(username: "taylorswift", name: "Taylor Swift", avatarId: "taylor")
        let rock = Author(username: "therock", name: "THE ROCK", avatarId: "rock")
        let jacko = Author(username: "jackowilink", name: "Jocko Willink", avatarId: "jacko")
        let kanye = Author(username: "kenyew.est", name: "Kanye West", avatarId: "kanye")
        let oprah = Author(username: "oprah", name: "Oprah", avatarId: "oprah")
        let jennifer = Author(username: "jenniferaniston", name: "Jennifer Aniston", avatarId: "jennifer")
        let casey = Author(username: "caseyneistat", name: "Casey Neistat", avatarId: "casey")
        let selena = Author(username: "selenagomez", name: "Selena Gomez", avatarId: "selena")

        // photos
        let photos = [
            Photo(
                author: taylor,
                likesCount: 98764567,
                description: "A tree 🌲.",
                locationName: "Forest",
                comments: [
                    Comment(text: "STAND BY TO GET SOME.", author: jacko),
                    Comment(text: "??", author: rock),
                    Comment(text: "Say hello to Chandler!", author: jennifer),
                ],
                photoId: "taylor-1"
            ),
            Photo(
                author: tmbk,
                likesCount: 456789,
                description: "Hotovo. Pokud by to nějaký fanda chtěl v tiskové kvalitě, jakože na transparent nebo si to vytisknout jako prachy a normálně s tím platit, napište zprávu. :-) #tmbk #jaromirjagr #kolaznaprani",
                locationName: "Kladno",
                comments: [
                    Comment(text: "In publishing and graphic design, lorem ipsum is common placeholder text used to demonstrate the graphic elements of a document or visual presentation, such as web pages, typography, and graphical layout. It is a form of \"greeking\".", author: kanye),
                    Comment(text: "Even though using \"lorem ipsum\" often arouses curiosity due to its resemblance to classical Latin, it is not intended to have meaning. Where text is visible in a document, people tend to focus on the textual content rather than upon overall presentation, so publishers use lorem ipsum when displaying a typeface or design in order to direct the focus to presentation. \"Lorem ipsum\" also approximates a typical distribution of letters in English.", author: oprah)
                ],
                photoId: "tmbk-1"
            ),
            Photo(
                author: dan,
                likesCount: 14678567,
                description: "Just the essentials",
                locationName: "SF",
                comments: [],
                photoId: "dan-1"
            ),
            Photo(
                author: rock,
                likesCount: 467987,
                description: "Last men standing. \nHOBBS & SHAW is officially wrapped. \nEasily the most challenging film I’ve ever produced and starred in, however based on the fans’ insanely hyped “break the internet” reactions to our first trailer — this film is also shaping up to be my most rewarding. \nA HUGE bald and brotherly MAHALO to the man who trusted me and our chemistry and “pushed all his chips in” to make something bad ass and fun for the fans. \nMy uso @jasonstatham. \nHe’s one legit talented and tough bastard and the pure joy I got from making him laugh so fucking hard during the our takes he couldn’t even talk, I will always remember with evil 😈 glee. \nFinally, one of the best heli pilots in the world @fred_north demonstrating here our extreme commitment we all had to deliver the goods to our worldwide audience. \n#ThatsAWrap #LastMenStanding #AllChipsIn \n#HOBBSANDSHAW AUGUST 2nd \n@sevenbucksprod",
                locationName: nil,
                comments: [],
                photoId: "rock-1"
            ),
            Photo(
                author: casey,
                likesCount: 34568567,
                description: "We take ⛷ very seriously",
                locationName: "NYC",
                comments: [],
                photoId: "casey-2"
            ),
            Photo(
                author: jacko,
                likesCount: 8567,
                description: "STAND BY TO GET SOME.",
                locationName: nil,
                comments: [],
                photoId: "jacko-1"
            ),
            Photo(
                author: kanye,
                likesCount: 14678567,
                description: "Tap tap tap.",
                locationName: nil,
                comments: [],
                photoId: "kanye-1"
            ),
            Photo(
                author: oprah,
                likesCount: 345678,
                description: "bla bla bla",
                locationName: nil,
                comments: [],
                photoId: "oprah-1"
            ),
            Photo(
                author: jennifer,
                likesCount: 987654,
                description: "bla bla bla",
                locationName: nil,
                comments: [],
                photoId: "jennifer-1"
            ),
            Photo(
                author: casey,
                likesCount: 6543298,
                description: "bla bla bla",
                locationName: nil,
                comments: [],
                photoId: "casey-1"
            ),
            Photo(
                author: selena,
                likesCount: 876543,
                description: "bla bla bla",
                locationName: nil,
                comments: [
                    Comment(text: "YO Selena, grow up!", author: kanye)
                ],
                photoId: "selena-1"
            ),
            Photo(
                author: rock,
                likesCount: 456789,
                description: "bla bla bla",
                locationName: nil,
                comments: [],
                photoId: "rock-2"
            ),
            Photo(
                author: selena,
                likesCount: 6543234567,
                description: "bla bla bla",
                locationName: nil,
                comments: [],
                photoId: "selena-2"
            ),
            Photo(
                author: taylor,
                likesCount: 987654,
                description: "bla bla bla",
                locationName: nil,
                comments: [],
                photoId: "taylor-2"
            ),
            Photo(
                author: selena,
                likesCount: 3456789,
                description: "bla bla bla",
                locationName: nil,
                comments: [],
                photoId: "selena-3"
            ),
            Photo(
                author: tmbk,
                likesCount: 987654,
                description: "bla bla bla",
                locationName: nil,
                comments: [
                    Comment(text: "Soukup na hrad!", author: rock),
                ],
                photoId: "tmbk-2"
            ),
            Photo(
                author: taylor,
                likesCount: 65432,
                description: "bla bla bla",
                locationName: nil,
                comments: [],
                photoId: "taylor-3"
            ),
            Photo(
                author: rock,
                likesCount: 9876543,
                description: "bla bla bla",
                locationName: nil,
                comments: [],
                photoId: "rock-3"
            ),
            Photo(
                author: casey,
                likesCount: 76543,
                description: "bla bla bla",
                locationName: nil,
                comments: [],
                photoId: "casey-3"
            )
        ]

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(photos)
        }
    }

}
