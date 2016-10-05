Forger Typo3 Redmine Plugin
====

This Redmine Plugin provides the functionality of Typo3 Forge Redmine instance
as Plugin for Redmine so it should be easy to integrate it in new Redmine
Versions.

To Install it you have to Put the Source Code in the Plugin directory and
change one line in `config/routes.rb`:

the line
```ruby
  root :to => 'welcome#index', :as => 'home'
```
becomes
```ruby
  root :to => 'start#index', :as => 'home'
```
run `bundle install` to install new gems
