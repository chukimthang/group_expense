# GROUP EXPENSE

## Command basic
- Create model and migrate: rails generate model Category
- Create controller: rails generate controller Categories
- Add column table db: rails generate migration add_is_deleted_to_categories is_deleted:boolean

## Libraries
1. Chosen
- Link: https://github.com/tsechingho/chosen-rails
2. jQuery-Validation-Engine
- https://github.com/posabsolute/jQuery-Validation-Engine
3. Bootstrap Tags Input
- Install gem in rails: https://github.com/luciuschoi/bootstrap-tagsinput-rails
- Doc: https://bootstrap-tagsinput.github.io/bootstrap-tagsinput/examples/
4. Bootstrap-tokenfield
- Gem twitter-typeahead-rails: https://github.com/yourabi/twitter-typeahead-rails
- Css typeahead: https://github.com/bassjobsen/typeahead.js-bootstrap-css/blob/master/typeaheadjs.css
- Gem bootstrap-tokenfield-rails: https://github.com/icicletech/bootstrap-tokenfield-rails
- Doc bootstrap-tokenfield: http://sliptree.github.io/bootstrap-tokenfield/
5. Moment js
- Gem: https://github.com/derekprior/momentjs-rails
- Doc: https://momentjs.com/

## Content
1. Static page
- Custom theme admin
2. Init model
3. Manage category
- Add and remove column migration
- Apply ajax and use popup
- Use validate model and jQuery-Validation-Engine
4. Manage product
- Apply chosen-rails
- Scope in model
- Create common class GroupItem
5. Change routes
- Use routes member
6. Listing user
- Apply sortable in table
7. Create user
- Use form field: email_field, password_field, text_field , radio_button, text_area
- Apply plugin markdown in text_area
- Apply jQuery-Validation-Engine: funcCall, ajax
8. Add Group member
- Apply Bootstrap Tags Input
- User hidden field with value = []
- User JSON Javascript
9. Listing transaction
- Apply dataTable
- Drop table with migration
10. Add Update Delete Transaction
- Apply moment js
- Load view by ajax
- Use event js with onChange
- Apply DATE_FORMAT in scope model (scope by_date by function search date)
11. Update charset migrate
- rails db:migration
- rails db:seed

- bin/rails db:environment:set RAILS_ENV=development
- rails db:drop
- rails db:setup
- rails db:seed

## Note
#### JSON Javascript
1. JSON Object
- myObj = { "name":"John", "age":30, "car":null }; x = myObj.name or myObj["name"]
2. JSON Array 
- myObj = {"name":"John", "age":30, "cars":[ "Ford", "BMW", "Fiat"]}; x = myObj.cars[0];
3. JSON Parse: Convert String -> Object
- var obj = JSON.parse('{ "name":"John", "age":30, "city":"New York"}');
4. JSON Stringify: Convert Object -> String
- var myJSON = JSON.stringify(myObj);

