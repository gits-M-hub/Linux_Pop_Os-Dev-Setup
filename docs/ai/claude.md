# Claude Code

Asistente de programación por Anthropic.

## 📋 Contenido

- [Qué es](#qué-es)
- [Instalación](#instalación)
- [Autenticación](#autenticación)
- [Casos de uso](#casos-de-uso)
- [Buenas prácticas](#buenas-prácticas)

---

## 🤔 Qué es

Claude Code es un asistente de programación impulsado por el modelo Claude de Anthropic, diseñado para ayudar con tareas de desarrollo de software.

**Características principales:**
- Generación y refactorización de código
- Debugging y análisis de errores
- Explicación de código complejo
- Integración con múltiples IDEs
- Soporte para múltiples lenguajes de programación

---

## 📥 Instalación

### Vía CLI

```bash
# Instalar Claude Code CLI
npm install -g @anthropic-ai/claude-code
```

### Vía IDE Extensiones

**VS Code:**
1. Buscar "Claude Code" en el marketplace
2. Instalar la extensión oficial
3. Configurar con tu API key

---

## 🔑 Autenticación

1. Obtén una API key en [console.anthropic.com](https://console.anthropic.com)
2. Configura la variable de entorno:

```bash
export ANTHROPIC_API_KEY="tu-api-key"
```

3. O añádela a tu archivo `~/.zshrc`:

```bash
echo 'export ANTHROPIC_API_KEY="tu-api-key"' >> ~/.zshrc
source ~/.zshrc
```

---

## 💡 Casos de uso

### Generación de código

```bash
claude "Crea una función en Python que ordene una lista"
```

### Debugging

```bash
claude "Ayúdame a debuggear este error: [pegar error]"
```

### Refactorización

```bash
claude "Refactoriza este código para que sea más legible"
```

### Explicación

```bash
claude "Explica qué hace este código: [pegar código]"
```

---

## ✅ Buenas prácticas

- **Revisar siempre** el código generado antes de usarlo
- **Entender** el código en lugar de copiar ciegamente
- **Ser específico** en los prompts para mejores resultados
- **Iterar** si la primera respuesta no es ideal
- **Usar contexto** proporcionando código relevante

---

**Volver a [Herramientas de IA](README.md)**