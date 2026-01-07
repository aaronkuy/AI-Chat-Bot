//Load the the base functions of Swift to form the framework
import SwiftUI
import Foundation 
//@main says that here is starting the App code
@main
//Data structure is App, 
struct AIChatBotApp: App {
//'body' is the content of the App, 'Scene' is an view of the App
    //and 'some' means that swift itself determine the formation 
    var body: some Scene {
        //'WindowGroup' creates the App page, evironment of it
        WindowGroup {
            //Display the file 'ContentView()' 
            ContentView()
        }
    }
}

