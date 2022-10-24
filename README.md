# Basic Info

* Ruby version => 2.7.4

* Database creation => local sqlite3 1.4

# Setup Instructions

* Install/Update Ruby to 2.7.4
* In the project directory on a terminal, run:
    - $ bundle install
    - $ rails db:migrate
* A mock up database should already be included with the pushed project.
* **If no database is present**, you need to setup a super user manually to access all app functionality:
    - Run: $ rails s
    - Access the app via web browser (default address: localhost:3000/)
    - Sign up a new user normally.
    - Back on the terminal run: $ rails c
    - In the console:
        - user = User.find_by(username: "rootUsernameYouCreated")
        - user.admin = true
        - user.root = true
        - user.save
    - This user can now edit other users administrative permissions via the app.

* Serve the app via terminal: $ rails s
    - Access via browser (default address: localhost:3000/).

# User administrative permissions

* By default, you can access a **root** user by logging in with the following credentials:
    - *username*: root
    - *password*: password
* Can be seen at their respective user pages (localhost:3000/users/<id>).
* Root status: **key icon** to the left of the username
* Admin status: **check mark stamp icon** to the left of the username

# More

* A list with albums entries created by the user should be shown in the user page after an album is created with that user account.

* You can access the app's features by usign the ever present navbar at the top and footer at the bottom.

# Feedback

* Please send any feedback to: carlos.ed.sxs@gmail.com

* **Any feedback, no mattter how small, is well appreciated!**