from flask import Flask, jsonify, request
from flask_cors import CORS
import mysql.connector
import os

app = Flask(__name__)
CORS(app)  # Permite conexiones desde Flutter

# ─── Conexión a BD ────────────────────────────────────────
def get_db():
    return mysql.connector.connect(
        host=os.environ.get("DB_HOST", "localhost"),
        user=os.environ.get("DB_USER", "camaronero"),
        password=os.environ.get("DB_PASSWORD", "camaronero123"),
        database=os.environ.get("DB_NAME", "camaronera01")
    )

# ─── Ruta de prueba ───────────────────────────────────────
@app.route('/')
def index():
    return jsonify({"mensaje": "API Camaronera funcionando ✅", "version": "1.0"})

# ══════════════════════════════════════════════════════════
# USUARIOS
# ══════════════════════════════════════════════════════════
@app.route('/api/usuarios', methods=['GET'])
def get_usuarios():
    db = get_db()
    cursor = db.cursor(dictionary=True)
    cursor.execute("SELECT * FROM usuario")
    result = cursor.fetchall()
    db.close()
    return jsonify(result)

@app.route('/api/usuarios/<int:id>', methods=['GET'])
def get_usuario(id):
    db = get_db()
    cursor = db.cursor(dictionary=True)
    cursor.execute("SELECT * FROM usuario WHERE id = %s", (id,))
    result = cursor.fetchone()
    db.close()
    if result:
        return jsonify(result)
    return jsonify({"error": "Usuario no encontrado"}), 404

@app.route('/api/usuarios', methods=['POST'])
def crear_usuario():
    data = request.json
    db = get_db()
    cursor = db.cursor()
    cursor.execute("""
        INSERT INTO usuario (NOMBRE, APELLIDO, IDENTIFICACION, CORREO, TELEFONO, ROL)
        VALUES (%s, %s, %s, %s, %s, %s)
    """, (data['nombre'], data['apellido'], data['identificacion'],
          data['correo'], data.get('telefono'), data['rol']))
    db.commit()
    new_id = cursor.lastrowid
    db.close()
    return jsonify({"mensaje": "Usuario creado", "id": new_id}), 201

# ══════════════════════════════════════════════════════════
# EMPRESAS
# ══════════════════════════════════════════════════════════
@app.route('/api/empresas', methods=['GET'])
def get_empresas():
    db = get_db()
    cursor = db.cursor(dictionary=True)
    cursor.execute("SELECT * FROM empresa")
    result = cursor.fetchall()
    db.close()
    return jsonify(result)

@app.route('/api/empresas', methods=['POST'])
def crear_empresa():
    data = request.json
    db = get_db()
    cursor = db.cursor()
    cursor.execute("INSERT INTO empresa (NOMBRE, UBICACION) VALUES (%s, %s)",
                   (data['nombre'], data.get('ubicacion')))
    db.commit()
    new_id = cursor.lastrowid
    db.close()
    return jsonify({"mensaje": "Empresa creada", "id": new_id}), 201

# ══════════════════════════════════════════════════════════
# FINCAS
# ══════════════════════════════════════════════════════════
@app.route('/api/fincas', methods=['GET'])
def get_fincas():
    db = get_db()
    cursor = db.cursor(dictionary=True)
    cursor.execute("""
        SELECT f.*, e.NOMBRE as EMPRESA_NOMBRE 
        FROM finca f
        JOIN empresa e ON f.EMPRESA_ID = e.id
    """)
    result = cursor.fetchall()
    db.close()
    return jsonify(result)

# ══════════════════════════════════════════════════════════
# EQUIPOS
# ══════════════════════════════════════════════════════════
@app.route('/api/equipos', methods=['GET'])
def get_equipos():
    db = get_db()
    cursor = db.cursor(dictionary=True)
    cursor.execute("SELECT * FROM equipos")
    result = cursor.fetchall()
    db.close()
    return jsonify(result)

# ══════════════════════════════════════════════════════════
# CASOS
# ══════════════════════════════════════════════════════════
@app.route('/api/casos', methods=['GET'])
def get_casos():
    db = get_db()
    cursor = db.cursor(dictionary=True)
    cursor.execute("""
        SELECT c.*, 
               u.NOMBRE as USUARIO_NOMBRE, u.APELLIDO as USUARIO_APELLIDO,
               e.NOMBRE as EQUIPO_NOMBRE, e.CODIGO as EQUIPO_CODIGO
        FROM casos c
        JOIN usuario u ON c.USUARIO_ID = u.id
        JOIN equipos e ON c.EQUIPO_ID = e.id
    """)
    result = cursor.fetchall()
    db.close()
    return jsonify(result)

@app.route('/api/casos', methods=['POST'])
def crear_caso():
    data = request.json
    db = get_db()
    cursor = db.cursor()
    cursor.execute("""
        INSERT INTO casos (USUARIO_ID, EQUIPO_ID, CODIGO_CASO, DIA, MES, ANIO,
                           HORA, TIPO_SOPORTE, MOTIVO, ESTADOCASO)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
    """, (data['usuario_id'], data['equipo_id'], data.get('codigo_caso'),
          data.get('dia'), data.get('mes'), data.get('anio'),
          data.get('hora'), data.get('tipo_soporte'),
          data.get('motivo'), data.get('estadocaso', 'Abierto')))
    db.commit()
    new_id = cursor.lastrowid
    db.close()
    return jsonify({"mensaje": "Caso creado", "id": new_id}), 201

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)