name: Validador de Lenguaje

on: [push, pull_request]

jobs:
  validar:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Instalar dependencias
        run: |
          pip install pyspellchecker

      - name: Validar ortografía
        run: python scripts/validar_ortografia.py

      - name: Validar nombres de variables
        run: python scripts/validar_nombres.py

      - name: Generar reporte
        run: python scripts/generar_reporte.py
