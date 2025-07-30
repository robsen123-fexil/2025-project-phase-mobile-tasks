# Ecommerce Flutter App

This app follows **Clean Architecture** to keep code organized, testable, and scalable.

---

## Task 10: Data Overview Layer

### ✅ Folder Structure

Organized under `lib/`:

lib/
├── core/ # Shared logic (e.g. error handling)
├── features/
│ └── product/ # Product feature module
│ └── data/
│ └── models/
│ └── product_model.dart
test/ # Unit and widget tests

### ✅ Product Model

- Created `ProductModel` with `fromJson` and `toJson`.
- Mirrors `Product` entity structure.
- Added unit tests to verify conversion and behavior.

### ✅ Documentation

- This README explains the structure and purpose of the data layer.
- Highlights how Clean Architecture is applied.

---

## 🧪 Testing

Run:

```bash
flutter test
