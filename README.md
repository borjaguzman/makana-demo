# Makana Demo - Sistema de Coins y Giftcards

Solución del desafío técnico de Makana: implementación frontend de un sistema de canje de Makana Coins por giftcards digitales.

---

## 📱 Demo en Vivo

La aplicación está corriendo en: **http://localhost:8080**

---

## 🚀 Instalación y Ejecución

### Requisitos Previos
- Flutter SDK (>=3.0.0)
- Dart SDK
- Navegador web moderno (Chrome/Edge recomendado)

### Pasos para Ejecutar

```bash
# 1. Instalar dependencias
flutter pub get

# 2. Ejecutar en modo desarrollo (web)
flutter run -d web-server --web-port=8080

# 3. Abrir en el navegador
# http://localhost:8080
```

### Para Desktop Linux (Opcional)
```bash
# Instalar dependencias de Linux
./fix_linux_deps.sh

# Ejecutar en desktop
flutter run -d linux
```

---

## 🎯 Funcionalidades Implementadas

### ✅ A) Punto de Entrada
- **Pantalla de Perfil Mock** (`home_entry_mock.dart`)
- Botón destacado "Mis Makana Coins" con diseño visual atractivo
- Navegación directa al dashboard de coins

### ✅ B) Pantalla de Makana Coins
- **Saldo actual** en tarjeta con gradiente visual
- **Botón "Mis Giftcards"** prominente debajo del saldo
- **Catálogo de giftcards** en formato grid
- Explicación clara del sistema

### ✅ C) Catálogo de Giftcards (Mejorado)
Tiendas disponibles:
- **Unimarc**: $5.000 (2.500 coins), $10.000 (5.000 coins)
- **Paris**: $5.000 (2.500 coins), $10.000 (5.000 coins)
- **Falabella**: $20.000 (10.000 coins)
- **Hugo Boss**: $50.000 (25.000 coins)

**Nuevas Funcionalidades:**
- **Buscador**: Encuentra tiendas rápidamente por nombre
- **Filtros**: Chips interactivos para filtrar por tienda específica
- **Empty State**: Mensaje amigable cuando no hay resultados
- Indicador visual de saldo suficiente/insuficiente

### ✅ D) Historial de Transacciones (Nuevo)
- Acceso desde el ícono de reloj en el dashboard
- Lista cronológica de movimientos (ganancias y gastos)
- Indicadores visuales (flecha verde/naranja)
- Detalles de fecha y monto

### ✅ E) Confirmación de Canje
- Pantalla dedicada con resumen claro
- Información: tienda, monto, costo en coins
- Botón de confirmación explícito
- Opción de cancelar
- Dialog de éxito post-canje

### ✅ E) Mis Giftcards
- Listado de todas las giftcards canjeadas
- Información completa: tienda, monto, código, fecha
- Código mock generado (formato: MOCK-XXXXX-STORE)
- **Copiar código** al portapapeles con un clic
- Estado vacío amigable

---

## 💡 Decisiones de Diseño

### UX / Producto

#### 1. **Flujo Simple de 3 Pasos**
Perfil → Seleccionar Giftcard → Confirmar → ✓ Éxito

Pensado para usuarios con baja alfabetización digital:
- Navegación lineal y clara
- Sin pasos innecesarios
- Confirmación explícita antes de acciones irreversibles

#### 2. **Feedback Visual Constante**
- Estados de loading durante operaciones
- Colores para indicar disponibilidad (gris = insuficiente)
- Mensajes de éxito/error amigables
- Animaciones nativas de Material Design

#### 3. **Accesibilidad Mejorada**
- **Botón "Mis Giftcards" grande y visible** (debajo del saldo, no hidden en AppBar)
- Texto con contraste adecuado
- Tamaños de botón apropiados para touch
- Iconos descriptivos

#### 4. **Tolerancia a Errores**
- Validación de saldo antes de navegar a confirmación
- Opción de cancelar en cualquier punto
- Mensajes de error claros en español
- No se pierde estado en caso de error

### Técnicas

#### 1. **Flutter vs React/Vue/Angular**
**Decisión:** Flutter

**Razones:**
- ✅ **Puntos extra** según el desafío
- ✅ Cross-platform: web + mobile + desktop desde el mismo código
- ✅ Performance superior con compilación nativa
- ✅ UI consistente en todas las plataformas
- ✅ Hot reload para desarrollo rápido

#### 2. **Estado: Provider**
**Decisión:** Provider pattern

**Razones:**
- ✅ Solución oficial recomendada por el equipo de Flutter
- ✅ Simple de entender y mantener
- ✅ Reactivo: UI se actualiza automáticamente
- ✅ No requiere generación de código (vs Bloc/Riverpod)
- ✅ Suficiente para el scope del proyecto

