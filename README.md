# 🛩️ Solstice Air Travel System

A comprehensive air travel system for FiveM QBCore servers, allowing players to travel between multiple airports with stunning cutscenes and a polished user experience.

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![QBCore](https://img.shields.io/badge/qbcore-dependency-green.svg)
![GTA5](https://img.shields.io/badge/gta5-compatible-orange.svg)

## ✨ Features

- **Multiple Airports**: Travel between Los Santos International, Sandy Shores Airfield, Grapeseed Airfield, Fort Zancudo Airbase, and Deep Arctic Runway
- **Seamless Integration**: Fully compatible with QBCore framework
- **Custom Cutscenes**: Immersive landing sequences at each airport
- **Map Blips**: Easy-to-locate airport markers on the map
- **Simple Interaction**: Uses qb-target for easy plane interaction
- **Configurable Options**: Easily adjust prices, coordinates, and other settings
- **Debug Mode**: Built-in developer tools for easy testing and configuration

## 📋 Dependencies

- QBCore Framework
- qb-core
- qb-target
- qb-menu

## 🚀 Installation

1. Download the latest release or clone the repository
2. Extract the `Solstice-AirTravel` folder to your server's resources directory
3. Add the following to your server.cfg:
```lua
ensure Solstice-AirTravel
```

4. Configure the settings in `config.lua` to your liking:
   - Adjust `TravelCost` for your economy
   - Enable/Disable `Debug` mode
   - Modify airport locations and coordinates if needed

## ⚙️ Configuration

The script is highly configurable through the `config.lua` file:

```lua
Config = {
    Debug = true,            -- Enable/disable debug commands
    EnableBlips = true,      -- Show airport blips on map
    TravelCost = 500,       -- Cost per flight
    DefaultCutsceneDuration = 8000
}
```

## 🎮 Usage

1. Visit any airport location on the map
2. Approach the Luxor 2 aircraft
3. Use qb-target to interact with the plane
4. Select your destination from the menu
5. Enjoy the flight!

## 🛠️ Debug Commands

When debug mode is enabled:
- `/testflight [airport_id]` - Test travel to specific airport
- `/getposdetailed` - Get detailed position information for configuration

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🎯 Future Plans

- Additional airport locations
- Custom aircraft selection
- VIP travel options
- Weather-dependent travel conditions
- Advanced booking system

## ⚠️ Support

For support, please open an issue in the GitHub repository or contact us through our Discord server.

---
Made with ❤️ by [Solstice]
