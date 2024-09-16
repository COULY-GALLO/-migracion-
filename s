from flask import Flask, render_template, request, redirect, url_for, flash, session, make_response
from flask_sqlalchemy import SQLAlchemy  # Importa SQLAlchemy para manejar la base de datos
import json


app = Flask(__name__)
app.secret_key = 'patri'

# Configuración de la cbase de datos
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://uvygxbx3ujut3sab:gDrHqdsepK62CtCk16ei@localbmf4xvockkzpjbcbrlhh-mysql.services.clever-cloud.com/bmf4xvockkzpjbcbrlhh'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)  




class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(80), unique=True, nullable=False)
    password = db.Column(db.String(120), nullable=False)

    def __repr__(self):
        return f'<User {self.username}>'


def añadir_usuario(nombre,contraseña):
   new_user = User(username=nombre, password=contraseña)
          db.session.add(new_user)  
          db.session.commit()
         
def mostrar_usuarios():
    users = User.query.all()
    print("Usuarios registrados:")
    for user in users:
        print(f'ID: {user.id}, Username: {user.username}')
         
def borrar_usuario():
   
    print("si no tiene el id, por favor ingrese su nombre y contraseña")
    selects=input("presione 1 si quiere buscar por nombre, presione 0 si qiere buscar por id")
    if selects==1:
        nombre_borrar=input("ingrese su nombre")
        contraseña_borrar=input("ingrese su contraseña")
         
        if User.query.filter_by(username=nombre_borrar, password=contraseña_borrar).first():

           db.session.delete(user)
           db.session.commit()
           print(f'Usuario {nombre_borrar} borrado')
        else:
   
           print(f'{nombre_borrar} esta mal la contraseña o el nombre intente de nuevo')
           borrar_usuario()
           
       
           
    elif selects==0:
        user_id = input("Ingrese el ID del usuario que desea eliminar: ")
    # Buscar usuario por ID
   
   
   
    user = User.query.get(user_id)
   
    if user:
        db.session.delete(user)
        db.session.commit()
        print(f'Usuario {user_id} borrado')
    else:
        print(f'Usuario {user_id} no encontrado.')
