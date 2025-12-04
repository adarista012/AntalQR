//
//  AboutScreen.swift
//  AntalQR
//
//  Created by antonio dante arista rivas on 12/3/25.
//
// ⚙️ Core/SharedUI/AboutScreen.swift

import SwiftUI

struct AboutScreen: View {
    private let appVersion: String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    
    var body: some View {
            VStack(alignment: .leading, spacing: Spacing.md) {
                Text(AppConstants.appName)
                    .font(.largeTitle)
                    .bold()
                
                Divider()
                
                HStack {
                    Text("createdBy")
                    
                    Link("antal.io", destination: AppConstants.URLs.creator)
                        .font(.body)
                        .bold()
                }
                
                Divider()
                
                HStack() {
                    Text("legalInfo")
                    
                    Link("privacyPolicy", destination: AppConstants.URLs.privacyPolicy)
                        .foregroundColor(.blue)

                }
                
                Spacer()
                
                HStack {
                    Text("version")
                    
                    Text("\(appVersion)")
                        
                }.font(.subheadline)
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .center)
                
            }.padding().navigationTitle("about")
    }
}


#Preview {
    AboutScreen()
}
