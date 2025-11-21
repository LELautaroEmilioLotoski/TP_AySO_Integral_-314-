# Ansible - playbook - TP_INI

## Informacion:
- playbook de ansible que llama a distintos roles.
	- TP_INI
	- ~~**role**~~
	
- Se deja una estructura **funcional** con la llamada a 1 rol

> El alumno debera modificar el rol entregado y generar los nuevos roles pedidos. </br>
> El playbook debera de llamar a todos los roles pedidos.</br>
> El Alumno debera realizar los ajustes en su entorno para que el playbook pueda correr</br>
> Conectandose con ssh-key a las distintas VM.</br>


## Ejecucion (Parado en la carpeta "ansible/"):
```sh
reset; ansible-playbook -i inventory/hosts playbook.yml
```

### Contenido:
- playbook.yml  -> receta 
- ansible.cfg -> configuracion local de ansible
- inventory
	- hosts -> inventario propiamente dicho en formato INI
	- host_vars  -> variables espesificas a un host
	- group_vars -> variables espesificas para grupos de host
- roles
	- TP_INI
		- tasks
			- main.yml  -> Archivo a editar con las tareas del parcial
		- templates
			- ~~template_01.j2~~  -> Template de jinja2 a editar
	

### Comportamiento deseado:
- El playbook llama a los roles: 
	- TP_INI
	- ~~**role**~~
> Se ejecuta contra el listado de host definido </br>
> Tomando los valores de las variables de los distintos archivos </br>
 