import Foundation

enum AnimalEnum {
    case lion
    case owl
    case dolphin
    case butterfly
}

class Personality {
    var lionLikelihood: Int = 0
    var owlLikelihood: Int = 0
    var dolphinLikelihood: Int = 0
    var butterflyLikelihood: Int = 0
    
    var like: AnimalEnum {
        var highestLikelihood = lionLikelihood
        var animal = AnimalEnum.lion
        
        if owlLikelihood > highestLikelihood {
            highestLikelihood = owlLikelihood
            animal = .owl
        }
        
        if dolphinLikelihood > highestLikelihood {
            highestLikelihood = dolphinLikelihood
            animal = .dolphin
        }
        
        if butterflyLikelihood > highestLikelihood {
            highestLikelihood = butterflyLikelihood
            animal = .butterfly
        }
        
        return animal
    }
    
    func addLikehood(_ animals: [AnimalEnum]) {
        
        for animal in animals {
            switch animal {
            case .lion:
                self.lionLikelihood += 10
            case .owl:
                self.owlLikelihood += 10
            case .dolphin:
                self.dolphinLikelihood += 10
            case .butterfly:
                self.butterflyLikelihood += 10
            }
        }
        
    }
    
}

class Answer {
    let personality: Personality
    let id: Int
    let text: String?
    init(personality: Personality, id: Int, text: String? = "") {
        self.personality = personality
        self.id = id
        self.text = text
    }
    func submit() -> Void {}
}


class AnswerTrueOfFalse: Answer {
    var animalLikehoods: [AnimalEnum] = []
    var selected: Bool = false
    override func submit() {
        if selected {
            self.personality.addLikehood(self.animalLikehoods)
        }
    }
    init(personality: Personality, id: Int, text: String? = "", animalLikehoods: [AnimalEnum], selected: Bool) {
        super.init(personality: personality, id: id, text: text)
        self.animalLikehoods = animalLikehoods
        self.selected = selected
    }
}

class AnswerNumberValue: Answer {
    var numberValue: Int = 0
    let lionRange: ClosedRange<Int>
    let owlRange: ClosedRange<Int>
    let dophinRange: ClosedRange<Int>
    let butterflyRange: ClosedRange<Int>
    
    init(personality: Personality, id: Int, text: String? = "", numberValue: Int, lionRange: ClosedRange<Int>, owlRange: ClosedRange<Int>, dophinRange: ClosedRange<Int>, butterflyRange: ClosedRange<Int>) {
        self.numberValue = numberValue
        self.lionRange = lionRange
        self.owlRange = owlRange
        self.dophinRange = dophinRange
        self.butterflyRange = butterflyRange
        super.init(personality: personality, id: id, text: text)
    }
    
    
    
    override func submit() {
        switch self.numberValue {
        case lionRange:
            self.personality.addLikehood([.lion])
        case owlRange:
            self.personality.addLikehood([.owl])
        case dophinRange:
            self.personality.addLikehood([.dolphin])
        case butterflyRange:
            self.personality.addLikehood([.butterfly])
        default:
            break
        }
    }
    
}


struct Quiz {
    let personality: Personality
    let question: String
    let answers: Array<Answer>
}


import Foundation

let personality: Personality = Personality()
let quiz1 = Quiz(personality: personality,
                 question: """
                    Now, please imagine yourself in a forest.
                    As you walk forward, you see a small cottage before you.
                    And you notice...
                 """,
                 answers: [
                    AnswerTrueOfFalse(personality: personality, id: 0, text: "A massive tree standing in front of it?",  animalLikehoods: [.owl, .lion], selected: false),
                    AnswerTrueOfFalse(personality: personality, id: 1, text: "A vast meadow surrounding it?",  animalLikehoods: [.lion, .butterfly], selected: false),
                    AnswerTrueOfFalse(personality: personality, id: 2, text: "A myriad of colorful flowers coverring it",  animalLikehoods: [.butterfly, .dolphin], selected: false),
                    AnswerTrueOfFalse(personality: personality, id: 3, text: "The door is wide open",  animalLikehoods: [], selected: false),
                 ])
let quiz2 = Quiz(personality: personality,
                 question: """
                            You enter the cottage and notice a table in the center of the room.
                            The table's shape is a ?
                          """,
                 answers:  [
                    AnswerTrueOfFalse(personality: personality, id: 0, text: "Circle?",  animalLikehoods: [.owl], selected: false),
                    AnswerTrueOfFalse(personality: personality, id: 1, text: "Square?",  animalLikehoods: [.dolphin], selected: false),
                    AnswerTrueOfFalse(personality: personality, id: 2, text: "Rectangle",  animalLikehoods: [.lion], selected: false),
                    AnswerTrueOfFalse(personality: personality, id: 3, text: "triangle",  animalLikehoods: [.butterfly], selected: false),]     )

let quiz3 = Quiz(personality: personality,
                 question: """
                            You spot a delicate vase filled with freshly picked flowers.
                            The number of flowers is?
                          """,
                 answers:  [AnswerNumberValue(personality: personality, id: 0, numberValue: 0, lionRange: 0...24, owlRange: 25...49, dophinRange: 50...74, butterflyRange: 75...100)]     )

let quiz4 = Quiz(personality: personality,
                 question: """
                            As you walk around to the back of the cottage.
                            You discover a small river running alongside it.
                            You dip your toes in the water.
                            The tempture of the water is?
                          """,
                 answers:  [AnswerNumberValue(personality: personality, id: 0, numberValue: 0, lionRange: 50...74, owlRange: 25...49, dophinRange: 0...24, butterflyRange: 75...100)]     )



let quizs: [Quiz] = [quiz1, quiz2, quiz3, quiz4]

let answer1: AnswerTrueOfFalse = quiz1.answers[1] as! AnswerTrueOfFalse
let answer2: AnswerTrueOfFalse = quiz1.answers[2] as! AnswerTrueOfFalse
let answer3: AnswerNumberValue = quiz3.answers[0] as! AnswerNumberValue
answer1.selected = true
answer1.submit()
answer2.selected = true
answer2.submit()
answer3.numberValue = 95
answer3.submit()

//print(quizs)
for q in quizs {
    for a in q.answers {
        print("lion: \(a.personality.lionLikelihood)")
        print("owl: \(a.personality.owlLikelihood)")
        print("dolphin: \(a.personality.dolphinLikelihood)")
        print("butterfly: \(a.personality.butterflyLikelihood)")
    }
}





