# 🎮 Zero Latency - Gaming Store Cart App

**UTS Pemrograman Mobile 2** - Flutter Shopping Cart Application dengan tema Gaming Store futuristik

## 🎯 Tentang Aplikasi

Zero Latency adalah aplikasi kasir toko gaming futuristik yang dibangun menggunakan Flutter dengan state management BLoC/Cubit. Aplikasi ini menawarkan pengalaman belanja gaming yang modern dengan interface yang sleek dan responsif.

### 🛒 Produk Gaming yang Tersedia:
- **Gaming Hardware**: Laptop ROG, Processor Intel i9, VGA RTX 4080 SUPER
- **Components**: RAM DDR5, Motherboard Z790, SSD NVMe
- **Peripherals**: Gaming keyboard, mouse, headset premium
- **Accessories**: RGB lighting, cooling systems, gaming chairs
- **Dan koleksi gaming gear terlengkap lainnya**

## ✨ Fitur Utama

### 🎮 Gaming Experience
- **Futuristic Theme**: Interface dengan nuansa gaming cyberpunk dan neon
- **Premium Catalog**: Koleksi produk gaming terbaik dan terbaru
- **Zero Latency Performance**: Optimasi performa untuk pengalaman smooth
- **RGB Color Palette**: Skema warna gaming yang eye-catching

### 📱 Mobile Optimization
- **Responsive Layout**: Tampilan dioptimalkan untuk semua ukuran layar
- **Grid Layout**: Grid 2 kolom khusus mobile dengan aspect ratio perfect
- **Touch Gestures**: Kontrol yang intuitive dengan gesture support
- **Bottom Navigation**: Info keranjang yang persistent dan accessible

### 🛒 Shopping Cart Features
- **Real-time Updates**: Total harga dan quantity update instant
- **Smart Controls**: Tombol +/- dengan haptic feedback
- **Bulk Operations**: Operasi massal untuk manage keranjang
- **Payment Flow**: Proses checkout yang streamlined

## 📋 Implementasi Soal UTS

### 🎯 Bagian A - State Management (30 Poin)

#### 1. Pemahaman Cubit vs Bloc Pattern
- **Cubit Implementation**: Dipilih untuk kesederhanaan state management
- **Event-driven Architecture**: Function-based state updates untuk cart operations
- **Performance**: Optimized untuk real-time cart calculations
- **Scalability**: Mudah diperluas untuk fitur shopping yang lebih kompleks

#### 2. Clean Architecture Implementation
```
📁 Architecture Layers:
├── 🎨 Presentation Layer (UI/Widgets)
├── 💼 Business Logic Layer (Cubit)
├── 📊 Data Layer (Models)
└── 🏗️ Core (Constants, Themes)
```

#### 3. CartCubit State Management
- ✅ **addToCart()**: Menambah produk gaming ke keranjang
- ✅ **removeFromCart()**: Remove item dengan konfirmasi
- ✅ **updateQuantity()**: Update jumlah dengan validasi
- ✅ **getTotalItems()**: Real-time count badge
- ✅ **getTotalPrice()**: Auto-calculate dengan format currency

### 🚀 Bagian B - Core Implementation (70 Poin)

#### Struktur Project Zero Latency
```
lib/
├── 🚀 main.dart                      # App entry dengan gaming theme
├── 💼 blocs/
│   └── cart_cubit.dart               # State management untuk cart
├── 📊 models/  
│   └── product_model.dart            # Gaming product data structure
├── 🎮 pages/
│   ├── cart_home_page.dart           # Gaming catalog showcase
│   ├── cart_summary_page.dart        # Checkout & payment flow  
│   └── cart_grid_page.dart           # Filter & bulk operations
├── 🎨 widgets/
│   └── product_card.dart             # Gaming product card component
└── 🎯 themes/
    └── gaming_theme.dart             # Futuristic color schemes
```

#### 📱 Feature Implementation Details

**1. ProductModel - Gaming Edition (20 Poin)**
```dart
class ProductModel {
  final String id;           // Unique gaming product identifier
  final String name;         // Gaming product name
  final int price;          // Price in IDR
  final String image;       // High-res product images
  
  // Conversion methods untuk data persistence
  Map<String, dynamic> toMap();
  factory ProductModel.fromMap();
}
```

