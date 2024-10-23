INSERT INTO DELIVERY(tipo_via,nombre_via,localidad,pais,codigo_postal,fecha_recepcion,hora_recepcion,inmueble,n_bloque,escalera,piso,puerta)
SELECT DISTINCT
DLIV_WAYTYPE as tipo_via,
DLIV_WAYNAME as nombre_via,
DLIV_TOWN as localidad,
DLIV_COUNTRY as pais,
DLIV_ZIP as codigo_postal,
DLIV_DATE as fecha_recepcion,
DLIV_TIME as hora_recepcion,
DLIV_GATE as inmueble,
DLIV_BLOCK as n_bloque,
DLIV_STAIRW as escalera,
DLIV_FLOOR as piso,
DLIV_DOOR as puerta
from fsdb.trolley
WHERE  
DLIV_WAYTYPE is not null
and DLIV_WAYNAME is not null
and DLIV_TOWN is not null
and DLIV_COUNTRY is not null
and DLIV_ZIP is not null
and DLIV_DATE is not null
and DLIV_TIME is not null
;

INSERT INTO FACTURACION
SELECT DISTINCT
BILL_WAYTYPE,
BILL_WAYNAME,
BILL_TOWN,
BILL_COUNTRY,
BILL_ZIP,
BILL_GATE,
BILL_BLOCK,
BILL_STAIRW,
BILL_FLOOR,
BILL_DOOR
from fsdb.trolley
WHERE  
BILL_WAYTYPE is not null
and BILL_WAYNAME is not null
and BILL_TOWN is not null
and BILL_COUNTRY is not null
and BILL_ZIP is not null
;


INSERT INTO PROVEEDORES(id_proveedor,cif,nombre,nombre_comercial,correo,telefono,ncuenta,dir_postal,pais,tmedioanual,coste,npedidos)
SELECT DISTINCT
    NULL,
    PROV_TAXID as cif,
    PROV_PERSON as nombre,
    SUPPLIER as nombre_comercial,
    PROV_EMAIL as correo,
    PROV_MOBILE as telefono,
    PROV_BANKACC as ncuenta,
    PROV_ADDRESS as dir_postal,
    PROV_COUNTRY as pais,
    0 as tmedioanual,
    RETAIL_PRICE as coste,
    0 as npedidos   
    FROM fsdb.catalogue 
    WHERE  
    PROV_TAXID IS NOT NULL
        and PROV_PERSON IS NOT NULL
        and SUPPLIER IS NOT NULL
        and PROV_EMAIL IS NOT NULL
        and PROV_MOBILE IS NOT NULL
        and PROV_BANKACC IS NOT NULL
        and PROV_ADDRESS IS NOT NULL
        and PROV_COUNTRY IS NOT NULL
        and RETAIL_PRICE IS NOT NULL;


INSERT INTO REFERENCIAS(id_referencia,cod_barras,descripcion,precio,stock,min_stock,max_stock)
SELECT DISTINCT
NULL,
BARCODE as cod_barras,
'EIFHWEUIFHWEUIFHWEUF',
COST_PRICE as descripcion,
CUR_STOCK as precio,
MIN_STOCK as min_stock,
MAX_STOCK as max_stock
from fsdb.catalogue
WHERE 
COST_PRICE is not null
and CUR_STOCK is not null
and MIN_STOCK > 4
and MAX_STOCK >14
;



INSERT INTO PRODUCTO(id_producto,nombre,coffea,varietal,origen,tostado,packaging,comercializacion,descafeinado,referencia)
SELECT DISTINCT
NULL,
PRODUCT as nombre,
COFFEA as coffea,
VARIETAL as varietal,
ORIGIN as origen,
ROASTING as tostado,
PACKAGING as packaging,
FORMAT as comercializacion,
DECAF as descafeinado,
NULL as referencia
from fsdb.catalogue
WHERE 
PRODUCT is not null
and COFFEA is not null
and VARIETAL is not null
and ORIGIN is not null
and ROASTING is not null
and PACKAGING is not null
and FORMAT is not null
and DECAF is not null
;
INSERT INTO PEDIDO(id_pedido,fecha_pedido,hora_pedido,referencia,cantidad_solicitada,nombre_producto,coffea,varietal,origen,tostado,packaging,comercializacion)
SELECT DISTINCT
NULL,
ORDERDATE as fecha_pedido,
ORDERTIME as hora_pedido,
BARCODE as referencia,
QUANTITY as cantidad_solicitada,
PRODUCT as nombre_producto,
COFFEA as coffea,
VARIETAL as varietal,
ORIGIN as origen,
ROASTING as tostado,
PACKAGING as packaging,
PRODTYPE as comercializacion
from fsdb.trolley
WHERE
ORDERDATE is not null
and ORDERTIME is not null
and QUANTITY is not null
and PRODUCT is not null
and COFFEA is not null
and VARIETAL is not null
and ORIGIN is not null
and ROASTING is not null
and PACKAGING is not null
and PRODTYPE is not null
;

