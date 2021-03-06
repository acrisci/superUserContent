// Generated by CoffeeScript 1.6.3
var CSS_DIR, PageMod, addonCssPath, buildImports, compareCssLists, cssFiles, cssMatch, cssMod, doAttach, file, pathFor, url;

file = require('sdk/io/file');

url = require('sdk/url');

pathFor = require('sdk/system').pathFor;

PageMod = require('sdk/page-mod').PageMod;

CSS_DIR = 'userContent.css.d';

cssMatch = /\.css$/;

addonCssPath = file.join(pathFor('ProfD'), 'chrome', CSS_DIR);

file.mkpath(addonCssPath);

cssFiles = null;

cssMod = null;

compareCssLists = function(a, b) {
  var i, v, _i, _len;
  if (!a || !b) {
    return false;
  } else if (a.length !== b.length) {
    return false;
  }
  for (i = _i = 0, _len = a.length; _i < _len; i = ++_i) {
    v = a[i];
    if (a[i] !== b[i]) {
      return false;
    }
  }
  return true;
};

buildImports = function(fileList) {
  if (fileList == null) {
    fileList = [];
  }
  return fileList.map(function(f) {
    return file.join(addonCssPath, f);
  }).map(url.fromFilename).map(function(f) {
    return "@import url(\"" + f + "\");";
  }).join("\n");
};

doAttach = function(worker) {
  var fileList;
  if (!file.exists(addonCssPath)) {
    return;
  }
  fileList = file.list(addonCssPath).filter(function(f) {
    return cssMatch.test(f);
  });
  if (!compareCssLists(fileList, cssFiles)) {
    cssFiles = fileList;
    cssMod = PageMod({
      include: "*",
      contentStyle: buildImports(cssFiles),
      contentScriptWhen: "start",
      onAttach: doAttach
    });
    worker.tab.reload();
    return worker.destroy();
  }
};

if (file.exists(addonCssPath)) {
  cssFiles = file.list(addonCssPath).filter(function(f) {
    return cssMatch.test(f);
  });
}

cssMod = PageMod({
  include: "*",
  contentStyle: buildImports(cssFiles),
  contentScriptWhen: "start",
  onAttach: doAttach
});
