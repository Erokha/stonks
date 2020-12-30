import UIKit
import PinLayout

class TermsConditionsViewController: UIViewController {

    private weak var titleLabel: UILabel!

    private weak var termsAndConditionsTextView: UITextView!

    private weak var termsAndConditionsTextViewGradientUp: CAGradientLayer!

    private weak var termsAndConditionsTextViewGradientDown: CAGradientLayer!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupSubviews()
    }

    private func setupView() {
        view.backgroundColor = Constants.backgroundColor
    }

    private func setupSubviews() {
        setupTitleLabel()
        setupTermsAndConditionsTextView()
    }

    private func setupTitleLabel() {
        let label = UILabel()

        titleLabel = label
        view.addSubview(titleLabel)

        titleLabel.text = Constants.TitleLabel.text
        titleLabel.textAlignment = .center
        titleLabel.font = Constants.TitleLabel.font
    }

    private func setupTermsAndConditionsTextView() {
        let textView = UITextView()

        termsAndConditionsTextView = textView
        view.addSubview(termsAndConditionsTextView)

        termsAndConditionsTextView.isEditable = false
        termsAndConditionsTextView.isSelectable = false
        termsAndConditionsTextView.isScrollEnabled = true
        termsAndConditionsTextView.showsVerticalScrollIndicator = true
        termsAndConditionsTextView.backgroundColor = Constants.backgroundColor

        termsAndConditionsTextView.font = Constants.TermsAndConditionsTextView.font
        termsAndConditionsTextView.text = Constants.TermsAndConditionsTextView.text

        let upGradient = CAGradientLayer()
        let downGradient = CAGradientLayer()

        termsAndConditionsTextViewGradientUp = upGradient
        termsAndConditionsTextViewGradientDown = downGradient

        view.layer.addSublayer(termsAndConditionsTextViewGradientUp)
        view.layer.addSublayer(termsAndConditionsTextViewGradientDown)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        layoutTitleLabel()
        layoutTermsAndConditionsTextView()
    }

    private func layoutTitleLabel() {
        titleLabel.pin
            .top(Constants.TitleLabel.topPercent)
            .width(Constants.TitleLabel.widthPercent)
            .height(Constants.TitleLabel.height)
    }

    private func layoutTermsAndConditionsTextView() {
        termsAndConditionsTextView.pin
            .below(of: titleLabel).marginTop(Constants.TermsAndConditionsTextView.topMargin)
            .hCenter()
            .width(Constants.TermsAndConditionsTextView.widthPercent)
            .bottom(Constants.TermsAndConditionsTextView.bottomPercent)

        termsAndConditionsTextViewGradientUp.frame = CGRect(x: .zero,
                                  y: termsAndConditionsTextView.frame.minY,
                                  width: termsAndConditionsTextView.bounds.width,
                                  height: Constants.TermsAndConditionsTextView.gradientOffset)
        termsAndConditionsTextViewGradientUp.colors = [Constants.backgroundColor.cgColor,
                             Constants.gradientBackgroundColor.cgColor]

        termsAndConditionsTextViewGradientDown.frame = CGRect(x: .zero,
                                    y: termsAndConditionsTextView.frame.maxY - Constants.TermsAndConditionsTextView.gradientOffset,
                                    width: termsAndConditionsTextView.bounds.width,
                                    height: Constants.TermsAndConditionsTextView.gradientOffset)
        termsAndConditionsTextViewGradientDown.colors = [Constants.gradientBackgroundColor.cgColor,
                               Constants.backgroundColor.cgColor]
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        updateUI()
    }

    private func updateUI() {
        updateView()
        updateTermsAndConditionsTextView()
    }

    private func updateView() {
        view.backgroundColor = Constants.backgroundColor
    }

    private func updateTermsAndConditionsTextView() {
        termsAndConditionsTextView.backgroundColor = Constants.backgroundColor
    }
}

extension TermsConditionsViewController {
    private struct Constants {
        static var backgroundColor: UIColor {
            if UITraitCollection.current.userInterfaceStyle == .dark {
                return UIColor(red: 61 / 255,
                               green: 59 / 255,
                               blue: 69 / 255,
                               alpha: 1)
            } else {
                return .white
            }
        }

        static var gradientBackgroundColor: UIColor {
            if UITraitCollection.current.userInterfaceStyle == .dark {
                return UIColor(red: 61 / 255,
                               green: 59 / 255,
                               blue: 69 / 255,
                               alpha: 0)
            } else {
                return UIColor(red: 1,
                               green: 1,
                               blue: 1,
                               alpha: 0)
            }
        }

        struct TitleLabel {
            static let font: UIFont? = UIFont(name: "DMSans-Bold", size: 17)

            static let text: String = "Terms&Conditions"

            static let topPercent: Percent = 2%

            static let widthPercent: Percent = 100%

            static let height: CGFloat = 40
        }

        struct TermsAndConditionsTextView {
            static let font: UIFont? = UIFont(name: "DMSans-Regular", size: 13)

