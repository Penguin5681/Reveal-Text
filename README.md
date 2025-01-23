
# 🎯 RevealText
![Pub Version](https://img.shields.io/pub/v/reveal_text?color=rgb(8%2C%20153%2C%20255))


[![anim.gif](https://i.postimg.cc/B6VFm6dy/anim.gif)](https://postimg.cc/62CT396L)

A lightweight Flutter package for elegant text reveal animations. Perfect for landing screens, loading states, and attention-grabbing UI elements.

## ✨ Features

- 🎭 Reveal by words or individual characters
- 🌓 Smooth fade & translate animations
- ⚙️ Customizable timing, spacing & effects
- 🎚️ Optional letter spacing parameter
- 🎯 Viewport-aware activation

## 📦 Installation

Add to `pubspec.yaml`:

```yaml
dependencies:
  reveal_text: ^latest
  visibility_detector: ^0.3.4
```

## 🚀 Basic Usage

```dart
RevealText(
  text: 'Welcome to Flutter Magic!',
  animateBy: AnimationType.words,
  delay: Duration(milliseconds: 150),
)
```

## 🛠 Parameters

| Parameter        | Description                    | Default               |
|------------------|--------------------------------|-----------------------|
| `text`           | Text content                   | Required              |
| `animateBy`      | Animation unit (words/letters) | `AnimationType.words` |
| `delay`          | Delay between elements         | `100ms`               |
| `curve`          | Animation timing curve         | `Curves.easeOutQuart` |
| `verticalOffset` | Starting Y position offset     | `8.0`                 |
| `opacityStart`   | Initial opacity (0-1)          | `0.0`                 |
| `letterSpacing`  | Custom spacing between letters | `null`                |
| `textAlign`      | Text alignment                 | `TextAlign.start`     |

## 🔥 Advanced Example

```dart
RevealText(
  text: 'Loading...',
  animateBy: AnimationType.letters,
  delay: Duration(milliseconds: 50),
  verticalOffset: 12.0,
  curve: Curves.easeInOutBack,
  letterSpacing: 2.0,
  textStyle: TextStyle(
    fontSize: 32,
    color: Colors.deepPurple,
    fontWeight: FontWeight.bold
  ),
)
```

## 🤝 Contributing

PRs welcome! Please ensure:
- Clear documentation
- Passing tests
- Consistent styling
