import Apps from "gi://AstalApps";
import { App, Astal, Gdk, Gtk } from "astal/gtk3";
import { bind, exec, execAsync, Variable } from "astal";

const MAX_ITEMS = 12;

function hide() {
  App.get_window("launcher")!.hide();
}

function AppButton({ app }: { app: Apps.Application }) {
  return (
    <button
      className="AppButton"
      onClicked={() => {
        hide();
        app.launch();
      }}
    >
      <box>
        <icon icon={app.iconName} />
        <box valign={Gtk.Align.CENTER} vertical>
          <label className="name" truncate xalign={0} label={app.name} />
          {app.description && (
            <label
              className="description"
              wrap
              xalign={0}
              label={app.description}
            />
          )}
        </box>
      </box>
    </button>
  );
}

export default function Applauncher() {
  const { CENTER } = Gtk.Align;
  const apps = new Apps.Apps();

  const text = Variable("");
  const mathResult = Variable("");
  const list = text((text) => apps.fuzzy_query(text).slice(0, MAX_ITEMS));

  const onEnter = () => {
    const input = text.get().trim();

    // Check if the input is a mathematical expression
    if (isMathExpression(input)) {
      try {
        const result = evaluateExpression(input);
        exec(`wl-copy ${result}`);
      } catch (error) {
        console.error("Invalid Expression");
      }
    } else {
      apps.fuzzy_query(input)?.[0].launch();
    }
    hide();
  };

  // Function to check if the input is a mathematical expression
  function isMathExpression(input: string) {
    return /^[0-9+\-*/().\s]+$/.test(input);
  }

  // Function to evaluate the mathematical expression
  function evaluateExpression(expression: string) {
    // Use Function constructor for safe evaluation
    return new Function(`return ${expression}`)();
  }

  return (
    <window
      name="launcher"
      anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.BOTTOM}
      exclusivity={Astal.Exclusivity.IGNORE}
      keymode={Astal.Keymode.ON_DEMAND}
      application={App}
      onShow={() => text.set("")}
      onKeyPressEvent={function (self, event: Gdk.Event) {
        if (event.get_keyval()[1] === Gdk.KEY_Escape) self.hide();

        const input = text.get().trim();
        if (isMathExpression(input)) {
          try {
            mathResult.set(evaluateExpression(input));
            console.log(mathResult.get());
          } catch (error) {
            console.error("Invalid Expression");
          }
        }
      }}
      visible={false}
    >
      <box>
        <eventbox widthRequest={4000} expand onClick={hide} />
        <box hexpand={false} vertical>
          <eventbox heightRequest={100} onClick={hide} />
          <box widthRequest={500} className="Applauncher" vertical>
            <entry
              placeholderText="Search"
              text={text()}
              onChanged={(self) => text.set(self.text)}
              onActivate={onEnter}
            />
            <box
              halign={CENTER}
              className="math-result"
              vertical
              visible={list.as((l) => l.length === 0)}
            >
              <label label={mathResult((_) => `${mathResult.get()}`)} />
            </box>
            <box spacing={6} vertical>
              {list.as((list) => list.map((app) => <AppButton app={app} />))}
            </box>
            <box
              halign={CENTER}
              className="not-found"
              vertical
              visible={list.as((l) => l.length === 0)}
            >
              <icon icon="system-search-symbolic" />
              <label label="No match found" />
            </box>
          </box>
          <eventbox expand onClick={hide} />
        </box>
        <eventbox widthRequest={4000} expand onClick={hide} />
      </box>
    </window>
  );
}
