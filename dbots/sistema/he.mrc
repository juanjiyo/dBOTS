alias helpserv.ayuda {
  if ($d(5)) { m.h $helpserv $o helps\he.help $replace($d(5-),$chr(32),-) }
  else { m.h $helpserv $o helps\he.help help }
  l.v
}

on 1:sockread:dbots: {
  if ( $d(2) == PRIVMSG ) || ( $d(2) == NOTICE ) && (( $d(3) == $helpserv ) || ( $d(3) == $helpserv $+ @ $+ %conf.servidor )) { p.m $helpserv | helpserv.procesa }
}

alias helpserv.procesa {
  if ( $d(4) == AYUDA ) || ( $d(4) == HELP ) { helpserv.ayuda }
  if ( $d(4) == UMODES ) { helpserv.umodes }
  if ( $d(4) == CMODES ) { helpserv.cmodes }
  if ( $d(4) == BOTS ) { helpserv.bots }
  if ( $d(4) == NICK ) { helpserv.nick }
  if ( $d(4) == CANAL ) { helpserv.canal }
  if ( $d(4) == CREDITOS ) { creditos PRIVADO }
  m Comando desconocido12 $strip($d(4)) $+ . "12/msg $helpserv AYUDA" para ayuda.
  l.v
}

alias helpserv.umodes {
  m Modos disponibles para usuarios:
  m
  m 12r Nick registrado y protegido.
  m 12R Solo admites privados de gente que tenga el nick registrado y migrado.
  m 12x Protección de IP contra nukes. (ip virtual)
  m 12i Modo invisible. (No aparece utilizando /who)
  m 12s Recibir noticias del servidor.
  m 12w Recibir wallops.
  m 12g Recibir mensajes del servidor Si está en modo DEBUG.
  m 12d Se ignora el flujo de los canales.
  m 12V Cliente WebTV.
  m 12v Rechaza un DCC de un archivo infectado con un virus.
  m 12G Censura palabras prohibidas en privados.
  m 12D Ignora privados.
  m 12T No recibe CTCp's.
  m 12z Usuario conectado por SSL.
  m 12t Usuario con vhost configurado (/vhost).
  m 12p Esconde los canales al usuario que te hace un /whois.
  m 12S Nick SUSPENDIDO.
  m
  m Modos sólo para Pre-Opers, Opers, Co-Admins y Admins:
  m
  m 12h Representante de la red.
  m 12o IRCop de la red.
  m 12O IRCop de la red (2º grado).
  m 12X Ver las ips REALES a usuarios que tienen +x.
  m 12k Modo Channel Service, no pueden ser deopeados o kickeados de un canal.
  m 12a ADMINistrador de services.
  m 12A ADMINistrador de servidor.
  m 12N ADMINistrador de la red.
  m 12C CO-ADMINistrador.
  m 12W Te avisa si te hacen un /whois.
  m 12q Solo U:Lines (services) pueden expulsarlo.
  m 12H Esconde el estatus de IRCop.
  m 
  m Modos de usuarios ESPECIALES:
  m 
  m 12B Indica que es un roBOT oficial de la red.
  m
  m Para cambiar los modos de usuario, escriba 12/mode nick {+/-}modos.
  m La 12+ es para agregar modos y la 12- para quitar modos.
  m El modo 12r de nick registrado no se puede poner ni quitar a voluntad.
  l.v
}

