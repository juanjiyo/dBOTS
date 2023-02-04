on 1:sockread:dbots: {
  if ( $d(2) == PRIVMSG ) || ( $d(2) == NOTICE ) && (( $d(3) == $globalserv ) || ( $d(3) == $globalserv $+ @ $+ %conf.servidor )) { p.m $globalserv | c.r CA | globalserv.procesa }
}

alias globalserv.procesa {
  if ( $d(4) == AYUDA ) || ( $d(4) == HELP ) { globalserv.ayuda }
  if ( $d(4) == GLOBAL ) { globalserv.global }
  if ( $d(4) == NICK ) { globalserv.nick }
  if ( $d(4) == CHAN ) { globalserv.chan }
  if ($d(4) == pre-oper) { globalserv.pre-oper }
  if ($d(4) == oper) { globalserv.oper }
  if ($d(4) == co-admin) { c.r R | globalserv.co-admin }
  if ($d(4) == admin) { c.r R | globalserv.admin }
  if ( $d(4) == JOIN ) { c.r R | globalserv.join }
  m Comando desconocido12 $strip($d(4)) $+ . "12/msg $globalserv AYUDA" para ayuda.
  l.v
}

alias globalserv.ayuda {
  if ($d(5)) { m.h $globalserv $o helps\gl.help $replace($d(5-),$chr(32),-) }
  else {
    m.h $globalserv $o helps\gl.help help-ca
    if ( $s.n($o) >= 8 ) { m.h $globalserv $o helps\gl.help help-r }
    m.h $globalserv $o helps\gl.help help-f
  }
  l.v
}

alias globalserv.e.g {
  %tmp.n.g.user = 1
  %tmp.n.g.impacto = 0
  if ( $l.db(bots.db,bots,$1) == $null ) {
    %tmp.b.temp.global = $1
    s SQLINE $1 :Servicio de Información
    s NICK $1 1 $ctime $l.conf(globalserv,identng) $l.conf(globalserv,vhostng) %conf.servidor 0 : $+ $l.conf(globalserv,realname)
    s : $+ $1 MODE $1 :+iorKkBdHD
  }
  flushini $mircdirdatabase\status.db
  %tmp.ruta = $mircdirdatabase\status.db
  if ( $initopic( %tmp.ruta , status ) == 0 ) { goto f }
  clear @global
  window -hl @global
  loadbuf -tstatus @global $mircdirdatabase\status.db
  %tmp.total = $line(@global,0)
  %tmp.linea = 0
  while ( %tmp.linea < %tmp.total ) {
    inc %tmp.linea
    %tmp.l.linea = $line( @global , %tmp.linea )
    %tmp.nick = $r.c($gettok(%tmp.l.linea,1,61))
    s : $+ $1 %conf.metodo %tmp.nick :3[ Mensaje Global ]
    s : $+ $1 %conf.metodo %tmp.nick : $+ $3-
  }
  :f
  s : $+ $globalserv %conf.metodo $2 :Mensaje global enviado correctamente.
  s : $+ $globalserv %conf.metodo $2 :Número de Impactos:12 %tmp.linea
  if ( $l.db(bots.db,bots,$1) == $null ) { s : $+ %tmp.b.temp.global QUIT : }
}

alias globalserv.global {
  if ( $d(5) == $null ) { m Error de Sintaxis: 12GLOBAL <mensaje> | l.v }
  globalserv.e.g $globalserv $o $d(5-)
  debugc $globalserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o envió un GLOBAL ( $+ $d(5-) $+ )
  l.v
}

alias globalserv.nick {
  if ( $d(6) == $null ) { m Error de Sintaxis: 12NICK <nick> <mensaje> | l.v }
  if ( $n.r($d(5)) == si ) { m El nick12 $d(5) está registrado. | l.v }
  if ( $l.db(status.db,status,$r.c($d(5))) != $null ) { m El nick12 $d(5)  actualmente está en uso. | l.v }
  if ( $len($d(5)) > 30 ) { m El nick del bot solo puede tener como máximo 30 caracteres. | l.v }
  globalserv.e.g $d(5) $o $d(6-)
  debugc $globalserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o envió un GLOBAL con el nick12 $d(5) ( $+ $d(6-) $+ )
  l.v
}

alias globalserv.chan {
  if ( $d(6) == $null ) { m Error de Sintaxis: 12CHAN <canal> <mensaje> | l.v }
  if ( $mid($d(5),1,1) != $chr(35) ) { m El canal debe comenzar por12 $chr(35) | l.v }
  if ( $e.c($d(5)) == no ) { m El canal12 $d(5) no está en uso en este momento. | l.v }
  %tipo.who = GCHAN
  %who.gchan = $d(6-)
  s : $+ $chanserv WHO $d(5)
  debugc $globalserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o envió un GLOBAL a los usuarios del canal12 $d(5) ( $+ $d(6-) $+ )
  l.v
}