INSERT INTO CLIENTE(id_cliente,correo,telefono,nombre,apellido1,apellido2,tipo_via_fact,nombre_via_fact,localidad_fact,pais_fact,codigo_postal_fact,tipo_via_del,nombre_via_del,localidad_del,pais_del,codigo_postal_del)
SELECT DISTINCT
NULL,
CLIENT_EMAIL as correo,
CLIENT_MOBILE as telefono,
CLIENT_NAME as nombre,
CLIENT_SURN1 as apellido1,
CLIENT_SURN2 as apellido2,
BILL_WAYTYPE as tipo_via_fact,
BILL_WAYNAME as nombre_via_fact,
BILL_TOWN as localidad_fact,
BILL_COUNTRY as pais_fact,
BILL_ZIP as codigo_postal_fact,
DLIV_WAYTYPE as tipo_via_del,
DLIV_WAYNAME as nombre_via_del,
DLIV_TOWN as localidad_del,
DLIV_COUNTRY as pais_del,
DLIV_ZIP as codigo_postal_del
FROM fsdb.trolley
WHERE
CLIENT_NAME is not null
and (CLIENT_EMAIL is not null or CLIENT_MOBILE is not null)
and CLIENT_SURN1 is not null
and BILL_WAYTYPE is not null
and BILL_WAYNAME is not null
and BILL_TOWN is not null
and BILL_COUNTRY is not null
and BILL_ZIP is not null
and DLIV_WAYTYPE is not null
and DLIV_WAYNAME is not null
and DLIV_TOWN is not null
and DLIV_COUNTRY is not null
and DLIV_ZIP is not null
;


INSERT INTO CLIENTE_REG
SELECT DISTINCT
NULL,
USERNAME,
USER_PASSW,
CLIENT_EMAIL,
CLIENT_MOBILE,
REG_DATE,
REG_TIME,
DISCOUNT,
CARD_NUMBER,
CARD_HOLDER,
CARD_COMPANY,
CARD_EXPIRATN
FROM fsdb.trolley
WHERE
USERNAME is not null
and USER_PASSW is not null
and (CLIENT_EMAIL is not null or CLIENT_MOBILE is not null)
and REG_DATE is not null
and REG_TIME is not null
and DISCOUNT is not null
and CARD_NUMBER is not null
and CARD_HOLDER is not null
and CARD_COMPANY is not null
and CARD_EXPIRATN is not null
;

INSERT INTO COMPRA(id_cliente,fecha_pago,hora_pago,referencia,cliente_correo,cliente_telefono,tipo_pago,precio_total)
SELECT DISTINCT
NULL,
PAYMENT_DATE as fecha_pago,
PAYMENT_TIME as hora_pago,
BARCODE as referencia,
CLIENT_EMAIL as cliente_correo,
CLIENT_MOBILE as cliente_telefono,
PAYMENT_TYPE as tipo_pago,
BASE_PRICE as precio
FROM fsdb.trolley
WHERE 
PAYMENT_DATE is not null
and PAYMENT_TYPE is not null
and BASE_PRICE is not null
and (CLIENT_EMAIL is not null or CLIENT_MOBILE is not null)
and PAYMENT_TYPE IN ('COD','credit card','bank transfer');

INSERT INTO HISTORIAL(id_historial,cliente_correo,cliente_telefono,nombre_producto,coffea,varietal,origen,tostado,packaging,comercializacion,id_cliente,fecha_pago,hora_pago,referencia)
SELECT DISTINCT
NULL,
CLIENT_EMAIL as cliente_correo,
CLIENT_MOBILE as cliente_telefono,
PRODUCT as nombre_producto,
COFFEA as coffea,
VARIETAL as varietal,
ORIGIN as origen,
ROASTING as tostado,
PACKAGING as packaging,
PRODTYPE as comercializacion,
NULL,
PAYMENT_DATE as fecha_pago,
PAYMENT_TIME as hora_pago,
BARCODE as referencia
FROM fsdb.trolley
WHERE
 (CLIENT_EMAIL is not null or CLIENT_MOBILE is not null)
and PRODUCT is not null
and COFFEA is not null
and VARIETAL is not null
and ORIGIN is not null
and ROASTING is not null
and PACKAGING is not null
and PRODTYPE is not null
;

INSERT INTO PUBLICACION
SELECT DISTINCT
USERNAME,
PRODUCT,
BARCODE,
POST_DATE,
POST_TIME,
TEXT,
TITLE,
LIKES,
SCORE,
ENDORSED
from fsdb.posts
WHERE
USERNAME is not null
and PRODUCT is not null
and BARCODE is not null
and POST_DATE is not null
and POST_TIME is not null
and TEXT is not null
and TITLE is not null
and LIKES is not null
and SCORE is not null
;

