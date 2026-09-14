# COMPARISON: LÖVE2D vs Godot GDScript

## WHAT GETS WRITTEN (New in Godot/GDScript)

### 1. Scene/Node System
```gdscript
extends Node                    # Everything extends a base class
extends CharacterBody2D         # Physics-based nodes
extends Area2D                  # Physics areas for collision

class_name Player               # Explicit class naming
class_name Zombie
class_name Bullet
```

### 2. Lifecycle Methods
```gdscript
func _ready() -> void:          # Called when node enters scene tree
	# Initialization code

func _process(delta: float) -> void:  # Called every frame
	# Update game logic

func _draw() -> void:           # Called when drawing
	# Rendering code

func _input(event: InputEvent) -> void:  # Handle input events
```

### 3. Input System
```gdscript
# LÖVE2D
function love.keypressed(key)
	if key == "space" then
		spawnZombie()
	end
end

# Godot
func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			get_tree().quit()
```

### 4. Type System
```gdscript
var player: Player              # Typed variables
var zombies: Array[Zombie] = [] # Generic typed arrays
var score: int = 0              # Explicit type declarations
const SCREEN_WIDTH = 1280       # Typed constants

# vs LÖVE2D (dynamically typed)
local player = {}               # No type information
local zombies = {}
local score = 0
```

### 5. Vector Operations
```gdscript
# Godot has built-in Vector2 class
position = Vector2(640, 360)
var direction = (player.position - position).normalized()
velocity = direction * SPEED
var angle = direction.angle()

# LÖVE2D manual math
player.x = love.graphics.getWidth() / 2
player.y = love.graphics.getHeight() / 2
local dx = player.x - zombie.x
local dy = player.y - zombie.y
```

### 6. Physics & Movement
```gdscript
extends CharacterBody2D         # Built-in physics
move_and_slide()                # Automatic collision handling
var velocity: Vector2           # Physics velocity

# LÖVE2D manual physics
player.x = player.x + moveX * player.speed * dt
player.y = player.y + moveY * player.speed * dt
```

### 7. Scene Tree Management
```gdscript
add_child(player)               # Add nodes to scene tree
queue_free()                    # Safe deletion
get_tree().quit()               # Quit game
add_child(sprite)               # Create sprites programmatically
```

### 8. Resource Loading
```gdscript
# Godot resource system
sprite.texture = load("res://assets/player.png")  # Preprocessed at startup

# LÖVE2D
sprites.player = love.graphics.newImage('sprites/player.png')  # Loaded at runtime
```

### 9. Signals (Events)
```gdscript
area_entered.connect(_on_area_entered)  # Signal system
func _on_area_entered(area: Area2D) -> void:
	# Handle collision via signal
```

### 10. String Formatting
```gdscript
draw_string(get_theme_font("font"), Vector2(10, 10), "Score: %d" % score)

# vs LÖVE2D
love.graphics.print("Score: " .. self.score, 10, 10)
```

---

## WHAT GETS ERASED (Removed from LÖVE2D)

### 1. **love.load() → Removed**
   - ❌ DELETED: `function love.load()`
   - ✅ REPLACED: `func _ready() -> void:`

### 2. **love.update(dt) → Removed**
   - ❌ DELETED: `function love.update(dt)`
   - ✅ REPLACED: `func _process(delta: float) -> void:`

### 3. **love.draw() → Removed**
   - ❌ DELETED: `function love.draw()`
   - ✅ REPLACED: `func _draw() -> void:` (or sprite rendering)

### 4. **love.keypressed() → Removed**
   - ❌ DELETED: `function love.keypressed(key)`
   - ✅ REPLACED: `func _input(event: InputEvent) -> void:`

### 5. **love.mousepressed() → Removed**
   - ❌ DELETED: `function love.mousepressed(x, y, button)`
   - ✅ REPLACED: Input handled in `_input()` or via `get_global_mouse_position()`

### 6. **Manual Table Management**
   - ❌ DELETED: `table.insert(zombies, zombie)`
   - ✅ REPLACED: `zombies.append(zombie)`
   
   - ❌ DELETED: `for i, z in ipairs(zombies) do`
   - ✅ REPLACED: `for zombie in zombies:`
   
   - ❌ DELETED: `table.remove(zombies, i)`
   - ✅ REPLACED: `zombies.remove_at(i)`

### 7. **Manual Sprite Loading with Error Handling**
   - ❌ DELETED: pcall() error handling for sprite loading
   - ✅ REPLACED: Built-in resource loader with editor validation

### 8. **Manual Math Functions**
   - ❌ DELETED: `math.sqrt(dx * dx + dy * dy)`
   - ✅ REPLACED: `(player.position - position).length()`
   
   - ❌ DELETED: `math.atan2(dy, dx)`
   - ✅ REPLACED: `(player.position - position).angle()`
   
   - ❌ DELETED: `math.cos(angle)` and `math.sin(angle)`
   - ✅ REPLACED: Vector2(cos(angle), sin(angle))

