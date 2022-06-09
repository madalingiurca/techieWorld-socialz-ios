//
//  PostCreatorView.swift
//  TechieWorld Socialz
//
//  Created by Madalin Giurca on 24.04.2022.
//

import SwiftUI

struct PostCreatorView: View {

    @State var text: String = ""
    let textPlaceholder = "Tap here to start typing..."
    @Binding var isPresented: Bool
    @State var showSubmitPostDialog = false
    @State var posting = false
    @FocusState private var focusedTextField : Bool;

    init(isPresented: Binding<Bool>) {
        self._isPresented = isPresented
    }

    init(isPresented: Binding<Bool>, text: String) {
        self._isPresented = isPresented
        self.text = text
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Create a new post")
                    .font(.title2)
                    .bold()
                    .padding()

                Spacer()

                Button(action: { isPresented = false }, label: {
                    Image(systemName: "x.circle.fill")
                        .resizable()
                        .foregroundColor(Color.primary)
                        .frame(width: 30, height: 30, alignment: .trailing)
                })
                .padding()
            }
            
            VStack {
                VStack {
                    if text.isEmpty && !focusedTextField {
                        Text("Tap here to start typing...")
                            .foregroundColor(Color(UIColor.placeholderText))
                            .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
                            .padding(.horizontal, 5)
                            .padding(.top, 10.0)
                    }
                    TextEditor(text: $text)
                        .focused($focusedTextField)
                }
                    .frame(minHeight: 30, maxHeight: .greatestFiniteMagnitude)
                    .onTapGesture {
                        focusedTextField.toggle()
                    }
                    .padding(.leading, 5)
                    .padding(.trailing, 5)
                    .overlay(RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.primary, lineWidth: 1))

            }


            TwButton("Submit") {
                showSubmitPostDialog = true
                focusedTextField = false
            }
            .alert("Submit post?", isPresented: $showSubmitPostDialog, actions: {
                Button("Cancel") { }
                Button("Submit") {
                    isPresented = false
                }
            })
            .padding(.all, 7.0)
        }
        .padding(.horizontal)
    }
}

struct PostCreatorView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PostCreatorView(
                isPresented: .constant(true),
                text: "fdjksnafposakdfsdafsdfa\nfgdasdfasdfasdcasd\nd\n\nadsgfsadgadsfgadfgadsfgasdfdjksnafposakdfsdafsdfa\nfgdasdfasdfasdcasdnd\nadsgfsadgadsfgadfgadsfgasdfdjksnafposakdfsdafsdfa\nfgdasdfasdfasdcasd\nadsgfsadgadsfgadfgadsfgasd"
            )
            PostCreatorView(
                isPresented: .constant(true),
                text: "fdjksnafposakdfsdafsdfa\nfgdasdfasdfasdcasd\nd\n\nadsgfsadgadsfgadfgadsfgasdfdjksnafposakdfsdafsdfa\nfgdasdfasdfasdcasdnd\nadsgfsadgadsfgadfgadsfgasdfdjksnafposakdfsdafsdfa\nfgdasdfasdfasdcasd\nadsgfsadgadsfgadfgadsfgasd"
            )
            .preferredColorScheme(.dark)
        }

    }
}
