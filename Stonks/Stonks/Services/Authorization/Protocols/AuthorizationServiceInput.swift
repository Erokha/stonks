protocol AuthorizationServiceInput {
    func userIsAuthorized() -> Bool
    func authorize()
}