### 9. **love.graphics Functions**
   - ❌ DELETED: `love.graphics.draw()`
   - ✅ REPLACED: Sprite2D nodes or custom `_draw()` calls
   
   - ❌ DELETED: `love.graphics.getWidth()`
   - ✅ REPLACED: `get_viewport().get_visible_rect().size`
   
   - ❌ DELETED: `love.graphics.print()`
   - ✅ REPLACED: `draw_string()` or Label nodes

### 10. **love.mouse Functions**
   - ❌ DELETED: `love.mouse.getX()`
   - ✅ REPLACED: `get_global_mouse_position().x`
   
   - ❌ DELETED: `love.mouse.getY()`
   - ✅ REPLACED: `get_global_mouse_position().y`

### 11. **Manual Collision Detection (Partially)**
   - ❌ DELETED: Simple AABB collision in one function
   - ✅ REPLACED: Godot's built-in Area2D and shape-based collision detection
   - Can still use manual AABB if needed, but physics engine handles it

### 12. **Constants File (Lua)**
   - ❌ DELETED: Separate `constants.lua` file
   - ✅ REPLACED: Constants defined at top of Main.gd
   - Godot doesn't need a separate constants module

### 13. **Sprite Manager Module**
   - ❌ DELETED: `sprites.lua` module with Sprites:initialize()
   - ✅ REPLACED: Direct resource loading with `load("res://...")` in each script
   - Godot's asset system handles sprite management

### 14. **Manual Memory Management**
   - ❌ DELETED: `for i = #self.zombies, 1, -1 do` reverse iteration for cleanup
   - ✅ REPLACED: `queue_free()` and Godot's garbage collection

### 15. **require() Statements**
   - ❌ DELETED: `require("src/player")` module imports
   - ✅ REPLACED: `class_name Player` and automatic discovery
   - Godot uses a global class registry

### 16. **Window Configuration**
   - ❌ DELETED: `love.window.setMode()` and `love.window.setTitle()`
   - ✅ REPLACED: Done in `project.godot` config or via:
   ```gdscript
   get_window().set_window_title("Zombie Shooter")
   get_window().size = Vector2i(1280, 720)
   ```

---

## STRUCTURE COMPARISON

### LÖVE2D File Structure
```
main.lua
src/
  ├── constants.lua
  ├── sprites.lua
  ├── player.lua
  ├── zombie.lua
  ├── bullet.lua
  └── game.lua
sprites/
  ├── background.png
  ├── player.png
  ├── zombie.png
  └── bullet.png
```

### Godot File Structure
```
Main.gd (scene root - main game logic)
Player.gd (autoload or instanced)
Zombie.gd (instanced)
Bullet.gd (instanced)
project.godot (config file)
res://
  ├── assets/
  │   ├── background.png
  │   ├── player.png
  │   ├── zombie.png
  │   └── bullet.png
  └── scenes/
      ├── main.tscn (scene file)
      ├── player.tscn
      ├── zombie.tscn
      └���─ bullet.tscn
```

---

## KEY DIFFERENCES SUMMARY

| Aspect | LÖVE2D | Godot |
|--------|--------|-------|
| **Callbacks** | `love.load/update/draw` | `_ready/_process/_draw` |
| **Input** | `love.keypressed/mousepressed` | `_input()` event system |
| **Movement** | Manual delta-time multiplication | `move_and_slide()` with physics |
| **Sprites** | Manual drawing with `draw()` | Sprite2D nodes |
| **Vectors** | Manual x, y coordinates | Built-in Vector2 class |
| **Math** | Manual `math.sqrt/atan2/cos/sin` | Vector2 methods |
| **Resources** | `newImage()` at runtime | `load()` preprocessed |
| **Tables** | Lua tables `{}` | GDScript arrays and dictionaries |
| **Memory** | Manual cleanup | `queue_free()` + garbage collection |
| **Modules** | `require()` imports | `class_name` registry |
| **Collision** | Manual AABB | Physics engine (Area2D/RigidBody2D) |
| **Scene Graph** | Flat structure | Hierarchical Node tree |

---

## CODE SIZE

### LÖVE2D
- main.lua: ~20 lines
- src/constants.lua: ~30 lines
- src/sprites.lua: ~30 lines
- src/player.lua: ~70 lines
- src/zombie.lua: ~60 lines
- src/bullet.lua: ~65 lines
- src/game.lua: ~150 lines
- **TOTAL: ~425 lines**

### Godot/GDScript
- Main.gd: ~120 lines
- Player.gd: ~45 lines
- Zombie.gd: ~40 lines
- Bullet.gd: ~50 lines
- **TOTAL: ~255 lines** (+ scene files which are XML)

Godot is more concise because the engine handles much of the boilerplate!
