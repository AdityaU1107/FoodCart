# 🍔 FoodCart

## Overview
This is a simple single-page food cart application built using **UIKit** and follows the **MVC (Model-View-Controller)** architecture.

## Features
- ✅ User can add and remove food items from the cart.
- 🧮 Dynamically updates the **total price** as items are added or removed.
- 🍽️ Three sections in the main view:
  - **Previous Orders:** Displays items ordered previously.
  - **Recommended Items:** Shows curated item suggestions.
  - **Full Menu List:** Scrollable list of all available items.
- 📍 Fetch and update **live user location** on screen.

## Requirements
- **Xcode 12+** (or the latest available version)
- **Swift 5+**
- **iOS 15.6+**

# 📁 Project Structure
📦 FoodCart ├── 📂 Models │ ├── cartitems.swift │ ├── Data.swift │ └── fnb_items.swift │ ├── 📂 Storyboard │ └── Main.storyboard │ ├── 📂 Viewcontroller │ ├── confirmLocationVC.swift │ └── OutletVC.swift │ ├── 📂 Views │ ├── couponCodeCVC.swift │ ├── filterCVC.swift │ ├── fnbItemsTVC.swift │ └── foodItemCVC.swift │ ├── AppDelegate.swift ├── SceneDelegate.swift ├── Assets.xcassets ├── LaunchScreen.storyboard └── Info.plist

## 🚀 Installation & Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/AdityaU1107/FoodCart.git

⚙️ How It Works
1) App loads a single view with multiple sections displaying food categories.
2) Each item can be added or removed via a plus/minus stepper.
3) The total price updates in real-time as cart contents change.
4) Users can also fetch and update their live location using the location confirmation screen.

🧰 Technologies Used
UIKit – for building the user interface.
CoreLocation – for fetching user’s live location.
Auto Layout – for responsive UI across all iOS devices.
MVC Architecture – clean separation of concerns.
Git – for version control and code collaboration.

👨‍💻 Author
Aditya Upadhyay
📧 Email: adityaupadhyay919@gmail.com
🌐 GitHub: AdityaU1107

Feel free to fork, star, and contribute to improve the project! 🍕🍟🍔

![image](https://github.com/user-attachments/assets/a3c5b103-a319-4538-a57e-a60d5bf3a1fb)



