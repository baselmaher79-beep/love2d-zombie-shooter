# Zombie Shooter - LÖVE2D Game

A top-down zombie shooter game built with LÖVE2D 11.x and Lua.

## Features

- ✅ Player movement with WASD keys
- ✅ Mouse-aimed rotation
- ✅ Shoot with left mouse button
- ✅ Multiple zombies with AI behavior
- ✅ Collision detection
- ✅ Score tracking
- ✅ Wave system (extensible)
- ✅ Clean, modular code architecture

## Project Structure

```
├── main.lua                 # Entry point
├── src/
│   ├── constants.lua       # Game configuration
│   ├── sprites.lua         # Sprite loading and management
│   ├── player.lua          # Player class
│   ├── zombie.lua          # Zombie class
│   ├── bullet.lua          # Bullet class
│   └── game.lua            # Game state manager
└── sprites/
    ├── background.png      # Background image
    ├── player.png          # Player sprite
    ├── zombie.png          # Zombie sprite
    └── bullet.png          # Bullet sprite
```

## Installation

1. Download and install [LÖVE 11.x](https://love2d.org/)
2. Create a `sprites/` folder in the project root
3. Add your sprite images:
   - `background.png` (recommended: 1280x720)
   - `player.png` (recommended: 32x32)
   - `zombie.png` (recommended: 32x32)
   - `bullet.png` (recommended: 4x4)

## Running the Game

```bash
love .
```

Or drag the project folder onto the LÖVE executable.

## Controls

- **WASD** - Move player
- **Mouse** - Aim player
- **Left Click** - Shoot
- **ESC** - Exit game

## Code Improvements Made

### 1. **Modular Architecture**
   - Separated concerns into individual files
   - Each entity (Player, Zombie, Bullet) is a class
   - Game state managed centrally in Game module

### 2. **Object-Oriented Design**
   - Proper Lua OOP implementation with metatables
   - Classes follow consistent patterns
   - Better code reusability and maintainability

### 3. **Bug Fixes**
   - ✅ Fixed zombie initialization (was missing `zombies` table initialization)
   - ✅ Added boundary clamping for player movement
   - ✅ Normalized diagonal movement to prevent faster diagonal speeds
   - ✅ Added proper collision detection between bullets and zombies
   - ✅ Implemented bullet lifetime and off-screen removal

### 4. **Enhanced Features**
   - Smart zombie spawning at screen edges
   - Continuous zombie spawning with cooldown
   - Bullet-zombie collision detection and scoring
   - UI showing score, zombie count, and bullet count
   - Error handling for missing sprites with fallback

### 5. **Best Practices**
   - Configuration constants in dedicated file
   - Consistent method naming conventions
   - Proper entity lifecycle management
   - Optimized entity cleanup to prevent memory leaks
   - Safe sprite loading with error handling

## Future Enhancements

- [ ] Player health system
- [ ] Different zombie types
- [ ] Power-ups and special weapons
- [ ] Wave progression with increasing difficulty
- [ ] Sound effects and music
- [ ] Particle effects
- [ ] High score persistence
- [ ] Menu system
- [ ] Game over screen

## License

MIT