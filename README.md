# Spy (Improved) — WoW 3.3.5 Wrath of the Lich King #

<img width="303" height="231" alt="Spy Demo" src="https://github.com/user-attachments/assets/fd931a86-e6b3-4988-b002-29410ff88515" />



A backport / fix of the classic **Spy** addon for World of Warcraft 3.3.5a (Wrath
of the Lich King). All original functionality of Spy is preserved exactly as it
was — Nearby list, alerts, tabs, counters, Last Hour, Ignore, and Kill on Sight
all behave the same. This package adds a small set of additive features and an
**Appearance** options panel so you can customize the look of the window without
touching XML or Lua.

## What's new in this version ##

### Friendly counter ###
- A green friendly-player counter is shown next to the existing enemy counter.
- It updates from your target, mouseover, and combat log just like enemy
  detection — no extra setup required.
- A mouseover tooltip on the counter explains what the number means.

### Appearance options panel ### 
Open the Spy options window (`/spy`) and look at the **Display Options →
Appearance** section. The current order is:

1. **Font** — pick any font registered with LibSharedMedia.
2. **Bar Texture** — status bar texture used for each row.
3. **Frame Border** — pick any border texture (LibSharedMedia).
4. **Background** — background texture for the main window.
5. **Border Size** — thickness of the frame border (1–32).
6. **Font Size** — height of each player row (10–40).
7. **Row Spacing** — vertical space between rows (0–20).
8. **Title Text Size** — height of the title bar text (8–30).
9. **Guild Font Size** — independent font size for the guild text on the right
   side of each row (6–30).
10. **Max Players Shown** — maximum number of players in the list (1–40).
11. **Window Opacity** — opacity of the main window.
12. **Background Opacity** — opacity while in an instance.
13. **Lock Window** — lock so it cannot be moved or resized.
14. **Invert Spy** — grow rows upward from the bottom (requires UI reload).
15. **Reload UI** — reload the interface so Invert Spy / display changes apply.

All Appearance settings are stored per profile, so switching profiles switches
the look as well.

### Slash commands ###
Command	and What it does
- `/spy` — open the options window (original behavior).
- `/spy show`	Show / enable the Spy window.
- `/spy hide`	Hide / disable the Spy window.
- `/spy reset`	Reset the Spy and Alert windows back to their default position.
- `/spy lock`	Toggle locking the window in place (prints the new state to chat).
- `/spy clear`	Clear all players from the current list.
- `/spy config`	Open the configuration panel directly.
- `/spy kos <name>`	Add or remove a player from your Kill on Sight list. Example: /spy kos Bob
- `/spy ignore <name>`	Add or remove a player from the Ignore list. Example: /spy ignore Alice
- `/spy stats`	Toggle the Spy statistics window.
- `/spy test`	Trigger a test stealth alert (uses the name "Bazzalan").

## Installation ##

1. Close the game completely.
2. Copy the `Spy` folder into `World of Warcraft\Interface\AddOns\`.
3. Launch the game and enable **Spy** on the character select AddOns screen.

The folder name on disk **must** be `Spy` for WoW to load it.

## Compatibility ## 

- **WoW client:** 3.3.5a (Wrath of the Lich King).
- **Required libraries:** Ace3 and LibSharedMedia-3.0 are embedded in the addon.
  The shared-media font / status bar / background / border dropdowns will
  automatically include any textures registered by other addons (SharedMedia,
  ElvUI, Masque, etc.).