#### 3. **Arquitectura**
```
models/         → Definiciones de datos (GiftCardOption, RedeemedGiftCard)
providers/      → Estado global (CoinsProvider)
screens/        → Pantallas completas
widgets/        → Componentes reutilizables
services/       → Lógica de negocio y mock API
theme/          → Configuración visual
```

**Ventajas:**
- Separación clara de responsabilidades
- Fácil de testear
- Escalable para features adicionales

#### 4. **Mock Data Service**
- Simula delay de red (1 segundo)
- Genera códigos únicos de giftcard
- Preparado para ser reemplazado por API real

---

## 📊 Manejo de Estados

### Loading
- Spinner durante carga inicial
- Indicador en botón de confirmación
- No bloquea UI innecesariamente

### Vacío
- Pantalla especial en "Mis Giftcards"
- Ícono + mensaje amigable
- Guía al usuario a canjear su primera card

### Error
- Mensajes en español, claros y accionables
- SnackBar para errores no críticos
- Validación preventiva (ej: saldo insuficiente)

---

## 🧪 Testing (Sugerido para Mejora Futura)

```bash
# Tests unitarios
flutter test

# Tests de widget
flutter test test/widget_test.dart

# Tests de integración
flutter drive --target=test_driver/app.dart
```

### Tests Sugeridos
- [ ] `coins_provider_test.dart`: Estado, canje, validaciones
- [ ] `catalog_item_test.dart`: Renderizado con/sin saldo
- [ ] `confirmation_screen_test.dart`: Flujo de confirmación
- [ ] `integration_test.dart`: Flujo completo end-to-end

---

## 📦 Dependencias

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.1         # Estado
  intl: ^0.18.1            # Formato de moneda y fechas

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^2.0.0
```

---

## 🎨 Guía de Estilo

- **Colores**: Azul primario (#1E60F4), gradientes suaves
- **Tipografía**: Roboto (default de Material)
- **Espaciado**: Múltiplos de 8 (8, 16, 24, 32)
- **Bordes**: Redondeados (12-20px)
- **Sombras**: Sutiles para dar profundidad

---

## 🚀 Mejoras Futuras

### Funcionalidad
- [ ] **Filtros**: Por tienda, rango de precio
- [x] **Búsqueda**: De giftcards en el catálogo
- [x] **Historial**: De transacciones con detalles ---- cabiar nombre de las transacciones
- [ ] **Notificaciones**: Push al recibir coins
- [ ] **Compartir**: Giftcard por WhatsApp/Email
- [ ] **QR Code**: Generación de QR para códigos

### UX
- [0.5 ] **Animaciones**: Transiciones entre pantallas
- [ ] **Tutorial**: Onboarding para nuevos usuarios
- [ ] **Modo oscuro**: Tema dark mode
- [ ] **Accesibilidad**: Screen reader support completo
- [ ] **Offline**: Cache local de giftcards

### Técnico
- [ ] **API real**: Integración con backend
- [ ] **Autenticación**: Login/logout
- [ ] **Tests**: Cobertura >80%
- [ ] **CI/CD**: GitHub Actions
- [ ] **Analytics**: Firebase Analytics
- [ ] **Crash reporting**: Sentry/Firebase Crashlytics

---

## 🎥 Video Demo

> **Pendiente**: Video de 1-3 minutos mostrando el flujo completo.

### Contenido sugerido:
1. Entrada desde pantalla de perfil
2. Visualización del saldo
3. Navegación a "Mis Giftcards" (vacío)
4. Selección de giftcard con saldo suficiente
5. Confirmación
6. Éxito y visualización del código
7. Copia del código al portapapeles
8. Intento de canje con saldo insuficiente

---

## 📝 Entregables

- ✅ Repositorio implementado
- ✅ README completo
- ✅ Código funcional
- ✅ Decisiones documentadas
- ⚠️ Video demo (pendiente)
- ⚠️ Tests (opcional, pendiente)

---

## 📞 Próximos Pasos

### 1. Revisar el Proyecto
Navega a http://localhost:8080 y prueba el flujo completo.

### 2. Agendar Revisión
Cuando estés listo, ejecuta:

```bash
curl -X POST https://api.makana.cl/candidates \
-H "Content-Type: application/json" \
-d '{}'
```

### 3. Compartir Repositorio
Si es privado, dar acceso a: **cjjouanne**

---

## 👨‍💻 Desarrollo

- **Framework**: Flutter 3.x
- **Lenguaje**: Dart
- **Patrón**: Provider + Clean Architecture
- **Plataforma**: Web (responsive, mobile-first)

---
