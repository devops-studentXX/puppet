# puppet

Instalar dependencias del proyecto con bundle
Ejecutar librarian-puppet 
$ librarian-puppet install --clean

Descarga todas las librerías

Revisa el init.pp para acondicionar los directorios

Ejecuta el comando puppet apply

$ sudo FACTER_app_version=XX puppet apply --modulepath=./modules init.pp
