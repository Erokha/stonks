protocol AuthorizationServiceInput {
    func userIsAuthorized() -> Bool

    func isNewUser() -> Bool

    func setUserIsNotNew()

    func authorize()

    func deAuthorize()
}
