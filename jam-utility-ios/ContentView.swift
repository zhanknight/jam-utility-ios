//
//  ContentView.swift
//  jam-utility-ios
//
//  Created by Zhan Knight on 7/29/22.
//

import SwiftUI


//the scale struct
struct Scale: Identifiable {
    let id = UUID()
    var quality: String
    var intervals: Array<Int>
    var root: String = "A"
    // build chords eventually
    func chords(root: String) -> Array<String> {
        return ["chords","go","here"]
    }
    // build scale from given root note
    func notes(root: String) -> Set<String> {
            let startNote = allNotes.firstIndex(of: root)!
            var theNotes: Set<String> = []
                theNotes.insert(allNotes[startNote])
                    for num in intervals {
                        theNotes.insert(allNotes[startNote + num])
                    }
            return theNotes
    }
}

let allNotes = ["A", "A#/Bb", "B", "C", "C#/Db", "D", "D#/Eb", "E", "F", "F#/Gb", "G", "G#/Ab",
                "A", "A#/Bb", "B", "C", "C#/Db", "D", "D#/Eb", "E", "F", "F#/Gb", "G", "G#/Ab"]
let allNotesUnique = Array(Set(allNotes))

// the definitions
let major = Scale(quality: "Major", intervals: [2,4,5,7,9,11], root: "B")
let minor = Scale(quality: "Minor", intervals: [2,3,5,7,8,10], root: "B")
let dorian = Scale(quality: "Dorian", intervals: [2,3,5,7,9,10])
let phrygian = Scale(quality: "Phrygian", intervals: [1,3,5,7,8,10])
let lydian = Scale(quality: "Lydian", intervals: [2,4,6,7,9,11])
let mixolydian = Scale(quality: "Mixolydian", intervals: [2,4,5,7,9,10])
let locrian = Scale(quality: "Locrian", intervals: [1,3,5,6,8,10])

//all available definitions
let allDefinitions = [major, minor, dorian, phrygian, lydian, mixolydian, locrian]


// generate all scales with all roots
func generateAllScales() -> Array<Scale> {
    var allScales = Array<Scale>()
    for note in allNotesUnique {
        for definition in allDefinitions {
            allScales.append(Scale(quality: definition.quality, intervals: definition.intervals, root: note))
        }
    }
    return allScales
}


// the UI
struct ContentView: View {
    var test = generateAllScales()
    @State private var selectedNotes: Set<String> = []
    @State var resultCount = 0
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.init(red: 0.2, green: 0.3, blue: 0.5, opacity: 0.5)
                VStack {
                    // buttons here
                    HStack {
                        ForEach(allNotesUnique, id: \.self) { note in
                            Button(note) {
                                if selectedNotes.contains(note) {
                                    selectedNotes.remove(note)
                                }
                                else {
                                    selectedNotes.insert(note)
                                }
                                print(selectedNotes)
                                print(test)
                            }

                        }
                    }
                    // results here
                    List {
                        ForEach(allDefinitions) { definition in
                            ForEach(allNotesUnique, id: \.self) { note in
                                if definition.notes(root: note).isSuperset(of: selectedNotes) {
                            HStack {
                                Text(definition.quality).foregroundColor(.red)
                                VStack {
                                    Text(definition.notes(root: note).joined(separator: ", "))
                                    Text(definition.chords(root: note).joined(separator: " "))
                                }
                                }
                            }
                            }
                        }
                        }
                    Text("reset button at the bottom")
                }
            }.navigationTitle("Jam Utility").navigationBarTitleDisplayMode(.inline)
        }
    }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
