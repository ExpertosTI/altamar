# SPEC.md — Pescadería Altamar Landing Page

## 1. Concept & Vision

Una landing page que captura la **esencia del mar**: frescura, autenticidad y la tradición de una pescadería de confianza. El diseño evoca mercados costeros mediterráneos — azules profundos del océano, blancos de la espuma, y acentos corals que invocan langostas y salmonetes. La experiencia debe sentirse como entrar a una pescadería premium donde cada producto respira frescura.

**Diferenciación**: En lugar del típico e-commerce genérico, esta landing transmite _artesanía marina_ — como si un pescador experto hubiera diseñado el espacio.

## 2. Design Language

### Aesthetic Direction
**"Mediterranean Fishmarket Premium"** — Una fusión entre la autenticidad de un mercado de pescado tradicional y la sofisticación de una marca premium. Texturas sutiles de sal marina, ondas acuáticas, y tipografía que combina tradición con modernidad.

### Color Palette
```css
--color-ocean-deep: #0a2540;      /* Azul profundo — fondo principal */
--color-ocean-mid: #1a4a6e;       /* Azul medio — secciones alternas */
--color-sea-foam: #f8fafc;        /* Blanco espuma — texto principal */
--color-coral-accent: #ff6b4a;   /* Coral vivo — CTAs, ofertas */
--color-gold-fresh: #f59e0b;      /* Dorado — badges premium */
--color-silver-fish: #94a3b8;    /* Gris plata — texto secundario */
--color-aqua: #06b6d4;           /* Aqua — acentos, hover states */
```

### Typography
- **Display**: `Playfair Display` (700) — headlines con personalidad clásica
- **Body**: `Source Sans 3` (400, 600) — legibilidad moderna
- **Accent**: `DM Sans` (500) — badges y labels

### Spatial System
- Base unit: 8px
- Section padding: 80px vertical (desktop), 48px (mobile)
- Container max-width: 1200px
- Grid: 12 columns con gaps de 24px

### Motion Philosophy
- **Page load**: Fade-in suave con stagger de 150ms entre secciones
- **Scroll reveals**: Elementos aparecen con translate-y de 30px + opacity
- **Hover states**: Scale sutil (1.02) + shadow elevation
- **Transitions**: 300ms ease-out-quart para interacciones

### Visual Assets
- **Icons**: Lucide Icons (outline style, stroke-width: 1.5)
- **Images**: Fotografías de alta calidad de pescado fresco (Unsplash: seafood, fish market)
- **Decorative**: Ondas SVG sutiles, patrones de escamas de pez, texturas de sal

## 3. Layout & Structure

### Page Flow (Top → Bottom)
1. **Hero Section** — Impacto visual inmediato con mensaje principal
2. **Productos Destacados** — Grid de productos frescos del día
3. **Ofertas Especiales** — Banner con promociones temporales
4. **Síguenos en Instagram** — Preview grid + enlace a IG
5. **Login Access** — Puerta de entrada clara al ERP (destacado pero secundario)

### Responsive Strategy
- Desktop: Full grid, todos los efectos
- Tablet: 2-column grid, efectos reducidos
- Mobile: Stack vertical, touch-optimized, 44px touch targets

## 4. Features & Interactions

### Hero Section
- Headline con animación de texto reveal
- Subtext con propuesta de valor clara
- CTA "Ver Productos" con hover glow effect
- Background: Gradient sutil + pattern de ondas animadas

### Productos Destacados
- Grid 4 columnas (desktop) → 2 (tablet) → 1 (mobile)
- Cards con:
  - Imagen del producto (aspect-ratio 4:3)
  - Nombre del producto
  - Precio por kg/unidad
  - Badge "Fresco" / "Oferta" / "Nuevo"
  - Hover: elevación + overlay con "Ver más"
- Datos obtenidos del ERP Odoo via API JSON-RPC

### Ofertas Especiales
- Banner full-width con countdown timer (si hay ofertas activas)
- Diseño打破了 el layout — rojo coral vibrante para urgencia
- CTA hacia sección de productos

### Instagram Preview
- Grid 3x3 de últimas fotos de IG
- Botón "Síguenos en @altamar_pescaderia"
- Embed de video reel destacado (opcional)

### Login Section
- Card centrada con logo Altamar
- Campo usuario + contraseña
- Botón "Entrar" ( enlaza a `/odoo` o IP:7015 )
- "¿Olvidaste tu contraseña?" link
- Texto: "Acceso para empleados y distribuidores"

## 5. Component Inventory

### NavBar (minimal)
- Logo izquierda
- Links: Inicio | Productos | Ofertas | Contacto
- Botón Login derecha
- Sticky on scroll con blur backdrop
- Mobile: Hamburger menu

### ProductCard
- States: default, hover, loading, out-of-stock
- Hover: translateY(-4px), shadow-xl, overlay reveal
- Loading: Skeleton con shimmer animation

### OfferBanner
- Gradient background coral → orange
- Countdown timer integrado
- CTA button white outline

### InstagramGrid
- 3x3 imágenes con aspect-ratio 1:1
- Hover: scale 1.05 + border highlight
- Fallback: placeholder si no hay conexión a IG

### LoginCard
- Centered, max-width 400px
- Inputs con focus ring aqua
- Button primary coral con loading state
- Error state: shake animation + red border

### Footer
- 3 columnas: About, Links, Contacto
- Social icons row
- Copyright + "Hecho con 🐟 en República Dominicana"

## 6. Technical Approach

### Stack
- **HTML5** semántico
- **CSS3** con custom properties, grid, flexbox
- **Vanilla JavaScript** para interactividad
- **No frameworks** — velocidad máxima, cero dependencias

### Data Source
- **Odoo ERP**: JSON-RPC API para obtener productos publicados
- **Endpoint**: `https://pescaderiaaltamar.com/api/products` (nuevo endpoint a crear)
- **Fallback**: Productos hardcodeados si API no disponible

### Instagram Integration
- Embed oficial de Instagram para posts/videos
- Fallback a imagen estática con mensaje "Síguenos"

### Performance
- Critical CSS inline
- Lazy loading para imágenes
- Preconnect a Google Fonts y CDN externos
- Target: < 2s First Contentful Paint en 3G

### SEO
- Meta tags completos (title, description, OG, Twitter)
- Schema.org markup para LocalBusiness
- Semantic HTML con landmarks adecuados
