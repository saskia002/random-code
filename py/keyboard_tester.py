# pip install pynput
from pynput import keyboard

def on_press(key):
    try:
        print(f"Key pressed: {key}")

        if key == keyboard.Key.esc:
            print("Escape pressed, exiting...")
            return False
    except AttributeError:
        print(f"Special key pressed: {key}")



with keyboard.Listener(on_press=on_press) as listener:
    try:
        print("Listening for key presses... (Press ESC to stop)")
        listener.join()
    except KeyboardInterrupt:
        ...
    except Exception as e:
        print(f"An error occurred: {e}")
