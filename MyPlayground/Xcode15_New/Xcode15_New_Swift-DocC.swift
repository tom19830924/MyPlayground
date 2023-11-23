// 文件即時預覽 assistant -> document preview
enum API {
    /// 登入帳號
    /// - Parameters:
    ///   - account: 帳號, 支援Email與手機號碼
    ///   - password: 密碼
    ///   - captcha: 驗證碼
    /// - Returns: 是否登入成功
    ///
    ///
    /// 
    func login(with account: String, password: String, captcha: String) async -> Bool {
        return false
    }
}
