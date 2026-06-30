# Codex

Modelo de código de OpenAI.

## 📋 Contenido

- [Qué es](#qué-es)
- [Instalación](#instalación)
- [Autenticación](#autenticación)
- [Casos de uso](#casos-de-uso)
- [Buenas prácticas](#buenas-prácticas)

---

## 🤔 Qué es

Codex es el modelo de lenguaje de OpenAI entrenado específicamente para código, capaz de entender y generar código en múltiples lenguajes de programación.

**Características principales:**
- Generación de código desde descripciones en lenguaje natural
- Autocompletado inteligente en IDEs
- Traducción entre lenguajes de programación
- Explicación de código existente
- Generación de tests

---

## 📥 Instalación

### Vía GitHub Copilot

1. Instala la extensión [GitHub Copilot](https://github.com/features/copilot) en tu IDE
2. Inicia sesión con tu cuenta de GitHub
3. Activa la suscripción si es necesario

### Vía OpenAI API

```bash
pip install openai
```

---

## 🔑 Autenticación

### GitHub Copilot

La autenticación se realiza a través de tu cuenta de GitHub al instalar la extensión.

### OpenAI API

1. Obtén una API key en [platform.openai.com](https://platform.openai.com)
2. Configura la variable de entorno:

```bash
export OPENAI_API_KEY="tu-api-key"
```

3. O añádela a tu archivo `~/.zshrc`:

```bash
echo 'export OPENAI_API_KEY="tu-api-key"' >> ~/.zshrc
source ~/.zshrc
```

---

## 💡 Casos de uso

### Generación de código

```
// Escribe un comentario descriptivo
// Función para calcular el factorial de un número
```

### Autocompletado

Escribe el inicio de una función y deja que Copilot complete el resto.

### Traducción

```python
# Traduce este código de Python a JavaScript
def factorial(n):
    if n == 0:
        return 1
    return n * factorial(n - 1)
```

### Generación de tests

```
// Genera tests unitarios para esta función
```

---

## ✅ Buenas prácticas

- **Revisar** el código generado antes de usarlo
- **Entender** la lógica detrás del código
- **Usar comentarios descriptivos** para mejores resultados
- **Iterar** refinando los prompts
- **No depender** completamente del autocompletado

---

**Volver a [Herramientas de IA](/docs/ai/README.md)**