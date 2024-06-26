//
//  SettingView.swift
//  PokeMaster
//
//  Created by user on 2024/2/7.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var store: Store
    var settingsBinding: Binding<AppState.Settings> {
        $store.appState.settings
    }
    var settings: AppState.Settings {
        store.appState.settings
    }
    
    var body: some View {
        Form {
            accountSecion
            optionSection
            actionSection
        }
        .alert(item: settingsBinding.loginError) { error in
            Alert(title: Text(error.localizedDescription))
        }
    }
    
    var accountSecion: some View {
        Section(header: Text("帳戶")) {
            if settings.loginUser == nil {
                Picker(selection: settingsBinding.checker.accountBehavior, label: Text("")) {
                    ForEach(AppState.Settings.AccountBehavior.allCases, id: \.self) {
                        Text($0.text)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())

                TextField("電子郵件", text: settingsBinding.checker.email)
                    .foregroundColor(settings.isEmailValid ? .green : .red)
                SecureField("密碼", text: settingsBinding.checker.password)
                
                if settings.checker.accountBehavior == .register {
                    SecureField("確認密碼", text: settingsBinding.checker.verifyPassword)
                }
                
                if settings.loginRequesting {
                    Text("登入中...")
                }
                else {
                    Button(settings.checker.accountBehavior.text) {
                        self.store.dispatch(.login(email: self.settings.checker.email, password: self.settings.checker.password))
                    }
                }
            }
            else {
                Text(settings.loginUser!.email)
                Button("登出") {
                    print("登出")
                }
            }
        }
    }
    
    var optionSection: some View {
        Section(header: Text("選項")) {
            Toggle(isOn: settingsBinding.showEnglishName) {
                Text("顯示英文名")
            }
            Picker(selection: settingsBinding.sorting, label: Text("排序方式")) {
                ForEach(AppState.Settings.Sorting.allCases, id: \.self) {
                    Text($0.text)
                }
            }
            .pickerStyle(.navigationLink)
            Toggle(isOn: settingsBinding.showFavoriteOnly) {
                Text("只顯示收藏")
            }
        }
    }
    
    var actionSection: some View {
        Section {
            Button(action: {
                self.store.dispatch(.clearCache)
            }) {
                Text("清空缓存").foregroundColor(.red)
            }
        }
    }
}

extension AppState.Settings.Sorting {
    var text: String {
        switch self {
        case .id: return "ID"
        case .name: return "名字"
        case .color: return "顏色"
        case .favorite: return "最愛"
        }
    }
}

extension AppState.Settings.AccountBehavior {
    var text: String {
        switch self {
            case .register:
                return "註冊"
            case .login:
                return "登入"
            }
    }
}

#Preview {
    SettingView()
        .environmentObject(Store())
}
