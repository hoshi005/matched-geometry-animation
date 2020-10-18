//
//  ContentView.swift
//  anime
//
//  Created by Susumu Hoshikawa on 2020/10/18.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selected = ButtonType.share
    @Namespace var namespace
    
    var body: some View {
        HStack {
            ForEach(ButtonType.allCases, id: \.self) { type in
                CustomButton(selected: $selected, type: type, namespace: namespace)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    @Namespace static var namespace
    
    static var previews: some View {
        Group {
            ContentView()
            
            Group {
                CustomButton(selected: .constant(.share), type: .share, namespace: namespace)
                CustomButton(selected: .constant(.trash), type: .share, namespace: namespace)
            }
            .previewLayout(.fixed(width: 100, height: 100))
            
        }
    }
}

enum ButtonType: String, CaseIterable {
    case share = "square.and.arrow.up"
    case trash = "trash"
    case folder = "folder"
    case person = "person"
}

struct CustomButton: View {
    
    @Binding var selected: ButtonType
    let type: ButtonType
    
    var namespace: Namespace.ID
    
    var body: some View {
        
        ZStack {
            
            if selected == type {
                Circle()
//                    .stroke(Color.pink)
                    .fill(Color.accentColor)
                    .matchedGeometryEffect(id: "CustomButton", in: namespace)
            }
            
            Button(action: {
                withAnimation {
                    selected = type
                }
            }, label: {
                Image(systemName: type.rawValue)
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 44, height: 44)
            })
        }
        .frame(width: 80, height: 80)
    }
}
