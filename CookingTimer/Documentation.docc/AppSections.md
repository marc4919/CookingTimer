# App Sections

Main sections of the app

@Metadata {
    @PageImage(purpose: card,
               source: "sections",
               alt: "sections overview")
    
    @PageImage(purpose: icon,
                source: "sections",
                alt: "app logo")
}

## Sections
@Row {
   @Column {
      @Image(source: "contentView", alt: "ContentView - With time picker, start button and settings access in the corner (also an animated emoji).") {
          ContentView - The main view of the app
      }
   }


   @Column {
       ### ContentView
       This is the main view of the App. Here you can start the timer, see the remaining time, and access the settings. When the user changes the time using the picker (to a value greater than 0 seconds), the start button becomes active. The timer starts when the user presses the button, and the user can see the remaining time in minutes and seconds. While the timer is running, the emoji moves. When the time finishes, a sound is played and the timer returns to its initial state. The user can stop the timer at any time and restart it.
    }
}

@Row {
   @Column {
      @Image(source: "settingsView", alt: "SettingsView - With main theme picker, sound enable/disable, emoji picker and reset button.") {
          SettingsView - The settings view of the app
      }
   }


   @Column {
       ### SettingsView
       This view allows the user to customize the application. The user can choose the application theme (background color), enable or disable sound, and select an emoji that will be displayed in the main view. There is also a button to reset the settings to default values. All settings are saved in UserDefaults / AppStorage so they persist even after closing the application. The user can return to the main view from here.
    }
}
           
