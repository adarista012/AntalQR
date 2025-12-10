//
//  AboutScreen.swift
//  AntalQR
//
//  Created by antonio dante arista rivas on 12/3/25.
//
import SwiftUI

struct AboutScreen: View {
    @State private var selectedURL: SafariLinkData? = nil
    
    private let appVersion: String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
    
    var body: some View {
        List{
            Section("createdBy"){
                Button("antal.io"){
                    selectedURL = SafariLinkData(url: AppConstants.URLs.creator)
                    
                }
            }
            
            Section("legalInfo"){
                Button("privacyPolicy"){
                    selectedURL = SafariLinkData(url: AppConstants.URLs.privacyPolicy)

                }
            }
            
            VStack(alignment: .leading, spacing: Spacing.md) {
                Text(AppConstants.appName)
                    .font(.largeTitle)
                    .bold()
                
                Text("privacyMissionStatement")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                HStack {
                    Text("version")
                    
                    Text("\(appVersion)")
                    
                }.font(.footnote)
                 .foregroundColor(.secondary)
                 .frame(maxWidth: .infinity, alignment: .center)
                
            }
        }.navigationTitle("about")
         .fullScreenCover(item: $selectedURL) { linkData in
            SafariViewService(url: linkData.url).ignoresSafeArea()
         }
    }
}

#Preview {
    AboutScreen()
}
