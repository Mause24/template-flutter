#!/bin/bash
# .tool/pre-commit.sh

echo "🔍 Ejecutando pre-commit hooks..."

# 1. Formatear el código
echo "▶️ Formateando código..."
dart format --set-exit-if-changed .

if [ $? -ne 0 ]; then
  echo "❌ El código no está formateado. Se corrigió automáticamente."
  exit 1
fi

# 2. Análisis estático
echo "▶️ Analizando proyecto..."
flutter analyze

if [ $? -ne 0 ]; then
  echo "❌ Errores encontrados en el análisis. Corrige antes de commitear."
  exit 1
fi

# 3. Linter avanzado con dart_code_metrics
echo "▶️ Verificando métricas de código..."
flutter pub run dart_code_metrics:metrics analyze lib

if [ $? -ne 0 ]; then
  echo "❌ Problemas detectados por dart_code_metrics."
  exit 1
fi

# 4. Tests (opcional, descomenta si quieres que corran SIEMPRE antes de commit)
# echo "▶️ Corriendo tests..."
# flutter test
# if [ $? -ne 0 ]; then
#   echo "❌ Tests fallaron. Corrige antes de commitear."
#   exit 1
# fi

echo "✅ Pre-commit hooks completados correctamente."
exit 0
