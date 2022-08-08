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
    func chords() -> Array<String> {
        return ["chords","go","here"]
    }
    // build scale from given root note
    func notes() -> Set<String> {
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
let major = Scale(quality: "Major", intervals: [2,4,5,7,9,11])
let minor = Scale(quality: "Minor", intervals: [2,3,5,7,8,10])
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
    @State var test2 = Array<Scale>()
    @State private var selectedNotes: Set<String> = []
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.init(red: 0.2, green: 0.3, blue: 0.5, opacity: 0.5)
                VStack {
                    
                    // buttons here
                    VStack {
                        HStack {
                            Spacer()
                            Spacer()
                            Button("C#/Db") {
                                noteFilter(selection: "C#/Db")
                            }.frame(maxWidth: .infinity)
                                .border(Color.black)
                            Button("D#/Eb") {
                                noteFilter(selection: "D#/Eb")
                            }.frame(maxWidth: .infinity)
                                .border(Color.black)
                            Spacer().frame(maxWidth: .infinity)
                                .border(Color.black)
                            Button("F#/Gb") {
                                noteFilter(selection: "F#/Gb")
                            }.frame(maxWidth: .infinity)
                                .border(Color.black)
                            Button("G#/Ab") {
                                noteFilter(selection: "G#/Ab")
                            }.frame(maxWidth: .infinity)
                                .border(Color.black)
                            Button("A#/Bb") {
                                noteFilter(selection: "A#/Bb")
                            }.frame(maxWidth: .infinity)
                                .border(Color.black)
                            Spacer()
                            Spacer()
                        }
                        HStack {
                            Button("C") {
                                noteFilter(selection: "C")
                            }.frame(maxWidth: .infinity)
                                .border(Color.white)
                            Button("D") {
                                noteFilter(selection: "D")
                            }.frame(maxWidth: .infinity)
                                .border(Color.white)
                            Button("E") {
                                noteFilter(selection: "E")
                            }.frame(maxWidth: .infinity)
                                .border(Color.white)
                            Button("F") {
                                noteFilter(selection: "F")
                            }.frame(maxWidth: .infinity)
                                .border(Color.white)
                            Button("G") {
                                noteFilter(selection: "G")
                            }.frame(maxWidth: .infinity)
                                .border(Color.white)
                            Button("A") {
                                noteFilter(selection: "A")
                            }.frame(maxWidth: .infinity)
                                .border(Color.white)
                            Button("B") {
                                noteFilter(selection: "B")
                            } .frame(maxWidth: .infinity)
                                .border(Color.white)
                        }
                    }
                    // results here
                    List {
                        ForEach(test) { scales in
                            if scales.notes().isSuperset(of: selectedNotes) {
                                HStack {
                                    Text(scales.quality).foregroundColor(.red)
                                    VStack {
                                        Text(scales.notes().joined(separator: ", "))
                                        Text(scales.chords().joined(separator: " "))
                                    }
                                }
                            }
                        }
                    }
                    Button("Clear Selected Notes") {
                        selectedNotes.removeAll()
                        print(selectedNotes)
                    }
                }
            }.navigationTitle("Jam Utility").navigationBarTitleDisplayMode(.inline)
        }
    }
    
    //function runs when any note button is tapped
    func noteFilter(selection: String) {
        if selectedNotes.contains(selection) {
            selectedNotes.remove(selection)
        }
        else {
            selectedNotes.insert(selection)
        }
        print(selectedNotes)
        
// this is where we'll create a separate array to filter from, then the list will just iterate out from here, that way we can display error if no results

//                           for scales in test {
//                               if scales.notes().isSuperset(of: selectedNotes) {
//                                   test2.append(scales)
//                               }
//                           }
        
        
    }
    
    
}







struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
