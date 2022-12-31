create database restaurante
use restaurante
drop database restaurante

create table usuario(
id_usuario int  NOT NULL,
clave char(9), 
passwd char(20), 
Tipo char(1) 
/*Tipo de usuario:
“G”. Gerente
“C”. Cliente
“E”. Camarero*/
);

create table cliente(
id_cliente int  NOT NULL,
nombre char(50),
telefono char(9),
apellido1 char(50),
apellido2 char(50),
email char(30),
FK_usuario int
);

create table pedido(
id_pedido int  NOT NULL,
fecha datetime,
precio decimal(10,2),
pagado tinyint,
/*
Indica si el pedido ha sido pagado por el cliente.
0: Pedido sin pagar.
1: Pedido pagado.
*/
confirmado tinyint,
/*Indica si el pedido ha sido confirmado por el
cliente y ya pueden comenzar a servirle:
0: Pedido sin confirmar.
1: Pedido confirmado.*/
servido tinyint,
/*Indica si todos las consumiciones del pedido han
sido ya servidas:
0: Quedan consumiciones por servir.
1: Todo el pedido está servido.*/
activo tinyint,
/*Indica si el pedido está todavía abierto, aún no ha pasado al histórico:
0: Pedido inactivo.
1: Pedido activo.*/
FK_Cliente int,
FK_Mesa int,
FK_Camarero int
);

create table mesa(
id_mesa int  NOT NULL,
numero int,
libre tinyint,
/*Indica si la mesa está libre en el momento actual:
0: Mesa libre.
1: Mesa ocupada.*/
max_personas int,
comensales int,
num_mesas int
);

create table camarero(
id_camarero int  NOT NULL,
nombre char(50),
apellido1 char(50),
apellido2 char(50),
foto char(100)
);

create table reserva(
id_reserva int  NOT NULL,
fecha datetime,
finalizada tinyint,
/*Indica si la reserva ya ha sido efectuada y
finalizada:89
0: Reserva por finalizar.
1: Reserva finalizada.*/
FK_Cliente int,
FK_Mesa int,
);

create table comentario(
id_comentario int  NOT NULL,
desde char(50),
asunto char(80),
comentario char(255),
fecha datetime
);

create table consumo(
id_consumo int  NOT NULL,
cantidad int,
precio decimal(10,2), 
/*Precio total de la consumición (cantidad * precio del itemconsumicion).*/
servida int,
/*Indica la cantidad de consumiciones servidas.*/
FK_Pedido int,
FK_Itemconsumicion int
);

create table itemConsumo(
id_itemConsumo int  NOT NULL,
tipo char(1),
/*Tipo del ítem de consumición:
P: Producto
M: Menú*/
nombre char(50),
descripcion char(255),
precio decimal(10,2)
);

create table menu(
id_menu int  NOT NULL,
FK_ItemConsumo int
);

create table producto(
id_producto int NOT NULL,
FK_TipoProducto int,
FK_ItemConsumicion int
);

create table productoMenu(
id_productoMenu int NOT NULL,
cantidad int,
FK_producto int,
FK_menu int
);

create table tipoProducto(
id_tipoProducto int NOT NULL,
nombre char (30) 
);


