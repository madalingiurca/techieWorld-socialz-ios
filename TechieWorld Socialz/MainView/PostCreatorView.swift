//
//  PostCreatorView.swift
//  TechieWorld Socialz
//
//  Created by Madalin Giurca on 24.04.2022.
//

import SwiftUI

struct PostCreatorView: View {
    var dismiss: () -> ()
    @State var text: String = ""
    
    @FocusState private var focusedTextField : Bool;
    
    var body: some View {
        VStack {
            HStack {
                Text("Create a new post")
                    .font(.title2)
                    .bold()
                .padding()
            
                Spacer()
                
                Button(action: dismiss, label: {
                    Image(systemName: "x.circle.fill")
                        .resizable()
                        .foregroundColor(Color.primary)
                        .frame(width: 30, height: 30, alignment: .trailing)
                })
                .padding()
            }
            
            Spacer()
            
            VStack {
                TextEditor(text: $text)
                    .focused($focusedTextField)
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                            focusedTextField = true
                        }
                    }
                    .frame(minHeight: 30, maxHeight: 300, alignment: .center)
                    .foregroundColor(Color(.label))
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 5)
                    .padding(.trailing, 5)
                
                Button(action: {
                    debugPrint("Post content \(text)")
                    dismiss()
                }, label: {
                    Image(systemName: "arrow.up.message.fill")
                        .resizable()
                        .foregroundColor(Color.primary)
                        .frame(width: 40, height: 40, alignment: .center)
                })
            }
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.primary, lineWidth: 1)
            )
            .padding()
            
        }
    }
}

struct PostCreatorView_Previews: PreviewProvider {
    static var previews: some View {
        PostCreatorView(dismiss: {}, text: "fdjksnafposakdfsdafsdfa\nfgdasdfasdfasdcasd\nd\n\nadsgfsadgadsfgadfgadsfgasdfdjksnafposakdfsdafsdfa\nfgdasdfasdfasdcasdnd\nadsgfsadgadsfgadfgadsfgasdfdjksnafposakdfsdafsdfa\nfgdasdfasdfasdcasd\nadsgfsadgadsfgadfgadsfgasd")
            
    }
}
