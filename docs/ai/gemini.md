# Gemini

Modelo multimodal de Google.

## 📋 Contenido

- [Qué es](#qué-es)
- [Instalación](#instalación)
- [Autenticación](#autenticación)
- [Casos de uso](#casos-de-uso)
- [Buenas prácticas](#buenas-prácticas)

---

## 🤔 Qué es

Gemini es el modelo de inteligencia artificial multimodal de Google, capaz de entender y generar texto, código, imágenes y más.

**Características principales:**

- Análisis de código y sugerencias
- Explicación de conceptos complejos
- Generación de documentación
- Soporte multimodal (texto, código, imágenes)
- Integración con ecosistema Google

---

## 📥 Instalación

### Vía Python SDK

```bash
pip install google-generativeai
```

### Vía CLI

```bash
# Instalar Google Cloud CLI
curl https://sdk.cloud.google.com | bash
```

---

## 🔑 Autenticación

1. Obtén una API key en [makersuite.google.com](https://makersuite.google.com)
2. Configura la variable de entorno:

```bash
export GOOGLE_API_KEY="tu-api-key"
```

3. O usa Google Cloud authentication:

```bash
gcloud auth application-default login
```

---

## 💡 Casos de uso

### Análisis de código

```python
import google.generativeai as genai

model = genai.GenerativeModel('gemini-pro')
response = model.generate_content("Explica este código: [pegar código]")
```

### Generación de documentación

```python
response = model.generate_content(
    "Genera documentación para esta función: [pegar función]"
)
```

### Explicación de conceptos

```python
response = model.generate_content(
    "Explica qué es la programación funcional con ejemplos"
)
```

---

## ✅ Buenas prácticas

- **Verificar** la información generada
- **Usar contexto específico** para mejores respuestas
- **Iterar** con follow-up questions
- **Combinar** con otras herramientas de IA
- **Mantener privacidad** - no compartir código sensible

---

**Volver a [Herramientas de IA](../README.md)**
