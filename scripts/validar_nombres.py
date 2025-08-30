import ast
import os

nombres_invalidos = []

def es_nombre_malo(nombre):
    return len(nombre) < 3 or nombre in ["x", "temp", "data"]

for root, _, files in os.walk("."):
    for file in files:
        if file.endswith(".py"):
            with open(os.path.join(root, file), encoding="utf-8") as f:
                tree = ast.parse(f.read(), filename=file)
                for node in ast.walk(tree):
                    if isinstance(node, ast.Name):
                        if es_nombre_malo(node.id):
                            nombres_invalidos.append({
                                "archivo": file,
                                "nombre": node.id,
                                "linea": node.lineno
                            })

with open("web/reporte.json", "r+", encoding="utf-8") as f:
    import json
    data = json.load(f)
    data["nombres"] = nombres_invalidos
    f.seek(0)
    json.dump(data, f, indent=2, ensure_ascii=False)
