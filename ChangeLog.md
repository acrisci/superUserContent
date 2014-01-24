# Change Log

## 0.2

Minor bugfix release

* Bugfix: gracefully handle the case where the addon css path may be missing. Normal addon functionality should resume when the path is found once again.
* Add `cake run` task to Cakefile.

## 0.1

Initial release

[superUserContent](https://addons.mozilla.org/en-US/firefox/addon/superusercontent/) is a simple Firefox plugin that creates a new directory in your profile's `chrome` directory called `userContent.css.d`. You can use this directory as a runtime path for css stylesheets. superUserContent will apply any stylesheets it finds in this directory to pages when they load.
