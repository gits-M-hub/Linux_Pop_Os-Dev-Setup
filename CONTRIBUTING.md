# 🤝 Contribuyendo a Linux Dev Setup

¡Gracias por tu interés en contribuir a este proyecto! Este documento te guiará sobre cómo contribuir de manera efectiva.

## 📋 Tabla de Contenidos

- [Código de Conducta](#código-de-conducta)
- [¿Cómo puedo contribuir?](#cómo-puedo-contribuir)
- [Proceso de Desarrollo](#proceso-de-desarrollo)
- [Estándares de Código](#estándares-de-código)
- [Proceso de Pull Request](#proceso-de-pull-request)
- [Reportando Issues](#reportando-issues)

---

## 🎯 Código de Conducta

Por favor, sé respetuoso y constructivo en todas las interacciones. Consulta el archivo [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) para más detalles.

---

## 🚀 ¿Cómo puedo contribuir?

### Reportar Bugs
- Busca issues existentes antes de crear uno nuevo
- Usa la plantilla de issue para bugs
- Incluye información del sistema y pasos para reproducir

### Sugerir Mejoras
- Usa la plantilla de feature request
- Explica claramente el problema que resuelve
- Considera si ya existe una solución similar

### Contribuir Código
- Haz fork del repositorio
- Crea una rama para tu feature
- Sigue los estándares de código
- Haz un pull request con descripción clara

### Mejorar Documentación
- Corrige errores gramaticales o de ortografía
- Mejora la claridad de explicaciones
- Añade ejemplos prácticos
- Traduce a otros idiomas

---

## 🔄 Proceso de Desarrollo

### 1. Fork y Clonar
```bash
# Fork el repositorio en GitHub
# Clona tu fork
git clone https://github.com/TU_USUARIO/Linux_Pop_Os-Dev-Setup.git
cd Linux_Pop_Os-Dev-Setup
```

### 2. Crear Rama
```bash
# Crea una rama para tu cambio
git checkout -b feature/tu-feature
# o
git checkout -b fix/tu-fix
```

### 3. Hacer Cambios
- Sigue los estándares de código
- Añade pruebas si es necesario
- Actualiza la documentación relevante
- Haz commits con mensajes claros

### 4. Testear
```bash
# Ejecuta scripts de validación
./scripts/doctor.sh
./scripts/update-system.sh
```

### 5. Push y Pull Request
```bash
git push origin feature/tu-feature
# Crea PR en GitHub usando la plantilla
```

---

## 📝 Estándares de Código

### Scripts de Shell

**Indentación:**
- Usa 4 espacios para indentación
- No uses tabs

**Comentarios:**
```bash
# Comentario de una línea
# Explica el propósito del comando

# Función: descripción breve
funcion() {
    # Comentario inline
    comando
}
```

**Nombres de funciones:**
```bash
# Usa snake_case
instalar_herramientas() {
    # código
}
```

**Variables:**
```bash
# Usa mayúsculas para constantes
MAX_RETRIES=5

# Usa minúsculas para variables locales
contador=0
```

### Markdown

**Encabezados:**
```markdown
# Título principal
## Subtítulo
### Sub-subtítulo
```

**Código:**
```markdown
# Código inline
Usa `comando` para ejecutar

# Bloques de código
```bash
comando
```
```

**Enlaces:**
```markdown
# Enlaces relativos
[Texto](../archivo.md)

# Enlaces absolutos
[Texto](https://ejemplo.com)
```

### Configuraciones

**Archivos de configuración:**
- Usa rutas relativas cuando sea posible
- Añade comentarios explicando cada sección
- Mantén consistencia en formato

---

## 📤 Proceso de Pull Request

### Antes de Crear el PR

1. **Sincroniza con upstream:**
```bash
git remote add upstream https://github.com/gits-M-hub/Linux_Pop_Os-Dev-Setup.git
git fetch upstream
git rebase upstream/main
```

2. **Resuelve conflictos si existen**

3. **Testea tus cambios:**
- Ejecuta los scripts que modificaste
- Verifica que la documentación sea correcta
- Asegúrate de no romper funcionalidades existentes

### Creando el PR

1. Usa la plantilla de Pull Request
2. Describe claramente:
   - Qué problema resuelve
   - Cómo lo resuelve
   - Cambios específicos realizados
   - Tests realizados
3. Añade capturas de pantalla si es relevante
4. Menciona issues relacionados

### Después del PR

- Responde a feedback de maintainers
- Realiza cambios solicitados
- Mantén el PR actualizado

---

## 🐛 Reportando Issues

### Bugs

Usa la plantilla de bug report e incluye:

- **Descripción clara** del problema
- **Pasos para reproducir**
- **Comportamiento esperado** vs **comportamiento actual**
- **Información del sistema:**
  - Distribución de Linux
  - Versión del sistema
  - Salida de `./scripts/doctor.sh`
- **Logs relevantes** si los hay

### Feature Requests

Usa la plantilla de feature request e incluye:

- **Descripción** de la feature deseada
- **Motivación** y **casos de uso**
- **Solución propuesta** (si tienes una)
- **Alternativas consideradas**

---

## ✅ Checklist antes de Contribuir

- [ ] Leí y entendí el CODE_OF_CONDUCT.md
- [ ] Busqué issues similares antes de crear uno nuevo
- [ ] Mi código sigue los estándares del proyecto
- [ ] Añadí/actualicé la documentación relevante
- [ ] Testé mis cambios en mi entorno
- [ ] Usé mensajes de commit claros y descriptivos
- [ ] Mi PR usa la plantilla y describe los cambios
- [ ] Sincronicé mi rama con upstream antes del PR

---

## 📚 Recursos para Contribuidores

- [GitHub Flow](https://guides.github.com/introduction/flow/)
- [Markdown Guide](https://www.markdownguide.org/)
- [Shell Script Best Practices](https://github.com/koalaman/shellcheck)
- [Conventional Commits](https://www.conventionalcommits.org/)

---

## 💬 Comunicación

- Usa issues para preguntas y discusiones
- Sé paciente con las respuestas
- Sé constructivo en feedback
- Agradece el trabajo de otros

---

## 🎓 Para Estudiantes

Si eres estudiante y estás aprendiendo:

- No temas hacer preguntas
- Empieza con contribuciones pequeñas (documentación, typos)
- Aprende leyendo código de otros
- Pide mentoría si necesitas guía
- Cada contribución cuenta, sin importar el tamaño

---

**¡Gracias por contribuir! 🎉**
