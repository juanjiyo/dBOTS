alias conf dialog -m conf conf

dialog conf {
  title "Configuración de los dBoTs"
  size $calc(($window(-1).w /2) - 305) 200 615 420
  option pixels

  tab "DeBuG", 1, 5 5 605 415
  edit "", 2, 75 55 155 20, tab 1 autohs
  button "?", 3, 235 55 20 20, tab 1 flat
  button "Actualizar", 4, 260 55 75 20, disable tab 1 flat
  edit "", 5, 90 80 140 20, tab 1 autohs
  button "?", 6, 235 80 20 20, tab 1 flat
  button "Actualizar", 7, 260 80 75 20, disable tab 1 flat
  edit "", 8, 130 105 100 20, tab 1 autohs
  button "?", 9, 235 105 20 20, tab 1 flat
  button "Actualizar", 10, 260 105 75 20, disable tab 1 flat
  edit "", 11, 120 130 110 20, tab 1 autohs
  button "?", 12, 235 130 20 20, tab 1 flat
  button "Actualizar", 13, 260 130 75 20, disable tab 1 flat
  edit "", 14, 80 155 150 20, tab 1 autohs
  button "?", 15, 235 155 20 20, tab 1 flat
  button "Actualizar", 16, 260 155 75 20, disable tab 1 flat
  edit "", 17, 65 255 165 20, tab 1 autohs
  button "?", 18, 235 255 20 20, tab 1 flat
  button "Actualizar", 19, 260 255 75 20, disable tab 1 flat
  edit "", 20, 65 280 165 20, tab 1 autohs
  button "?", 21, 235 280 20 20, tab 1 flat
  button "Actualizar", 22, 260 280 75 20, disable tab 1 flat
  edit "", 23, 65 305 165 20, tab 1 autohs
  button "?", 24, 235 305 20 20, tab 1 flat
  button "Actualizar", 25, 260 305 75 20, disable tab 1 flat
  edit "", 26, 85 330 145 20, tab 1 autohs
  button "?", 27, 235 330 20 20, tab 1 flat
  button "Actualizar", 28, 260 330 75 20, disable tab 1 flat
  edit "", 29, 70 355 160 20, tab 1 autohs
  button "?", 30, 235 355 20 20, tab 1 flat
  button "Actualizar", 31, 260 355 75 20, disable tab 1 flat
  edit "", 32, 110 380 120 20, tab 1 autohs
  button "?", 33, 235 380 20 20, tab 1 flat
  button "Actualizar", 34, 260 380 75 20, disable tab 1 flat
  check "Entrada usuarios", 35, 360 55 115 15, disable tab 1
  check "Salidas usuarios", 36, 360 75 115 15, disable tab 1
  check "Cambio de modos", 37, 360 95 115 15, disable tab 1
  check "Cambios de nicks", 38, 360 115 115 15, disable tab 1
  check "Entradas a canales", 39, 360 135 115 15, disable tab 1
  check "Salida de canales", 40, 360 155 115 15, disable tab 1
  check "Cambios de topic", 41, 360 175 115 15, disable tab 1
  check "Set host", 42, 360 195 115 15, disable tab 1
  check "Server whois", 43, 360 215 115 15, disable tab 1
  check "Set ident", 44, 360 235 115 15, disable tab 1
  check "Set name", 45, 360 255 115 15, disable tab 1
  check "Kick", 46, 360 275 115 15, disable tab 1
  check "Kill", 47, 360 295 115 15, disable tab 1
  check "Away's", 48, 360 315 115 15, disable tab 1
  check "Change host", 49, 360 335 95 15, disable tab 1
  check "Change ident", 50, 360 355 110 15, disable tab 1
  check "Change name", 51, 360 375 110 15, disable tab 1
  check "/ChatOPs", 52, 480 55 110 15, disable tab 1
  check "/ADChat", 53, 480 75 110 15, disable tab 1
  check "/NAChat", 54, 480 95 110 15, disable tab 1
  check "/helpop", 55, 480 115 110 15, disable tab 1
  check "Link servidores", 56, 480 135 110 15, disable tab 1
  check "UnLink de servidor", 57, 480 155 110 15, disable tab 1
  button "?", 58, 570 380 20 20, tab 1 flat
  box "Información del BOT de DEBUG:", 1000, 15 240 330 170, tab 1
  text "Nombre:", 1001, 25 60 45 15, tab 1
  text "Descripción:", 1002, 25 85 60 15, tab 1
  text "IP / Host a conectar:", 1003, 25 110 105 15, tab 1
  text "Puerto a conectar:", 1004, 25 135 95 15, tab 1
  text "Password:", 1005, 25 160 55 15, tab 1
  box "Información del nodo de DEBUG", 1006, 15 35 330 150, tab 1
  text "Canal de debug:", 1007, 25 385 80 15, tab 1
  box "¿Qué información deseas mostar?", 1008, 350 35 250 375, tab 1
  text "Nick:", 1009, 25 260 30 15, tab 1
  text "Ident:", 1010, 25 285 35 15, tab 1
  text "vhost:", 1011, 25 310 35 15, tab 1
  text "Realname:", 1012, 25 335 55 15, tab 1
  text "Modos:", 1013, 25 360 40 15, tab 1
  ;----------------------------------------------------------------------------------------------
  tab "dBoTs", 101
  edit "", 102, 75 55 155 20, tab 101 autohs
  button "?", 103, 235 55 20 20, tab 101 flat
  button "Actualizar", 104, 260 55 75 20, disable tab 101 flat
  edit "", 105, 90 80 140 20, tab 101 autohs
  button "?", 106, 235 80 20 20, tab 101 flat
  button "Actualizar", 107, 260 80 75 20, disable tab 101 flat
  edit "", 108, 130 105 100 20, tab 101 autohs
  button "?", 109, 235 105 20 20, tab 101 flat
  button "Actualizar", 110, 260 105 75 20, disable tab 101 flat
  edit "", 111, 120 130 110 20, tab 101 autohs
  button "?", 112, 235 130 20 20, tab 101 flat
  button "Actualizar", 113, 260 130 75 20, disable tab 101 flat
  edit "", 114, 80 155 150 20, tab 101 autohs
  button "?", 115, 235 155 20 20, tab 101 flat
  button "Actualizar", 116, 260 155 75 20, disable tab 101 flat
  edit "", 117, 115 205 115 21, tab 101 autohs
  button "?", 118, 235 205 20 20, tab 101 flat
  button "Actualizar", 119, 260 205 75 20, disable tab 101 flat
  edit "", 120, 95 230 135 21, tab 101 autohs
  button "?", 121, 235 230 20 20, tab 101 flat
  button "Actualizar", 122, 260 230 75 20, disable tab 101 flat
  edit "", 123, 115 255 115 21, tab 101 autohs
  button "?", 124, 235 255 20 20, tab 101 flat
  button "Actualizar", 125, 260 255 75 20, disable tab 101 flat
  radio "privmsg", 126, 110 285 60 15, group tab 101
  radio "notice", 127, 175 285 50 15, tab 101
  button "?", 128, 235 280 20 20, tab 101 flat
  edit "", 129, 110 330 120 20, tab 101 autohs
  button "?", 130, 235 330 20 20, tab 101 flat
  button "Actualizar", 131, 260 330 75 20, disable tab 101 flat
  edit "", 132, 120 355 110 20, tab 101 autohs
  button "?", 133, 235 355 20 20, tab 101 flat
  button "Actualizar", 134, 260 355 75 20, disable tab 101 flat
  edit "", 135, 115 380 115 20, tab 101 autohs
  button "?", 136, 235 380 20 20, tab 101 flat
  button "Actualizar", 137, 260 380 75 20, disable tab 101 flat
  check "Mostrar debug por ventana", 147, 360 55 160 15, tab 101
  button "?", 148, 525 50 20 20, tab 101 flat
  check "Actualizaciones automáticas", 149, 360 80 160 15, tab 101
  button "?", 150, 525 75 20 20, tab 101 flat
  check "Leer noticias al iniciar dBoTs", 151, 360 105 160 15, tab 101
  button "?", 152, 525 100 20 20, tab 101 flat
  button "Buscar actualizaciones", 153, 360 125 160 20, tab 101 flat
  button "?", 154, 525 125 20 20, tab 101 flat
  check "Si, a los", 155, 360 215 60 15, tab 101
  edit "", 156, 420 210 20 20, tab 101 autohs limit 1
  button "?", 157, 525 210 20 20, tab 101 flat
  box "Información del nodo de los dBoTs:", 1014, 15 35 330 150, tab 101
  text "Nombre:", 1015, 25 60 45 15, tab 101
  text "Descripción:", 1016, 25 85 60 15, tab 101
  text "IP / Host a conectar:", 1017, 25 110 105 15, tab 101
  text "Puerto a conectar:", 1018, 25 135 95 15, tab 101
  text "Password:", 1019, 25 160 55 15, tab 101
  box "Configuración del IRC", 1020, 15 190 330 120, tab 101
  text "Nombre de la red:", 1021, 25 210 90 15, tab 101
  text "Nick del root:", 1022, 25 235 65 15, tab 101
  text "Nick tras registro:", 1023, 25 260 90 15, tab 101
  text "Responder con:", 1024, 25 285 80 15, tab 101
  box "Configuración de los canales:", 1025, 15 315 330 95, tab 101
  text "Canal de ayuda:", 1026, 25 335 80 15, tab 101
  text "Canal para admins:", 1027, 25 360 95 15, tab 101
  text "Canal para opers:", 1028, 25 385 90 15, tab 101
  box "Más opciones:", 1031, 350 35 205 120, tab 101
  box "Auto-Conectar", 1032, 350 190 205 50, tab 101
  text " segundos", 1033, 445 215 55 15, tab 101
  ;----------------------------------------------------------------------------------------------
  tab "Services", 201
  list 202, 25 50 180 310, tab 201 sort size
  button "C U I D A D O", 203, 25 380 180 20, tab 201 flat
  text "", 204, 230 55 100 15, tab 201 right
  edit "", 205, 335 50 150 20, tab 201 autohs
  button "Actualizar", 206, 490 50 75 20, disable tab 201 flat
  button "?", 207, 570 50 20 20, tab 201 flat
  text "", 208, 230 80 100 15, tab 201 right
  edit "", 209, 335 75 150 20, tab 201 autohs
  button "Actualizar", 210, 490 75 75 20, disable tab 201 flat
  button "?", 211, 570 75 20 20, tab 201 flat
  text "", 212, 230 105 100 15, tab 201 right
  edit "", 213, 335 100 150 20, tab 201 autohs
  button "Actualizar", 214, 490 100 75 20, disable tab 201 flat
  button "?", 215, 570 100 20 20, tab 201 flat
  text "", 216, 230 130 100 15, tab 201 right
  edit "", 217, 335 125 150 20, tab 201 autohs
  button "Actualizar", 218, 490 125 75 20, disable tab 201 flat
  button "?", 219, 570 125 20 20, tab 201 flat
  text "", 220, 230 155 100 15, tab 201 right
  edit "", 221, 335 150 150 20, tab 201 autohs
  button "Actualizar", 222, 490 150 75 20, disable tab 201 flat
  button "?", 223, 570 150 20 20, tab 201 flat
  text "", 224, 230 180 100 15, tab 201 right hide
  edit "", 225, 335 175 150 20, tab 201 autohs hide
  button "Actualizar", 226, 490 175 75 20, disable tab 201 flat hide
  button "?", 227, 570 175 20 20, tab 201 flat hide
  text "", 228, 230 205 100 15, tab 201 right hide
  edit "", 229, 335 200 150 20, tab 201 autohs hide
  button "Actualizar", 230, 490 200 75 20, disable tab 201 flat hide
  button "?", 231, 570 200 20 20, tab 201 flat hide
  text "", 232, 230 230 100 15, tab 201 right hide
  edit "", 233, 335 225 150 20, tab 201 autohs hide
  button "Actualizar", 234, 490 225 75 20, disable tab 201 flat hide
  button "?", 235, 570 225 20 20, tab 201 flat hide
  text "", 236, 230 255 100 15, tab 201 right hide
  edit "", 237, 335 250 150 20, tab 201 autohs hide
  button "Actualizar", 238, 490 250 75 20, disable tab 201 flat hide
  button "?", 239, 570 250 20 20, tab 201 flat hide
  text "", 240, 230 280 100 15, tab 201 right hide
  edit "", 241, 335 275 150 20, tab 201 autohs hide
  button "Actualizar", 242, 490 275 75 20, disable tab 201 flat hide
  button "?", 243, 570 275 20 20, tab 201 flat hide
  text "", 244, 230 305 100 15, tab 201 right hide
  edit "", 245, 335 300 150 20, tab 201 autohs hide
  button "Actualizar", 246, 490 300 75 20, disable tab 201 flat hide
  button "?", 247, 570 300 20 20, tab 201 flat hide
  edit "", 248, 260 380 60 21, tab 201 autohs
  edit "", 249, 375 380 110 21, tab 201 autohs
  button "Actualizar", 250, 490 380 75 20, disable tab 201 flat
  button "?", 251, 570 380 20 20, tab 201 flat
  box "", 1036, 15 35 200 375, tab 201
  box "", 1037, 15 35 200 335, tab 201
  box "Configuraciones globales:", 2229, 220 365 380 45, tab 201
  text "Ident:", 1038, 228 385 30 15, tab 201
  text "V-Host:", 1039, 330 385 40 15, tab 201
  box "", 1040, 220 35 380 320, tab 201
  ;----------------------------------------------------------------------------------------------
  tab "Módulos", 301
  list 302, 25 50 180 325, tab 301 size
  button "Cargar", 303, 25 380 75 20, disable tab 301 flat
  button "Descargar", 304, 105 380 75 20, disable tab 301 flat
  button "?", 305, 185 380 20 20, tab 301 flat
  text "Nick:", 306, 230 55 100 15, tab 301 right
  edit "", 307, 335 50 150 20, tab 301 autohs
  button "Actualizar", 308, 490 50 75 20, disable tab 301 flat
  button "?", 309, 570 50 20 20, tab 301 flat
  text "Ident:", 310, 230 80 100 15, tab 301 right
  edit "", 311, 335 75 150 20, tab 301 autohs
  button "Actualizar", 312, 490 75 75 20, disable tab 301 flat
  button "?", 313, 570 75 20 20, tab 301 flat
  text "V-Host:", 314, 230 105 100 15, tab 301 right
  edit "", 315, 335 100 150 20, tab 301 autohs
  button "Actualizar", 316, 490 100 75 20, disable tab 301 flat
  button "?", 317, 570 100 20 20, tab 301 flat
  text "Real name:", 318, 230 130 100 15, tab 301 right
  edit "", 319, 335 125 150 20, tab 301 autohs
  button "Actualizar", 320, 490 125 75 20, disable tab 301 flat
  button "?", 321, 570 125 20 20, tab 301 flat
  text "Modos:", 322, 230 155 100 15, tab 301 right
  edit "", 323, 335 150 150 20, tab 301 autohs
  button "Actualizar", 324, 490 150 75 20, disable tab 301 flat
  button "?", 325, 570 150 20 20, tab 301 flat
  text "Auto-Join:", 326, 230 180 100 15, tab 301 right
  edit "", 327, 335 175 150 20, tab 301 autohs
  button "Actualizar", 328, 490 175 75 20, disable tab 301 flat
  button "?", 329, 570 175 20 20, tab 301 flat
  edit "", 331, 275 380 210 20, tab 301 autohs
  button "Actualizar", 332, 490 380 75 20, disable tab 301 flat
  button "?", 333, 570 380 20 20, tab 301 flat
  button "Abrir configuración del módulo", 330, 230 325 360 20, tab 301 flat
  box "", 3000, 15 35 200 375, tab 301
  box "", 1043, 220 35 380 320, tab 301
  box "Nombre del nodo de los módulos", 2318, 220 365 380 45, tab 301
  text "Nombre:", 2504, 230 385 45 15, tab 301

  edit "", 400, 10 430 595 260, hide read multi vsbar
  button "", 401, 10 695 595 10, hide
  ;----------------------------------------------------------------------------------------------
  tab "SMTP", 501
  radio "Activo", 502, 25 55 55 15, group tab 501
  radio "desactivado", 503, 90 55 80 15, tab 501
  button "?", 504, 190 50 20 20, group tab 501 flat
  edit "", 505, 70 105 160 20, tab 501 autohs
  button "?", 506, 235 105 20 20, group tab 501 flat
  button "Actualizar", 507, 260 105 75 20, disable tab 501 flat
  edit "", 508, 70 130 160 20, tab 501 autohs
  button "?", 509, 235 130 20 20, group tab 501 flat
  button "Actualizar", 510, 260 130 75 20, disable tab 501 flat
  edit "", 511, 90 155 140 20, tab 501 autohs
  button "?", 512, 235 155 20 20, group tab 501 flat
  button "Actualizar", 513, 260 155 75 20, disable tab 501 flat
  edit "", 514, 120 180 110 20, tab 501 autohs
  button "?", 515, 235 180 20 20, tab 501 flat
  button "Actualizar", 516, 260 180 75 20, disable tab 501 flat
  check "Requiere autentificación", 517, 25 235 140 15, tab 501
  check "Usar conexión segura", 518, 175 235 130 15, tab 501
  button "?", 519, 315 230 20 20, group tab 501 flat
  radio "Activado", 520, 25 285 70 15, disable group tab 501
  radio "Desactivado", 521, 100 285 80 15, disable group tab 501
  button "?", 522, 190 280 20 20, tab 501 flat
  check "En el IRC", 523, 25 310 70 15, disable tab 501
  check "Por ventana", 524, 100 310 80 15, disable tab 501
  button "?", 525, 190 305 20 20, tab 501 flat
  edit "", 526, 360 380 150 20, tab 501 autohs
  button "ENVIAR", 527, 515 380 75 20, disable tab 501 flat
  box "Datos", 1044, 15 86 330 125, tab 501
  box "Otras opciones", 1050, 15 215 330 45, tab 501
  box "Debug del SMTP:", 1030, 15 265 205 70, tab 501
  box "Prueba de SMTP", 1042, 350 35 250 375, tab 501
  text "Escribe una dirección de correo electrónico para", 1045, 360 60 230 15, tab 501
  text "Dicha dirección NO PUEDE SER la misma que", 1046, 360 90 230 15, tab 501
  text "Introduce email, pulsa enviar y mira si llega...", 1047, 360 355 230 15, tab 501
  text "NOTA:", 1048, 360 140 230 15, tab 501
  text "en la bandeja de entrada... compruébalo antes", 1049, 360 185 230 15, tab 501
  text "probar el envío de correos.", 1052, 360 75 230 15, tab 501
  text "estés usando para el SMTP.", 1053, 360 105 230 15, tab 501
  text "el correo aparezca en la carpeta de SPAM, no", 1054, 360 170 230 15, tab 501
  text "de pensar que el SMTP no funciona.", 1055, 360 200 230 15, tab 501
  box "Configuración del SMTP ", 1029, 15 35 205 45, tab 501
  text "SMTP:", 1041, 25 111 35 15, tab 501
  text "Contraseña:", 1034, 25 160 60 15, tab 501
  text "Correo:", 1035, 25 135 40 15, tab 501
  text "Puerto de acceso:", 1051, 25 185 90 15, tab 501
  text "NOTA 2:", 1057, 360 235 230 15, tab 501
  text "Dependiendo del servidor que uses, puede que", 1058, 360 155 230 15, tab 501
  text "El correo que se use para enviar los email será", 1059, 360 250 230 15, tab 501
  text "el que aparezca como correo de envío de emails", 1060, 360 265 230 15, tab 501
  text "por lo que se recomienda usar una dirección de", 1061, 360 280 230 15, tab 501
  text "correo que no sea personal. Create una cuenta", 1062, 360 295 230 15, tab 501
  text "nueva o usa una cuenta de tu webhosting para", 1063, 360 310 230 15, tab 501
  text "el envío de correos.", 1064, 360 325 230 15, tab 501
}