alias helpserv.cmodes {
  m En esta red, los canales pueden tener los siguientes modos:
  m
  m 12r Canal registrado.
  m 12p Canal privado (no sale en la lista de canales /list).
  m 12s Canal secreto (no sale en la lista de canales /list).
  m 12i Canal de sólo invitados.
  m 12k Canal protegido con clave, para entrar necesita la contraseña.
  m 12l Con un número, numero máximo de usuarios que pueden entrar.
  m 12R Solo pueden entrar los usuarios con nicks registrados con +r.
  m 12M Solo pueden hablar los usuarios con nicks registrados con +r.
  m 12m Canal moderado sólo pueden hablar los usuarios con +q, +a, +o, +h y +v.
  m 12t Solo los usuarios con +q, +a, +o y +h pueden cambiar el topic.
  m 12n Solo los usuarios que están dentro pueden hablar.
  m 12c Bloquea una línea que contenga colores.
  m 12u Solo los operadores +q, +a y +o pueden hacer /names y /who al canal.
  m 12C Bloquea los CTCPs.
  m 12G Censura palabras prohibidas.
  m 12N Los usuarios no pueden cambiar el nick mientras estén en el canal.
  m 12S Elimina los colores de una línea.
  m 12T No permite NOTICEs en el canal.
  m 12V No permite INVITEs en el canal.
  m 12O Solo IRCops pueden entrar al canal.
  m 12A Solo ADMINistradores pueden entrar al canal.
  m 12L Fija el canal al que entraran los usuarios al pasarse el modo +l.
  m 12Q Solo U:Lines (services) pueden echar (kickear) a los usuarios del canal.
  m 12K /knock no permitidos en el canal.
  m 12z Solo usuarios conectados por SSL pueden entrar al canal.
  m
  m Modos de usuario dentro del canal:
  m
  m 12q [nick] Status de fundador del canal.
  m 12a [nick] Status de sucesor del canal.
  m 12o [nick] Status de operador del canal.
  m 12h [nick] Status de semi-operador del canal.
  m 12v [nick] Status de moderador del canal.
  m 12b [nick!user@host] Prohibe la entrada (Ban) a la mascara <nick!ident@host>.
  m 12e [nick!user@host] Exceptúa un (Ban) a la mascara <nick!ident@host>.
  m 12f [lineas:segundos] Fija protecciones en el canal mediante el servidor.
  m
  m Para cambiar los modos de canal en un canal, escriba 12/mode canal {+/-}modos.
  m La 12+ es para agregar modos y la 12- para quitar modos.
  l.v
}

alias helpserv.bots {
  m A continuación se muestra una lista de los bots que funcionan en esta red:
  m
  flushini $mircdirdatabase\bots.db
  %tmp.ruta = $mircdirdatabase\bots.db
  if ( $initopic( %tmp.ruta , bots ) == 0 ) { goto f.f }
  clear @bots
  window -hl @bots
  loadbuf -tbots @bots $mircdirdatabase\bots.db
  %tmp.total = $line(@bots,0)
  %tmp.linea = 0
  while ( %tmp.linea < %tmp.total ) {
    inc %tmp.linea
    %tmp.l.linea = $line( @bots , %tmp.linea )
    %tmp.nbot = $gettok(%tmp.l.linea,1,61)
    %tmp.desc = $gettok(%tmp.l.linea,2-,61)
    m 12 $+ %tmp.nbot  $+ %tmp.desc
  }
  :f.f
  m
  m Para ver la ayuda de cada bot, escriba 12/msg BOT AYUDA.
  l.v
}

alias helpserv.nick {
  m ¿Cómo se registra un 12nick?
  m
  m Debes poner 12/msg $nickserv REGISTRA <tu e-mail>
  m
  m 12NOTA: No cambies la palabra $nickserv ya que es el nombre del bot de
  m registro y mantenimiento de nicks. El nick que se registrará
  m será el que tengas puesto.
  m
  m El registro de nicks se permite sobre cualquier tipo de correo
  m bien sea una cuenta POP o WebMail, gratuíto o de pago con la única
  m restricción de registrar12 $l.conf(nickserv,rmail) nicks por e-mail.
  if ($l.conf(nickserv,vcorreo)) {
    m
    m Una vez ejecutado el comando 12REGISTRA, tendrás que validar
    m el registro mediante el comando 12VALIDAR y el código que te
    m proporcionará12 $nickserv en un texto de cinco lineas.
  }
  m
  m Después de registrar el nick, te llegará una contraseña temporal y
  m las instrucciones para identificarse a la cuenta de correo que has
  m especificado al registrar el nick.
  l.v
}

alias helpserv.canal {
  m ¿Cómo se registra un 12canal?
  m
  m Primero hay que hacer una petición de pre-registro del canal,
  m necesitas tener el nick registrado para hacer la petición.
  m El pre-registro se solicita al bot12 $cregserv $+ , la sintaxis es la siguiente:
  m
  m Sintaxis: 12/msg $cregserv REGISTRA <canal> <contraseña> <descripción>
  m
  m 12<canal> El canal que quieres registrar
  m 12<contraseña> Una contraseña para identificarte como fundador
  m 12<descripción> Una descripción sobre la temática del canal
  m
  m Tienes una semana de plazo para conseguir los apoyos para tu canal,
  m para apoyar, necesitan tener el nick registrado y deben poner
  m 12/msg $cregserv APOYA <#canal> y seguir las instrucciones.
  m
  m Una vez conseguido los apoyos, tienes que esperar 24/48 horas para la
  m aprobación del canal por la comisión de canales de la red.
  l.v
}
