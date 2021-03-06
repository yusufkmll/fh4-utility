#File Organization

Screens: This folder will contain the application UI files rendered on the device screen.

Utils: This folder contains the functions used to implement the application’s business logic. For instance, if we build a social media application that supports a multi-account login, the utilities will ensure that the data rendered is changed according to the currently logged-in account.

Widgets: This folder contains widgets that are used repeatedly in the application. If you are using an API to list GitHub accounts following a particular user, the followers’ list view remains the same. Only the data that is rendered is dynamic. In such a case, we will use the followers widget in our widgets folder.

Data: The data folder contains data collections that are fetched from services or databases. For instance, if our application will use firebase, we could have a user model containing information about the user relating to password name, age, etc.

Services: Services folder should handle your application’s networking logic. For example, once a user gets authenticated with Google or GitHub, the application needs to update the backend with the access token. The service folder will contain the implementation of the logic responsible for handling this functionality.

Source: https://www.section.io/engineering-education/flutter-folder-organization/