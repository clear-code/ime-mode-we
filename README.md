# ime-mode-we

Provides an ability to handle the [`ime-mode`](https://developer.mozilla.org/en-US/docs/Web/CSS/ime-mode) CSS property on GNU/Linux. Because Firefox on GNU/Linux doesn't support `active` and `inactive` values of `ime-mode`, this extension complements handling these values by calling a native command.

You need to install not only the Firefox extension but also the native connector for it to work. It supports only [IBus](https://github.com/ibus) as an IM framework and a few engines for it by default.

## Steps to install the native connector

  1. Clone this repository
  2. Type `make` to build ime-mode-we-host.tar.gz
      * The native commands are installed into /usr/local/bin by default.
        * You can change the path by adding `PREFIX` environmental variable.
        * e.g.) `make PREFIX=/usr`
      * The application manifest is installed into /usr/lib/mozilla/native-messaging-hosts by default.
        * You can change the path by adding `MOZILLADIR` environmental variable.
        * See also [the MDN page](https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/Native_manifests#Linux) to find the appropriate directory.
        * e.g.) `make MOZILLADIR=/usr/lib64/mozilla/native-messaging-hosts`
  3. `sudo make install`

  
## Steps to build & install the extension for testing

  1. Clone this repository
  2. Type `make` to build ime-mode-we.xpi
  3. Open "about:debugging" in Firefox, click "Load Temporary Add-on" and select the built ime-mode-we.xpi.
  
## How to install the extension permanently

  * Install from https://addons.mozilla.org/en-US/firefox/addon/ime-mode-we/

## Supported IM frameworks

  * [IBus](https://github.com/ibus)

## Suppreted IM engines

  * anthy
  * kkc
  * mozc-jp
  * skk
  
You can add other engines by adding config files under following directories:

  * /etc/ibus-set-input-mode/
  * ~/.config/ibus-set-input-mode/
  
Here is the example for Anthy:

  * path: /etc/ibus-set-input-mode/anthy.json
  * content:
```json
{
  "anthy": {
    "active":   "InputMode.Hiragana",
    "inactive": "InputMode.Latin"
  }
}
```
