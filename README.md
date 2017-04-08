TYPO3 Forge Redmine Plugin
====

This Redmine Plugin provides the functionality of [TYPO3 Forge](https://forge.typo3.org) Redmine instance
as plugin for Redmine so it should be easy to integrate it in new Redmine
Versions.

run `bundle install` to install new gems

To use this plugin, put the content of the repo into `plugins/typo3_forge` folder.

The changed base layout uses the assets provided by the [TYPO3 theme](https://github.com/TYPO3-infrastructure/rm_typo3_forge_theme) (which needs to go to `public/themes/TYPO3`.

On first intstallation, you have to run the migrations with `rake redmine:plugins:migrate`.
