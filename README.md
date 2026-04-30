# 📚 Book Store App (Flutter)

A modern Book Store mobile application built using Flutter.
The app allows users to browse books, view details, and manage a collection of books with a clean and scalable UI.

---

## ✨ Features

* 📖 Browse books list
* 🔍 View book details
* ➕ Add new books
* ✏️ Edit existing books
* ❌ Delete books
* 🎨 Clean and responsive UI
* 🔄 Real-time updates (if connected to API/Firebase)
* 📱 Mobile-friendly design

---

## 🧠 Tech Stack

* Flutter (Dart)
* REST API / Firebase (based on implementation)
* HTTP / Dio
* Material UI

---

## 📁 Project Structure

```
lib/
├── core/
│   ├── networking/
│   ├── constants/
│   └── utils/
│
├── features/
│   ├── home/
│   ├── book_details/
│   ├── add_book/
│   └── edit_book/
│
├── models/
├── services/
└── main.dart
```

---

## 🚀 Getting Started

### 1. Clone the repo

```
git clone https://github.com/mohamdy9520-eng/book_store.git
cd book_store
```

### 2. Install dependencies

```
flutter pub get
```

### 3. Run the app

```
flutter run
```

---

## ⚙️ Configuration

If your project uses API:

* Update base URL in:

```
lib/core/networking/api_constants.dart
```

If using Firebase:

* Add:

  * `google-services.json`
  * `firebase_options.dart`

---

## ⚠️ Known Issues

* No offline caching
* Limited error handling
* Heavy reliance on UI logic inside widgets
* No proper state management (yet)
* API/Firebase calls directly inside UI

---

## 🚀 Future Improvements

* Add Bloc/Cubit for state management
* Implement Clean Architecture
* Add caching (Hive / SharedPreferences)
* Improve performance
* Add search & filtering
* Add authentication system
* Add cart / checkout (for full e-commerce)

---

## 🧠 Architecture Notes

Current architecture:

```
UI → Service → API/Firebase
```

Target architecture:

```
UI → State Management → Domain → Repository → Data Source
```

---

## 👨‍💻 Author

**Mohamed Hamdy**

* GitHub: https://github.com/mohamdy9520-eng

---

## ⭐ Support

If you like this project, give it a ⭐ on GitHub!


![readme_images](assets/readme_images/1.png)
![readme_images](assets/readme_images/2++.png)
![readme_images](assets/readme_images/3.png)
![readme_images](assets/readme_images/4.png)
![readme_images](assets/readme_images/5.png)
![readme_images](assets/readme_images/6.png)
![readme_images](assets/readme_images/7++.png)
![readme_images](assets/readme_images/8.png)
![readme_images](assets/readme_images/9.png)
![readme_images](assets/readme_images/11.png)
<img width="297" height="620" alt="99" src="https://github.com/user-attachments/assets/e8eecb5e-1dda-44ba-9a17-d85272d61d5f" />
<img width="303" height="602" alt="88" src="https://github.com/user-attachments/assets/c2651be3-fd29-4945-9517-b30f8bf69f12" />
<img width="365" height="740" alt="77" src="https://github.com/user-attachments/assets/ee2a60b8-d0eb-4c93-b3e2-12d4ef33625e" />
<img width="401" height="806" alt="66" src="https://github.com/user-attachments/assets/bf4b508d-6d22-410c-acf4-8f42f889b191" />
<img width="357" height="763" alt="55" src="https://github.com/user-attachments/assets/b1ade167-3911-4dd8-9843-ea01d5b51c78" />
<img width="437" height="807" alt="44" src="https://github.com/user-attachments/assets/c8bb72ca-efce-4af9-896d-970c3c8e5e86" />
<img width="322" height="597" alt="33" src="https://github.com/user-attachments/assets/da96422d-7f77-41f3-b204-fcbeb0905fbf" />
<img width="291" height="593" alt="22" src="https://github.com/user-attachments/assets/682859c3-7252-462a-aac8-64fc811e38a7" />
<img width="292" height="601" alt="11" src="https://github.com/user-attachments/assets/bdc3115c-9ff4-4bd3-b6dc-4db214680f35" />
<img width="455" height="815" alt="1" src="https://github.com/user-attachments/assets/fabfee1f-44c7-4db3-a6f1-bff56a2685b3" />
<img width="407" height="818" alt="1313" src="https://github.com/user-attachments/assets/0fb07de3-f7b5-4921-be3a-ba1be04b1cff" />
<img width="381" height="757" alt="1212" src="https://github.com/user-attachments/assets/897e60d6-2b16-4ab0-98b1-0045a5eb16cf" />
<img width="390" height="802" alt="1111" src="https://github.com/user-attachments/assets/d92d03c9-fe8b-4f03-959f-d9bceb5a12ae" />
<img width="351" height="745" alt="1010" src="https://github.com/user-attachments/assets/abedd2f2-a157-407d-b2c0-7ff89e8a91a2" />

