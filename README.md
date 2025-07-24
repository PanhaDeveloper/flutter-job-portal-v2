## Animating Page Route Transitions in GetX

GetX makes it simple to animate page transitions using `Get.to()` or `Get.off()`. Just specify the transition type you want.

### 🚀 Basic Usage

```dart
Get.to(MyNextPage(), transition: Transition.rightToLeft);
```
*Slides the new page in from right to left.*

---

### 🎨 Available Transitions

| Transition                | Animation Description                |
|---------------------------|--------------------------------------|
| `Transition.fade`         | Fade in                              |
| `Transition.rightToLeft`  | Slide in from right                  |
| `Transition.leftToRight`  | Slide in from left                   |
| `Transition.upToDown`     | Slide in from top                    |
| `Transition.downToUp`     | Slide in from bottom                 |
| `Transition.zoom`         | Zoom in                              |
| `Transition.topLevel`     | Instant switch (no animation)        |
| `Transition.circularReveal`| Circular reveal animation           |
| `Transition.size`         | Expands from center                  |
| `Transition.native`       | Platform default transition          |

---

### ⏱️ Custom Duration Example

```dart
Get.to(
    MyNextPage(),
    transition: Transition.fade,
    duration: Duration(milliseconds: 500),
);
```

---

### 🔄 Replace Current Page with Animation

```dart
Get.off(
    MyNextPage(),
    transition: Transition.leftToRightWithFade,
);
```

---

### 💡 Tip: Set Default Transitions App-wide

You can set default transitions for your entire app in `GetMaterialApp`:

```dart
GetMaterialApp(
    defaultTransition: Transition.rightToLeft,
    transitionDuration: Duration(milliseconds: 300),
    // other options
);
```

---
