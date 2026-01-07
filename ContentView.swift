//Insert the base elements needed for the framework
import SwiftUI
import Foundation 

//'View' is the UI view 
struct ContentView: View {

//'@state' are variables that are changable in terms of value. 
//Means if true than the UI is rebuilding to the correspnded values
    @State private var input = ""
    @State private var response = ""
//Initial value is needed for the button implementation 
    @State private var isLoading = false
//UI revise in terms of design 
    var body: some View {
//Vertical stack, with the spacing of 16 pixels
        VStack(spacing: 16) {
//View for the responsive page of the chat bot, with the feature to scroll for UX 
            ScrollView {
//Text of 'response' is changing automatically
                Text(response)
//'.frame(maxWidth:' takes the whole width, and turn it leftwing 
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
            }
//Container for the Chat window, light grey background, rounded corners, 400px high 
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(8)
            .frame(maxHeight: 400)
//Input field with the corresponded placedholder, everything what the user types is 
            //bind to the variable 'input', rounded corners for UX
            TextField("Enter prompt...", text: $input)
                .textFieldStyle(.roundedBorder)
//Task for debug, so it won't freeze while waiting for the network request
 //If the button got pressed then execute the sendPompt() function. 
            Button(action: {
                Task {
                    await sendPrompt()
                }
            }) {
//Button content, horizontal stack, 
                HStack {
//If 'isLoading' is True then initiate the loading circle 
                    if isLoading {
                        ProgressView()
                    }
                    Text(isLoading ? "Loading..." : "Send")
                        .bold()
                }
                .frame(maxWidth: .infinity)
            }
//Button is deactivated when just loaded xor the input field empty is
            .disabled(isLoading || input.isEmpty)
            .buttonStyle(.borderedProminent)

        }
//End result gets padding for better overview
        .padding()
    }

    func sendPrompt() async {
//Button is getting disabled, loading circle appears 
        isLoading = true
//Old reply is getting deleted 
        response = ""

        do {
//Input content is getting send to AIService and saved to the variable 'response'
            response = try await AIService.sendPrompt(input)
        } catch {
//Catch potential errors for debugging followed by the corresponded string
            response = "Error: \(error.localizedDescription)"
        }
//Loading circle disappeard and button reappears 
        isLoading = false
    }
}




