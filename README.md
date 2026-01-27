# Makana Demo - Sistema de Coins y Giftcards

Solución del desafío técnico de Makana: implementación frontend de un sistema de canje de Makana Coins por giftcards digitales.

---

## � Instrucciones para Correr el Proyecto

### Requisitos
- Flutter SDK (>=3.0.0)
- Navegador Chrome/Edge (recomendado para desarrollo web)

### Pasos
1. **Instalar dependencias:**
   ```bash
   flutter pub get
   ```

2. **Generar código (Importante):**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

3. **Ejecutar en web:**
   ```bash
   flutter run -d web-server --web-port=8080
   ```
   Luego abre [http://localhost:8080](http://localhost:8080) en tu navegador.

---

## 💡 Decisiones de UX y Técnicas

A continuación se responden las preguntas clave sobre el diseño e implementación:

### 1. ¿Dónde ubicaste el acceso al canje y por qué?
**Ubicación:** Un botón/tarjeta destacado ("Mis Makana Coins") directamente en el feed principal del perfil (`HomeEntryMock`).
**Por qué:** Para maximizar la **descubribilidad**. Al ser la función principal del desafío, debe ser inmediatamente visible sin bucear en menús. El uso de un gradiente y sombra lo diferencia jerárquicamente del resto del contenido informativo.

### 2. ¿Cómo redujiste fricción para usuarios con baja alfabetización digital?
- **Navegación Lineal:** Flujo simple de 3 pasos: *Inicio → Selección → Confirmación*.
- **Lenguaje Claro:** Etiquetas explícitas como "Canjea aquí" en lugar de iconos abstractos sin texto.
- **Feedback Visual:** Uso de colores semánticos (gris para deshabilitado, verde para éxito) y `Chips` grandes para filtros fáciles de tocar.
- **Búsqueda Simple:** Un buscador y filtros predefinidos (chips) que no requieren escritura compleja.

### 3. ¿Cómo evitarías canjes erróneos?
- **Flujo de Confirmación:** Se implementó una `ConfirmationScreen` dedicada que actúa como "cortafuegos" antes de la transacción final.
- **Resumen Claro:** La pantalla de confirmación muestra explícitamente qué se compra y cuánto costará, requiriendo una segunda acción del usuario.
- **Coste Visual:** Las opciones inalcanzables se muestran visualmente deshabilitadas/diferentes para evitar clicks frustrantes desde el inicio.

### 4. ¿Cómo escalarías esto si hay 50 tiendas y miles de usuarios?
Esta solución mock está diseñada para migrar a una arquitectura robusta:

1.  **Backend & Paginación (API):** Reemplazar la carga total por *paginación server-side* (infinite scroll) en el catálogo. No cargar 50 tiendas de golpe, sino bajo demanda.
2.  **Búsqueda en Servidor:** Mover la lógica de filtrado del cliente al backend (ElasticSearch o consultas SQL optimizadas) para búsquedas instantáneas entre miles de items.
3.  **Caching:** Implementar caché de imágenes y respuestas HTTP para reducir la carga de datos en dispositivos de usuarios frecuentes.



