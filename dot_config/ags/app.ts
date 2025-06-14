import { App } from "astal/gtk3";
import style from "./style.scss";
import Bar from "./widget/Bar";
import DesktopQuote from "./widget/DesktopQuote";

App.start({
  css: style,
  instanceName: "js",
  requestHandler(request, res) {
    print(request);
    res("ok");
  },
  main() {
    App.get_monitors().map(Bar);
    App.get_monitors().map(DesktopQuote);
  },
});
