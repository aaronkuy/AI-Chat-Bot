import SwiftUI
import Foundation 

struct ContentView: View {

    @State private var input = ""
    @State private var response = ""
    @State private var isLoading = false

    var body: some View {
        VStack(spacing: 16) {

            ScrollView {
                Text(response)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
            }
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(8)
            .frame(maxHeight: 400)

            TextField("Enter prompt...", text: $input)
                .textFieldStyle(.roundedBorder)

            Button(action: {
                Task {
                    await sendPrompt()
                }
            }) {
                HStack {
                    if isLoading {
                        ProgressView()
                    }
                    Text(isLoading ? "Loading..." : "Send")
                        .bold()
                }
                .frame(maxWidth: .infinity)
            }
            .disabled(isLoading || input.isEmpty)
            .buttonStyle(.borderedProminent)

        }
        .padding()
    }

    func sendPrompt() async {
        isLoading = true
        response = ""

        do {
            response = try await AIService.sendPrompt(input)
        } catch {
            response = "Error: \(error.localizedDescription)"
        }

        isLoading = false
    }
}




