Tratamiento de Imágenes Médicas
Práctica #3

Duarte García, Jesús.
Nava Vargas, Cathia Michelle.

Nuestro programa consta de 3 partes llamadas: Comandos.m, Promedio.m y
Histograma.m. Explicaré el modo de uso de cada uno de los programas.

Comandos utiliza dos imágenes de entrada que son llamadas "RMI2.jpg" y "pp.jpeg".
En la primera se aplicaran las operaciones de invertir niveles de gris, rotación,
recorte, y logaritmo. Por cada operación se guardaran 2 imágenes, una creada por
un comando para lograr la operación y la otra mediante ciclos para lograr la misma
operación.
La imagen de "pp,jpeg" cumple la característica de ser una imagen muy oscura a la
cual se le aplicará una corrección gamma generando, igualmente, dos imagenes.

Para nuestro programa de Promedio.m se necesitan 4 imagenes llamadas:
"aerial_view_no_turb.tif"
"aerial_view_turb_c1.tif"
"aerial_view_turb_C2.tif"
"aerial_view_turb_c3.tif"
Las cuales representan la misma imagen pero con un nivel distinto de turbulencia.
En este programa se calculará el promedio de las imágenes que presentan turbulencia
para comprobar la eficacia de esta operación para eliminar la turbulencia.

Nuestro ultimo programa Histograma.m utilizará la imagen de "RMI2.jpg" para
calcular su histograma de manera manual y por comando además de modificar
este histograma igualmente por comandos y por ciclos. Los resultados se irán
generando en imágenes con formato 'png'.

Se recomiendo generar una carpeta para cada programa y tener las imagenes
solicitadas en cada una de las carpetas del programa antes de ejecutarlo para
evitar confusion entre imágenes generadas.
