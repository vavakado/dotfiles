import { App } from "astal/gtk3";
import { Variable, GLib, bind, Process } from "astal";
import { Astal, Gtk, Gdk } from "astal/gtk3";
import Hyprland from "gi://AstalHyprland";
import Mpris from "gi://AstalMpris";
import Wp from "gi://AstalWp";
import Tray from "gi://AstalTray";

const greekLetters = {
	1: "α",
	2: "β",
	3: "γ",
	4: "δ",
	5: "ε",
	6: "ζ",
	7: "η",
	8: "θ",
	9: "ι",
	10: "κ",
};

function getGreekLetter(number: string | number) {
	return greekLetters[number];
}

function SysTray() {
	const tray = Tray.get_default();

	return (
		<box className="SysTray">
			{bind(tray, "items").as((items) =>
				items.map((item) => (
					<menubutton
						tooltipMarkup={bind(item, "tooltipMarkup")}
						usePopover={false}
						actionGroup={bind(item, "action-group").as((ag) => [
							"dbusmenu",
							ag,
						])}
						menuModel={bind(item, "menu-model")}
					>
						<icon gicon={bind(item, "gicon")} />
					</menubutton>
				)),
			)}
		</box>
	);
}

function AudioSlider() {
	const speaker = Wp.get_default()?.audio.defaultSpeaker!;

	return (
		<box className="AudioSlider">
			<icon icon={bind(speaker, "volumeIcon")} />
			<label
				label={bind(speaker, "volume").as(
					() => `${(speaker.volume * 100).toFixed(0)}%`,
				)}
			/>
		</box>
	);
}

function Media() {
	const mpris = Mpris.get_default();

	return (
		<box className="Media">
			{bind(mpris, "players").as((ps) =>
				ps[0] ? (
					<box>
						<box
							className="Cover"
							valign={Gtk.Align.CENTER}
							css={bind(ps[0], "coverArt").as(
								(cover) => `background-image: url('${cover}');`,
							)}
						/>
						<label
							label={bind(ps[0], "artist").as(
								() =>
									` ${truncateString(ps[0].artist, 43)} - ${truncateString(ps[0].title, 43)}`,
							)}
						/>
					</box>
				) : (
					"Nothing Playing"
				),
			)}
		</box>
	);
}

function KeyboardLayout() {
	const hypr = Hyprland.get_default();
	const icon = Variable("unknown");
	hypr.connect("keyboard-layout", (_c, _k, layout) => {
		icon.set(layout);
	});

	return (
		<box className="KeyboardLayout">
			<label
				className="Layout"
				label={icon((value) => `${getKeyboardLayoutIcon(value)}`)}
			/>
		</box>
	);
}

function getKeyboardLayoutIcon(layout: string) {
	const layoutMap: { [key: string]: string } = {
		"English (Colemak)": "CL",
		"English (US)": "US",
		Russian: "RU",
		Hebrew: "HE",
	};

	return layoutMap[layout] || layout;
}

function Workspaces() {
	const hypr = Hyprland.get_default();

	return (
		<box className="Workspaces">
			{bind(hypr, "workspaces").as((wss) =>
				wss
					.sort((a, b) => a.id - b.id)
					.filter((ws) => ws.id > 0)
					.map((ws) => (
						<button
							className={bind(hypr, "focusedWorkspace").as((fw) =>
								ws === fw ? "focused" : "",
							)}
							onClicked={() => ws.focus()}
						>
							{getGreekLetter(ws.id)}
						</button>
					)),
			)}
		</box>
	);
}

function truncateString(str: string, n: number) {
	// TODO: strip \n
	let nstr = str.replace(/\n/g, " ");

	return nstr.length > n ? nstr.slice(0, n - 3) + "..." : nstr;
}

function FocusedClient() {
	const hypr = Hyprland.get_default();
	const focused = bind(hypr, "focusedClient");

	return (
		<box className="Focused" visible={focused.as(Boolean)}>
			{focused.as(
				(client) =>
					client && (
						<label
							label={bind(client, "title").as((title) =>
								truncateString(title, 65),
							)}
						/>
					),
			)}
		</box>
	);
}

function Time({ format = "%H:%M | %m/%d" }) {
	const time = Variable<string>("").poll(
		1000,
		() => GLib.DateTime.new_now_local().format(format)!,
	);

	return (
		<label className="Time" onDestroy={() => time.drop()} label={time()} />
	);
}

function NextEvent() {
	const event = Variable<string>("").poll(60000, () =>
		Process.execv(["whenst", "next", "-tn"]),
	);

	return (
		<label
			className="NextEvent"
			onDestroy={() => event.drop()}
			label={event()}
		/>
	);
}

export default function Bar(monitor: Gdk.Monitor) {
	const anchor =
		Astal.WindowAnchor.BOTTOM |
		Astal.WindowAnchor.LEFT |
		Astal.WindowAnchor.RIGHT;

	return (
		<window
			className="Bar"
			gdkmonitor={monitor}
			exclusivity={Astal.Exclusivity.EXCLUSIVE}
			anchor={anchor}
		>
			<centerbox>
				<box hexpand halign={Gtk.Align.START}>
					<Workspaces />
					<NextEvent />
				</box>
				<box>
					<FocusedClient />
				</box>
				<box hexpand halign={Gtk.Align.END}>
					<SysTray />
					<KeyboardLayout />
					<AudioSlider />
					<Time />
				</box>
			</centerbox>
		</window>
  ); 
} 
 