alias globalserv.join {
  if ( $d(6) == $null ) { m Error de Sintaxis: 12JOIN <canal> <motivo> | l.v }
  if ( $mid($d(5),1,1) != $chr(35) ) { m El canal debe comenzar por12 $chr(35) | l.v }
  flushini $mircdirdatabase\status.db
  %tmp.ruta = $mircdirdatabase\status.db
  if ( $initopic( %tmp.ruta , status ) == 0 ) { goto f }
  clear @globalj
  window -hl @globalj
  loadbuf -tstatus @globalj $mircdirdatabase\status.db
  %tmp.total = $line(@globalj,0)
  %tmp.linea = 0
  while ( %tmp.linea < %tmp.total ) {
    inc %tmp.linea
    %tmp.l.linea = $line( @globalj , %tmp.linea )
    %tmp.nick = $r.c($gettok(%tmp.l.linea,1,61))
    s SAJOIN %tmp.nick $d(5)
    s : $+ $globalserv %conf.metodo %tmp.nick :3[ Mensaje Global ]
    s : $+ $globalserv %conf.metodo %tmp.nick : $+ $d(6-)
  }
  :f
  m Forzada la entrada de todos los usuarios de la red al canal12 $d(5) $+ .
  debugc $globalserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o fuerza a todos los usuarios entrar al canal12 $d(5) ( $+ $d(6-) $+ )
  l.v
}

alias globalserv.pre-oper {
  if ( $d(5) == $null ) { m Error de Sintaxis: 12PRE-OPER <mensaje> | l.v }
  var %a 1
  while ($ini(database\representantes.db,conectados,%a)) {
    var %n = $ini(database\representantes.db,conectados,%a)
    var %r = $l.db(representantes.db,conectados,%n)
    s : $+ $globalserv %conf.metodo %n :3[ Mensaje Global para 12Pre-Oper3adores (Y superiores) ]
    s : $+ $globalserv %conf.metodo %n : $+ $d(5-)
    inc %a 1
  }
  debugc $globalserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o envió un GLOBAL para Pre-Operadores y superiores: $d(5-)
  l.v
}

alias globalserv.oper {
  if ( $d(5) == $null ) { m Error de Sintaxis: 12OPER <mensaje> | l.v }
  var %a 1
  while ($ini(database\representantes.db,conectados,%a)) {
    var %n = $ini(database\representantes.db,conectados,%a)
    var %r = $l.db(representantes.db,conectados,%n)
    if (%r == Operador || %r == Co-Administrador || %r == Administrador) {
      s : $+ $globalserv %conf.metodo %n :3[ Mensaje Global para 12Oper3adores (Y superiores) ]
      s : $+ $globalserv %conf.metodo %n : $+ $d(5-)
    }
    inc %a 1
  }
  debugc $globalserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o envió un GLOBAL para Operadores y superiores: $d(5-)
  l.v
}

alias globalserv.co-admin {
  if ( $d(5) == $null ) { m Error de Sintaxis: 12CO-ADMIN <mensaje> | l.v }
  var %a 1
  while ($ini(database\representantes.db,conectados,%a)) {
    var %n = $ini(database\representantes.db,conectados,%a)
    var %r = $l.db(representantes.db,conectados,%n)
    if (%r == Co-Administrador || %r == Administrador) {
      s : $+ $globalserv %conf.metodo %n :3[ Mensaje Global para 12Co-Admin3istradores (Y superiores) ]
      s : $+ $globalserv %conf.metodo %n : $+ $d(5-)
    }
    inc %a 1
  }
  debugc $globalserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o envió un GLOBAL para Co-Administradores y superiores: $d(5-)
  l.v
}

alias globalserv.admin {
  if ( $d(5) == $null ) { m Error de Sintaxis: 12ADMIN <mensaje> | l.v }
  var %a 1
  while ($ini(database\representantes.db,conectados,%a)) {
    var %n = $ini(database\representantes.db,conectados,%a)
    var %r = $l.db(representantes.db,conectados,%n)
    if (%r == Administrador) {
      s : $+ $globalserv %conf.metodo %n :3[ Mensaje Global para 12Admin3istradores ]
      s : $+ $globalserv %conf.metodo %n : $+ $d(5-)
    }
    inc %a 1
  }
  debugc $globalserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o envió un GLOBAL para Administradores: $d(5-)
  l.v
}
