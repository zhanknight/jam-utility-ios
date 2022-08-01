//
//  ContentView.swift
//  jam-utility-ios
//
//  Created by Zhan Knight on 7/29/22.
//

import SwiftUI

//the scale struct
struct Scale {
    let id = UUID()
    var quality: String
    var intervals: Array<Int>
    // build chords
    func chords(root: String) -> Array<String> {
        return ["chords","go","here"]
    }
    // build scale from given root note
    func notes(root: String) -> Array<String> {
        let allNotes = ["A", "A#/Bb", "B", "C", "C#/Db", "D", "D#/Eb", "E", "F", "F#/Gb", "G", "G#/Ab",
                        "A", "A#/Bb", "B", "C", "C#/Db", "D", "D#/Eb", "E", "F", "F#/Gb", "G", "G#/Ab"]
            let startNote = allNotes.firstIndex(of: root)!
            var theNotes: Array<String> = []
                theNotes.append(allNotes[startNote])
                    for num in intervals {
                        theNotes.append(allNotes[startNote + num])
                    }
            return theNotes
    }
}

// the definitions
let major = Scale(quality: "major", intervals: [2,4,5,7,9,11])
let minor = Scale(quality: "minor", intervals: [2,3,5,7,8,10])

//all available definitions
let allDefinitions = [major, minor]


struct Result {
    var root: String
    var notes: Array<String>
}





// the UI
struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.init(red: 0.2, green: 0.3, blue: 0.5, opacity: 0.5)
                VStack {
                    Text("Note buttons go here")
                    List {
                        
                        ForEach(allDefinitions, id: \.id) { x in
                            HStack {
                                Text(x.quality).foregroundColor(.red)
                                VStack {
                                    Text(x.notes(root: "A").joined(separator: ", "))
                                    Text(x.chords(root: "A").joined(separator: " & "))
                                }
                            }
                        }
                        }
                    Text("reset button at the bottom")
                }
            }.navigationTitle("Jam Utility")
        }
    }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
