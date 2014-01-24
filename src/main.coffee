# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# Copyright © 2014, Tony Crisci

file = require 'sdk/io/file'
url = require 'sdk/url'
{pathFor} = require 'sdk/system'
{PageMod} = require 'sdk/page-mod'

# the name of the top-level directory to find css files
CSS_DIR = 'userContent.css.d'

# match a file with a css file extension
cssMatch = /\.css$/

# the stylesheet include path
addonCssPath = file.join pathFor('ProfD'), 'chrome', CSS_DIR

# try to create the directory for stylesheets
unless file.exists addonCssPath
  file.mkpath addonCssPath

# the current stylesheets in the include path
cssFiles = null
# the current pagemod to dispatch workers
cssMod = null

# compares two file lists and determines if they are the same
compareCssLists = (a, b) ->
  if not a or not b
    return no
  else if a.length isnt b.length
    return no
  for v,i in a
    if a[i] isnt b[i]
      return no
  return yes

# creates the stylesheet to be included from the list of files
buildImports = (fileList = []) ->
  fileList
    .map((f) -> file.join(addonCssPath, f))
    .map(url.fromFilename)
    .map((f) -> """@import url("#{f}");""")
    .join("\n")

# creates the PageMod to attach the worker that includes the stylesheets
doAttach = (worker) ->
  return unless file.exists addonCssPath
  fileList = file.list(addonCssPath).filter((f) -> cssMatch.test(f))
  if not compareCssLists fileList, cssFiles
    cssFiles = fileList
    cssMod = PageMod
      include: "*"
      contentStyle: buildImports cssFiles
      contentScriptWhen: "start"
      onAttach: doAttach
    worker.tab.reload()
    worker.destroy()

if file.exists addonCssPath
  cssFiles = file.list(addonCssPath).filter((f) -> cssMatch.test(f))

# begin attaching workers to new pages
cssMod = PageMod
  include: "*"
  contentStyle: buildImports cssFiles
  contentScriptWhen: "start"
  onAttach: doAttach