            static let text: String = """
            Present The license agreement (hereinafter referred to as the Agreement) governs the relations between Stonks LLC (OGRN 1027739850962, Russia, 125167, Moscow, Leningradsky Prospekt 39, p. 79), hereinafter referred to as the "Company" and by You, hereinafter referred to as the "User", on using the program for Computer (hereinafter referred to as the "Stonks Service", "Service"), under the following conditions::

            1. Terms and definitions:

            Service – a set of programs for Computers and other intellectual property objects Companies ( including graphical interface design (design) , etc.), information (Content) posted by By the company and/or By users. You can access the Service using the site, the mobile version of the site , and / or the app.

            User — an individual who is a licensee under this agreement. Under this agreement and has the necessary legal capacity to gain access to the Service and implement the features provided for in the functionality The service.

            Product — any product or service in relation to which the User places an order. Ad via the Service. At the same time, products on the Service can be offered free of charge, services-only for a fee (for a fee).

            Ad — informational message with a product offer (including photos Product, price , and any related information) posted on the site By the user via the Service in an App addressed to an unspecified group of people.

            Service requests- functionality A service in the "services" category that provides the ability to The user can search for Ads in their chosen service category with the option to respond to such an ad as a potential performer, and place ads in the following categories: Ads designed to search for potential performers. All rights and obligations Users in relation to Ads are applied to requests for services, unless otherwise expressly stated in this agreement. The agreement.

            Seller — A user posting via the Service Ad with an offer to make a deal in relation to Goods, acting in their own interests or in the interests of another person.

            Buyer — The user who views the posted content By the seller Ads and interactions with the Seller in relation to And / or entering into a transaction with the Seller.

            Personal account- interaction interface A user with a Service that allows them to view Ads and manage them, change the information provided by the user. User 's personal information (last name, first name, photo, phone number) available To the user after their registration on the Service.

            2. Terms of use Service's. Application Agreements

            2.1. This license agreement (hereinafter referred to as the "Agreement") has been developed by Company and defines the terms of use The service, as well as the rights and obligations of its Users and the Company. The agreement also regulates relations aimed at protecting the rights and interests of third parties who are not legal entities. Users, but whose rights and interests may be affected as a result of actions Users.
            An integral part of this agreement is the Rules for protecting User information The service (more – The "rules").

            2.2. the User is obliged to read this agreement in full This agreement and the Rules until the start of use Service's. Making a payment User 's actions aimed at using This includes searching, viewing or submitting Ads, registering on the Service, and other actions related to using the functionality of the service. This means full and unconditional acceptance of By the user of the present Agreement and Rules, as well as its consent to receive newsletters of informational and advertising content (for more information, see clause 6.7. of this agreement Agreement), in accordance with article 438 of the civil code of the Russian Federation. code of the Russian Federation Russian Federation.
            Visit and/or use actions Using the service any device and any operating system , regardless of registration and authorization, indicate the user's unconditional consent to the terms and conditions Agreements and Rules.

            2.3. the Present The agreement and Rules may be amended and / or supplemented By the company unilaterally, unless otherwise provided by applicable law. The user undertakes to regularly check the terms of this agreement. Agreements and Rules for their modification and / or addition. Continued use Service by the User after making changes and / or additions to this agreement. The agreement and Rules mean that the User accepts and agrees to such changes and / or additions.

            2.4. In case of disagreement A user with a real name By this agreement or its updates, the User undertakes to refuse to use it. Service by deleting all data from your Personal account, as well as all your own personal data. Ads. User 's refusal to use it The use of the service and / or removal of content does not terminate the Company's non-exclusive rights to the content The user that was used By the company until the decision on refusal is made in accordance with the procedure established by clause 9.3 of the Agreement, unless otherwise provided by applicable law.

            3. Register with the Service

            3.1. Registration The user 's participation in the Service is voluntary and free of charge. The user guarantees Company that they have reached the legal age allowed by law Russian Federation Russian Federation for accepting this agreement Agreement and Rules, and has the appropriate authority to use the functionality The service.

            3.2. Registration on the Service is carried out by making the following transactions: A user of active actions on the Service or a representative Companies when making direct phone contact with the User.
            When registering for the Service The user must provide The company needs reliable and up-to-date information to generate the following information: From your personal account User, including, at a minimum, those unique to each user. The user 's username ( phone number), as well as their last and first names. The company , in turn , sends to the specified address: User 's phone number code for confirming the User's access to the phone number specified by them and subsequent authorization on the Service. Each time A user attempts to log in to the Service The company will send to the specified address User 's phone number code according to the procedure described above.

            3.3. User's Login and code sent to To the user They are necessary and sufficient information for authorization by the company to the phone number specified by it. The user and getting access to Service. The user does not have the right to transfer his login and code to third parties, and is fully responsible for their safety, independently choosing the method of storing them.

            3.4. the User also has the right to log in to the Service through his account created within the framework of other Internet resources, authorization through which is available on In the service.

            3.5. Registration and / or authorization in the Service is possible using VK Connect, which is a tool VK ecosystems. Ecosystem VK represents a common user interaction space, Services that are part of the Ecosystem, and specialized tools designed to improve the usability of the services that are familiar to users. Service users.

            The tool VK WITHonnect provided by V Kontakte LLC» (OGRN 1079847035179, location address: 191024, Saint Petersburg, 12-14 Khersonskaya St., lit. Ah, pom. 1-N), allows you to transfer user Credentials and Other data to third parties (to participants Ecosystems that use VK WITHonnect and provide within the Ecosystem VK your services and / or tools), as well as receiving By the company from the specified third parties User's credentials and Other data in the process of use by such a person included in the The ecosystem VK services and / or tools to the extent specified in your merchant profile The user Ecosystems VK, for the purpose of executing user agreements with participants Ecosystems.

            Registration and / or authorization in the Program by VK Connect, means you agree with Rules Ecosystems VK's that are publicly available on the network The Internet address: https://vk.com/vk_ecosystem_terms, as well as By the user agreement VK Connect, which is publicly available on the Internet at: https://connect.vk.com/terms and Rules for protecting user information VK Connect, which are publicly available on the Internet at: https://connect.vk.com/privacy.

            3.6. Unless proven otherwise by the User, any actions performed using the user's username or account A user created by them as part of another Internet resource, through which The user has logged in to the Service and is considered complete By the user. In case of unauthorized access to the login and code and/or To your merchant profile The user, or distributing the username and code The user must immediately inform the Company about this.

            3.7. the User is responsible for the accuracy, topicality, completeness and compliance with the legislation Russian Federation Of the Russian Federation provided by Companies during registration and further in the course of use Information service. The user must update the information provided to them in a timely manner.

            Posting information in the Service, The user agrees that such information may be available to others For users Using the service based on its functionality (which may change from time to time).

            3.8. Processing Processing of the user's personal data is carried out in accordance with the legislation of the Russian Federation. Russian Federation Russian Federation and in accordance with with the Rules. The company processes Users ' personal data for the purpose of providing the following services: Users of access to the Service and its functionality, review, research , and analyze such data that allows them to maintain and improve the current functionality The service, as well as develop new functionality. The company takes all necessary measures to protect Users ' personal data from unauthorized access, alteration, disclosure or destruction. The company provides access to Users ' personal data only to those employees, contractors and agents of the Company who need this information to ensure their functioning Service and provision Users have access to its use. The company has the right to use the provided information Information provided by the user, including personal data, in order to ensure compliance with the requirements of current legislation Russian Federation Russian Federation ( including for the purpose of preventing and / or suppressing illegal and / or illegal actions Users). Disclosure of information provided The user of the information can perform the following actions: only in accordance with the current legislation Russian Federation Of the Russian Federation at the request of the court, law enforcement agencies, as well as in other cases stipulated by the legislation of the Russian Federation. Russian Federation In some cases. Because The company processes Users ' personal data in order to comply with this agreement. Agreements, due to the provisions of the legislation on personal data consent Users ' consent to the processing of their personal data is not required.

            3.9. the user agrees that for the purposes provided for in this agreement, The agreement, The company may collect and use additional information related to: Information received by the user during the user's access to the Service or from third parties, and including data on technical means (devices) and methods of technological interaction with the Service ( including the IP address of the host, the type Of user's operating system, browser type, geographical location, data about the provider , etc.), activity The user on the Service, as well as other data obtained by the specified methods. The company has the right to dispose of statistical information related to its operation The service, as well as information about Users for the organization of operations and technical support Service and fulfillment of the terms of this agreement Agreements.

            4. subject of the Agreement and description Of the service

            4.1. by this agreement To the agreement The company provides The user has the right to use The service is performed in the manner described in this section. Agreement, under the terms of a simple gratuitous non-exclusive license, unless otherwise provided by this agreement. By agreement.
            The service provides Users have a platform for posting, searching, and viewing content Ads under the terms of this agreement Agreements.

            4.2. by default, the User is provided with a basic limit of ads that he can place simultaneously within the same product category and one region, on a free basis, for a period of 30 (thirty) days. The number of ads within this limit may differ depending on the category (subcategory) of products in which the ad is planned to be placed, and the selected one. By the user of the placement region, as well as from other parameters. The minimum limits for the number of ads on a free basis can be found here https://help.mail.ru/youla/adpacks/freepacks.

            4.3. when the basic ad limit is reached The user has the right to purchase packages of an additional ad limit on a paid basis on the terms, in accordance with the procedure and at the rates set out in the Service Offer "Ad packages» (https://help.mail.ru/legal/terms/youla/adpacks) and/or in the Offer The Universal Tariff Service »» (https://help.mail.ru/legal/terms/youla/tariffs). These offers are an integral part of this agreement. Agreements.

            4.4. When making any payment for the services of the Service made by By the user using a Bank card, the Bank card data is automatically saved on the secure page of the money transfer Operator, and the Bank card is linked go to your Merchant profile The user. List of saved files (linked to your Merchant profile User) of Bank cards is displayed in the Merchant profile The user in the "Bank cards" section. The user has the right to independently manage (delete, add , etc.) the list of Bank cards linked to his Personal account in the "banking" section. Bank cards", located at: "My profile" - " profile Settings" - "Bank cards".

            4.5. Unsolicited messages.
            The user may receive a notification that a third-party message in the Service is an unsolicited message. Under an unwanted message The company understands a message that may potentially constitute spam, be aimed at committing fraud, and / or cause damage to the User.
            The company uses programs to automatically detect unwanted messages. The features that allow you to identify an unwanted message include, in particular::
            Mass mailing list;
            Sending messages to two or more Users A service with the same number of characters;
            Complaints Users to the message sender's account in the Service;
            Recent creation date the message sender's account in the Service.
            The company takes reasonable steps to notify However, the Company does not guarantee that with respect to each and every unsolicited message The company will send a corresponding notification. The user bears full responsibility for the result of their actions in the Service when clicking on external links placed within the Service by third parties, as well as when using communication channels with third parties that differ from the functionality Service's.
            4.6. by default, The user is provided with a basic limit of responses to published requests under the "service Requests" option. Ads that they can use on a free basis, as well as the basic limit of ads that they can place on a free basis simultaneously within the same product category for a given period of time. 30 (thirty) days.

            The actual availability of the " service requests" option may depend on the selected Option. By the user of the region and / or from the actual geolocation The user.

            4.7. the service may, at Its sole discretion , unilaterally change and Supplement the package of the basic response limit and the basic ad limit. With information about available responses and ads The user can view it in the interface The service.

            4.8. the Response is considered used By the user and to be debited after the user fills out the Response form on the request and the User clicks the "Respond" button.

            4.9. the User is given the opportunity to purchase an unlimited response package by purchasing the tariff "Tariff" in the "Services" category in the updated version of the tariff, which by default includes a package of unlimited responses as an additional service (Offer The "Tariff" Service» (https://help.mail.ru/legal/terms/youla/tariffs).

            4.10. Providing an opportunity to respond to a published ad as a result of using the "service Requests" option », The service does not guarantee receipt of By the user of orders, and also does not guarantee the relevance of contacts The user who published Announcement and relevance of published content Ads.

            4.11. If the basic ad limit is exhausted under the " service Requests" option, the User may purchase a package of additional ad limits on a paid basis within the limits of an additional one-time placement on the terms, in accordance with the procedure and at the rates set out in the Service Offer "Ad packages» (https://help.mail.ru/legal/terms/youla/adpacks) and/or in the Offer The Universal Tariff service (https://help.mail.ru/legal/terms/youla/tariffs).

            5. Rights and obligations The user

            5.1. the User has the right, subject to the conditions stipulated in this agreement, to: Using these rules is free of charge Service as a program for Computers under a simple (non-exclusive) license for hosting, searching, and viewing Ads.

            5.2. When using The user of the service must:
            comply with applicable laws Russian Federation Of the Russian Federation and the present Agreements;
            create the name and text of the Ad in Russian in accordance with the requirements of current legislation Russian Federation Russian Federation, with the exception of international and well-known trademarks. At the same time, the User has the right to duplicate the text in the Ad in another language, only if the content of such text fully corresponds to the text in Russian. By placing The ad is available in two languages, The user confirms the authenticity of the text versions Ads in Russian and other languages;
            before posting any information on the Service, including Ads, you must first evaluate the legality of their placement;
            post it Ads only for Goods in respect of which the User has sufficient rights to dispose of such Goods and make transactions in respect of them;
            bring it to your attention Provide users with complete and exceptionally accurate information about the properties Products and their characteristics; The products listed in the Ad must match the description provided in this Ad;
            keep confidential and do not disclose to other Users and third parties any information that has become known to them as a result of communicating with others Users and other uses The service provides personal data and information about the private life of other Users and third parties without obtaining the appropriate prior permission of the latter.

            5.3. to the User when using The service is prohibited from performing the actions listed in the requirements for user accounts in the service.

            5.4. by Posting on In the Ad service, the User understands and agrees that the Company has the right to demonstrate Ads placed By users on the Service or on other Internet resources, including social networks. In this case, when deleting By the user Ads from the Service are automatically removed from other Internet resources. When deleting it By the user Ads from other Internet resources, such an Ad is automatically removed from the site. The service.

            5.5. When using Users of the service have the right to enter into contracts for the purchase and sale of goods/provision of services using the online payment service Products "Safe transaction" under the terms of the offer, which is Application No. 1 to the present The agreement. Offer to conclude an agreement on the purchase and sale of goods with the use of Online services "Secure transaction" is accepted By the buyer at the time of clicking on the "Buy now"/ "Buy"/ "Pay"/ "Order" button, and by the Seller - at the time of delivery of the product To the buyer and clicking the "Confirm transfer" button or at the time of delivery of the goods for shipment via the Boxberry delivery Service (in this case , the transfer of goods is confirmed automatically).

            5.6. the User has the right to assign to his personal page on In the service, a short (subdomain) name that replaces the sequence number of the id when addressing on the Internet. Words and names that are prohibited from being used in accordance with the terms of this agreement cannot be selected as a subdomain name. License agreement, Requirements for user accounts in the service and applicable legislation Russian Federation Russian Federation and international legal acts, including, but not limited to, obscene language, names registered as trademarks (regardless from the mctu class), brand names and commercial designations, if the User does not have exclusive rights to them. If a violation of these terms is detected The company has the right to prohibit Use of the subdomain name assigned to the user , including, if applicable, transfer the right to use it to the appropriate user. to a person (representative of the copyright holder). The user has the right to register no more than one personal page on In the service.
            Requirements to a short (subdomain) User name:
            - minimum / maximum number of characters - from 5 to 20;
            - dots are allowed only between characters;
            - you can use letters of the Latin alphabet a-z A-Z, numbers 0-9, signs _.

            6. Rights and obligations The company

            6.1. the Company performs day-to-day management By using the service, it independently determines its structure, appearance , and other elements. The company reserves the right to review or change the design at any time Use of the service, its functionality, modify or Supplement the scripts used, software used or stored within the Service, and access conditions Users to them.

            6.2. the Company also has the right, at its sole discretion , to terminate (temporarily or permanently) the provision of access to the Service in full, or in any part of all Users as a whole or as an individual To the user.

            6.3. the Company may , without compensation for any costs or losses, at any time without notice Block the user Personal account The user or delete non-compliant data from this document. Agreements Ads, including in case of any one -time violation By the user of the terms of this agreement Agreements, unless otherwise expressly provided by applicable law. Deleting a User's Personal account means automatically deleting all information posted in it. After deleting the Personal account, the User loses access to use it The service. Company it has the right, but is not obligated, to restore the User's access to the service or restore previously deleted Data. Ads in case of elimination Violations committed by the user.

            6.4. the Company has the right to make comments Users, warn, notify, inform them about non-compliance with the terms of this agreement. Agreements. Addressed to To the user , the Company's instructions on usage issues The terms of the service are mandatory for such a User.

            6.5. the Company may at any time , at its sole discretion , conduct a random review of ads for compliance with the following Requirements: Users of the present Agreements and their compliance with the current legislation Russian Federation Russian Federation.

            6.6. the Company also has the right to request from the User at any time, and the User must, upon request Provide the company with information, documents and/or materials confirming the accuracy of the information provided by the company. By the user about yourself, in Ads, as well as its compliance with the present Agreement and current legislation Russian Federation Russian Federation.

            6.7. the Company has the right to send Information (for example, about the development of the Service and its functionality), including service and advertising messages, sent to the User's email address, mobile phone (SMS, phone calls), as well as to the user on their own behalf, independently or with the involvement of technical partners. push-notifications (push notifications). The user has the right to refuse to receive advertising and other information at any time without explaining the reasons for refusal. Service messages informing you Information about the user 's status/changes in the status of the purchase and sale transaction are sent automatically and cannot be rejected By the user, since such messages are a necessary condition for the provision of services.

            The user has the right to refuse to receive advertising messages after creating the User's personal account in the web version From the service or in the mobile app Service by editing your merchant profile The user (on the site in the "Notifications" section in "Settings", or simply by clicking on the link: https://youla.ru/user/settings/?modal=notifications-modal as well as in the mobile app in the "Notifications" section in " profile Settings") or use the help of the support Department For the service, fill out the feedback form https://help.mail.ru/youla/sms. The user also has the right to refuse advertising push notifications from the mobile app Use the service via your mobile device settings.

            6.8. the Company undertakes to:
            - on the terms and conditions set forth in this agreement. Agreement, provide User 's rights to use The service is provided under a simple (non-exclusive) license;
            - provide technical and informational support within a reasonable time frame Information required for users to access the Service and then use it.

            6.9. the Company has the right to demonstrate Ads placed By users on the Service or on other Internet resources, including social networks.

            6.10. the Company may, acting on behalf of Sellers (or Sellers ' agent), provide placement services on the Service Ads with the offer of products sold by the company By sellers via Of The Service Mall.My.com in accordance with the procedure and conditions specified in the " User agreement Mall.My.com» (http://storage.mall.my.com/files/agreement.pdf). At the same time, the Company undertakes to post on Name information in the service Sellers, as well as post Ads Sellers in full compliance with the information provided Sellers, and without making any changes/additions/corrections to the Ads.

            Making a decision about a transaction with the Seller, Which ad was placed By the company in accordance with this clause of the License agreement, The buyer confirms that they have fully read and agree to the terms and conditions User agreement Of The Service Mall.My.com and that they fully understand and accept the subject matter and terms of the transaction with the Seller. The user confirms that they fully understand the meaning and consequences of their actions in relation to the conclusion and execution of a transaction with the Seller.

            When entering into a transaction with the Seller, Which ad was placed By the company in accordance with this clause of the License agreement, The buyer has the right to: 3 (three) hours to cancel the transaction or change the delivery address. After the specified time has elapsed, the Buyer should contact the support service for all questions. The service specified in clause 11.6 of the License agreement.

            7. Guarantees, liability, risk acceptance By users

            7.1. Usage The service is performed by By users at their own risk: the seller independently , at Their own risk, places the following information: Ads in relation to The product for which The seller has the right to dispose, and the Buyer considers at its own discretion and under its own responsibility Ads Sellers and makes a decision on entering into a transaction with a particular Seller.

            7.2. if the User has doubts about the legality of performing certain actions, including those related to the placement Ads, The company recommends that you refrain from committing the latter.

            7.3. the User is personally responsible for any information, Ads and photos placed on the Service's website/in In the app, informs others Users, as well as for any interactions with others By users, carried out at their own risk.

            7.4. the User undertakes to be careful when choosing a counterparty (Buyer or seller , respectively), makes a decision on the transaction on its own responsibility, independently making sure that the offer, sale and/or acquisition of any of the services provided by the buyer or Seller, respectively. The product specified in the Ad is valid and legal.

            7.5. Users are responsible for their own actions in connection with the use of the service. Service, including in connection with transactions in relation to: Products whose information is placed in Ads, creating and placing information and Ads in your own site In your merchant profile and in other sections Service, in accordance with the current legislation Russian Federation Russian Federation. Violation of this agreement Agreement and current legislation Russian Federation The Russian Federation entails civil, administrative and criminal liability.

            7.6. the User confirms that he / she is acting legally (for example, by proxy) and has all the necessary rights (in particular , for posting ads). Ads) and does not violate the legal rights and interests of third parties and current legislation by their actions Russian Federation Of the Russian Federation, including legislation on competition and rights to the results of intellectual activity and means of individualization.

            8. Limitation of liability The company

            8.1. the Company does not provide any guarantees that the Service or its elements may be suitable for specific purposes of use. The company cannot guarantee and does not promise any specific results from the use The service or its elements. Service, including all scripts, individual elements, and design The following services are provided: "as is".

            8.2. the Company does not provide any guarantees that there will be no interruptions in the operation of the service due to technical malfunctions, maintenance work, etc., but it makes commercially reasonable efforts to ensure the operation of the Service. The service is available around the clock. The company does not provide any guarantees that the Service or any of its elements will function at any particular time in the future or that they will not stop working.

            8.3. the Company is not responsible and does not compensate for any damage, direct or indirect, caused by To the user or third parties as a result of use or inability to use Use of the service, unless otherwise provided by applicable law.

            8.4. the Company is not responsible for any damage to the device or software User or other person, caused by or related to the use of The service is not due to the Company's fault, or when you click on links placed within the Service by third parties.

            8.5. Under no circumstances The company and its representatives are not responsible to Users and/or third parties for any indirect, incidental, unintentional damages, including lost profits or lost data, damage to honor, dignity or business reputation caused in connection with the use of the site. Service, content The service or other materials that can be accessed Users or other third parties individuals gained access using Use of the service, even if the Company has warned or indicated the possibility of such harm, unless otherwise provided by applicable law.

            8.6. the Company does not participate in content generation Ads, Personal accounts , and other sections Service's. At the same time, the Company is not required to perform verification Ads and their content, resources linked to in the Ad, and trustworthiness Sellers and Customers (as well as their identification). In this regard , quality, safety, legality and compliance Product description, as well as the ability to Sell the seller and / or purchase the Buyer The goods are out of participation and control The company. The company is not responsible for the content of the information provided by the company. By users, including content Ads, usage Users of third-party trademarks, logos , and other components Ads and other sections Service generated by By users.

            8.7. the Company is not a party to transactions made between the buyer and the Seller, nor is it an organizer, intermediary, agent or representative of any other Person. The user and/or any other interested party in relation to the proposed/concluded transaction between Users. All transactions made Users in connection with placement on the Service Ads are entered into and executed without the Company's direct or indirect participation.

            8.4. the Company is not responsible for any damage caused by To the user when clicking on links placed within the Service by third parties, as well as when using communication channels with third parties that differ from the functionality The service.

            9. intellectual property rights terms and Conditions

            9.1. Exclusive rights to the Service, including but not limited to programs Computers, databases, interface, technical developments, logo, trademark, and other means of individualization used on the Service and allowing you to implement functionality The service belongs to The company.

            9.2. Except for the cases established by this agreement. This agreement, as well as the current legislation Russian Federation Russian Federation, The service and its components, including those listed in the paragraph above, may not be copied (reproduced), processed, distributed, framed , published, downloaded, transferred, sold or otherwise used in whole or in part without prior written permission The company.

            9.3. if the information (content) posted by It is protected by copyright, and the rights to such information are reserved for the User who posted such information.

            At the same time, the User provides information to other Users The service has a gratuitous , non-exclusive right to use such content by viewing, reproducing, and sharing it. (including copying), recycling (including the right to print copies) and other rights solely for the purpose of personal non-commercial use, except in cases where such use causes or may cause harm to the legally protected interests of the copyright holder.

            In addition, the User provides The company has a non-exclusive right to use , free of charge , the content posted on the Service and legally owned by it in order to ensure: Company of operation The service to the extent determined by its functionality and architecture, as well as the display of content (including, but not limited to, photos Ads and from Ads, description texts Product) in promotional materials Companies, including within the framework of interface images The service, including by making such promotional materials publicly available, including for advertising purposes Service on various information resources. Specified non-exclusive right is for the whole period action exceptional law includes among other things, the right play content, and processing the content including by incorporating in the complex object or composite works subsequent show, bringing to the public information, messages, cable and etc., and distributes action on-site countries around the world. The company has the right to transfer the rights specified in this clause to third parties. End of the term for posting content on Service and/or expiration date a non-exclusive right does not entail the need to withdraw promotional materials from circulation Companies that display content ( including removing them from the Internet).

            9.4. None of the provisions of this agreement Agreements do not provide The user has the right to use the company's logo, brand name, trademarks, domain names and other distinctive signs.

            10. Territory and validity period Agreements. Modification and termination Agreements

            10.1. the User has the right to use Service throughout the territory Russian Federation Russian Federation, as well as other territories where it is available using standard computer tools and programs.

            10.2. the Present The agreement comes into force for the User from the moment of joining the terms and conditions Agreements and are valid for an indefinite period.

            10.3. This agreement is terminated if::

            10.3.1 the User will decide to stop using it Of the service by sending The company is notified accordingly (by contacting us via the interface Contact the technical support service, or by sending the company a scanned copy of the relevant request to the email address specified in clause 11.6. of this agreement. Agreements);

            10.3.2. the Company will decide to terminate this agreement. Unilateral , out-of-court agreements with immediate termination of access and the ability to use Service and without compensation for any costs or losses, unless otherwise provided by applicable law. In particular, The company may make such a decision in the following cases::
            - closing the Service;
            - any violation, including a single one By the user of the terms of this agreement Agreements.

            10.4. Any changes to the agreement made by: These changes will take effect unilaterally by the company on the day following the day when such changes are published on the site. The user undertakes to check independently The agreement on the subject changes before using The service. Non-implementation Actions taken by the user to read the Agreement and / or the amended version The agreement cannot serve as a ground for non-performance By the user of its obligations and non-compliance By the user of the restrictions set by the Agreement.

            11. Other provisions

            11.1. regarding operation and development Our company is guided by the legislation of the Russian Federation Russian Federation Of the Russian Federation, hereby This agreement and other special documents that have been developed or may be developed and adopted by the Company for the purpose of regulating the provision of services. Users accessing the Service.

            11.2. the Present This agreement shall be governed by and interpreted in accordance with applicable law Russian Federation Russian Federation. Unresolved issues By agreement, subject to resolution in accordance with the law Russian Federation Russian Federation. Since access to the service and its functionality is provided free of charge, the terms and conditions of the Agreement apply. Federal Government Agency Law No. 2300-1 of 07.02.1992 "on consumer rights protection" on relations between the Administration and Users regulated by these terms and conditions Rules that don't apply.

            11.3. in case of any disputes or disagreements related to the performance of this agreement, Agreements, the User and the Company will make every effort to resolve them through negotiations between them. If disputes are not resolved through negotiations, disputes are subject to resolution in accordance with the procedure established by the current legislation. Russian Federation Russian Federation, by location Companies, unless otherwise expressly provided by applicable law.

            11.4. the Present The agreement is written in Russian and can be provided by: To the user for familiarization in another language. If the Russian version of the Agreement differs from the version in another language, the provisions of the Russian version of this agreement will apply. Agreements.

            11.5. If, for any reason, one or more of the provisions of this agreement The agreements will be deemed invalid or unenforceable , and this does not affect the validity or applicability of the remaining provisions. Agreements.

            11.6. Requests, suggestions and claims of individuals and legal entities to the Company in connection with the implementation of this agreement Agreements and their operation Violations of the rights and interests of third parties when using the service The service, as well as for requests authorized by law Russian Federation Federations of individuals can be sent to the support service Use the feedback form or contact us at : <url>, 125167, Moscow, Leningradsky Prospekt 39, p. 79.
            Revision from" 05 " October 2020.
            APPENDIX # 1
            to the License agreement
            OFFER FORM AT THE CONCLUSION OF AGREEMENTS on the purchase and sale of goods/ services with the use of Secure transaction online service »
            Real An offer is an offer Buyer 's right to enter into a contract with the Seller Contract on the terms and conditions set forth in this article. The offer. Acceptance Offers are made in accordance with the procedure provided for in this article. The offer. Acceptance Offers by the Seller are equivalent to the conclusion of Contract on the terms and conditions set forth in this article. The offer.
            The buyer offers To the seller to conclude a contract Contract for the purchase and sale of goods/or services using the Secure transaction online service for settlements under the following conditions::
            Present Agreement on the purchase and sale of goods/or services with the use of Secure transaction online service, hereinafter also referred to as the Agreement or this agreement The agreement is concluded between:
            a person who is By the buyer, as defined below, also referred to as " Buyer»;
            and a person who is By the seller, as defined below, also referred to as " Seller»;
            hereinafter collectively referred to as the "Parties" and separately as the "Party".

            1. Terms and definitions

            1.1. Analog of a handwritten signature-entering the correct combination Username and Password used By buyer or Seller on Protected pages Of the site/Applications, and follow -up actions on Protected pages Of the site/Appendices, introduction of directional control Buyer or Seller of a one-time authentication code on Secure pages Of the site/Applications, as well as pressing the buttons "Buy", "Buy now", "Pay", "Call", "Write", "Confirm payment", "Write to the seller", "delivery to Boxberry", " delivery as a Boxberry courier», "Take it from the seller", "Delivery address", "Continue", "Select ex", "Confirm transfer", "Confirm getting", "Open a dispute", "History dispute" "Cancel ordering", "Full the refund" "Partial the refund" "Refund and product", "Accept"/"Reject" (offer any party in the Chat in order settlement dispute), "Sum return" "The reason for the dispute" "Confirm agreement/disagreement with the offer Arbiter", " Rate The seller/Buyer" " Buy " and other buttons in connection with the operation of Online service "Secure transaction", as well as making a payment other actions that clearly indicate certain intentions Sides.

            1.2. "Secure transaction" — an online service available on the Site/in In the app.

            1.3. Buyer- user Of the Site/ The user registered on the Site/in the app that is viewing the posted content By the seller Ads and interactions with the Seller in relation to Who signed a contract with the Seller The agreement using Protected pages Of the Site/Applications. The buyer can be a fully capable individual who has reached the age of eighteen.

            1.4. Secure pages Of the site/Applications — pages Secure transaction online service , which can only be accessed by the Buyer or Seller entering the Password. Username and Password.

            1.5. The seller — the user Of the site/An application that is registered on the Site/in the Application and places an Ad there with an offer to conclude a contract The agreement in relation to Who signed a contract with the Buyer for the product Agreement and acting in their own interests or in the interests of another person. The seller can be a fully capable individual who has reached the age of eighteen.

            1.6. Login — the unique name of the Buyer or Seller used by them on the Site/in In the app for access purposes to Secure pages Of the site/Applications.

            1.7. the Company, Administration Of the site/Applications, The referee — Stonks LLC, location: 125167, Moscow, Leningradsky Ave., 39, p. 79, OGRN 1027739850962, TIN 7743001840.

            1.8. Offer — a real offer Buyer 's purchase made by To the seller using the Site's software and hardware tools/Appendices, conclude this agreement Agreement on the terms specified in The offer.

            1.9. Password — a combination of letters, numbers, and symbols that is unique to the Username, allowing you to log in to Secure pages when entering them at the same Time Of the site/Applications. The password is selected By the buyer and / or Seller independently.

            1.10. Goods — any property, including works/services, sold or intended for sale By the seller under the Agreement, not withdrawn from and not restricted in circulation in the territory of the Russian Federation. Russian Federation Russian Federation, which is not prohibited from being placed In ads on the Site/App in accordance with the requirements Of the Rules.

            1.11. Site — a set of software and hardware tools for Computers that provide publication for viewing of information and data United by a common purpose, by means of technical means used for communication between A computer on the Internet. The site is available at a unique email address or its associated address. the letter designation. A Site is defined as Website located on the Internet at https://youla.io/, as well as at: https://youla.ru/.

            Youla, Application, Application Youla – a mobile application, a resource that is a collection of information (Content) posted by Administration and / or Sellers, and intellectual property objects Administration (including a program for Computer, graphical interface design (design) , etc.), which is accessed from various user devices connected to the Internet, and allows you to use the functionality of The site.

            1.12. Agreement – this agreement on the purchase and sale of goods and/or performance of work and/or provision of services using the online service "Secure transaction", concluded between the Seller and the Buyer.

            1.13. The cost Product — price Of the product, expressed exclusively in rubles of the Russian Federation that was initially agreed upon Buyer and Seller in the Ad on the Site / in In the app.

            1.14. the Parties Are the Buyer and Seller when they are mentioned together, and the Party is any of them when they are mentioned separately.

            1.15. Ad - offer Seller's request to sell a specific product Product description with information about this Product: detailed description of the condition The product, its purpose and consumer properties, its shortcomings, indication of its expiration date or service life, as well as other necessary and reliable information about the Product, ensuring the possibility of its correct choice by the Buyer.

            1.16. Personal account - interaction interface The buyer/Seller with the Site/An application that allows it to view Ads and manage them, change the information provided by the user. By the buyer/Seller 's personal information (last name, first name, photo, phone number) available To the buyer/To the seller after registering on the Site/in the App when entering your Username and Password.

            1.17. Terms – terms of use The site and App Youla defining terms of use and development Of the Site/The application, as well as the rights and obligations of its users and Administration.

            1.18. money transfer Operator – rnco "Money.Stonks» (LLC) (location : Moscow, 125167, Russian Federation, Leningradsky Prospekt , 39, building 79, OGRN 1127711000042, TIN 7750005718, License Central Bank of the Russian Federation No. 3511-K dated 19.09.2012), which provides the service To the buyer "Stonks - Secure transaction" based on the agreement concluded between the Buyer and the money transfer Operator , as well as the service To the seller "Transfer to a Bank card" on the basis of an agreement concluded between the Seller and the money transfer Operator . These agreements are posted on the website of the money transfer Operator https://money.mail.ru/oferta/youla_service, and a link to the text of the agreements is posted on On the website and in the App for review and their acceptance without fail until the transaction is completed The buyer pays for the Goods and transfers funds To the seller.

            1.19. Delivery service - a legal entity or individual entrepreneur that provides services in order to fulfill this agreement. Agreements delivery services The product.

            2. Subject Of The Agreement

            2.1. by this agreement To the agreement The seller undertakes to sell to the Buyer The product under the conditions specified in The ad, and the Buyer agrees to pay for the Product using Secure transaction online service in accordance with the terms of this agreement. Agreements.

            2.2. a Detailed description of the Product, its cost, dimensions (for calculating the cost of delivery) and other relevant conditions are indicated By the seller in An ad placed by them using software and hardware tools on the site Protected pages Of the site/Appendices in accordance with the procedure provided for by Rules.

            Delivery terms and conditions Product details are determined by By the delivery service, in accordance with clause 6.1. of this agreement. Agreements.

            From the moment of confirmation The seller agrees to sell the Product using the following terms: Secure deal online service (click The seller of the "Confirm transfer" button or the transfer by the Seller Goods to be sent via the Boxberry delivery Service). The agreement is considered concluded, and the Announcement becomes an integral part of this agreement. Agreements.

            2.3. the seller pays the Operator's Commission for the transfer of funds in accordance with the procedure provided for in the Contract. The terms of transfers are "Stonks-Secure transaction".

            2.4. delivery Costs Of the product via Delivery service, paid for By the buyer.

            Delivery-related costs If the goods are sold in a different way, they are agreed upon Parties independently.

            2.5. expenses related to the refund Goods of improper quality, paid for By the seller.

            3. Placement Ads on the Site/App and the Buyer's offer

            3.1. Placement Ads are made using the Site's software and hardware tools/Apps on Secure pages Of the site/Appendices in accordance with the procedure provided for by Rules.

            3.2. the Ad is considered placed By the seller from the moment they click the "Publish" button. The ad must contain all the necessary information that is required by the current legislation. Russian Federation Russian Federation and Rules. To sell a Product using The Seller must link a Bank card to their Personal account using the Secure transaction online service .

            3.3. Buyer's offer to conclude a contract Purchase and sale agreements Goods under the terms of this agreement The agreement is considered directed To the seller from the moment of clicking The buyer of the "Buy now"/"Pay" button"/"Order". Technical means Of the site/Applications allow you to identify a button click made under your Username The buyer. When the specified Ad button is clicked (using the Site's software and hardware tools/Apps) is removed from the list of ads visible to other buyers -users Of the site/Application, and is sent "in reserve", in which the Product is located in within 15 (fifteen) minutes for the Buyer to pay for it.

            3.4. Until confirmation By the seller of the Product transfer (or sending it via the Boxberry delivery Service) using Online service "Safe transaction", the Buyer has the right to refuse the purchase Product name (button "Cancel order"), which will be considered a review of the previously sent request. Offers.

            3.5. the Buyer may, prior to sending the offer, To the seller about purchasing a Product using Secure transaction online service ( until you click "Buy now" / " Pay"/"Order") apply contact the Seller with a request to clarify information about the Product, the terms of its purchase and delivery (the "Write" button).

            3.6. the ad May not contain an offer for the sale of Goods that are prohibited or restricted in circulation in accordance with the law Russian Federation Russian Federation and Rules.

            3.7. Responsibility for compliance with the information specified in the Ad, legal requirements Russian Federation and the Rules are borne by the Seller.

            4. Seller's Acceptance

            4.1. the Agreement is considered concluded from the moment of confirmation By the seller of the fact of delivery of the Goods To the buyer using Online service "Secure transaction", that is, by clicking the "Confirm transfer" button, or from the moment of delivery of the goods for shipment through the Boxberry delivery Service (in this case , confirmation of the transfer of Goods This happens automatically).

            4.2. Cash and cash equivalents The buyer 's funds are debited to the account of the money transfer Operator after clicking The buyer of the "Buy now"/"Pay"/"Order" button.

            4.3. funds are Debited from the Operator 's account for transferring funds to the Seller 's account after clicking By clicking the "Confirm receipt" button, or after receiving confirmation from the Boxberry delivery Service that the product has been delivered To the buyer.

            5. The procedure for the use Secure transaction online service »

            5.1. To use Online service " Secure transaction " the Seller must have a Bank card linked to his Personal account – for crediting funds to it in order to pay for the Goods, for making a refund/partial refund of funds in the cases provided for in this agreement. The agreement.

            To use The Buyer has the right to link a Bank card to their Personal account using the Secure transaction online service -for more convenient and fast payment of Goods and services for delivery Of the product via Delivery service, for making a refund/partial refund of funds in the cases provided for in this agreement. The agreement. The Buyer also has the right to pay for Goods and delivery services by entering their Bank card details each time they make a purchase. Order form (without linking a Bank card).

            5.2. when clicking Click on the "Buy now" button to pay for the Product using the following parameters: The Secure transaction online service displays a window for entering the Buyer's Bank card details and confirming payment for the Order.

            The buyer can link connect your Bank card to your Merchant profile using the following method: "My profile" - " Settings» - "Bank cards" - "Bank cards" - entering Bank card data on the secure page of the money transfer Operator - "Save". Subsequently , funds will be transferred from The buyer's linked Bank card to the Seller 's payment account. Goods and/or for the benefit of the delivery Service as payment for delivery services The product.

            5.3. if the Buyer has a Bank card linked to their Personal account , or when entering the Bank card details in the corresponding window when making a payment Order, as well as if the card account has a monetary amount equal to the cost of the order. Product and delivery cost via Delivery service (if applicable), in accordance with the procedure established by the legislation of the Russian Federation. Under the terms of "Stonks – Secure transaction" transfers, funds are debited from the Buyer's Bank card and then settled with the Seller and the delivery Service.
            5.4. After payment The seller is automatically notified of payment for the Product By the buyer and need to send To the buyer Goods within the time period specified in clause 6.1. of this agreement. Agreements.

            5.5. when placing ads By the seller Ads for the sale of a Product that it doesn't have in stock, Administration Of the site/Apps notifies you The seller's notification that in the event of a repeated similar violation The Administration reserves the right to suspend and / or terminate the Seller's access to the Site/To the app in whole or in part, including by rejecting, blocking, or deleting Ads The seller and/or their Personal account.

            5.6. when confirming the sale of the Product using Using the Secure transaction online service, the Merchant must link a Bank card to their Personal account by entering the details of such a card in the corresponding window of the money transfer Operator.

            Alternatively , to link a Bank card to your Merchant profile yourself, the Merchant must perform the following actions: go to the "My profile" section in Your merchant profile - " Settings» - "Secure transaction" - "Bank cards" - entering Bank card data on the secure page of the money transfer Operator - "Save".

            5.7. Information and technological interaction between the money transfer Operator and the Buyer/By the seller/ The delivery service, in terms of making money transfers for the Product and for its delivery services , provides By the administration Of the site/Applications using the Site's software, hardware , and hardware/Applications.
            When making money transfers , the money transfer operator is guided by the following instructions: Buyer 's data according to Conditions of the buyer's orders.

            6. delivery Terms and acceptance procedure Of the product

            6.1. the Seller undertakes to send the Goods To the buyer in the following terms and in the following way, selected by the buyer's authorized representative: By the buyer:
            - either via Boxberry delivery service » (http://boxberry.ru/, next - "Boxberry") – within 3 days (three) days from the date of payment By the buyer Goods and services for their delivery;
            When choosing delivery via Boxberry The buyer is obliged to read the terms of delivery posted at http://boxberry.ru/private_customers/documentation/. By clicking the "Pay for boxberry delivery" button» The buyer confirms its full and unconditional consent to the terms of delivery.
            - either by the method of receiving Product "no delivery " ("I'll Pick it up from the seller myself") – within 3 days (three) days from the date of receipt Seller notifies you of payment for the Product By the buyer. At the same time, the parties independently agree on the place and time of delivery of the Goods.

            6.2. in case of sending Of the product via Delivery service:

            6.2.1. the Buyer must receive Product during the following period: 5 (five) days from the date of receipt of the notification from the delivery Service about the delivery Send the product to the pick-up point.

            6.2.2. After receiving Of The Product By The Buyer, The delivery service automatically sends a notification about this to the Administration Of the site/Applications. Order acceptance in the delivery Service is a specific order The buyer To an automated money transfer operator To the seller of funds for Product.

            6.2.3. at the time of acceptance By the buyer The Buyer must check the product at the pick-up point of the delivery Service Check the product for its compliance with the description specified By the seller in In the ad.

            6.2.4. in case of nonconformity detection The Buyer has the right not to accept the product Order (leave it at the delivery service's pick-up point ). In that case:
            - The delivery service notifies you The administration Of the site/Appendices about the Buyer's refusal of the Order,
            - funds for the Goods are subject to return to the Buyer in accordance with the procedure established by the agreements A money transfer operator with a Buyer and Seller,
            - money for delivery will not be refunded.

            6.3. in case of transfer Goods to the Buyer "without delivery" (delivery method "I will Pick up myself from the seller»):
            6.3.1. the Seller is obliged to inform Buyer 's information about the transfer Send the product by clicking the "Confirm transfer" button.

            6.3.2. the Buyer is obliged to: 3 (three) calendar days from the date of delivery of the Product By the seller:
            - or confirm its receipt by clicking the "Confirm receipt" button. Product", then The money transfer operator receives an automatic notification about the need to transfer funds To the seller of funds for Product. Clicking the specified button by the Buyer is the basis for the transfer To the seller of funds for Goods in accordance with the procedure provided for by the legislation of the Russian Federation By agreement.
            - or open a dispute with the Seller by clicking the "Open dispute" button (Section 7 of the Agreement).

            6.4. if the Buyer has not confirmed receipt of the payment within the time period specified in clause 6.3.2. of the Agreement And / or has not opened a dispute with the Seller, then the money transfer Operator on a specific order The buyer is automatically listed To the seller cash for Product.

            6.5. the Seller is responsible for compliance with the established deadline (clause 6.1. of the agreement) and the payment method. sending/transmitting data The product you selected By the buyer.
            In case of violation By the seller of the term sending/transmitting data The product specified in clause 6.1. of this agreement. Agreements:
            - The order is subject to cancellation,
            - funds are subject to refund To the buyer,
            - Administration Of the site/Applications have the right to suspend and / or terminate the Seller's access to the Site/To the app in whole or in part, including by rejecting, blocking, or deleting Ads The seller and/or their Personal account.

            6.6. the seller is responsible for the availability of appropriate Information. packaging of the Product that ensures its safety during delivery.

            6.7. Quality of delivered goods The product description must correspond to the Product description specified in the Ad, and in the absence of such a description – to the requirements usually imposed on such products .

            7. Procedure for opening and resolving a dispute between Buyer and Seller

            7.1. if you receive By the buyer The product is of poor quality or does not match the description specified By the seller in In the ad, or not in the agreed amount, The buyer has the right to open a dispute with the Seller using software and hardware tools on the website of the buyer. Protected Pages Of the Site/Applications, namely: the "Open dispute" buttons.

            7.2. when opening a dispute by the Buyer The seller receives a notification in the Chat about the availability of Buyer 's claims to The product with an indication of the reasons for opening a dispute (description of defects, photos , etc.), as well as to The chat is automatically connected The referee.

            7.3. the Arbitrator participates in the resolution of the dispute that has arisen. dispute resolution as a disinterested person and solely for the purpose of assistance To the seller and The buyer can find a mutual solution to the problem the dispute. When resolving a dispute, the Seller and Buyer can independently come to one of the following solutions:: 1) funds will be transferred To the seller in the agreed (full/reduced) amount, or 2) funds will be refunded To the buyer in full. Need to return the Product The seller must: be separately agreed upon Parties.

            7.4. if If the parties have not reached any of the decisions specified in clause 7.3. of the Agreement , the dispute may be resolved As an arbitrator. Time limit for consideration of the dispute by the arbitrator, making a decision by the arbitrator and confirmation of the decision by the Arbitrator. The parties agree to the decision The referee's signature is 7 (seven) calendar days. Transfer/refund of funds The parties to the dispute are responsible after the decision of the Arbitrator is made.

            Accepting the terms of this agreement Agreements, The seller and The buyer specifically stipulated and agree that the solution The decision of the arbitrator on the dispute that has arisen is an agreed expression of the will of both Parties and is executed by them unconditionally, as accepted with respect for the rights of each party. Sides.

            Each of the parties has the right to provide: To the arbitrator the evidence available to it of the proper performance of its obligations under this agreement. This agreement, as well as other necessary information and materials requested by the parties. As an arbitrator.

            7.5. the arbitrator has the right to refuse to participate in the dispute resolution if there is no opportunity to consider the Issue. dispute on its merits on the basis of evidence submitted by Parties. Such a dispute may be referred by the Parties for resolution to a judicial authority in accordance with the current legislation.

            7.6. if an expert assessment is required to confirm the improper quality of the Product and determine the reasons for its occurrence , any of the Parties has the right to apply to an independent specialized organization for conducting an expert examination The product. The costs of paying for the expert examination are borne by the Party whose fault in the improper quality of the Goods will be established during the expert study.

            The arbitrator does not provide expert quality assessment services The product.

            8. Rights to the Product

            8.1. the right of ownership of the Goods and the risk of their accidental death is transferred from the Seller To the buyer at the time of receipt Delivery of goods by the buyer from the delivery Service or by any other method chosen by the Buyer. By the buyer.

            8.2. Responsibility for the safety of Of the product until its delivery The buyer is responsible for the Seller.

            8.3. the seller guarantees that It is the rightful owner of the rights A person who has all the necessary rights to dispose of the product in favor of the Buyer.

            8.4. the Seller guarantees that the Goods are delivered at the time of delivery. The buyer is not mortgaged, arrested, or subject to third-party claims .

            8.5. if The seller did not have the right to freely and fully dispose of Goods and (or) guaranteed facts By the seller in the present Agreement that turned out to be untrue, erroneous , or false, The buyer has the right to demand compensation from the Seller for any losses incurred , including legal costs.

            8.6. in all other cases, issues related to the rights to Goods, will be regulated by the current legislation Russian Federation Russian Federation.

            9. Liability of the parties

            9.1. For non -performance or improper performance of obligations under the Agreement The parties are responsible in accordance with the applicable legislation Russian Federation Russian Federation.

            9.2. the Parties are released from liability for non -performance or improper performance of obligations under the Agreement in the event of force majeure, that is , extraordinary and unavoidable circumstances under these conditions , which are understood as prohibited actions of the authorities, civil unrest, epidemics, blockade, embargo, earthquakes, floods, fires or other natural disasters.

            10. Conclusion, entry into force, amendment and termination Agreements

            10.1. the Agreement is considered concluded from the moment of confirmation The seller agrees to sell the Product using the Secure transaction online service.

            10.2. Actions related to the conclusion, modification, termination or execution of the contract. Agreements that have been concluded by the person who used it With your username and Password The seller or Buyer for access to Secure pages Of the site/Apps are considered perfect , respectively By the seller/By the buyer on their own behalf, as if the following transactions were made: By the seller/By the buyer personally.

            10.4. presence of a prisoner The agreement is confirmed , among other things, by the following actions: Sides'.

            10.5. At the time of acceptance By the seller Offers Administration Of the Site/Applications via the Site's software and hardware tools/Applications have the right to assign Specify the internal number and date that are available To the seller and To the buyer via the Site's software and hardware tools/Application through a Secure page Of the Site/Applications.

            10.6. the Present The agreement may be amended only by mutual consent of the Parties in the cases provided for in this agreement. By agreement.

            11. Applicable law and dispute resolution procedures

            11.1. the Agreement is governed by and interpreted in accordance with the substantive law of the Russian Federation. Russian Federation.

            11.2. in case of any disputes or disagreements related to the performance of the contract, Agreements, The parties will make every effort to resolve them through negotiations.

            11.3. If the dispute and disagreements that have arisen are not resolved through negotiations, they may be resolved in accordance with section 7 Contract or in court in accordance with the procedure established by law Russian Federation Russian Federation.

            12. Privacy policy

            12.1. the Seller or The buyer who received in order to fulfill their obligations under this agreement This agreement contains confidential information, information constituting a commercial secret, respectively The buyer or Seller is not entitled to disclose this information to third parties without the written permission of the other Party Agreements, with the exception of cases established by law.

            12.2. in case of violation of the obligation stipulated in clause 12.1 of this agreement, Agreements, The buyer and Seller are responsible in accordance with the law Russian Federation Russian Federation.

            13. Final provisions

            13.1. By entering into this The contract, the Seller and the Buyer guarantee that they, in accordance with the applicable law and the law of the country of origin , have full legal capacity and legal capacity, and have the right to enter into this agreement. The agreement and the Contract.

            13.2. the Parties send all notifications, requests and documents through special software and hardware tools Of the site/Applications located on Secure pages Of the site/Applications. Such notifications and requests are saved using the Site's software and hardware tools/Applications. The parties agree that such communications, notices and documents will be deemed appropriate for the purposes of this agreement. Agreements (including in the case when a facsimile reproduction of the signature was used), will be equated to written documents signed by authorized representatives Parties, and have the same legal meaning.

            13.3. in case of disagreements between the Parties , information that is recorded using the technical means of the Site/Applications that take precedence in resolving such disputes.

            13.4. Provisions Agreement in the part regulating the relations between the parties Buyer and Seller, are an integral part of this agreement. The agreements Supplement the provisions of this agreement. Agreements and are considered included in the Agreement. In case of non-compliance with the provisions The Agreement and Agreements the rules provided for in the Agreement will prevail over the provisions of this agreement. Agreements.

            13.5. the Parties take into account and agree that the performance, non -performance or improper performance of obligations under this agreement This agreement and / or Agreement may affect the status and / or characteristics of the person registered on the Site/in the Application through which it operates Buyer and / or Seller, in accordance with the rules Of the site/Applications, information about this can be reflected and commented on on the corresponding pages Of the site/Applications to be used otherwise in connection with the operation of the Of the site/The app and its services.

            13.6. the Buyer and Seller guarantee that they use By a website/The application in accordance with the terms and conditions of its use, information about them on Secure pages Of the site/ All actions performed on the Site/in the App under a Username and Password are performed by them personally or by authorized persons, and are binding and legally valid for the Buyer and Seller. The parties undertake to inform each other of any unauthorized disclosure to third parties Username and Password.

            13.7. all settlements under this agreement Payments are made exclusively in the currency of the Russian Federation. Russian Federation – in rubles.

            13.8. all amendments to the Agreement, as well as other agreements between the Parties, correspondence between them, notifications and appeals are made exclusively in Russian.

            Revision from" 05 " October 2020.
            """

            static let topMargin: Percent = 1%

            static let widthPercent: Percent = 96%

            static let bottomPercent: Percent = 3%

            static let gradientOffset: CGFloat = 7
        }
    }
}
