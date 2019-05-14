browser.runtime.onMessage.addListener(message => {
  let mode = message["ime-mode"];
  browser.runtime.sendNativeMessage("com.clear_code.ime_mode_we_host", mode);
});
