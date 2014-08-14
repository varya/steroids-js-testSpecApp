buttons = document.querySelectorAll "button"

for button in buttons
  button.onclick = () ->
    webView = new steroids.views.WebView this.dataset.location
    steroids.layers.push webView

