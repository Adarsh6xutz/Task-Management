# Task Management System

This is a Ruby on Rails application.
This application supports user roles as client, manager,
and employee and utilizes JWT for authentication.

```sh
git clone https://github.com/Adarsh6xutz/Task-Management.git
cd TaskManagementSystem
bundle install
rails db:migrate
rails s
```

# Usage
* A Client can create tasks.
* A Manager can delete tasks and assign tasks to an Employee.
* An Employee can complete tasks.
* Generate a Secure JWT Secret Key: open rails console by using
```ruby
rails c
SecureRandom.hex(64)
```
* Copy this and assign to JWT_SECRET_KEY in application_controller.rb

APIs are protected using JWT, so make sure to log in first and include 
the JWT token in the Authorization header of your requests.




