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
