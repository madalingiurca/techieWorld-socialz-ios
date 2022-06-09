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
    @FocusState private var focusedTextField : Bool
    let dataSource: PostDataSource

    init(dataSource: PostDataSource, isPresented: Binding<Bool>) {
        self.dataSource = dataSource
        self._isPresented = isPresented
    }

    init(dataSource: PostDataSource, isPresented: Binding<Bool>, text: String) {
        self.init(dataSource: dataSource, isPresented: isPresented)
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

                if !posting {
                    Button(action: { isPresented = false }, label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .foregroundColor(Color.primary)
                            .frame(width: 20, height: 20, alignment: .trailing)
                    })
                    .padding()
                } else {
                    // Cancel button
                }
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
                .padding(.horizontal, 5)
                .overlay(RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.primary, lineWidth: 1))

            }


            TwButton("Submit", loading: posting) {
                showSubmitPostDialog = true
                focusedTextField = false
            }
            .alert("Submit post?", isPresented: $showSubmitPostDialog, actions: {
                Button("Cancel") { }
                Button("Submit") {
                    posting = true
                    dataSource.createNewPost(text) {
                        isPresented = false
                        posting = false
                    }
                }
            })
            .padding(.all, 7.0)
        }
        .padding(.horizontal)
    }
}

struct PostCreatorView_Previews: PreviewProvider {
    static var previews: some View {
        let dataSource = PostDataSource(accessToken: "access-token")
        return Group {
            PostCreatorView(
                dataSource: dataSource,
                isPresented: .constant(true),
                text: "fdjksnafposakdfsdafsdfa\nfgdasdfasdfasdcasd\nd\n\nadsgfsadgadsfgadfgadsfgasdfdjksnafposakdfsdafsdfa\nfgdasdfasdfasdcasdnd\nadsgfsadgadsfgadfgadsfgasdfdjksnafposakdfsdafsdfa\nfgdasdfasdfasdcasd\nadsgfsadgadsfgadfgadsfgasd"
            )
            PostCreatorView(
                dataSource: dataSource,
                isPresented: .constant(true),
                text: "fdjksnafposakdfsdafsdfa\nfgdasdfasdfasdcasd\nd\n\nadsgfsadgadsfgadfgadsfgasdfdjksnafposakdfsdafsdfa\nfgdasdfasdfasdcasdnd\nadsgfsadgadsfgadfgadsfgasdfdjksnafposakdfsdafsdfa\nfgdasdfasdfasdcasd\nadsgfsadgadsfgadfgadsfgasd"
            )
            .preferredColorScheme(.dark)
        }

    }
}
