# superUserContent

Dynamically load stylesheets in Firefox from plaintext files in your profile.

## About

[superUserContent](https://addons.mozilla.org/en-US/firefox/addon/superusercontent/) is a simple Firefox plugin that creates a new directory in your profile's `chrome` directory called `userContent.css.d`. You can use this directory as a runtime path for css stylesheets. superUserContent will apply any stylesheets it finds in this directory to pages when they load.

* Changes to css files in userContent.css.d will take effect when the page refreshes
* Make rapid prototypes or try out new changes without busting your cache
* Use your own editor and CLI tools to maintain themes

superUserContent is for developers who want an easy way to change the look and feel of the sites they frequently visit using their own text editor and CLI tools. superUserContent is a great tool for theme designers who want to share their customizations on sites like [userstyles.org](http://userstyles.org) so they can be used easily by casual browser users with plugins like [Stylish](https://addons.mozilla.org/en-US/firefox/addon/stylish/).

This plugin was made to address the [current limitations](https://bugzilla.mozilla.org/show_bug.cgi?id=208641) of userContent.css that make it difficult to use for general web development.

## Installing

Building the plugin requires the [Add-on SDK](https://developer.mozilla.org/en-US/Add-ons/SDK).

Compile the [CoffeeScript](http://coffeescript.org/) files with `cake build` and then build the xpi with `cfx xpi`.

For normal users, install the addon by visiting its [listing](https://addons.mozilla.org/en-US/firefox/addon/superusercontent/) on Mozilla.org.

## License

superUserContent is open source software available under the [MPL 2.0](http://www.mozilla.org/MPL/2.0/) license.

Copyright © 2014, Tony Crisci

All rights reserved.
