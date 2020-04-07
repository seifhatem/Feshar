//
//  MovieDummyList.swift
//  Feshar
//
//  Created by Seif Elmenabawy on 3/31/20.
//  Copyright © 2020 Seif Elmenabawy. All rights reserved.
//

import Foundation

//
//
//let leonardo = Cast(name: "Leonardo DiCaprio", bio: "Few actors in the world have had a career quite as diverse as Leonardo DiCaprio's.", photoIdentifier: "leonardo")
//let reiner = Cast(name: "Rob Reiner", bio: "Robert Reiner was born in New York City, to Estelle Reiner (née Lebost) and Emmy-winning actor, comedian, writer, and producer Carl Reiner.", photoIdentifier: "reiner")
//let jonah  = Cast(name: "Jonah Hill", bio: "Jonah Hill was born and raised in Los Angeles, the son of Sharon Feldstein (née Chalkin), a fashion designer and costume stylist, and Richard Feldstein, a tour accountant for Guns N' Roses.", photoIdentifier: "jonah")
//let wolfofwallstreetcast = [leonardo,reiner,jonah]
//let wolfofwallstreet = Movie(id: 1, title: "The Wolf of Wall Street", posterIdentifier: "wolf_poster", genre: .Comedy, duration: "3 hours", cast: wolfofwallstreetcast, imdbRating: "8.2", tags: [.Comedy,.Trending], description: "Introduced to life in the fast lane through stockbroking, Jordan Belfort takes a hit after a Wall Street crash. He teams up with Donnie Azoff, cheating his way to the top as his relationships slide.")
//
//let martin = Cast(name: "Martin Lawrence", bio: "Martin Lawrence was born on April 16, 1965 in Frankfurt am Main, Hesse, Germany as Martin Fitzgerald Lawrence.", photoIdentifier: "martin")
//let nia = Cast(name: "Nia Long", bio: "Stunning pop culture icon, Hollywood leading lady and three-time NAACP award winner Nia Long returns to the big screen this fall in the highly anticipated Universal Pictures sequel The Best Man Holiday", photoIdentifier: "nia")
//
//let bigmommashousecast = [martin,nia]
//let bigmommashouse = Movie(id: 2, title: "Big Momma's House", posterIdentifier: "bigmommas_poster", genre: .Comedy, duration: "1h 39m", cast: bigmommashousecast, imdbRating: "5.2", tags: [.Comedy,.Trending], description: "In order to protect a beautiful woman and her son from a robber, a male FBI agent disguises himself as a large grandmother.")
//
//let dwayne = Cast(name: "Dwayne Johnson", bio: "Dwayne Douglas Johnson, also known as The Rock, was born on May 2, 1972 in Hayward, California.", photoIdentifier: "dwayne")
//let zac = Cast(name: "Zac Efron", bio: "Zachary David Alexander Efron was born October 18, 1987 in San Luis Obispo, California, to Starla Baskett, a secretary, and David Efron, an electrical engineer.", photoIdentifier: "zac")
//let priyanka = Cast(name: "Priyanka Chopra", bio: "Priyanka Chopra Jonas (née Chopra) was born on July 18, 1982 in Jamshedpur, India, to the family of Capt. Dr. Ashok Chopra and Dr. Madhu Chopra, both Indian Army physicians. She had a very varied upbringing.", photoIdentifier: "priyanka")
//
//let baywatchcast = [dwayne,zac,priyanka]
//let baywatch = Movie(id: 3, title: "Bay Watch", posterIdentifier: "bay_poster", genre: .Comedy, duration: "2 hours", cast: baywatchcast, imdbRating: "5.5", tags: [.Comedy,.New], description: "Lifeguard Mitch Buchannon and his team discover a drug racket involving businesswoman Victoria Leeds and decide to unearth the truth and bring the perpetrators to justice.")
//
//let jason = Cast(name: "Jason Statham", bio: "Jason Statham was born in Shirebrook, Derbyshire, to Eileen (Yates), a dancer, and Barry Statham, a street merchant and lounge singer. He was a Diver on the British National Diving Team and finished twelfth in the World Championships in 1992. ", photoIdentifier: "jason")
//let idris = Cast(name: "Idris Elba", bio: "An only child, Idrissa Akuna Elba was born and raised in London, England. His father, Winston, is from Sierra Leone and worked at Ford Dagenham; his mother, Eve, is from Ghana and had a clerical duty.", photoIdentifier: "idris")
//
//let hobbscast = [dwayne,jason,idris]
//let hobbs = Movie(id: 4, title: "Hobbs & Shaw", posterIdentifier: "hobbs_poster", genre: .Action, duration: "2h 16m", cast: hobbscast, imdbRating: "6.5", tags: [.Action,.New], description: "Lawman Luke Hobbs (Dwayne \"The Rock\" Johnson) and outcast Deckard Shaw (Jason Statham) form an unlikely alliance when a cyber-genetically enhanced villain threatens the future of humanity.")
//
//let ansel = Cast(name: "Ansel Elgort", bio: "Ansel Elgort is an American actor, known for playing Augustus Waters in the romance The Fault in Our Stars (2014) and the title character in the action thriller Baby Driver (2017). ", photoIdentifier: "ansel")
//let bernthal = Cast(name: "Jon Bernthal", bio: "Jon Bernthal was born and raised in Washington D.C., the son of Joan (Marx) and Eric Bernthal, a lawyer. His grandfather was musician Murray Bernthal. Jon went to study at The Moscow Art Theatre School, in Moscow, Russia, where he also played professional baseball in the European professional baseball federation.", photoIdentifier: "bernthal")
//let hamm = Cast(name: "Jon Hamm", bio: "Jon Hamm was born on March 10, 1971 in St. Louis, Missouri, USA as Jonathan Daniel Hamm. He is an actor and producer, known for Mad Men (2007), The Town (2010) and Million Dollar Arm (2014).", photoIdentifier: "hamm")
//let kevin = Cast(name: "Kevin Spacey", bio: "Kevin Spacey Fowler, better known by his stage name Kevin Spacey, is an American actor of screen and stage, film director, producer, screenwriter and singer.", photoIdentifier: "kevin")
//
//let babydrivercast = [ansel,bernthal,kevin,hamm]
//let babydriver = Movie(id: 5, title: "Baby Driver", posterIdentifier: "baby_poster", genre: .Action, duration: "1h 53m", cast: babydrivercast, imdbRating: "7.6", tags: [.Action,.Trending], description: "Doc forces Baby, a former getaway driver, to partake in a heist, threatening to hurt his girlfriend if he refuses. The plan goes awry when their arms dealers turn out to be undercover officers.")
//
//
//let shailene = Cast(name: "Shailene Woodley", bio: "Actress Shailene Woodley was born in Simi Valley, California, to Lori (Victor), a middle school counselor, and Lonnie Woodley, a school principal. ", photoIdentifier: "shailene")
//
//let faultcast = [ansel,shailene]
//let faultstars = Movie(id: 6, title: "The Fault in Our Stars", posterIdentifier: "fault_poster", genre: .Romance, duration: "2h 13m", cast: faultcast, imdbRating: "7.7", tags: [.Romance,.Trending], description: "Two teenage cancer patients begin a life-affirming journey to visit a reclusive author in Amsterdam.")