on 1:dialog:conf:*:*:{
  if ($devent == init) {
    did -a $dname 2 $l.conf(debugserv,sname)
    did -a $dname 5 $l.conf(debugserv,sdesc)
    did -a $dname 8 $l.conf(debugserv,sip)
    did -a $dname 11 $l.conf(debugserv,sport)
    did -a $dname 14 $l.conf(debugserv,spass)
    did -a $dname 17 $l.conf(debugserv,nick)
    did -a $dname 20 $l.conf(debugserv,ident)
    did -a $dname 23 $l.conf(debugserv,vhost)
    did -a $dname 26 $l.conf(debugserv,realname)
    did -a $dname 29 $l.conf(debugserv,modos)
    did -a $dname 32 $l.conf(debugserv,canal.debug)
    if (a == b) { did -c $dname 33 }
    if (a == b) { did -c $dname 34 }
    if (a == b) { did -c $dname 35 }
    if (a == b) { did -c $dname 36 }
    if (a == b) { did -c $dname 37 }
    if (a == b) { did -c $dname 38 }
    if (a == b) { did -c $dname 39 }
    if (a == b) { did -c $dname 40 }
    if (a == b) { did -c $dname 41 }
    if (a == b) { did -c $dname 42 }
    if (a == b) { did -c $dname 43 }
    if (a == b) { did -c $dname 44 }
    if (a == b) { did -c $dname 45 }
    if (a == b) { did -c $dname 46 }
    if (a == b) { did -c $dname 47 }
    if (a == b) { did -c $dname 48 }
    if (a == b) { did -c $dname 49 }
    if (a == b) { did -c $dname 50 }
    if (a == b) { did -c $dname 51 }
    if (a == b) { did -c $dname 52 }
    if (a == b) { did -c $dname 53 }
    if (a == b) { did -c $dname 54 }
    if (a == b) { did -c $dname 55 }
    if (a == b) { did -c $dname 56 }

    did -a conf 102 $readini(dbots.conf,servidor,servidor)
    did -a conf 105 $readini(dbots.conf,servidor,desc)
    did -a conf 108 $readini(dbots.conf,servidor,ip)
    did -a conf 111 $readini(dbots.conf,servidor,puerto)
    did -a conf 114 $readini(dbots.conf,servidor,clink)
    did -a conf 117 $readini(dbots.conf,otras,nombrered)
    did -a conf 120 $readini(dbots.conf,otras,root)
    did -a conf 123 $readini(dbots.conf,otras,pinvitado)
    did -c conf $iif($readini(dbots.conf,otras,metodo) == PRIVMSG,126,127)
    did -a conf 129 $readini(dbots.conf,canales,ayuda)
    did -a conf 132 $readini(dbots.conf,canales,admins)
    did -a conf 135 $readini(dbots.conf,canales,opers)

    if (%debugv == si) { did -c conf 147 }
    if (%actualizar == si) { did -c conf 149 }
    if (%conf.noticias == si) { did -c conf 151 }
    if ($gettok(%auto.conectar,1,32) == si) { did -ec conf 155,156 }
    did -a conf 156 $gettok(%auto.conectar,2,32)

    var %a = 1
    while ($gettok($readini(dbots.conf,otras,tbots),%a,32)) { did -a conf 202 $gettok($readini(dbots.conf,otras,tbots),%a,32) | inc %a 1 }

    var %b 1
    while ($finddir(sistema\modulos,*,%b)) { did -a conf 302 $nopath($finddir(sistema\modulos,*,%b)) |  inc %b 1 }
    did -a conf 331 $l.conf(modulosserv,sname)

    did -c conf $iif($sslready == $false || $readini(dbots.conf,smtp,estado) == off,503,502)
    if ($sslready == $false) { did -b conf 502,503 | writeini dbots.conf smtp estado off | set %conf.smtp.estado off }
    did -a conf 505 $readini(dbots.conf,smtp,smtp)
    did -a conf 508 $readini(dbots.conf,smtp,user)
    did -a conf 511 $l.conf(smtp,pass)
    did -a conf 514 $readini(dbots.conf,smtp,port)
    if ($readini(dbots.conf,smtp,identificacion)) { did -c conf 517 }
    if ($readini(dbots.conf,smtp,ssl)) { did -c conf 518 }
    did -c conf $iif(smtpdebugon == smtpdebugon,520,519)
    if (smtpdebugirc == si) { }
    if (smtpdebugwindow == smtpdebugwindow) { did -c conf 524 }


    if ($sock(dbots)) { did -b conf 2,5,8,11,14,102,105,108,111,114,117,129,132,135 | var %a $input(Bots conectados $+ $chr(44) hay datos que no se podrán modificar,oi,Bots conectados a la red) }
  }
  if ($devent == edit) {
    if ($did == 2) {
      if ($did(2)) && ($did(2) != $l.conf(debugserv,sname)) && ($nunn($did(2))) { did -e $dname 4 }
      else { did -b $dname 4 }
    }
    if ($did == 5) {
      if ($did(5)) && ($did(5) != $l.conf(debugserv,sdesc)) { did -e $dname 7 }
      else { did -b $dname 7 }
    }
    if ($did == 8) {
      if ($did(8)) {
        if ($checkip($did(8))) && ($did(8) != $l.conf(debugserv,sip)) { did -e $dname 10 | checkdns off }
        elseif (. isin $did(8)) && ($numtok($did(8),46) >= 2) && ($gettok($did(8),1,46) !isnum) { checkdns on $did(8) $did }
        else { did -b $dname 10 | checkdns off }
      }
      else { did -b $dname 10 | checkdns off }
    }
    if ($did == 11) {
      if ($did(11) != $l.conf(debugserv,sport)) && ($did(11) isnum) { did -e $dname 13 }
      else { did -b $dname 13 }
    }
    if ($did == 14) {
      if ($did(14)) && ($did(14) != $l.conf(debugserv,spass)) && ($chr(32) !isin $did(14)) { did -e $dname 16 }
      else { did -b $dname 16 }
    }
    if ($did == 17) {
      if ($did(17)) && ($did(17) != $l.conf(debugserv,nick)) && ($chr(32) !isin $did(17)) && ($chr(44) !isin $did(17)) { did -e $dname 19 }
      else { did -b $dname 19 }
    }
    if ($did == 20) {
      if ($did(20)) && ($did(20) != $l.conf(debugserv,ident)) && ($chr(32) !isin $did(20)) && ($chr(44) !isin $did(20)) { did -e $dname 22 }
      else { did -b $dname 22 }
    }
    if ($did == 23) {
      if ($did(23)) && ($did(23) != $l.conf(debugserv,vhost)) && ($chr(32) !isin $did(23)) && ($chr(44) !isin $did(23)) { did -e $dname 25 }
      else { did -b $dname 25 }
    }
    if ($did == 26) {
      if ($did(26)) && ($did(26) != $l.conf(debugserv,realname)) { did -e $dname 28 }
      else { did -b $dname 28 }
    }
    if ($did == 29) {
      if ($did(29)) && ($did(29) !=== $l.conf(debugserv,modos)) && ($chr(32) !isin $did(29)) && (+* iswm $did(29)) && ($right($did(29),-1) isalpha) { did -e $dname 31 }
      else { did -b $dname 31 }
    }
    if ($did == 32) {
      if ($did(32)) && ($did(32) != $l.conf(debugserv,canal.debug)) && ($chr(32) !isin $did(32)) && (#* iswm $did(32)) && ($chr(44) !isin $did(32)) { did -e conf 34 }
      else { did -b conf 34 }
    }

    if ($did == 102) {
      if ($did(102)) && ($did(102) != $readini(dbots.conf,servidor,servidor)) && ($nunn($did(102))) { did -e conf 104 }
      else { did -b conf 104 }
    }
    if ($did == 105) {
      if ($did(105)) && ($did(105) != $readini(dbots.conf,servidor,desc)) { did -e conf 107 }
      else { did -b conf 107 }
    }
    if ($did == 108) {
      if ($did(108)) {
        if ($checkip($did(108))) && ($did(108) != $l.conf(servidor,ip)) { did -e $dname 110 | checkdns off }
        elseif (. isin $did(108)) && ($numtok($did(108),46) >= 2) && ($gettok($did(108),1,46) !isnum) { checkdns on $did(108) $did }
        else { did -b $dname 110 | checkdns off }
      }
      else { did -b $dname 110 | checkdns off }
    }
    if ($did == 111) {
      if ($did(111)) && ($did(111) isnum) && ($chr(32) !isin $did(111)) && ($chr(46) !isin $did(111)) && ($did(111) != $readini(dbots.conf,servidor,puerto)) { did -e conf 113 }
      else { did -b conf 113 }
    }
    if ($did == 114) {
      if ($did(114)) && ($chr(32) !isin $did(114)) && ($did(114) != $readini(dbots.conf,servidor,clink)) { did -e conf 116 }
      else { did -b conf 116 }
    }
    if ($did == 117) {
      if ($did(117)) && ($$nunn($did(117))) && ($did(117) != $readini(dbots.conf,otras,nombrered)) { did -e conf 119 }
      else { did -b conf 119 }
    }
    if ($did == 120) {
      if ($did(120)) && ($chr(32) !isin $did(120)) && ($isfile(database\nickserv\ $+ $r.c($did(120)))) && ($did(120) != $readini(dbots.conf,otras,root)) { did -e conf 122 }
      else { did -b conf 122 }
    }
    if ($did == 123) {
      if ($did(123)) && ($chr(32) !isin $did(123)) && ($chr(44) !isin $did(123)) && ($did(123) != $readini(dbots.conf,otras,pinvitado)) { did -e conf 125 }
      else { did -b conf 125 }
    }
    if ($did == 129) {
      if ($did(129)) && (#* iswm $did(129)) && ($chr(32) !isin $did(129)) && ($chr(44) !isin $did(129)) && ($did(129) != $readini(dbots.conf,canales,ayuda)) && ($len($did(129)) >= 2) { did -e conf 131 }
      else { did -b conf 131 }
    }
    if ($did == 132) {
      if ($did(132)) && (#* iswm $did(132)) && ($chr(32) !isin $did(132)) && ($chr(44) !isin $did(132)) && ($did(132) != $readini(dbots.conf,canales,admins)) && ($len($did(132)) >= 2) { did -e conf 134 }
      else { did -b conf 134 }
    }
    if ($did == 135) {
      if ($did(135)) && (#* iswm $did(135)) && ($chr(32) !isin $did(135)) && ($chr(44) !isin $did(135)) && ($did(135) != $readini(dbots.conf,canales,opers)) && ($len($did(135)) >= 2) { did -e conf 137 }
      else { did -b conf 137 }
    }
    if ($did == 156) {
      if ($did(156)) && ($did(156) isnum) && ($chr(32) !isin $did(156)) && ($chr(46) !isin $did(156)) { did -e conf 155 }
      else { did -ub conf 155 }
    }
    if ($did == 205) {
      if ($did(205)) && ($did(202).seltext) && ($chr(32) !isin $did(205)) && ($chr(44) !isin $did(205)) && ($chr(58) !isin $did(229)) && ($did(205) != $l.conf($did(202).seltext,$did(204))) { did -e conf 206 }
      else { did -b conf 206 }
    }
    if ($did == 209) {
      if ($did(209)) && ($did(202).seltext) && ($chr(32) !isin $did(209)) && ($chr(44) !isin $did(209)) && ($chr(58) !isin $did(229)) && ($did(209) != $l.conf($did(202).seltext,$did(208))) { did -e conf 210 }
      else { did -b conf 210 }
    }
    if ($did == 213) {
      if ($did(213)) && ($did(202).seltext) && ($chr(32) !isin $did(213)) && ($chr(44) !isin $did(213)) && ($chr(58) !isin $did(229)) && ($did(213) != $l.conf($did(202).seltext,$did(212))) { did -e conf 214 }
      else { did -b conf 214 }
    }
    if ($did == 217) {
      if ($did(217)) && ($did(202).seltext) && ($did(217) != $l.conf($did(202).seltext,$did(216))) { did -e conf 218 }
      else { did -b conf 218 }
    }
    if ($did == 221) {
      if ($did(221)) && ($did(202).seltext) && ($did(221) !=== $l.conf($did(202).seltext,$did(220))) && ($chr(32) !isin $did(221)) && (+* iswm $did(221)) && ($right($did(221),-1) isalpha) { did -e $dname 222 }
      else { did -b $dname 222 }
    }
    if ($did == 225) {
      if ($did(202).seltext == chanserv || $did(202).seltext == memoserv || $did(202).seltext == nickserv) {
        if ($did(225)) && ($did(225) !=== $l.conf($did(202).seltext,$did(224))) && ($regex($did(225),/^[0-9]*$/)) { did -e $dname 226 }
        else { did -b $dname 226 }
      }
      if ($did(202).seltext == cregserv) {
        if ($did(225) || $did(225) == 0) && ($did(225) !=== $l.conf($did(202).seltext,$did(224))) && ($regex($did(225),/^[0-9]*$/)) { did -e $dname 226 }
        else { did -b $dname 226 }
      }
      if ($did(202).seltext == globalserv || $did(202).seltext == noticiasserv) {
        if ($did(225)) && ($did(225) !== $l.conf($did(202).seltext,$did(224))) && ($chr(32) !isin $did(225)) && ($chr(44) !isin $did(225)) && ($chr(58) !isin $did(229)) { did -e $dname 226 }
        else { did -b $dname 226 }
      }
      if ($did(202).seltext == proxyserv) {
        if ($did(225)) && ($did(225) !== $l.conf($did(202).seltext,$did(224))) { did -e $dname 226 }
        else { did -b $dname 226 }
      }
    }

    if ($did == 229) {
      if ($did(202).seltext == chanserv) {
        if ($did(229)) && ($did(229) !=== $l.conf($did(202).seltext,$did(228))) { did -e $dname 230 }
        else { did -b $dname 230 }
      }
      if ($did(202).seltext == cregserv) {
        if ($did(229)) && ($did(229) == on || $did(229) == off) && ($did(229) !=== $l.conf($did(202).seltext,$did(228))) { did -e $dname 230 }
        else { did -b $dname 230 }
      }
      if ($did(202).seltext == globalserv || $did(202).seltext == noticiasserv) {
        if ($did(229)) && ($chr(32) !isin $did(229)) && ($chr(44) !isin $did(229)) && ($chr(58) !isin $did(229)) && ($did(229) != $l.conf($did(202).seltext,$did(228))) { did -e $dname 230 }
        else { did -b $dname 230 }
      }
      if ($did(202).seltext == memoserv || $did(202).seltext == nickserv) {
        if ($did(229)) && ($regex($did(229),/^[0-9]*$/)) && ($did(229) != $l.conf($did(202).seltext,$did(228))) { did -e $dname 230 }
        else { did -b $dname 230 }
      }
      if ($did(202).seltext == proxyserv) {
        if ($did(229)) && ($did(229) != $l.conf($did(202).seltext,$did(228))) { did -e $dname 230 }
        else { did -b $dname 230 }
      }
    }


    if ($did == 233) {
      if ($did(202).seltext == cregserv || $did(202).seltext == nickserv) {
        if ($did(233)) && ($regex($did(233),/^[0-9]*$/)) && ($did(233) != $l.conf($did(202).seltext,$did(232))) { did -e $dname 234 }
        else { did -b $dname 234 }
      }
      if ($did(202).seltext == proxyserv) {
        if ($did(233)) && ($did(233) == ALL || $did(233) == NOREG) && ($did(233) != $l.conf($did(202).seltext,$did(232))) { did -e $dname 234 }
        else { did -b $dname 234 }
      }
    }
    if ($did == 237) {
      if ($did(202).seltext == cregserv) {
        if ($did(237)) && ($did(237) != $l.conf($did(202).seltext,$did(236))) { did -e $dname 238 }
        else { did -b $dname 238 }
      }
      if ($did(202).seltext == nickserv) {
        if ($did(237)) && ($regex($did(237),/^[0-9]*$/)) && ($did(237) != $l.conf($did(202).seltext,$did(236))) { did -e $dname 238 }
        else { did -b $dname 238 }
      }
    }
    if ($did == 241) && ($did(202).seltext == nickserv) {
      if ($did(241)) && ($did(241) == on || $did(241) == off) && ($did(241) !=== $l.conf($did(202).seltext,$did(240))) { did -e $dname 242 }
      else { did -b $dname 242 }
    }
    if ($did == 245) && ($did(202).seltext == nickserv) {
      if ($did(245) || $did(245) == 0) && ($did(245) == 1 || $did(245) == 0) && ($did(245) !=== $l.conf($did(202).seltext,$did(244))) { did -e $dname 246 }
      else { did -b $dname 246 }
    }
    if ($did == 248 || $did == 249) {
      if ($did(248)) && ($did(249)) && ($chr(32) !isin $did(248)) && ($chr(32) !isin $did(249)) && ($chr(44) !isin $did(248)) && ($chr(44) !isin $did(249)) && ($chr(58) !isin $did(248)) && ($chr(58) !isin $did(249)) { did -e $dname 250 }
      else { did -b $dname 250 }
    }

    if ($did == 307) {
      if ($did(307)) && ($did(302).seltext) && ($chr(32) !isin $did(307)) && ($chr(44) !isin $did(307)) && ($chr(58) !isin $did(307)) && ($did(307) != $ginfo($did(302).seltext,info,nick)) { did -e conf 308 }
      else { did -b conf 308 }
    }
    if ($did == 311) {
      if ($did(311)) && ($did(302).seltext) && ($chr(32) !isin $did(311)) && ($chr(44) !isin $did(311)) && ($chr(58) !isin $did(311)) && ($did(311) != $ginfo($did(302).seltext,info,ident)) { did -e conf 312 }
      else { did -b conf 312 }
    }
    if ($did == 315) {
      if ($did(315)) && ($did(302).seltext) && ($chr(32) !isin $did(311)) && ($chr(32) !isin $did(315)) && ($chr(44) !isin $did(315)) && ($chr(58) !isin $did(315)) && ($did(315) != $ginfo($did(302).seltext,info,host)) { did -e conf 316 }
      else { did -b conf 316 }
    }
    if ($did == 319) {
      if ($did(319)) && ($did(302).seltext) && ($chr(32) !isin $did(311)) && ($did(319) != $ginfo($did(302).seltext,info,realname)) { did -e conf 320 }
      else { did -b conf 320 }
    }
    if ($did == 323) {
      if ($did(323)) && ($did(302).seltext) && ($chr(32) !isin $did(311)) && ($did(323) !=== $ginfo($did(302).seltext,info,modos)) && ($chr(32) !isin $did(323)) && (+* !iswm $did(323)) { did -e $dname 324 }
      else { did -b $dname 324 }
    }
    if ($did == 327) {
      if ($did(327)) && ($did(302).seltext) && ($chr(32) !isin $did(311)) && ($did(327) !== $ginfo($did(302).seltext,info,join)) && ($chr(32) !isin $did(327)) && ($chr(58) !isin $did(327)) { did -e $dname 328 }
      else { did -b $dname 328 }
    }
    if ($did == 331) {
      if ($did(331)) && ($did(331) !== $l.conf(modulosserv,sname)) && ($nunn($did(331))) { did -e $dname 332 }
      else { did -b $dname 332 }
    }

    if ($did == 505) {
      if ($did(505)) && ($did(505) != $l.conf(smtp,smtp)) { did -e $dname 507 }
      else { did -b $dname 507 }
    }
    if ($did == 508) {
      if ($did(508)) && (@ isin $did(508)) && (. isin $did(508)) && ($chr(32) !isin $did(508)) && ($did(508) != $l.conf(smtp,user)) { did -e $dname 510 }
      else { did -b $dname 510 }
    }
    if ($did == 511) {
      if ($did(511)) && ($chr(32) !isin $did(511)) && ($did(511) != $l.conf(smtp,pass)) { did -e $dname 513 }
      else { did -b $dname 513 }
    }
    if ($did == 514) {
      if ($did(514)) && ($did(514) isnum) && (. !isin $did(514)) && (, !isin $did(514)) && ($did(514) != $l.conf(smtp,port)) { did -e $dname 516 }
      else { did -b $dname 516 }
    }
    if ($did == 526) {
      if ($did(526)) && (@ isin $did(526)) && (. isin $did(526)) && ($chr(32) !isin $did(526)) && ($did(526) != $l.conf(smtp,user)) { did -e $dname 527 }
      else { did -b $dname 527 }
    }

  }
  if ($devent == sclick) {
    ;if ($did) { echo -s > $did }
    if ($did) && ($did($did).text == ?) || ( $did == 203) { dialog -s conf -1 -1 615 710 | did -r conf 400 | did -v conf 400,401 | .timer -m 1 10 did -c conf 400 1 }
    if ($istok(1 101 201 301 401,$did,32)) && ($dialog(conf).ch != 420) { dialog -s conf -1 -1 615 420 | did -r conf 400 | did -h conf 400,401 }
    if ($istok(3 6 9 12 15 103 106 109 112 115,$did,32)) {
      did -a conf 400 $chr(9) $chr(9) $chr(9) $chr(9) Información del nodo de $iif($did < 100,BEBUG,los dBoTs) $crlf $crlf
      did -a conf 400 Nombre: $crlf
      did -a conf 400   Este es el nombre del servidor de $iif($did < 100,BEBUG,los dBoTs) $+ . $crlf
      did -a conf 400   Es el nombre que tendra que tener el boque del LINK. $crlf $crlf
      did -a conf 400 Descripción: $crlf
      did -a conf 400   Información adicional del nodo. $crlf
      did -a conf 400   Es lo que sale al hacer, por ejemplo, un /links $crlf $crlf
      did -a conf 400 IP / Host a conectar: $crlf
      did -a conf 400   Dirección IP o HOST al que conectará el nodo de $iif($did < 100,BEBUG,los dBoTs) $+ . $+ $crlf
      did -a conf 400   Logicamente, deberá ser la misma a la que el nodo de $iif($did < 100,los dBoTs,BEBUG) $+ . $crlf
      did -a conf 400   NOTA: Si el servidor de IRC está en el mismo PC, deberá usarse la IP 127.0.0.1  $crlf  $crlf
      did -a conf 400 Puerto a conectar: $crlf
      did -a conf 400   Puerto al que conectará el nodo de $iif($did < 100,BEBUG,los dBoTs) $+ . $+ $crlf
      did -a conf 400   Dicho puerto se define en el bloque del LINK. $crlf $crlf
      did -a conf 400 Password: $+ $crlf
      did -a conf 400   Contraseña que usará el nodo de $iif($did < 100,BEBUG,los dBoTs) para conectar. $+ $crlf
      did -a conf 400   Dicha contraseña se define en el bloque del LINK.
    }
    if ($did == 4) { writeini dbots.conf debugserv sname $did(2) | did -b $dname 4 }
    if ($did == 7) { writeini dbots.conf debugserv sdesc $did(5) | did -b $dname 7 }
    if ($did == 10) { writeini dbots.conf debugserv sip $did(8) | did -b $dname 10 }
    if ($did == 13) { writeini dbots.conf debugserv sport $did(11) | did -b $dname 13 }
    if ($did == 16) { writeini dbots.conf debugserv spass $did(14) | did -b $dname 16 }
    if ($did == 18 || $did == 21 || $did == 24 || $did == 27 || $did == 30 || $did == 33) {
      did -a conf 400 $chr(9) $chr(9) $chr(9) $chr(9) Información del BOT de DEBUG $crlf $crlf
      did -a conf 400 NiCK: $crlf
      did -a conf 400   Nick que usará el bot de debug. $crlf $crlf
      did -a conf 400 Ident: $crlf
      did -a conf 400   Ident que usará el bot de debug. $crlf $crlf
      did -a conf 400 V-host: $crlf
      did -a conf 400   Host virtual que usará el bot de debug. $crlf $crlf
      did -a conf 400 Real Name: $crlf
      did -a conf 400   Es el "nombre real" que usara el bor de debug. $crlf
      did -a conf 400   Es lo que aparecerá entre los datos que salen al hacerle /whois $crlf $crlf
      did -a conf 400 Modos: $crlf
      did -a conf 400   Modos que usará el bot de debug. $crlf $crlf
      did -a conf 400 Canal de debug: $crlf
      did -a conf 400   Canal donde el bot enviará los mensajes.
    }
    if ($did == 19) { if ($sock(dbots)) { s : $+ $l.conf(debugserv,nick) NICK $did(17) : $+ $ctime } | writeini dbots.conf debugserv nick $did(17) | did -b $dname 19 }
    if ($did == 22) { if ($sock(dbots)) { s : $+ $l.conf(debugserv,nick) CHGIDENT $l.conf(debugserv,nick) $did(20) } | writeini dbots.conf debugserv ident $did(20) | did -b $dname 22 }
    if ($did == 25) { if ($sock(dbots)) { s : $+ $l.conf(debugserv,nick) CHGHOST $l.conf(debugserv,nick) $did(23) } | writeini dbots.conf debugserv vhost $did(23) | did -b $dname 25 }
    if ($did == 28) { if ($sock(dbots)) { s : $+ $l.conf(debugserv,nick) CHGNAME $l.conf(debugserv,nick) : $+ $did(26) } | writeini dbots.conf debugserv realname $did(26) | did -b $dname 28 }
    if ($did == 31) { if ($sock(dbots)) { s : $+ $l.conf(debugserv,nick) MODE $l.conf(debugserv,nick) :- $+ $right($l.conf(debugserv,modos),-1) | s : $+ $l.conf(debugserv,nick) MODE $l.conf(debugserv,nick) : $+ $did(29) } | writeini dbots.conf debugserv modos $did(29) | did -b $dname 31 }
    if ($did == 34) { if ($sock(dbots)) { s : $+ $l.conf(debugserv,nick) PART $l.conf(debugserv,canal.debug) | s : $+ $l.conf(debugserv,nick) JOIN $d(32) } | writeini dbots.conf debugserv canal.debug $did(32) | did -b $dname 34 }
    if ($did == 35) { }
    if ($did == 36) { }
    if ($did == 37) { }
    if ($did == 38) { }
    if ($did == 39) { }
    if ($did == 40) { }
    if ($did == 41) { }
    if ($did == 42) { }
    if ($did == 43) { }
    if ($did == 44) { }
    if ($did == 45) { }
    if ($did == 46) { }
    if ($did == 47) { }
    if ($did == 48) { }
    if ($did == 49) { }
    if ($did == 50) { }
    if ($did == 51) { }
    if ($did == 52) { }
    if ($did == 53) { }
    if ($did == 54) { }
    if ($did == 55) { }
    if ($did == 56) { }
    if ($did == 57) { }
    if ($did == 58) {
      did -a conf 400 $chr(9) $chr(9) $chr(9) $chr(9) ¿Qué información deseas mostar? $crlf $crlf
      did -a conf 400   Esta sección estará disponible en una proxima actualización. $crlf
      did -a conf 400   Se podrá tener un mayor control sobre lo que el bot de DEBUG mostrará
    }
    if ($did == 104) { writeini dbots.conf servidor servidor $did(102) | set %conf.servidor $did(102) | did -b conf 104 }
    if ($did == 107) { writeini dbots.conf servidor desc $did(105) | set %conf.desc $did(105) | did -b conf 107 }
    if ($did == 110) { writeini dbots.conf servidor ip $did(108) | set %conf.ip $did(108) | did -b conf 110 }
    if ($did == 113) { writeini dbots.conf servidor puerto $did(111) | set %conf.puerto $did(111) | did -b conf 113 }
    if ($did == 116) { writeini dbots.conf servidor clink $did(114) | set %conf.clink $did(114) | did -b conf 116 }
    if ($istok(118 121 124 128,$did,32)) {
      did -a conf 400 $chr(9) $chr(9) $chr(9) $chr(9) Configuración del IRC $crlf $crlf
      did -a conf 400 Nombre de la red: $crlf
      did -a conf 400   Nombre de la red a la que estarán conectados los bots, dicho nombre se usara en el envío de los e-mails. $crlf $crlf
      did -a conf 400 Nick del root: $crlf
      did -a conf 400   Este nick será el del Root principal de los bots. $crlf
      did -a conf 400   NOTA: Antes de poder establecer este nick deberás haberlo registrado. $crlf $crlf
      did -a conf 400 Nick tras registro: $crlf
      did -a conf 400   Este será el nick que establecerán los bots a los usuarios en ciertos momentos, como por ejemplo: $crlf
      did -a conf 400   Al registar el nick, al tener que migrarlo, al añadirlos como representantes de la red... $crlf
      did -a conf 400   Lo normal es usar: invitado- $crlf $crlf
      did -a conf 400 Responde con: $crlf
      did -a conf 400   Modo en el que los bots mandarán la información a los usuarios, por privado o notice.
    }
    if ($did == 119) { writeini dbots.conf otras nombrered $did(117) | set %conf.red $did(117) | did -b conf 119 }
    if ($did == 122) { writeini dbots.conf otras root $did(120) | set %conf.root $did(120) | did -b conf 122 }
    if ($did == 125) { writeini dbots.conf otras pinvitado $did(123) | set %conf.pinv $did(123) | did -b conf 125 }
    if ($did == 126) { writeini dbots.conf otras metodo privmsg | set %conf.metodo privmsg }
    if ($did == 127) { writeini dbots.conf otras metodo notice | set %conf.metodo notice }
    if ($istok(130 133 136,$did,32)) {
      did -a conf 400 $chr(9) $chr(9) $chr(9) $chr(9) Configuración de los canales $crlf $crlf
      did -a conf 400 Canal Canal de ayuda: $crlf
      did -a conf 400   Canal de ayuda para los usuarios del IRC, el más usado es #opers_help $crlf $crlf
      did -a conf 400 Canal para admins: $crlf
      did -a conf 400   Canal donde estarán los administradores del IRC y de los bots, en dicho canal se mandará debug de acciones con los bots (registro de canales, envío de contraseñas, etc.) $crlf $crlf
      did -a conf 400 Canal para opers: $crlf
      did -a conf 400   Canal donde estarán los operadores del IRC y de los bots, en dicho canal se mandará debug de acciones con los bots (registro de canales, envío de contraseñas, etc.)
    }
    if ($did == 131) { writeini dbots.conf canales ayuda $did(129) | set %conf.canal.ayuda $did(129) | did -b conf 131 }
    if ($did == 134) { writeini dbots.conf canales admins $did(132) | set %conf.canal.admins $did(132) | did -b conf 134 }
    if ($did == 137) { writeini dbots.conf canales opers $did(135) | set %conf.canal.opers $did(135) | did -b conf 137 }
    if ($istok(148 150 152 154,$did,32)) {
      did -a conf 400 $chr(9) $chr(9) $chr(9) $chr(9) Más opciones $crlf $crlf
      did -a conf 400 Mostrar debug por ventana: $crlf
      did -a conf 400   Muestra todo el trafico con el servidor de los bots en una ventana. $crlf $crlf
      did -a conf 400 Actualizaciones automáticas: $crlf
      did -a conf 400   Activando esta opción, los bots buscan actualizaciones de forma automática todos los dias. $crlf $crlf
      did -a conf 400 Leer noticias al iniciar dBoTs: $crlf
      did -a conf 400   Activando esta opción, se buscarán las últimas noticias disponibles en la web de los dBoTs. $crlf $crlf
      did -a conf 400 Buscar actualizaciones: $crlf
      did -a conf 400   Como su nombre indica, pulsando este botón se buscarán nuevas actualizaciones de los dBoTs.
    }
    if ($did == 147) { set %debugv $iif($did(147).state,si,no) }
    if ($did == 149) { set %actualizar $iif($did(149).state,si,no) }
    if ($did == 151) { set %conf.noticias $iif($did(151).state,si,no) }
    if ($did == 153) { actualizar }
    if ($did == 155) { set %auto.conectar $iif($did(155).state,si,no) $did(156) | did $iif($did(155).state,-e,-b) conf 156 }
    if ($did == 157) {
      did -a conf 400 $chr(9) $chr(9) $chr(9) $chr(9) Auto-Conectar $crlf $crlf
      did -a conf 400 Activando esta opción, los bots conectarán automáticamente transcurridos los X segundos indicados (de 1 a 9)
    }

    if ($did == 202) && ($did(202).seltext) {
      did -r conf 204,205,208,209,212,213,216,217,220,221,224,225,228,229,232,233,236,237,240,241,244,245
      did -h conf  225,226,227,229,230,231,233,234,235,237,238,239,241,242,243,245,246,247
      did -b conf 206,210,214,218,222,226,230,234,238,242,246
      var %a 1
      var %id 204
      while ($ini(dbots.conf,$did(202).seltext,%a)) {
        var %r = $ini(dbots.conf,$did(202).seltext,%a)
        did -va conf %id %r
        did -va conf $calc(%id + 1) $readini(dbots.conf,$did(202).seltext,%r)
        did -v conf $calc(%id + 2) $+ , $+ $calc(%id + 3)
        inc %a 1
        inc %id 4
      }
    }
    if ($did == 203) {
      did -a conf 400 $chr(9) $chr(9) $chr(9) $chr(9) CUIDADO!!! $crlf $crlf
      did -a conf 400 Estás a punto de modificar datos de los bots de servicio. $crlf $crlf
      did -a conf 400 Es MUY RECOMENDABLE leer bien la ayuda para cada bot, ya que los nombres que aparecen a la izquierda de los compos de edición están sacados directamente del archivo de configuración.
    }
    if ($istok(207 211 215 219 223 227 231 235 239 243 247,$did,32)) {
      if ($did(202).seltext) {
        did -a conf 400 $chr(9) $chr(9) $chr(9) $chr(9) $upper($did(202).seltext) $crlf $crlf
        did -a conf 400 NICK: $crlf
        did -a conf 400   Nick que usará el bot en el IRC. $crlf $crlf
        did -a conf 400 IDENT: $crlf
        did -a conf 400   Ident que tendrá el bot en el IRC. Es lo que sale ANTES de la @ al hacer un /whois $eval($+($chr(36),$did(202).seltext),2) $crlf $crlf
        did -a conf 400 VHOST: $crlf
        did -a conf 400   Virtual host que tendrá el bot en el IRC. Es lo que sale DESPUES de la @ al hacer un /whois $eval($+($chr(36),$did(202).seltext),2) $crlf $crlf
        did -a conf 400 REALNAME: $crlf
        did -a conf 400   "Nombre real" que tendrá el bot en el IRC. Esta información también se muestra en el /whois $eval($+($chr(36),$did(202).seltext),2) $crlf $crlf
        did -a conf 400 MODOS: $crlf
        did -a conf 400   Los modos de usuario e IRCop que usará el bot en la red. $crlf $crlf
        if ($did(202).seltext == centerserv) { }
        if ($did(202).seltext == chanserv) {
          did -a conf 400 CADUCACANALES: $crlf
          did -a conf 400   Es el tiempo, en días, que se mantendrá un canal registado, y que no es usado, antes de ser borrado. $crlf $crlf
          did -a conf 400 MAKICK: $crlf
          did -a conf 400   Mensaje por defecto del auto kick de $eval($+($,$did(202).seltext),2) $crlf $crlf
        }
        if ($did(202).seltext == cregserv) {
          did -a conf 400 APOYOS: $crlf
          did -a conf 400   Número de apoyos que necesitará un canal para considerarse apto para la aprobación por parte de un representante de la red. $crlf $crlf
          did -a conf 400 ARDIA: $crlf
          did -a conf 400   Estando en ON, impide que un nick recien registrado pueda registrar un canal; tendrá que esperar 24h para poder proceder al registro de un canal. Si se desea desactivar poner OFF $crlf $crlf
          did -a conf 400 CANALESNICK: $crlf
          did -a conf 400   Número de canales que podrá tener registrados un usuario en la red. $crlf $crlf
          did -a conf 400 ENTRYMSG: $crlf
          did -a conf 400   Mensaje por defecto que aparecerá en un canal registrado. $crlf $crlf
        }
        if ($did(202).seltext == globalserv) {
          did -a conf 400 IDENTNG: $crlf
          did -a conf 400   Al igual que la ident del apartado de arriba, pero en este caso para los nicks conectado al enviar un mensaje GLOBAL con el comando NICK. $crlf $crlf
          did -a conf 400 VHOSTNG: $crlf
          did -a conf 400   Al igual que la vhost del apartado de arriba, pero en este caso para los nicks conectado al enviar un mensaje GLOBAL con el comando NICK. $crlf $crlf
        }
        if ($did(202).seltext == helpserv) { }
        if ($did(202).seltext == memoserv) {
          did -a conf 400 LMEMOSNICK: $crlf
          did -a conf 400   Limite de mensajes que puede tener un usuario. $crlf $crlf
          did -a conf 400 LMEMOSCANAL: $crlf
          did -a conf 400   Limite de mensajes que puede tener un canal. $crlf $crlf
          did -a conf 400 NOTA: Este límite no se ve afectado por los mensajes enviado por los representantes de la red. $crlf
          did -a conf 400 Así que si un usuario o canal está en el tope de mensjes, no se le guardarán más mensajes, a no ser de representante de la red.
        }
        if ($did(202).seltext == nickserv) {
          did -a conf 400 CADUCANICKS $crlf
          did -a conf 400   Tiempo, en días, que se podrá tener un nick registrado sin ser usado. Pasado ese tiempo, el nick será borrado. $crlf $crlf
          did -a conf 400 RMAIL: $crlf
          did -a conf 400   Maxímo de nicks que se pueden registrar por cuenta de correo. $crlf $crlf
          did -a conf 400 NOEXPIRE $crlf
          did -a conf 400   Tiempo, en días, que durará la activación del NO EXPIRE en un nick por parte de su propietario. $crlf $crlf
          did -a conf 400 ENOEXPIRE: $crlf
          did -a conf 400   Tiempo, en días, que tendrá que esperar un usuario para poder volver a usar el comando NOEXPIRE una vez se le haya terminado la anterior activaciión. $crlf $crlf
          did -a conf 400 MSGNR: $crlf
          did -a conf 400   Estando activo (ON) se enviará un mensaje a los usuarios identificados con el modo +r. Si se quiere desactivar ponerlo en OFF $crlf $crlf
          did -a conf 400 VCORREO: $crlf
          did -a conf 400   Estando en 1, pedirá una validación para poder registrarse. Si se desea desactivar ponerlo en 0.
        }
        if ($did(202).seltext == noticiasserv) {
          did -a conf 400 IDENTNN: $crlf
          did -a conf 400   Al igual que la ident del apartado de arriba, pero en este caso para los nicks usados para enviar un mensaje de entrada con el comando NICK. $crlf $crlf
          did -a conf 400 VHOSTNN: $crlf
          did -a conf 400   Al igual que la vhost del apartado de arriba, pero en este caso para los nicks usados para enviar un mensaje de entrada con el comando NICK. $crlf $crlf
        }
        if ($did(202).seltext == operserv) { }
        if ($did(202).seltext == proxyserv) {
          did -a conf 400 MEXPULSION: $crlf
          did -a conf 400   Mensaje de expulsión para una IP o HOST detectado. $crlf $crlf
          did -a conf 400 PMEXPULSION: $crlf
          did -a conf 400   Mensaje por privado que se le enviará al nick conectado por la IP o HOST detectado.
          did -a conf 400   En dicho mensaje se pueden usar los terminos <nick> <ip> y <dnsbl> los cuales serán reemplazados en el mensaje por el nick del usuario, la IP o HOST detectados, y la DNSBL donde aparece. $crlf $crlf
          did -a conf 400 MODE: $crlf
          did -a conf 400   Modo de actuación del bot. Se puede poner en ALL para escanear a todos los usuarios que conecten, o se puede poner en NOREG, para que solo escanee a los que no tiene en nick registrado.

        }
        if ($did(202).seltext == shadowserv) { }
      }
      else {
        did -a conf 400 $chr(9) $chr(9) $chr(9) $chr(9) ERROR AL CARGAR LA AYUDA $crlf $crlf
        did -a conf 400 Prueba a seleccionar primero un bot de servicio ^_^
      }
    }
    if ($istok(206 210 214 218 222 226 230 234 238 242 246,$did,32)) { writeini dbots.conf $did(202).seltext $did($calc($did - 2)).text $did($calc($did - 1)).text | did -b conf $did }
    if ($did == 250) {
      var %a 1
      while ($did(202,%a).text) {
        writeini dbots.conf $did(202,%a).text ident $did(248).text
        writeini dbots.conf $did(202,%a).text vhost $did(249).text
        inc %a 1
      }
      did -b conf 250
    }
    if ($did == 251) {
      did -a conf 400 $chr(9) $chr(9) $chr(9) $chr(9) Configuraciones globales $crlf $crlf
      did -a conf 400 IDENT: $crlf
      did -a conf 400   Asígna este valor como IDENT para los once bots de la lista. $crlf $crlf
      did -a conf 400 V-HOST: $crlf
      did -a conf 400   Asígna este valor como Virtual Host para los once bots de la lista.
    }
    if ($did == 302) && ($did(302).seltext) {
      did -r conf 307,311,315,319,323,327
      did -b conf 308,312,316,320,324,328
      did -a conf 307 $ginfo($did(302).seltext,info,nick)
      did -a conf 311 $ginfo($did(302).seltext,info,ident)
      did -a conf 315 $ginfo($did(302).seltext,info,host)
      did -a conf 319 $ginfo($did(302).seltext,info,realname)
      did -a conf 323 $ginfo($did(302).seltext,info,modos)
      did -a conf 327 $ginfo($did(302).seltext,info,join)
      did -e conf $iif($script($did(302).seltext $+ .mrc),304,303)
      did -b conf $iif($script($did(302).seltext $+ .mrc),303,304)
    }
    if ($did == 303) {
      .load -rs sistema\modulos\ $+ $did(302).seltext $+ \ $+ $did(302).seltext $+ .mrc
      if ($read(sistema\modulos\modulos.txt,s,$did(302).seltext) == $NULL) { write sistema\modulos\modulos.txt $did(302).seltext ok }
      if ($sock(dbots)) { debugc $centerserv %conf.canal.admins $+ , $+ %conf.canal.opers Módulo12 $did(302).seltext cargado desde la consola. | mmete $did(302).seltext }
      did -b conf 303
      did -e conf 304
    }
    if ($did == 304) {
      .unload -rs $did(302).seltext $+ .mrc
      write -ds $+ $did(302).seltext sistema\modulos\modulos.txt
      if ($sock(dbots)) { debugc $centerserv %conf.canal.admins $+ , $+ %conf.canal.opers Módulo12 $did(302).seltext descargado desde la consola. | s : $+ $ginfo($did(302).seltext,info,nick) quit :Quit: Modulo descargado. }
      .ruser bot $ginfo($did(302).seltext,info,nick)
      did -e conf 303
      did -b conf 304
    }
    if ($did == 305) {
      did -a conf 400 $chr(9) $chr(9) $chr(9) $chr(9) Lista de módulos $crlf $crlf
      did -a conf 400 En esta lista aparecerán los módulos que tengas para los dBoTs $crlf $crlf
      did -a conf 400 CARGAR: $crlf
      did -a conf 400   Carga el módulo seleccionado $crlf $crlf
      did -a conf 400 DESCARGAR: $crlf $crlf
      did -a conf 400   Descarga el módulo seleccionado.
    }
    if ($did == 308) { writeini sistema\modulos\ $+ $did(302).seltext $+ \ $+ $did(302).seltext $+ .ini info nick $did(307) | did -b conf 308 }
    if ($did == 312) { writeini sistema\modulos\ $+ $did(302).seltext $+ \ $+ $did(302).seltext $+ .ini info ident $did(311) | did -b conf 312 }
    if ($did == 316) { writeini sistema\modulos\ $+ $did(302).seltext $+ \ $+ $did(302).seltext $+ .ini info host $did(315) | did -b conf 316 }
    if ($did == 320) { writeini sistema\modulos\ $+ $did(302).seltext $+ \ $+ $did(302).seltext $+ .ini info realname $did(319) | did -b conf 320 }
    if ($did == 324) { writeini sistema\modulos\ $+ $did(302).seltext $+ \ $+ $did(302).seltext $+ .ini info modos $did(323) | did -b conf 324 }
    if ($did == 328) { writeini sistema\modulos\ $+ $did(302).seltext $+ \ $+ $did(302).seltext $+ .ini info join $did(327) | did -b conf 328 }
    if ($istok(309 313 317 321 325 329,$did,32)) {
      if ($did(302).seltext) {
        did -a conf 400 $chr(9) $chr(9) $chr(9) $chr(9) Opciones de los módulos $crlf $crlf
        did -a conf 400 NICK: $crlf
        did -a conf 400   Establece el nick del módulo. $crlf $crlf
        did -a conf 400 IDENT: $crlf
        did -a conf 400   Establede el IDENT del módulo. $crlf $crlf
        did -a conf 400 V-HOST: $crlf
        did -a conf 400   Establece el host virtual del módulo. $crlf $crlf
        did -a conf 400 REAL NAME: $crlf
        did -a conf 400   Establece el realname que usará el módulo. $crlf $crlf
        did -a conf 400 MODOS: $crlf
        did -a conf 400   Establece los módos que usará el módulo. $crlf $crlf
        did -a conf 400 AUTO-JOIN: $crlf
        did -a conf 400   Establece los canales (separados por comas) a los que entrará el módulo al conectar.
      }
      else {
        did -a conf 400 $chr(9) $chr(9) $chr(9) $chr(9) ERROR AL CARGAR LA AYUDA $crlf $crlf
        did -a conf 400 Prueba a seleccionar primero uno de los módulos ^_^
      }
    }
    if ($did == 330) {
      if ($did(302).seltext) {
        if ($isalias($+($did(302).seltext,.dconf))) { $+($did(302).seltext,.dconf) }
        else {
          var %a $input(El módulo $did(conf,302).seltext no tiende dialog de configuración. $crlf $+ Se abrirá el archivo $did(conf,302).seltext $+ .conf $crlf $crlf $+ Ten cuidado al modificarlo!,w,    CUIDADO)
          if (%a) { run sistema\modulos\ $+ $did(conf,302).seltext $+ \ $+ $did(conf,302).seltext $+ .ini }
        }
      }
      else { var %a $input(Primero selecciona un módulo,oh,    ERROR) }
    }
    if ($did == 332) { writeini dbots.conf modulosserv sname $did(331) | did -b conf 332 }
    if ($did == 333) {
      did -a conf 400 $chr(9) $chr(9) $chr(9) $chr(9) Nombre del nodo de los módulos $crlf $crlf
      did -a conf 400 Este es el nombre del servidor donde se conectarán los módulos cargados en los dBoTs. $crlf $+ Dicho nodo aparecerá linkado al nodo principal de los dBoTs.
    }

    if ($did == 502) { writeini dbots.conf smtp estado on | set %conf.smtp.estado on }
    if ($did == 503) { writeini dbots.conf smtp estado off | set %conf.smtp.estado off }
    if ($did == 504) {
      did -a conf 400 $chr(9) $chr(9) $chr(9) $chr(9) Configuración del SMTP $crlf $crlf
      did -a conf 400 Activado: $crlf
      did -a conf 400   Estando activado, las contraseñas de registro de los nicks se enviarán por correo electrónico. $crlf
      did -a conf 400   (Registro más lento, pero más seguro) $crlf $crlf
      did -a conf 400 Desactivado: $crlf
      did -a conf 400   Estando desactivado, las contraseñas de registro de los nicks se dan diractamente al usuario. $crlf
      did -a conf 400   (Registro más rápido, pero menos seguro) $crlf $crlf
      did -a conf 400 NOTA:
      did -a conf 400   Si no se tienen instaladas las librerias para el SSL, no se podrá usar el SMTP.
    }

    if ($istok(506 509 512 515,$did,32)) {
      did -a conf 400 $chr(9) $chr(9) $chr(9) $chr(9) DATOS $crlf $crlf
      did -a conf 400 SMTP: $crlf
      did -a conf 400   Servidor SMTP para emviar los correos. $crlf $crlf
      did -a conf 400 Correo: $crlf
      did -a conf 400   Correo electronico para logearse en el SMTP. $crlf $crlf
      did -a conf 400 Contraseña: $crlf
      did -a conf 400   Contraseña para logearse en el SMTP. $crlf $crlf
      did -a conf 400 Puerto: $crlf
      did -a conf 400   Puerto que se usará para conectar con el SMTP. $crlf
      did -a conf 400   Por lo general se usa el 21 para conexiones normales, el 465 para coenctar por SSL y el 587 para conectar por TLS. $crlf
      did -a conf 400   Si tienes problemas para conectar, busca información del puerto que usa tu servidor de SMTP.
    }
    if ($did == 517) { writeini dbots.conf smtp identificacion $did($did).state }
    if ($did == 518) { writeini dbots.conf smtp ssl $did($did).state }
    if ($did == 519) {
      did -a conf 400 $chr(9) $chr(9) $chr(9) $chr(9) OTRAS OPCIONES $crlf $crlf
      did -a conf 400 Requiere autentificación: $crlf
      did -a conf 400   Por lo genereal todos los servidores necesitan autentificación, si desconoces si es así, dejalo activado. $crlf $crlf
      did -a conf 400 Usar conexión segura: $crlf
      did -a conf 400   Por lo genereal todos los servidores necesitan conexión segura por SSL, si desconoces si es así, prueba a dejarlo dejalo activado. $crlf
      did -a conf 400   Si el servidor usa el cifrado TLS, la opcion SSL ha de estar desactivada!
    }

    if ($did == 507) { writeini dbots.conf smtp smtp $did(505) | did -b $dname $did }
    if ($did == 510) { writeini dbots.conf smtp user $did(508) | did -b $dname $did }
    if ($did == 513) { writeini dbots.conf smtp pass $did(511) | did -b $dname $did }
    if ($did == 516) { writeini dbots.conf smtp port $did(514) | did -b $dname $did }

    if ($istok(522 525,$did,32)) {
      did -a conf 400 $chr(9) $chr(9) $chr(9) $chr(9) Debug del SMTP $crlf $crlf
      did -a conf 400 Activado: $crlf
      did -a conf 400  Muestra el debug del SMTP para comprobar que todo está bien, puede servir de ayuda para cuando hay problemas a la hora de enviar correos. $crlf $crlf
      did -a conf 400 Desactivado: $crlf
      did -a conf 400   Oculta el debug del SMTP, practico si todo está bien y se quiere evitar tantas ventanas con mensajes. $crlf $crlf $crlf
      did -a conf 400 En el IRC:
      did -a conf 400   Si el debug está activado, muestra ciertos datos en el IRC para poder chequear si hay problemas en el envío de los correos. $crlf $crlf
      did -a conf 400 Por ventana: $crlf
      did -a conf 400   Muestra todo el trafico con el servidor SMTP, útil para ver si hay problemas con el envío de los correos. $crlf $crlf $crlf
      did -a conf 400 NOTA: Por el momento, estas opciones van por defecto bloqueadas en ACTIVADO y POR VENTANA, en un futuro se podrán modificar.
    }
    if ($did == 527) {
      %mail.datos = smtp.txt $did(526)
      sockopen $iif($l.conf(smtp,ssl),-e,-t) e.c $l.conf(smtp,smtp) $l.conf(smtp,port)
    }
  }
}

sdsasad {
  if ($devent == sclick) {
    if ($did == 89) {
      writeini dbots.conf $did(conf,78).seltext nick $did(conf,80)
      writeini dbots.conf $did(conf,78).seltext ident $did(conf,82)
      writeini dbots.conf $did(conf,78).seltext vhost $did(conf,84)
      writeini dbots.conf $did(conf,78).seltext realname $did(conf,86)
      did -b conf 89
    }
  }
  if ($devent == edit) {
    if ($did == 74) {
      if ($chr(44) !isin $did(conf,74)) && ($did(conf,74) != $readini(dbots.conf,otras,tbots)) {
        did -e conf 76
      }
      else {
        did -b conf 76
      }
    }
    if ($did == 80 || $did == 82 || $did == 84 || $did == 86) {
      if ($did == 80) {
        if ($did(conf,78).seltext) && ($did(conf,80)) && ($chr(32) !isin $did(conf,80)) {
          did -e conf 89
        }
        else {
          did -b conf 89
        }
      }
      if ($did == 82) {
        if ($did(conf,78).seltext) && ($did(conf,82)) && ($chr(32) !isin $did(conf,82)) {
          did -e conf 89
        }
        else {
          did -b conf 89
        }
      }
      if ($did == 84) {
        if ($did(conf,78).seltext) && ($did(conf,84)) && ($chr(32) !isin $did(conf,84)) {
          did -e conf 89
        }
        else {
          did -b conf 89
        }
      }
      if ($did == 86) {
        if ($did(conf,78).seltext) && ($did(conf,86)) {
          did -e conf 89
        }
        else {
          did -b conf 89
        }
      }
      if ($did(conf,80) = $readini(dbots.conf,$did(conf,78).seltext,nick)) && ($did(conf,82) = $readini(dbots.conf,$did(conf,78).seltext,ident)) && ($did(conf,84) = $readini(dbots.conf,$did(conf,78).seltext,vhost)) && ($did(conf,86) = $readini(dbots.conf,$did(conf,78).seltext,realname)) {
        did -b conf 89
      }
      else {
        did -e conf 89
      }
    }
  }
  if ($devent == close) {
    if ($dialog(conf+)) { dialog -x conf+ }
  }
}

alias -l mira {
  var %a = 1
  var %b = 0
  while ($gettok($readini(dbots.conf,otras,tbots),%a,32)) {
    if ($ini(dbots.conf,$gettok($readini(dbots.conf,otras,tbots),%a,32),0) > %b) {
      %b = $ini(dbots.conf,$gettok($readini(dbots.conf,otras,tbots),%a,32),0)
      echo -s > %b
    }
    inc %a 1
  }
}

on 1:dialog:conf+:*:*:{
  if ($devent == init) {
    var %a = 1
    while ($gettok($readini(dbots.conf,otras,tbots),%a,32)) {
      did -a conf+ 1 $gettok($readini(dbots.conf,otras,tbots),%a,32)
      inc %a 1
    }
  }
  if ($devent == sclick) {
    if ($did == 1) {
      did -rb conf+ 2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23
      var %a 1
      var %b 2
      while (%a <= $ini(dbots.conf,$did(conf+,1).seltext,0)) {
        did -ae conf+ %b $ini(dbots.conf,$did(conf+,1).seltext,%a)
        did -ae conf+ $calc(%b +1) $readini(dbots.conf,$did(conf+,1).seltext,$ini(dbots.conf,$did(conf+,1).seltext,%a))
        inc %a 1
        inc %b 2
      }
    }
    if ($did == 25) {
      if ($did(conf+,3).enabled) {
        writeini dbots.conf $did(conf+,1).seltext $did(conf+,2) $did(conf+,3)
      }
      if ($did(conf+,5).enabled) {
        writeini dbots.conf $did(conf+,1).seltext $did(conf+,4) $did(conf+,5)
      }
      if ($did(conf+,7).enabled) {
        writeini dbots.conf $did(conf+,1).seltext $did(conf+,6) $did(conf+,7)
      }
      if ($did(conf+,9).enabled) {
        writeini dbots.conf $did(conf+,1).seltext $did(conf+,8) $did(conf+,9)
      }
      if ($did(conf+,11).enabled) {
        writeini dbots.conf $did(conf+,1).seltext $did(conf+,10) $did(conf+,11)
      }
      if ($did(conf+,13).enabled) {
        writeini dbots.conf $did(conf+,1).seltext $did(conf+,12) $did(conf+,13)
      }
      if ($did(conf+,15).enabled) {
        writeini dbots.conf $did(conf+,1).seltext $did(conf+,14) $did(conf+,15)
      }
      if ($did(conf+,17).enabled) {
        writeini dbots.conf $did(conf+,1).seltext $did(conf+,16) $did(conf+,17)
      }
      if ($did(conf+,19).enabled) {
        writeini dbots.conf $did(conf+,1).seltext $did(conf+,18) $did(conf+,19)
      }
      if ($did(conf+,21).enabled) {
        writeini dbots.conf $did(conf+,1).seltext $did(conf+,20) $did(conf+,21)
      }
      if ($did(conf+,23).enabled) {
        writeini dbots.conf $did(conf+,1).seltext $did(conf+,22) $did(conf+,23)
      }
      did -b conf+ 25
    }
    if ($did == 27) {
      dialog -s conf+ -1 -1 300 455
      did -v conf+ 30,31
      did -r conf+ 30
      var %a 101
      var %b 102
      while (%a <= %b) {
        did -a conf+ 30 $replace($read($script,%a),ç,$crlf)
        inc %a 1
      }
    }
    if ($did == 29) {
      run http://www.davidlig.com/foro
    }
    if ($did == 31) {
      dialog -s conf+ -1 -1 300 275
      did -r conf+ 30
      did -h conf+ 30,31
    }
  }
  if ($devent == close) && ($dialog(conf)) {
    did -e conf 80,82,84,86,87
  }
  if ($devent == edit) {
    if ($did(conf+,3) = $readini(dbots.conf,$did(conf+,1).seltext,$did(conf+,2))) && ($did(conf+,5) = $readini(dbots.conf,$did(conf+,1).seltext,$did(conf+,4))) && ($did(conf+,7) = $readini(dbots.conf,$did(conf+,1).seltext,$did(conf+,6))) && ($did(conf+,9) = $readini(dbots.conf,$did(conf+,1).seltext,$did(conf+,8))) && ($did(conf+,11) = $readini(dbots.conf,$did(conf+,1).seltext,$did(conf+,10))) && ($did(conf+,13) = $readini(dbots.conf,$did(conf+,1).seltext,$did(conf+,12))) && ($did(conf+,15) = $readini(dbots.conf,$did(conf+,1).seltext,$did(conf+,14))) && ($did(conf+,17) = $readini(dbots.conf,$did(conf+,1).seltext,$did(conf+,16))) && ($did(conf+,19) = $readini(dbots.conf,$did(conf+,1).seltext,$did(conf+,18))) && ($did(conf+,21) = $readini(dbots.conf,$did(conf+,1).seltext,$did(conf+,20))) && ($did(conf+,23) = $readini(dbots.conf,$did(conf+,1).seltext,$did(conf+,22))) {
      did -b conf+ 25
    }
    else {
      did -e conf+ 25
    }
  }
}


0 0 dialog -s conf+ $calc($dialog(conf).x + $dialog(conf).w) $dialog(conf).y -1 -1

alias checkdns {
  if ($1 == on) {
    set %checkdns $3
    .timercheckdnsa 1 1 did -ra conf $calc($3 + 2) Chequeando
    .timercheckdns1 1 1 .enable #checkdns
    .timercheckdns2 1 2 .dns $2 
  }
  if ($1 == off) { .timercheckdns off | .disable #checkdns | if (%checkdns) { did -ra conf $CALC(%CHECKDNS + 2) Actaulizar | unset %checkdns } }
}

#checkdns off
on 1:DNS:{
  var %n = $dns(0)
  if (%n >= 2) {
    var %t 1
    while (%n > 0) {
      var %a $input(Deseas usar la IP: $dns(%n).ip,yi,Encontradas varias IPs para $did(conf, $eval(%checkdns)) ( $+ %t $+ / $+ $dns(0) $+ ))
      if (%a == $true) { did -ra conf %checkdns $dns(%n).ip | did -rae conf $calc(%checkdns + 2) Actualizar | .disable #checkdns | unset %checkdns | halt }
      inc %t 1
      dec %n
    }
    if (%a == $false) { var %a $input(No se ha seleccionado una dirección IP para $did(conf,$eval(%checkdns)),oh,ERROR en elección de IP) | .disable #checkdns | did -ra conf $calc(%checkdns + 2) Actualizar | unset %checkdns }
  }
  elseif (%n == 1) { did -ra conf %checkdns $dns(%n).ip | did -rae conf $calc(%checkdns + 2) Actualizar | .disable #checkdns | unset %checkdns }
  else { var %a $input(No se ha podido encontra una IP para $did(conf,$eval(%checkdns)),ow,ERROR en DNS) | .disable #checkdns | did -ra conf $calc(%checkdns + 2) Actualizar | unset %checkdns }
}
#debugdns end

alias nunn {
  var %a 1
  while ($mid($1-,%a,1)) {
    if ($mid($1-,%a,1) !isin abcdefghijklmnñopqrstuvwxyzABCDEFGHIJKLMNÑOPQRSTUVWXYZ0123456789.-_) { return 0 | halt }
    inc %a 1
  }
  return 1
}
