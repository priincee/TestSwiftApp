//
//  APIInfoView.swift
//  APITestApp
//
//  Created by Prince Embola on 02/10/2021.
//

import Foundation
import SwiftUI

struct Colour: Codable {
    let hex_value: String
    let  color_name: String
}

struct APIInfoView: View {
    @ObservedObject var colourGetter: ColourGetter = ColourGetter()
    
    var body: some View {
        Group {
            if colourGetter.hasLoaded {
                ZStack {
                    RoundedRectangle(cornerRadius: 16.00)
                        .fill(HexStringToColour(hex:colourGetter.colours[0].hex_value))
                    VStack {
                        Text(" Possible Colour Name: \(colourGetter.colours[0].color_name) ")
                        .font(.headline)
                        Spacer()
                        Text(" Its Hex Value: \(colourGetter.colours[0].hex_value) ")
                        .font(.footnote)
                    }
                    .padding([.top, .bottom])
                    .foregroundColor(HexStringToColour(hex:colourGetter.colours[0].hex_value).accessibleFontColor)
                }
                .padding()
                .navigationTitle("Random Colour From API")
                .navigationBarItems(trailing: Button(action: self.Reload) {
                    Image(systemName: "arrow.clockwise")
                })
                
            } else {
                Text("Loading Data...")
                    .navigationTitle("Random Colour From API")
            }
        }
        .onAppear {
            colourGetter.FetchColour(reload: false)
        }
    }
    
    func Reload() {
            self.colourGetter.hasLoaded =  false
            self.colourGetter.FetchColour(reload: true)
        }
    
    private func HexStringToColour (hex: String) -> Color {
        var colourString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (colourString.hasPrefix("#")) {
            colourString.remove(at: colourString.startIndex)
        }

        if ((colourString.count) != 6) {
            return Color.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: colourString).scanHexInt64(&rgbValue)

        return Color(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0
        )
    }
}

struct APIInfoView_Previews: PreviewProvider {
    static var previews : some View {
        NavigationView {
            APIInfoView()
        }
    }
}

