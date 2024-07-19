# MyAnimVue

## Tech Stack
- Swift 5; iOS 14
- UIKit
- VIPER
- Keychain

## Installation

1. Clone the project repository:

    ```bash
    git clone git@github.com:oleg-romanov/MyAnimVue.git
    ```

    ```bash
    cd MyAnimVue
    ```

2. Add a `Config.plist` file:
   
- To run script, execute:
    ```bash
    ./create_config.sh
    ```

    After executing the script: 
    - Open the **Xcode project**
    - In the file tree, click **"Add files to "MyAnimVue"..."**
    - Select **"Add files to "MyAnimVue""**.
    - Select **Config.plist** : *"{Project location}/MyAnimVue/MyAnimVue/App/Config.plist"*
    - Make sure that the **"Copy items if needed"** checkbox **is selected**
    - And marked **"Create groups"**


- Or instead of executing a script, create a `Config.plist` file in the project directory in Xcode yourself:
    - Create a file `Config.plist` 
    - Add the `CLIENT_ID` and `CLIENT_SECRET` keys and values for them.