**2. CartCubit - Zero Latency Performance (20 Poin)**
```dart
class CartCubit extends Cubit<CartState> {
  // Core cart operations
  void addToCart(ProductModel product);      // Add gaming gear
  void removeFromCart(String productId);    // Remove with confirmation
  void updateQuantity(product, quantity);   // Batch quantity updates
  void clearCart();                         // Reset untuk next customer
  
  // Real-time calculations  
  int getTotalItems();                      // Live item count
  int getTotalPrice();                      // Auto price calculation
  
  // Advanced operations
  List getCartItems();                      // Get all cart data
  bool isInCart(product);                   // Check availability
  int getProductQuantity(product);          // Get specific quantity
}
```

**3. ProductCard - Gaming UI Component (15 Poin)**
- 🎮 **Gaming Aesthetics**: Neon borders, gradient backgrounds
- 📱 **Mobile-First**: Optimized touch targets dan spacing
- 🔄 **Real-time Updates**: Instant quantity changes
- 💫 **Smooth Animations**: Micro-interactions untuk better UX
- 🎯 **Accessibility**: Semantic labels dan contrast ratios

**4. Cart Summary - Checkout Experience (15 Poin)**
- 🛒 **Complete Cart View**: Detailed item breakdown
- 💰 **Price Calculations**: Tax, discounts, totals
- 📱 **Mobile Payment Flow**: Streamlined checkout process  
- 🔔 **Notifications**: Success feedback dengan sound effects
- 📊 **Order Summary**: Professional receipt format

### 🎖️ Bagian C - Bonus Features (10 Poin)

#### Advanced Gaming Store Features

**1. 🎯 Smart Filter System**
- **Filter by Status**: 
  - 🛒 "Ada di Keranjang" - Items already added
  - 📦 "Tidak di Keranjang" - Available to add  
  - 🌟 "Semua Produk" - Complete catalog view
- **Real-time Counters**: Dynamic count untuk setiap filter
- **Empty State Handling**: Informative messages untuk setiap kondisi

**2. ⚡ Bulk Operations (Zero Latency Style)**
- **×2 Gandakan Semua**: Double quantity untuk power gamers
- **+1 Tambah Semua**: Quick add semua produk ke keranjang  
- **↺ Reset Keranjang**: Clear cart dengan confirmation dialog
- **Smart Feedback**: Toast notifications dengan gaming sound effects

**3. 🎮 Enhanced UX Features**
- **Haptic Feedback**: Vibration untuk setiap action
- **Loading States**: Skeleton loading untuk smooth experience
- **Error Handling**: Graceful error states dengan retry options
- **Accessibility**: Screen reader support untuk inclusive gaming

## 🛠 Tech Stack & Dependencies

### Core Technologies
```yaml
dependencies:
  flutter: sdk
  flutter_bloc: ^8.1.3      # State management
  
dev_dependencies:
  flutter_test: sdk
  flutter_lints: ^5.0.0     # Code quality
```

### Gaming Design System
- **Color Palette**: Cyberpunk inspired (Neon cyan, Electric purple, Matrix green)
- **Typography**: Futuristic fonts dengan pixel-perfect spacing  
- **Iconography**: Gaming-themed icons pack
- **Animations**: 120fps smooth transitions

## Screenshots

Aplikasi ini memiliki 3 halaman utama:
1. **Home Page**: Menampilkan grid produk yang tersedia
2. **Cart Summary**: Menampilkan detail keranjang belanja
3. **Cart Grid**: Tampilan grid keranjang dengan fitur filter

## Penjelasan Implementasi

### State Management
Menggunakan `CartCubit` yang mengelola state keranjang dengan fungsi-fungsi:
- State disimpan dalam Map dengan key product ID
- Setiap perubahan state menggunakan `emit()` untuk memperbarui UI
- BlocBuilder digunakan untuk mendengarkan perubahan state

### Real-time Updates
Setiap perubahan jumlah item atau penambahan/pengurangan produk akan langsung memperbarui:
- Total item di badge keranjang
- Total harga di bottom bar
- Tampilan quantity di product card

### Modular Architecture
- Model terpisah untuk data structure
- Cubit terpisah untuk business logic  
- Widget terpisah untuk UI components
- Pages terpisah untuk different screens
