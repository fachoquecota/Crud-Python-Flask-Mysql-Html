from flask import Flask, request, jsonify
import mysql.connector
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

# Configuración de la base de datos
db_config = {
    'host': 'localhost',
    'user': 'root',
    'password': 'abc123',
    'database': 'test',
    'port': 3306
}


@app.route('/productos', methods=['GET'])
def get_productos():
    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor(dictionary=True)
    cursor.callproc('SeleccionarTodosProductos')
    results = next(cursor.stored_results()).fetchall()
    cursor.close()
    conn.close()
    return jsonify(results)

@app.route('/producto', methods=['POST'])
def add_producto():
    data = request.get_json()
    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor()
    cursor.callproc('InsertarProducto', (data['nombre'], data['descripcion'], data['precio'], data['stock']))
    conn.commit()
    cursor.close()
    conn.close()
    return jsonify({"message": "Producto añadido con éxito!"}), 201

@app.route('/producto/<int:id>', methods=['PUT'])
def update_producto(id):
    data = request.get_json()
    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor()
    cursor.callproc('ActualizarProducto', (id, data['nombre'], data['descripcion'], data['precio'], data['stock']))
    conn.commit()
    cursor.close()
    conn.close()
    return jsonify({"message": "Producto actualizado con éxito!"})

@app.route('/producto/<int:id>', methods=['DELETE'])
def delete_producto(id):
    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor()
    cursor.callproc('EliminarProducto', (id,))
    conn.commit()
    cursor.close()
    conn.close()
    return jsonify({"message": "Producto eliminado con éxito!"})

@app.route('/producto/<int:id>', methods=['GET'])
def get_producto(id):
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor(dictionary=True)
        cursor.callproc('SeleccionarProductoPorID', (id,))
        producto = next(cursor.stored_results()).fetchone()
        cursor.close()
        conn.close()
        
        if producto:
            return jsonify(producto)
        else:
            return jsonify({"message": "Producto no encontrado"}), 404

    except Exception as e:
        print(e)
        return jsonify({"message": "Error al obtener el producto"}), 500

if __name__ == '__main__':
    app.run(debug=True)
