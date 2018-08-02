# GROUP EXPENSE

## Command basic
- Create model and migrate: rails generate model Category
- Create controller: rails generate controller Categories
- Add column table db: rails generate migration add_is_deleted_to_categories is_deleted:boolean

## Content
**1. Static page**
- Custom theme admin

**2. Init model**

**3. Manage category**
- Add and remove column migration
- Apply ajax and use popup
- Use validate model and jQuery-Validation-Engine

**4. Manage product**
- Apply chosen-rails
- Scope in model
- Create common class GroupItem

**5. Change routes**
- Use routes member

**6. Listing user**
- Apply sortable in table

**7. Create user**
- Use form field: email_field, password_field, text_field , radio_button, text_area
- Apply plugin markdown in text_area
- Apply jQuery-Validation-Engine: funcCall, ajax

**8. Add Group member**
- Apply Bootstrap Tags Input
- User hidden field with value = []
- User JSON Javascript

**9. Listing transaction**
- Apply dataTable
- Drop table with migration

**10. Add Update Delete Transaction**
- Apply moment js
- Load view by ajax
- Use event js with onChange
- Apply DATE_FORMAT in scope model (scope by_date by function search date)

**11. Update charset migrate**

**12. Export Excel Transaction**
- Apply RubyXL export excel

**13. Data File Management**
- Delete and download file log

**14. Delete selected row with checkbox in Data File**

**15. Create selectbox excel and sheet master (rubyxl)**

**16. Apply gem Cancancan**

**17. Rails Parent/Child Relationship - Listing Product Category**

## Deploy Heroku
**1. Install CLI**
- Run command: curl https://cli-assets.heroku.com/install-ubuntu.sh | sh
- Doc: https://devcenter.heroku.com/articles/heroku-cli

**2. Install Nodejs (ver >= 8.0)**
- curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
- sudo apt-get install -y nodejs
- Check: node -v, npm -v, heroku --version

**3. Clone code from github**
- git clone git@github.com:chukimthang/group_expense.git
- cd group_expense

**4. Login heroku**
- Run command: heroku login (enter email and password heroku)

**5. Create new app heroku**

5.1. Create in url: https://dashboard.heroku.com/apps
- Create app: Click New -> Enter App Name -> Click button Create App
- Create database: Click app name -> Resources -> Find more add-ons -> Choose Heroku Postgres -> 
  Install Heroku Postgres -> Enter app name -> Provision add-on
  
5.2. Create by command
- Run command: heroku create (create app + database + add remote)

**6. Add remote heroku (if execute method 5.1)**
- Run command: heroku git:clone -a sochitieu
- Check: git remote -v

**7. Update gem file**
- Add gem: `ruby '2.3.1'`
- Move gem 'mysql2' to
```
group :development, :test do
  gem 'mysql2 
end
```
- Add gem gem 'pg' and gem 'rails_12factor' to
```
group :production
  gem 'pg'
  gem 'rails_12factor'  
end
```
- Delete line Gemfile.lock in .gitignore
- Run bundle install

**8. Install heroku buildpacks**
- heroku buildpacks:set heroku/nodejs
- heroku buildpacks:set heroku/ruby

**9. Push heroku**
- Git add -A
- git commit -m "Deploy Heroku"
- git push heroku master

**10. Migration heroku**
- heroku run rake db:migrate
- heroku run rake db:seed

## Libraries
**1. Chosen**
- Link: https://github.com/tsechingho/chosen-rails

**2. jQuery-Validation-Engine**
- https://github.com/posabsolute/jQuery-Validation-Engine

**3. Bootstrap Tags Input**
- Install gem in rails: https://github.com/luciuschoi/bootstrap-tagsinput-rails
- Doc: https://bootstrap-tagsinput.github.io/bootstrap-tagsinput/examples/

**4. Bootstrap-tokenfield**
- Gem twitter-typeahead-rails: https://github.com/yourabi/twitter-typeahead-rails
- Css typeahead: https://github.com/bassjobsen/typeahead.js-bootstrap-css/blob/master/typeaheadjs.css
- Gem bootstrap-tokenfield-rails: https://github.com/icicletech/bootstrap-tokenfield-rails
- Doc bootstrap-tokenfield: http://sliptree.github.io/bootstrap-tokenfield/

**5. Moment js**
- Gem: https://github.com/derekprior/momentjs-rails
- Doc: https://momentjs.com/

**6. RubyXL**
- https://github.com/weshatheleopard/rubyXL

**7. Cancancan**
- https://github.com/CanCanCommunity/cancancan

## Note
#### JSON Javascript
**1. JSON Object**
```
myObj = { "name":"John", "age":30, "car":null }; 
x = myObj.name or myObj["name"]
```

**2. JSON Array**
```
myObj = {"name":"John", "age":30, "cars":[ "Ford", "BMW", "Fiat"]}; 
x = myObj.cars[0];
```

**3. JSON Parse: Convert String -> Object**

```var obj = JSON.parse('{ "name":"John", "age":30, "city":"New York"}');```

**4. JSON Stringify: Convert Object -> String**

```var myJSON = JSON.stringify(myObj);```

## Document Other
- Rails Parent/Child Relationship: https://www.kbarrett.com/blog/2013/05/28/rails-parent-child.html

