
# Recipe app

> RealTime search engine is a ruby on rails app that filter articles in articles list and display the filtered result. It saves all seaching keywords for data analysis. 

## Built With

- Ruby on Rails & postgreSQL.
- Linters (Rubocop, Stylelint).
- Git & GitHub.

## Getting Started

To get a local copy up and running follow these simple example steps.

### Prerequisites

    Git
    PostgreSQL
    Ruby on Rails 

### Setup

    1. git clone https://github.com/JoffreyNK/realTimeSearcBox
    2. cd realTimeSearcBox
    3. bundle install
    4. rails db:create
    5. rails db:migrate
    6. rails db:seed

you can add your testing data in ```db/seeds.rb``` file using the same partern used

### Usage

    1. rails server
    2. xdg-open http://localhost:3000/


when you the app loads you have to sign up using email and apssword to help the algoritm to track users. 

### Testing cases:
after login you are indicated on Ui where you can enter query keyword:

having article title: ```What is a good car?```

if you type ```what``` it saves it.

when you continue typing ```what is a good``` it replaces the first one with the last searched

if you type for the third time ```what is a```. It won't save it  bcause the algoritm will think that you are rubbing a keyword which you already have saved. But if the last searched keyword was different it will save bcause the algoritm will thinking you are trying another search.

If you search using the same keyword for different times the algrith will incremet seaching counter on the same keyword.

### Done!

Ready to work?⛏️ You're all set to explore and change the repo locally (on your computer).

## Author: 👤 **Joffrey**

- GitHub: [@joffreynk](https://github.com/joffreynk)
- Twitter: [@joffreynk](https://twitter.com/joffreynk)
- LinkedIn: [joffreynk](https://linkedin.com/in/joffreynk)

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](../../issues/).

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

- My fellow Micronauts.
- Google and Stack Overflow.
- Inspiration.
- etc.

## 📝 License

This project is [MIT](./MIT.md) licensed.
