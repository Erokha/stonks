protocol AuthorizationServiceInput {
    func userIsAuthorized() -> Bool
    func saveUser(name: String, surname: String)
    func getUser() -> (String, String)?
}
