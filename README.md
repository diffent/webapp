# webapp
web app template for ios

build on xcode 14.2 or newer

see the file webapptemplate.png for a diagram on where the index.html is located

to adjust the web view scroll behavior, check out the methods in the file ViewController.m

some apps need pinch zooming or scrolling handled at the webview level, some app want
the internal html/javascript to handle this and to shut off all brower-level scrolling / zooming

the template is set up to start to allow most of this scrolling / pinch zooming 
(or all of it?) to be handled in the html/js code

this is just a base level setup, there may be more things to adjust or set up
