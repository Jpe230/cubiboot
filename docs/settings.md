# Configuration

Cubiboot reads `/config.ini` from the root of the storage device it is running
from. The file name and the `[cubeboot]` section are both required. If the file
is missing or a value is invalid, Cubiboot uses its built-in default instead.

Start with this:

```ini
[cubeboot]
# Open this folder when Cubiboot starts. A trailing slash is optional.
default_folder = /games

# Four rows are always shown. Choose between two and eight columns.
grid_columns = 4

# 100 is the stock size. Larger values make both normal and selected icons larger.
grid_icon_scale_percent = 120

# Optional visual and boot behaviour.
cube_color = 00ffff
force_progressive = 1
auto_boot_dvd = 0
```

## Browser

| Setting | Default | Notes |
| --- | --- | --- |
| `default_folder` | `/` | Folder opened at startup and after returning from the original GameCube menu. `/games` and `/games/` are equivalent. |
| `grid_columns` | `8` | Number of columns, from `2` to `8`. The browser always shows four rows. Icons are centered with even outer spacing. |
| `grid_icon_scale_percent` | `100` | Icon size from `75` to `150`. `120` is a good starting point for a four-column grid. |

## Boot and video

| Setting | Default | Notes |
| --- | --- | --- |
| `cube_color` | Stock colour | Six-digit hexadecimal RGB value, such as `00ffff`, or `random`. |
| `force_progressive` | `0` | Set to `1` to request progressive scan. |
| `force_swiss_default` | `0` | Set to `1` to boot compatible games through Swiss by default. |
| `auto_boot_dvd` | `0` | Set to `1` to check for a physical DVD after the browser finishes loading. A detected disc boots automatically; otherwise the browser remains open. |
| `preboot_delay_ms` | `0` | Delay before the opening animation. |
| `postboot_delay_ms` | `0` | Delay after the animation before booting the selected title. |

## Interface and controller behaviour

| Setting | Default | Notes |
| --- | --- | --- |
| `show_watermark` | `0` | Set to `1` to show the Cubiboot beta watermark. |
| `disable_mcp_select` | `0` | Set to `1` to disable MCP-based game selection handling. |

## Notes

- Use plain numbers for on/off settings: `0` means off and any non-zero value means on.
- Paths are case-sensitive on devices that expose a case-sensitive filesystem.
- `cube_logo`, `default_program`, and `button_*` are accepted by the parser but
  are not wired into the current boot path. They are kept for compatibility and
  should not be relied on.
