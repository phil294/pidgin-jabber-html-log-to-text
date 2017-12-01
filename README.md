# pidgin-jabber-html-log-to-text

Shell: Convert `2017-05-11.191514+0200CEST.html` files with content like
```html
<font color="#A82F2F"><font size="2">(23:59:21)</font> <b>Bob:</b></font> <html xmlns='http://jabber.org/protocol/xhtml-im'><body xmlns='http://www.w3.org/1999/xhtml'><p><span style='font-size: xx-large;'>Hello</span></p></body></html><br/>
<font color="#A82F2F"><font size="2">(00:00:09)</font> <b>Alice:</b></font> <html xmlns='http://jabber.org/protocol/xhtml-im'><body xmlns='http://www.w3.org/1999/xhtml'><p><span style='font-size: xx-large;'>Olleh</span></p></body></html><br/>
```
to
```
2017-05-11 23:59:21 **Bob:** Hello
2017-05-12 00:00:09 **Alice:** Olleh
```
Needs scripting because day changes implicitly.
Depends on [html2text.py](https://github.com/aaronsw/html2text).