/*RESTRICCION DE TABLA USUARIO*/
ALTER TABLE usuario ADD CONSTRAINT pk_usuario PRIMARY KEY (id_usuario);
/*RESTRICCION DE TABLA CLIENTE*/
ALTER TABLE cliente ADD CONSTRAINT pk_cliente PRIMARY KEY (id_cliente);
/*RESTRICCION DE TABLA PEDIDO*/
ALTER TABLE pedido ADD CONSTRAINT pk_pedido PRIMARY KEY (id_pedido);
/*RESTRICCION DE TABLA MESA*/
ALTER TABLE mesa ADD CONSTRAINT pk_mesa PRIMARY KEY (id_mesa);
/*RESTRICCION DE TABLA CAMARERO*/
ALTER TABLE camarero ADD CONSTRAINT pk_camarero PRIMARY KEY (id_camarero);
/*RESTRICCION DE TABLA RESERVA*/
ALTER TABLE reserva ADD CONSTRAINT pk_reserva PRIMARY KEY (id_reserva);
/*RESTRICCION DE TABLA COMENTARIO*/
ALTER TABLE comentario ADD CONSTRAINT pk_comentario PRIMARY KEY (id_comentario);
/*RESTRICCION DE TABLA CONSUMO*/
ALTER TABLE consumo ADD CONSTRAINT pk_consumo PRIMARY KEY (id_consumo);
/*RESTRICCION DE TABLA ITEMCONSUMO*/
ALTER TABLE itemConsumo ADD CONSTRAINT pk_itemConsumo PRIMARY KEY (id_itemConsumo);
/*RESTRICCION DE TABLA MENU*/
ALTER TABLE menu ADD CONSTRAINT pk_menu PRIMARY KEY (id_menu);
/*RESTRICCION DE TABLA PRODUCTO*/
ALTER TABLE producto ADD CONSTRAINT pk_producto PRIMARY KEY (id_producto);
/*RESTRICCION DE TABLA PRODUCTOMENU*/
ALTER TABLE productoMenu ADD CONSTRAINT pk_productoMenu PRIMARY KEY (id_productoMenu);
/*RESTRICCION DE TABLA TIPOPRODUCTO*/
ALTER TABLE tipoProducto ADD CONSTRAINT pk_tipoProducto PRIMARY KEY (id_tipoProducto);


/*---------ALTER TABLE---------*/
ALTER TABLE cliente ADD CONSTRAINT cliente_usuario_fk
FOREIGN KEY (fk_usuario) REFERENCES usuario (id_usuario);

ALTER TABLE reserva ADD CONSTRAINT reserva_cliente_fk
FOREIGN KEY (fk_cliente) REFERENCES cliente (id_cliente);

ALTER TABLE reserva ADD CONSTRAINT reserva_mesa_fk
FOREIGN KEY (fk_mesa) REFERENCES mesa (id_mesa);

ALTER TABLE pedido ADD CONSTRAINT pedido_cliente_fk
FOREIGN KEY (fk_cliente) REFERENCES cliente (id_cliente);

ALTER TABLE pedido ADD CONSTRAINT pedido_mesa_fk
FOREIGN KEY (fk_mesa) REFERENCES mesa (id_mesa);

ALTER TABLE consumo ADD CONSTRAINT consumo_pedido_fk
FOREIGN KEY (fk_pedido) REFERENCES pedido (id_pedido);

ALTER TABLE pedido ADD CONSTRAINT pedido_camarero_fk
FOREIGN KEY (fk_camarero) REFERENCES camarero (id_camarero);

ALTER TABLE pedido ADD CONSTRAINT pedido_camarero_fk
FOREIGN KEY (fk_camarero) REFERENCES camarero (id_camarero);

ALTER TABLE consumo ADD CONSTRAINT consumo_itemConsumo_fk
FOREIGN KEY (fk_ItemConsumicion) REFERENCES itemConsumo (id_itemConsumo);

ALTER TABLE menu ADD CONSTRAINT menu_itemConsumo_fk
FOREIGN KEY (fk_ItemConsumo) REFERENCES itemConsumo (id_itemConsumo);

ALTER TABLE productomenu ADD CONSTRAINT productomenu_menu_fk
FOREIGN KEY (fk_menu) REFERENCES menu (id_menu);

ALTER TABLE productomenu ADD CONSTRAINT productomenu_producto_fk
FOREIGN KEY (fk_producto) REFERENCES producto (id_producto);

ALTER TABLE producto ADD CONSTRAINT producto_tipoproducto_fk
FOREIGN KEY (fk_tipoproducto) REFERENCES tipoproducto (id_tipoproducto);

ALTER TABLE producto ADD CONSTRAINT producto_itemConsumo_fk
FOREIGN KEY (fk_ItemConsumicion) REFERENCES itemConsumo (id_itemConsumo);

