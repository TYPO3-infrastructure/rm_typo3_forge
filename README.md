Forger Typo3 Redmine Plugin
====

This Redmine Plugin provides the functionality of Typo3 Forge Redmine instance
as Plugin for Redmine so it should be easy to integrate it in new Redmine
Versions.

run `bundle install` to install new gems

To Completly Use this Plugin you should put the Content of the repo into the
`plugins` folder. In order this Plugins changes the Layout of the 
Base Page we recomend to use the Typo3 Redmine Theme.

On first intstallation you have to run the migrations with `rake redmine:plugins:migrate`.
To let them run throuhg the old databasedump is needed.