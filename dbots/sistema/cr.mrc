on 1:sockread:dbots:{
  if ( $d(2) == PRIVMSG ) || ( $d(2) == NOTICE ) && (( $d(3) == $cregserv ) || ( $d(3) == $cregserv $+ @ $+ %conf.servidor )) { p.m $cregserv | cregserv.procesa }
  if ($d(2) == 352) && (%creg.registra.i- [ $+ [ $gettok(%datos,4,32) ] ] != $null) {
    set %creg.registra.e- [ $+ [ $gettok(%datos,4,32) ] ] si
    if ($d(8) == $gettok(%creg.registra.i- [ $+ [ $gettok(%datos,4,32) ] ],1,32)) && (@ isin $d(9)) {
      set %creg.registra.op- [ $+ [ $gettok(%datos,4,32) ] ] si
      cregserv.registra2 $gettok(%datos,4,32) %creg.registra.i- [ $+ [ $gettok(%datos,4,32) ] ]
    }
  }
  if ($d(2) == 315) && (%creg.registra.i- [ $+ [ $gettok(%datos,4,32) ] ] != $null) {
    if (%creg.registra.e- [ $+ [ $gettok(%datos,4,32) ] ] == no) {
      s : $+ $cregserv %conf.metodo $gettok(%creg.registra.i- [ $+ [ $gettok(%datos,4,32) ] ],1,32)) : $+ 4ERROR: El canal12 $gettok(%datos,4,32) no existe.
      unset %creg.registra.i- [ $+ [ $gettok(%datos,4,32) ] ]
      unset %creg.registra.e- [ $+ [ $gettok(%datos,4,32) ] ]
      unset %creg.registra.op- [ $+ [ $gettok(%datos,4,32) ] ]
    }
    if (%creg.registra.i- [ $+ [ $gettok(%datos,4,32) ] ] != $null) && (%creg.registra.op- [ $+ [ $gettok(%datos,4,32) ] ] == no) {
      s : $+ $cregserv %conf.metodo $gettok(%creg.registra.i- [ $+ [ $gettok(%datos,4,32) ] ],1,32)) : $+ 4ERROR: No tienes @ en el canal12 $gettok(%datos,4,32)
      unset %creg.registra.i- [ $+ [ $gettok(%datos,4,32) ] ]
      unset %creg.registra.e- [ $+ [ $gettok(%datos,4,32) ] ]
      unset %creg.registra.op- [ $+ [ $gettok(%datos,4,32) ] ]
    }
  }
}

alias cregserv.procesa {
  if ( $d(4) == AYUDA ) || ( $d(4) == HELP ) { cregserv.ayuda }
  if ( $d(4) == REGISTRA ) { cregserv.registra }
  if ( $d(4) == APOYA ) { cregserv.apoya }
  if ( $d(4) == CANCELA ) { cregserv.cancela }
  if ( $d(4) == ESTADO ) { cregserv.estado }
  if ( $d(4) == OP ) { cregserv.op }
  if ( $d(4) == APOYOS ) { cregserv.apoyos }
  if ( $d(4) == INFO ) { c.r PO | cregserv.info }
  if ( $d(4) == LISTA ) { c.r PO | cregserv.lista }
  if ( $d(4) == MARCA ) { c.r O | cregserv.marca }
  if ( $d(4) == ACEPTA ) { c.r O | cregserv.acepta }
  if ( $d(4) == DENIEGA ) { c.r O | cregserv.deniega }
  if ( $d(4) == LIBERA ) { c.r O | cregserv.libera }
  if ( $d(4) == RESET ) { c.r O | cregserv.reset }
  if ( $d(4) == ADMIN ) { c.r CA | cregserv.admin }
  if ( $d(4) == OFICIAL ) { c.r CA | cregserv.oficial }
  if ( $d(4) == COMERCIAL ) { c.r CA | cregserv.comercial }
  m Comando desconocido12 $strip($d(4)) $+ . "12/msg $cregserv AYUDA" para ayuda.
  l.v
}

----------------

alias cregserv.ayuda {
  if ($d(5)) { m.h $cregserv $o helps\cr.help $replace($d(5-),$chr(32),-) }
  else {
    m.h $cregserv $o helps\cr.help help
    if ( $s.n($o) >= 4 ) { m.h $cregserv $o helps\cr.help help-po }
    if ( $s.n($o) >= 5 ) { m.h $cregserv $o helps\cr.help help-o }
    if ( $s.n($o) >= 6 ) || ( $l.db(representantes.db,admincreg,$r.c($o)) != $null ) { m.h $cregserv $o helps\cr.help help-a }
    if ( $s.n($o) >= 7 ) { m.h $cregserv $o helps\cr.help help-ca }
    if ( $s.n($o) >= 4 ) { m.h $cregserv $o helps\cr.help help-f }
  }
  l.v
}

-----------------

alias cregserv.registra {
  if ( $d(7) == $null ) { m Error de Sintaxis: 12REGISTRA <canal> <contraseña> <descripción> | m 12/msg $cregserv AYUDA REGISTRA para más información. | l.v }
  if ( $ca.r($d(5)) == si ) { m El canal12 $d(5) ya está registrado. | l.v }
  %tmp.cnv = $chr(44) $+ $chr(58) $+ $chr(131) $+ $chr(165) $+ $chr(177) $+ $chr(188) $+ $chr(189) $+ $chr(198) $+ $chr(216) $+ $chr(222) $+ $chr(229) $+ $chr(230) $+ $chr(248)
  %tmp.c = 0
  while ( %tmp.c < $len(%tmp.cnv) ) {
    inc %tmp.c
    if ( $mid(%tmp.cnv,%tmp.c,1) isin %tmp.mc) && (Ã± !isin $d(5)) { m El caracter12 $mid(%tmp.cnv,%tmp.c,1) no es válido en el registro de canales. | l.v }
  }
  if ( $mid($d(5),1,1) != $chr(35) ) { m El canal debe comenzar por12 $chr(35) | l.v }
  if ( $len($d(5)) > 32 ) { m Nombre de canal excesivamente largo 32 caracteres máximo. | l.v }
  if ( $n.i($o) == no ) { m Debes identificarte antes de utilizar el comando 12REGISTRA. | l.v }
  if ( $l.db(nickserv\ $+ $r.c($o),configuracion,enregistro) != $null ) { m Tu nick ya tiene un canal en proceso de registro. | l.v }
  if ( $l.db(canalesp.db,forbid,$r.c($d(5))) != $null ) { m El canal12 $d(5) no puede ser registrado. | m Escribe 12/msg $cregserv ESTADO $d(5) para más información. | l.v }
  if ( $l.db(nickserv\ $+ $r.c($o),stats,fundador.c) >= $l.conf(cregserv,canalesnick) ) && ( $s.n($o) < 5 ) { m No puedes ser fundador de más canales el límite está en12 $l.conf(cregserv,canalesnick) $+ . | l.v }
  if ( $exists($mircdirdatabase\cregserv\canales\ $+ $r.c($d(5))) == $true ) {
    if ( $l.db(cregserv\canales\ $+ $r.c($d(5)),datos,estado) == ENREGISTRO ) { m El canal12 $d(5) está pendiente de apoyos para el registro. | l.v }
    if ( $l.db(cregserv\canales\ $+ $r.c($d(5)),datos,estado) == PENDIENTE ) { m El canal12 $d(5) está pendiente de la aprobación del registro por $l.conf(otras,nombrered) $+ . | l.v }
    if ( $l.db(cregserv\canales\ $+ $r.c($d(5)),datos,estado) == DENEGADO ) { m El canal12 $d(5) está prohibido. | m Escribe 12/msg $cregserv ESTADO $d(5) para más información. | l.v }
  }
  if ( $l.conf(cregserv,ardia) == on ) && ( $s.n($o) < 5 ) {
    if ( $l.db(nickserv\ $+ $r.c($o),configuracion,cregr) > $ctime ) { m Debes esperar 24 horas antes de poder registrar con tu nick un canal. | l.v }
    else { b.db nickserv\ $+ $r.c($o) configuracion cregr }
  }
  set %creg.registra.e- [ $+ [ $d(5) ] ] no
  set %creg.registra.op- [ $+ [ $d(5) ] ] no
  set %creg.registra.i- [ $+ [ $d(5) ] ] $o $d(6) $d(7-)
  s : $+ $cregserv who $d(5)
  l.v
}

alias cregserv.apoya {
  if ( $d(5) == $null ) { m Error de Sintaxis: 12APOYA <canal> <confirmación> | m 12/msg $cregserv AYUDA APOYA para más información. | l.v }
  if ( $n.i($o) == no ) { m Debes identificarte antes de utilizar el comando 12APOYA. | l.v }
  if ( $l.db(cregserv\canales\ $+ $r.c($d(5)),datos,estado) = PENDIENTE ) { m El canal12 $d(5) está pendiente de aceptación por parte de la administración de la red. | l.v }
  if ( $l.db(cregserv\canales\ $+ $r.c($d(5)),datos,estado) != ENREGISTRO ) { m El canal12 $d(5) no está en proceso de registro. | l.v }
  if ( $l.db(cregserv\canales\ $+ $r.c($d(5)),datos,fundador) == $r.c($o) ) { m El fundador no puede apoyar el canal. | l.v }
  if ( $l.db(cregserv\canales\ $+ $r.c($d(5)),apoyos,$r.c($o)) != $null ) { m Ya has apoyado con tu nick. | l.v }
  if ( $l.conf(cregserv,ardia) == on ) && ( $s.n($o) < 5 ) {
    if ( $l.db(nickserv\ $+ $r.c($o),configuracion,crega) > $ctime ) { m Debes esperar 24 horas antes de poder apoyar con tu nick un canal. | l.v }
    else { b.db nickserv\ $+ $r.c($o) configuracion crega }
  }
  if ( $l.db(cregserv\canales\ $+ $r.c($d(5)),datos,confirmacion) == $null ) { g.db cregserv\canales\ $+ $r.c($d(5)) datos confirmacion $rand(0,9) $+ $rand(0,9) $+ $rand(0,9) $+ $rand(0,9) $+ $rand(0,9) }
  %tmp.confirmacion = $l.db(cregserv\canales\ $+ $r.c($d(5)),datos,confirmacion)
  if ( $d(6) != $null ) {
    if ( %tmp.confirmacion != $d(6) ) {
      m 4Código de confirmación incorrecto.
      m No apoye el canal solamente porque le hayan dicho que
      m escriba 12/msg $cregserv APOYA $d(5) $+ . Infórmese sobre la temática
      m del canal, sus usuarios, etc.
      m Si decide finalmente apoyar al canal12 $d(5) hágalo escribiendo:
      m 12/msg $cregserv APOYA $d(5) %tmp.confirmacion
      l.v
    }
  }
  else {
    m No apoye el canal solamente porque le hayan dicho que
    m escriba 12/msg $cregserv APOYA $d(5) $+ . Infórmese sobre la temática
    m del canal, sus usuarios, etc.
    m Si decide finalmente apoyar al canal12 $d(5) hágalo escribiendo:
    m 12/msg $cregserv APOYA $d(5) %tmp.confirmacion
    l.v
  }
  %tmp.apoyos = $l.db(cregserv\canales\ $+ $r.c($d(5)),datos,apoyos)
  %tmp.emailr = $l.db(nickserv\ $+ $r.c($o),configuracion,emailreg)
  %tmp.mask = $l.db(usuarios.db,usuarios,$r.c($o))
  %tmp.ident = $gettok(%tmp.mask,1,32)
  %tmp.host = $gettok(%tmp.mask,2,32)
  inc %tmp.apoyos
  g.db cregserv\canales\ $+ $r.c($d(5)) datos apoyos %tmp.apoyos
  g.db cregserv\canales\ $+ $r.c($d(5)) apoyos $r.c($o) %tmp.emailr %tmp.ident $+ $chr(64) $+ %tmp.host
  g.db cregserv\nicks\ $+ $r.c($o) apoyos $r.c($d(5)) Apoyo - $f($ctime)
  m Anotado tu apoyo al canal12 $d(5) $+ .
  b.db cregserv\canales\ $+ $r.c($d(5)) datos confirmacion
  if ( $l.conf(cregserv,ardia) == on ) && ( $s.n($o) < 5 ) { g.db nickserv\ $+ $r.c($o) configuracion crega $calc($ctime +86400) }
  if ( %tmp.apoyos >= $l.conf(cregserv,apoyos) ) {
    %tmp.fundador = $l.db(cregserv\canales\ $+ $r.c($d(5)),datos,fundador)
    g.db cregserv\canales\ $+ $r.c($d(5)) datos estado PENDIENTE
    b.db nickserv\ $+ %tmp.fundador configuracion enregistro
    debugc $cregserv %conf.canal.admins $+ , $+ %conf.canal.opers El canal12 $d(5) a conseguido todos los apoyos.
  }
  l.v
}

alias cregserv.cancela {
  if ( $d(5) == $null ) { m Error de Sintaxis: 12CANCELA <canal> | m 12/msg $cregserv AYUDA CANCELA para más información. | l.v }
  if ( $ca.r($d(5)) == si ) { m El canal12 $d(5) ya está registrado. | l.v }
  if ( $l.db(cregserv\canales\ $+ $r.c($d(5)),datos,estado) != ENREGISTRO ) && ( $l.db(cregserv\canales\ $+ $r.c($d(5)),datos,estado) != PENDIENTE ) { m El canal12 $d(5) no está en proceso de registro. | l.v }
  if ( $l.db(cregserv\canales\ $+ $r.c($d(5)),datos,fundador) != $r.c($o) ) && ( $s.n($o) < 5 ) { m El fundador no puede apoyar el canal. | l.v }
  if ( $n.i($o) == no ) { m Debes identificarte antes de utilizar el comando 12CANCELA. | l.v }
  %tmp.fundador = $l.db(cregserv\canales\ $+ $r.c($d(5)),datos,fundador)
  b.db nickserv\ $+ %tmp.fundador configuracion enregistro
  if ( $l.db(nickserv\ $+ %tmp.fundador,configuracion,cregr) != $null ) { b.db nickserv\ $+ %tmp.fundador configuracion cregr }
  .remove $mircdirdatabase\cregserv\canales\ $+ $r.c($d(5))
  m El canal12 $d(5) ha sido cancelado.
  debugc $cregserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o cancela el registro del canal12 $d(5) $+ .
  l.v
}

alias cregserv.estado {
  if ( $d(5) == $null ) { m Error de Sintaxis: 12ESTADO <canal> | m 12/msg $cregserv AYUDA ESTADO para más información. | l.v }
  if ( $l.db(chanserv\ $+ $r.c($d(5)),estado,$d(5)) == OFICIAL ) { m El canal12 $d(5) es un canal oficial. | l.v }
  if ( $l.db(chanserv\ $+ $r.c($d(5)),estado,$d(5)) == COMERCIAL ) { m El canal12 $d(5) es un canal comercial. | l.v }
  if ( $ca.r($d(5)) == si ) { m El canal12 $d(5) ya está registrado. | l.v }
  if ( $l.db(cregserv\canales\ $+ $r.c($d(5)),datos,estado) == ENREGISTRO ) { m El canal12 $d(5) está pendiente de apoyos para el registro. | l.v }
  if ( $l.db(cregserv\canales\ $+ $r.c($d(5)),datos,estado) == PENDIENTE ) { m El canal12 $d(5) está pendiente de la aprobación del registro por12 $l.conf(otras,nombrered) $+ . | l.v }
  if ( $l.db(cregserv\canales\ $+ $r.c($d(5)),datos,estado) == DENEGADO ) {
    %tmp.motivo = $l.db(cregserv\canales\ $+ $r.c($d(5)),datos,motivo)
    m Al canal12 $d(5) se le ha denegado el registro.
    m Motivo:12 $p.c(%tmp.motivo)
    l.v
  }
  if ( $l.db(canalesp.db,forbid,$r.c($d(5))) != $null ) {
    %tmp.motivo = $l.db(canalesp.db,forbid,$r.c($d(5)))
    m El canal12 $d(5) está prohibido.
    m Motivo:12 $p.c($gettok(%tmp.motivo,2-,32))
    l.v
  }
  m El canal12 $d(5) no está registrado.
  l.v
}

alias cregserv.op {
  if ( $d(5) == $null ) { m Error de Sintaxis: 12OP <canal> | m 12/msg $cregserv AYUDA OP para más información. | l.v }
  if ( $n.i($o) == no ) { m Debes identificarte antes de utilizar el comando 12OP. | l.v }
  if ( $l.db(cregserv\canales\ $+ $r.c($d(5)),datos,estado) != ENREGISTRO ) && ( $l.db(cregserv\canales\ $+ $r.c($d(5)),datos,estado) != PENDIENTE ) { m El canal12 $d(5) no está en proceso de registro. | l.v }
  if ( $l.db(cregserv\canales\ $+ $r.c($d(5)),datos,fundador) != $r.c($o) ) && ( $s.n($o) < 5 ) { m Debes de ser el fundador del canal para ejecutar este comando. | l.v }
  s : $+ $cregserv MODE $d(5) +o $o
  m Has sido opeado en el canal12 $d(5) $+ .
  l.v
}

alias cregserv.apoyos {
  if ( $d(5) == $null ) { m Error de Sintaxis: 12APOYOS <canal/nick> | m 12/msg $cregserv AYUDA APOYOS para más información. | l.v }
  if ( $n.i($o) == no ) { m Debes identificarte antes de utilizar el comando 12APOYOS. | l.v }
  if ( $mid($d(5),1,1) == $chr(35) ) {
    if ( $exists($mircdirdatabase\cregserv\canales\ $+ $r.c($d(5))) == $false ) { m El canal12 $d(5) no está registrado | l.v }
    if ( $l.db(cregserv\canales\ $+ $r.c($d(5)),datos,fundador) != $r.c($o) ) && ( $s.n($o) < 5 ) { m 4Permiso denegado. | l.v }
    %tmp.linea = 0
    m Lista de apoyos de12 $d(5) $+ :
    flushini $mircdirdatabase\cregserv\canales\ $+ $r.c($d(5))
    %tmp.ruta = $mircdirdatabase\cregserv\canales\ $+ $r.c($d(5))
    if ( $initopic( %tmp.ruta , apoyos ) == 0 ) { goto f.lac }
    clear @apoyosc
    window -hl @apoyosc
    loadbuf -tapoyos @apoyosc $mircdirdatabase\cregserv\canales\ $+ $r.c($d(5))
    %tmp.total = $line(@apoyosc,0)
    while ( %tmp.linea < %tmp.total ) {
      inc %tmp.linea
      %tmp.l.linea = $line( @apoyosc , %tmp.linea )
      %tmp.nick = $r.c($gettok(%tmp.l.linea,1,61))
      if ( $s.n($o) >= 5 ) {
        %tmp.datos = $gettok(%tmp.l.linea,2,61)
        %tmp.email = $gettok(%tmp.datos,1,32)
        %tmp.ip = $gettok(%tmp.datos,2,32)
        m 12 $+ %tmp.nick ( $+ %tmp.email $+ ) - IP:12 %tmp.ip
      }
      else { m 12 $+ %tmp.nick }
    }
    :f.lac
    m Actualmente12 %tmp.linea apoyos.
    l.v
  }
  else {
    if ( $n.r($d(5)) == no ) { m El nick12 $d(5) no está registrado | l.v }
    if ( $o != $d(5) ) && ( $s.n($o) < 5 ) { m 4Permiso denegado. | l.v }
    m Lista de apoyos de12 $d(5) $+ :
    if ( $exists($mircdirdatabase\cregserv\nicks\ $+ $r.c($d(5))) == $false ) { goto f.lan }
    flushini $mircdirdatabase\cregserv\nicks\ $+ $r.c($d(5))
    %tmp.ruta = $mircdirdatabase\cregserv\nicks\ $+ $r.c($d(5))
    if ( $initopic( %tmp.ruta , apoyos ) == 0 ) { goto f.lan }
    clear @apoyosn
    window -hls @apoyosn
    loadbuf -tapoyos @apoyosn $mircdirdatabase\cregserv\nicks\ $+ $r.c($d(5))
    %tmp.total = $line(@apoyosn,0)
    %tmp.linea = 0
    while ( %tmp.linea < %tmp.total ) {
      inc %tmp.linea
      %tmp.l.linea = $line( @apoyosn , %tmp.linea )
      %tmp.canal = $gettok(%tmp.l.linea,1,61)
      %tmp.datos = $gettok(%tmp.l.linea,2,61)
      m -12 $r.c(%tmp.canal) ( $+ %tmp.datos $+ )
    }
    :f.lan
    m Fin de la información de los apoyos de12 $d(5) $+ .
    l.v
  }
}

alias cregserv.info {
  if ( $d(5) == $null ) { m Error de Sintaxis: 12INFO <canal> | l.v }
  if ( $exists($mircdirdatabase\cregserv\canales\ $+ $r.c($d(5))) == $false ) { m El canal12 $d(5) no está registrado | l.v }
  %tmp.fundador = $r.c($l.db(cregserv\canales\ $+ $r.c($d(5)),datos,fundador))
  %tmp.mailr = $l.db(cregserv\canales\ $+ $r.c($d(5)),datos,fundadorm)
  %tmp.ip = $l.db(cregserv\canales\ $+ $r.c($d(5)),datos,mask)
  %tmp.fecha = $l.db(cregserv\canales\ $+ $r.c($d(5)),datos,fecha)
  %tmp.estado = $l.db(cregserv\canales\ $+ $r.c($d(5)),datos,estado)
  %tmp.desc = $l.db(cregserv\canales\ $+ $r.c($d(5)),datos,desc)
  m Información del canal12 $d(5) $+ :
  m Fundador:12 $r.c(%tmp.fundador) ( $+ %tmp.mailr $+ ) - IP:12 %tmp.ip
  m Fecha petición:12 $f(%tmp.fecha)
  m Estado:12 %tmp.estado
  if ( $l.db(cregserv\canales\ $+ $r.c($d(5)),datos,ultc) != $null ) {
    %tmp.origen = $l.db(cregserv\canales\ $+ $r.c($d(5)),datos,ultc)
    %tmp.fecha = $l.db(cregserv\canales\ $+ $r.c($d(5)),datos,ultcf)
    m Ultimo cambio por:12 $r.c(%tmp.origen)
    m Fecha cambio:12 $f(%tmp.fecha)
  }
  m Descripción:12 $p.c(%tmp.desc)
  m Apoyos:
  flushini $mircdirdatabase\cregserv\canales\ $+ $r.c($d(5))
  %tmp.ruta = $mircdirdatabase\cregserv\canales\ $+ $r.c($d(5))
  if ( $initopic( %tmp.ruta , apoyos ) == 0 ) { goto f.lac }
  clear @iapoyosc
  window -hl @iapoyosc
  loadbuf -tapoyos @iapoyosc $mircdirdatabase\cregserv\canales\ $+ $r.c($d(5))
  %tmp.total = $line(@iapoyosc,0)
  %tmp.linea = 0
  while ( %tmp.linea < %tmp.total ) {
    inc %tmp.linea
    %tmp.l.linea = $line( @iapoyosc , %tmp.linea )
    %tmp.nick = $r.c($gettok(%tmp.l.linea,1,61))
    %tmp.datos = $gettok(%tmp.l.linea,2,61)
    %tmp.email = $gettok(%tmp.datos,1,32)
    %tmp.ip = $gettok(%tmp.datos,2,32)
    m 12 $+ %tmp.nick ( $+ %tmp.email $+ ) - IP:12 %tmp.ip
  }
  :f.lac
  if ( $l.db(cregserv\canales\ $+ $r.c($d(5)),marcas,total) != $null ) {
    %tmp.marcas = $l.db(cregserv\canales\ $+ $r.c($d(5)),marcas,total)
    %tmp.marca = 0
    m
    m Marcas de12 $d(5) $+ :
    while ( %tmp.marca < %tmp.marcas ) {
      inc %tmp.marca
      %tmp.marcat = $l.db(cregserv\canales\ $+ $r.c($d(5)),marcas,%tmp.marca)
      %tmp.marcaf = $gettok(%tmp.marcat,1,32)
      %tmp.marcan = $gettok(%tmp.marcat,2,32)
      %tmp.marcad = $gettok(%tmp.marcat,3-,32)
      m %tmp.marca $chr(91) $+ $f(%tmp.marcaf) $+ $chr(93) - (12 $+ $r.c(%tmp.marcan) $+ ) -> $p.c(%tmp.marcad)
    }
    m Fin de la lista 3( $+ %tmp.marcas marcas)
  }
  m Fin de la información de12 $d(5) $+ .
  l.v
}

alias cregserv.lista {
  %tmp.tcanales = $findfile($mircdirdatabase\cregserv\canales\,*,0)
  %tmp.c = 0
  if ( %tmp.tcanales == 0 ) { m Lista vacia. }
  else {
    m Listado de canales:
    :o.c
    inc %tmp.c
    %tmp.canal = $nopath($findfile($mircdirdatabase\cregserv\canales\,*,%tmp.c))
    if ( $l.db(cregserv\canales\ $+ %tmp.canal,datos,estado) != ACEPTADO ) {
      %tmp.estado = $l.db(cregserv\canales\ $+ %tmp.canal,datos,estado)
      m 12 $+ $r.c(%tmp.canal) - ( $+ %tmp.estado $+ )
    }
    if ( %tmp.c == %tmp.tcanales ) { goto f.lc }
    goto o.c
    :f.lc
    m Fin de la lista de canales.
  }
  l.v
}

alias cregserv.marca {
  if ( $d(5) == ADD ) {
    if ( $d(7) == $null ) { m Error de Sintaxis: 12MARCA ADD <canal> <texto> | l.v }
    if ( $exists($mircdirdatabase\cregserv\canales\ $+ $r.c($d(6))) == $false ) { m El canal12 $d(6) no está registrado | l.v }
    %tmp.marcas = $l.db(cregserv\canales\ $+ $r.c($d(6)),marcas,total)
    inc %tmp.marcas
    g.db cregserv\canales\ $+ $r.c($d(6)) marcas total %tmp.marcas
    g.db cregserv\canales\ $+ $r.c($d(6)) marcas %tmp.marcas $ctime $r.c($o) $q.c($d(7-))
    m Añadida marca al canal12 $d(6) $+ .
    debugc $cregserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o añade una marca al canal12 $d(6) $+ . Motivo:12 $d(7-)
    l.v
  }
  if ( $d(5) == DEL ) {
    if ( $d(7) == $null ) { m Error de Sintaxis: 12MARCA DEL <canal> <numero> | l.v }
    if ( $exists($mircdirdatabase\cregserv\canales\ $+ $r.c($d(6))) == $false ) { m El canal12 $d(6) no está registrado | l.v }
    if ( $d(7) !isnum ) { m La marca debe de ser un numero. | l.v }
    if ( $l.db(cregserv\canales\ $+ $r.c($d(6)),marcas,$d(7)) == $null ) { m La marca12 $d(7) no existe. | l.v }
    %tmp.marcas = $l.db(cregserv\canales\ $+ $r.c($d(6)),marcas,total)
    dec %tmp.marcas
    b.db cregserv\canales\ $+ $r.c($d(6)) marcas $d(7)
    g.db cregserv\canales\ $+ $r.c($d(6)) marcas total %tmp.marcas
    m La marca12 $d(7) ha sido borrada.
    if ( %tmp.marcas == 0 ) { b.db cregserv\canales\ $+ $r.c($d(6)) marcas | goto f.om }
    %tmp.marca = $d(7)
    :o.m
    inc %tmp.marca
    if ( $l.db(cregserv\canales\ $+ $r.c($d(6)),marcas,%tmp.marca) == $null ) { goto f.om }
    %tmp.marcag = $l.db(cregserv\canales\ $+ $r.c($d(6)),marcas,%tmp.marca)
    g.db cregserv\canales\ $+ $r.c($d(6)) marcas $calc(%tmp.marca -1) %tmp.marcag
    b.db cregserv\canales\ $+ $r.c($d(6)) marcas %tmp.marca
    goto o.m
    :f.om
    l.v
  }
  m Sintaxis: 12MARCA $chr(123) $+ ADD $chr(124) DEL $+ $chr(125) <canal> <nº/texto>
  l.v
}

alias cregserv.acepta {
  if ( $d(5) == $null ) { m Error de Sintaxis: 12ACEPTA <canal> | l.v }
  if ( $l.db(representantes.db,acreg,$r.c($o)) == $null ) && ( $s.n($o) < 6 ) { m 4Permiso denegado. | l.v }
  if ( $ca.r($d(5)) == si ) { m El canal12 $d(5) ya está registrado. | l.v }
  if ( $exists($mircdirdatabase\cregserv\canales\ $+ $r.c($d(5))) == $false ) { m El canal12 $d(5) no está registrado | l.v }
  if ( $d(6) == FORCE ) {
    %tmp.fundador = $l.db(cregserv\canales\ $+ $r.c($d(5)),datos,fundador)
    %tmp.password = $l.db(cregserv\canales\ $+ $r.c($d(5)),datos,password)
    %tmp.desc = $l.db(cregserv\canales\ $+ $r.c($d(5)),datos,desc)
    cregserv.registrac $d(5) $r.c(%tmp.fundador) %tmp.password ACTIVO $p.c(%tmp.desc)
    g.db cregserv\canales\ $+ $r.c($d(5)) datos estado ACEPTADO
    g.db cregserv\canales\ $+ $r.c($d(5)) datos ultc $r.c($o)
    g.db cregserv\canales\ $+ $r.c($d(5)) datos ultcf $ctime
    b.db nickserv\ $+ $r.c(%tmp.fundador) configuracion enregistro
    memoserv.envia %tmp.fundador $cregserv Tu canal12 $d(5) ha sido3 ACEPTADO: Recuerda que si el canal incumple alguna norma de la red sera borrado AUTOMATICAMENTE y sin previo aviso.
    m El canal12 $d(5) ha sido registrado.
    debugc $cregserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o fuerza el registro del canal12 $d(5) (Fundador:12 %tmp.fundador $+ )
    l.v
  }
  if ( $l.db(cregserv\canales\ $+ $r.c($d(5)),datos,estado) == ENREGISTRO ) { m El canal12 $d(5) está pendiente de apoyos para el registro. | m Si deseas forzar el registro teclea 12/msg $cregserv ACEPTA $d(5) FORCE | l.v }
  if ( $l.db(cregserv\canales\ $+ $r.c($d(5)),datos,estado) != PENDIENTE ) { m El canal12 $d(5) no está pendiente de la aprobación del registro. | l.v }
  %tmp.fundador = $l.db(cregserv\canales\ $+ $r.c($d(5)),datos,fundador)
  %tmp.password = $l.db(cregserv\canales\ $+ $r.c($d(5)),datos,password)
  %tmp.desc = $l.db(cregserv\canales\ $+ $r.c($d(5)),datos,desc)
  cregserv.registrac $d(5) $r.c(%tmp.fundador) %tmp.password ACTIVO $p.c(%tmp.desc)
  g.db cregserv\canales\ $+ $r.c($d(5)) datos estado ACEPTADO
  g.db cregserv\canales\ $+ $r.c($d(5)) datos ultc $r.c($o)
  g.db cregserv\canales\ $+ $r.c($d(5)) datos ultcf $ctime
  memoserv.envia %tmp.fundador $cregserv Tu canal12 $d(5) ha sido3 ACEPTADO: Recuerda que si el canal incumple alguna norma de la red sera borrado AUTOMATICAMENTE y sin previo aviso.
  m El canal12 $d(5) ha sido registrado.
  debugc $cregserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o acepta el registro del canal12 $d(5) (Fundador:12 %tmp.fundador $+ )
  l.v
}

alias cregserv.deniega {
  if ( $d(6) == $null ) { m Error de Sintaxis: 12DENIEGA <canal> <motivo> | l.v }
  if ( $l.db(representantes.db,acreg,$r.c($o)) == $null ) && ( $s.n($o) < 6 ) { m 4Permiso denegado. | l.v }
  if ( $l.db(cregserv\canales\ $+ $r.c($d(5)),datos,estado) != PENDIENTE ) { m El canal12 $d(5) no está pendiente de la aprobación del registro. | l.v }
  %tmp.fundador = $l.db(cregserv\canales\ $+ $r.c($d(5)),datos,fundador)
  g.db cregserv\canales\ $+ $r.c($d(5)) datos estado DENEGADO
  g.db cregserv\canales\ $+ $r.c($d(5)) datos motivo $q.c($d(6-))
  g.db cregserv\canales\ $+ $r.c($d(5)) datos ultc $r.c($o)
  g.db cregserv\canales\ $+ $r.c($d(5)) datos ultcf $ctime
  b.db nickserv\ $+ %tmp.fundador configuracion enregistro
  b.db nickserv\ $+ %tmp.fundador configuracion cregr
  memoserv.envia %tmp.fundador $cregserv Tu canal12 $d(5) ha sido4 DENEGADO: $d(6-)
  m El canal12 $d(5) ha sido denegado.
  debugc $cregserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o deniega el registro del canal12 $d(5) ( $+ $d(6-) $+ )
  l.v
}

alias cregserv.libera {
  if ( $d(5) == $null ) { m Error de Sintaxis: 12LIBERA <canal> | l.v }
  if ( $l.db(representantes.db,acreg,$r.c($o)) == $null ) && ( $s.n($o) < 6 ) { m 4Permiso denegado. | l.v }
  if ( $l.db(cregserv\canales\ $+ $r.c($d(5)),datos,estado) != DENEGADO ) { m El canal12 $d(5) no está denegado. | l.v }
  .remove $mircdirdatabase\cregserv\canales\ $+ $r.c($d(5))
  m El canal12 $d(5) ha sido liberado
  debugc $cregserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o libera el canal12 $d(5)
  l.v
}

alias cregserv.reset {
  if ( $d(5) == $null ) { m Error de Sintaxis: 12RESET <canal> | l.v }
  if ( $l.db(representantes.db,acreg,$r.c($o)) == $null ) && ( $s.n($o) < 6 ) { m 4Permiso denegado. | l.v }
  if ( $ca.r($d(5)) == no ) { m El canal12 $d(5) no está registrado. | l.v }
  %tmp.fundador = $l.db(cregserv\canales\ $+ $r.c($d(5)),datos,fundador)
  %tmp.password = $l.db(cregserv\canales\ $+ $r.c($d(5)),datos,password)
  %tmp.estado = $l.db(cregserv\canales\ $+ $r.c($d(5)),estado,$d(5))
  %tmp.desc = $l.db(cregserv\canales\ $+ $r.c($d(5)),datos,desc)
  chanserv.dropc $d(5)
  cregserv.registrac $d(5) $r.c(%tmp.fundador) %tmp.password %tmp.estado $p.c(%tmp.desc)
  m El canal12 $d(5) reseteado.
  debugc $cregserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o resetea el canal12 $d(5)
  l.v
}

alias cregserv.admin {
  if ( $d(5) == ADD ) {
    if ( $d(6) == $null ) { m Error de Sintaxis: 12ADMIN ADD <nick> | l.v }
    if ( $n.r($d(6)) == no ) { m El nick12 $d(6) no está registrado. | l.v }
    if ( $l.db(nickserv\ $+ $r.c($d(6)),representante,tipo) == $null ) { m 12 $+ $d(6) no es un representante de la red. | l.v }
    if ( $l.db(representantes.db,acreg,$r.c($d(6))) != $null ) { m 12 $+ $d(6) ya es un Administrador de $cregserv $+ . | l.v }
    g.db representantes.db acreg $r.c($d(6)) *
    m 12 $+ $d(6) añadido como Administrador de $cregserv $+ .
    debugc $cregserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o añade como Administrador de $cregserv a12 $d(6) $+ .
    l.v
  }
  if ( $d(5) == DEL ) {
    if ( $d(6) == $null ) { m Error de Sintaxis: 12ADMIN DEL <nick> | l.v }
    if ( $l.db(representantes.db,acreg,$r.c($d(6))) == $null ) { m 12 $+ $d(6) no es un Administrador de $cregserv $+ . | l.v }
    b.db representantes.db acreg $r.c($d(6))
    m 12 $+ $d(6) borrado de Administrador de $cregserv $+ .
    debugc $cregserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o borra de Administrador de $cregserv a12 $d(6) $+ .
    l.v
  }
  if ( $d(5) == LIST ) {
    flushini $mircdirdatabase\representantes.db
    %tmp.ruta = $mircdirdatabase\representantes.db
    if ( $initopic( %tmp.ruta , acreg ) == 0 ) { m Lista vacia. }
    else {
      m Listado de Administradores de $cregserv
      clear @acreg
      window -hl @acreg
      loadbuf -tacreg @acreg $mircdirdatabase\representantes.db
      %tmp.total = $line(@acreg,0)
      %tmp.linea = 0
      while ( %tmp.linea < %tmp.total ) {
        inc %tmp.linea
        %tmp.l.linea = $line( @acreg , %tmp.linea )
        %tmp.nadmin = $gettok(%tmp.l.linea,1,61)
        m $r.c(%tmp.nadmin) $e(%tmp.nadmin)
      }
      :f.a
      m Fin de la lista.
    }
    l.v
  }
  m Error de Sintaxis: 12ADMIN $chr(123) $+ ADD $chr(124) DEL $chr(124) LIST $+ $chr(125)
  l.v
}

alias cregserv.oficial {
  if ( $d(7) == $null ) { m Error de Sintaxis: 12OFICIAL <canal> <contraseña> <descripción> | l.v }
  if ( $ca.r($d(5)) == si ) { m El canal12 $d(5) ya está registrado. | l.v }
  if ( $l.db(canalesp.db,forbid,$r.c($d(5))) != $null ) { m El canal12 $d(5) no puede ser registrado. | m Escribe 12/msg $cregserv ESTADO $d(5) para más información. | l.v }
  %tmp.cnv = $chr(44) $+ $chr(58) $+ $chr(131) $+ $chr(165) $+ $chr(177) $+ $chr(188) $+ $chr(189) $+ $chr(198) $+ $chr(216) $+ $chr(222) $+ $chr(229) $+ $chr(230) $+ $chr(248)
  %tmp.c = 0
  while ( %tmp.c < $len(%tmp.cnv) ) {
    inc %tmp.c
    if ( $mid(%tmp.cnv,%tmp.c,1) isin $d(5) ) { m El caracter12 $mid(%tmp.cnv,%tmp.c,1) no es válido en el registro de canales. | l.v }
  }
  %tmp.mask = $l.db(usuarios.db,usuarios,$r.c($o))
  %tmp.ident = $gettok(%tmp.mask,1,32)
  %tmp.host = $gettok(%tmp.mask,2,32)
  %tmp.emailr = $l.db(nickserv\ $+ $r.c($o),configuracion,emailreg)
  g.db cregserv\canales\ $+ $r.c($d(5)) datos fundador $r.c($o)
  g.db cregserv\canales\ $+ $r.c($d(5)) datos fundadorm %tmp.emailr
  g.db cregserv\canales\ $+ $r.c($d(5)) datos mask %tmp.ident $+ $chr(64) $+ %tmp.host
  g.db cregserv\canales\ $+ $r.c($d(5)) datos fecha $ctime
  g.db cregserv\canales\ $+ $r.c($d(5)) datos estado ACEPTADO
  g.db cregserv\canales\ $+ $r.c($d(5)) datos password $d(6)
  g.db cregserv\canales\ $+ $r.c($d(5)) datos desc $q.c($d(7-))
  g.db cregserv\canales\ $+ $r.c($d(5)) datos apoyos 0
  g.db cregserv\canales\ $+ $r.c($d(5)) datos ultc $r.c($o)
  g.db cregserv\canales\ $+ $r.c($d(5)) datos ultcf $ctime
  g.db cregserv\nicks\ $+ ñ apoyos $r.c($d(5)) Fundador - $f($ctime)
  cregserv.registrac $d(5) $o $d(6) OFICIAL $d(7-)
  m El canal12 $d(5) ha sido registrado como oficial.
  debugc $cregserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o registra el canal12 $d(5) como oficial.
  l.v
}

alias cregserv.comercial {
  if ( $d(8) == $null ) { m Error de Sintaxis: 12COMERCIAL <canal> <fundador> <contraseña> <descripción> | l.v }
  if ( $ca.r($d(5)) == si ) { m El canal12 $d(5) ya está registrado. | l.v }
  if ( $n.r($d(6)) == no ) { m El nick12 $d(6) no está registrado. | l.v }
  if ( $l.db(canalesp.db,forbid,$r.c($d(5))) != $null ) { m El canal12 $d(5) no puede ser registrado. | m Escribe 12/msg $cregserv ESTADO $d(5) para más información. | l.v }
  %tmp.cnv = $chr(44) $+ $chr(58) $+ $chr(131) $+ $chr(165) $+ $chr(177) $+ $chr(188) $+ $chr(189) $+ $chr(198) $+ $chr(216) $+ $chr(222) $+ $chr(229) $+ $chr(230) $+ $chr(248)
  %tmp.c = 0
  while ( %tmp.c < $len(%tmp.cnv) ) {
    inc %tmp.c
    if ( $mid(%tmp.cnv,%tmp.c,1) isin $d(5) ) { m El caracter12 $mid(%tmp.cnv,%tmp.c,1) no es válido en el registro de canales. | l.v }
  }
  %tmp.mask = $l.db(nickserv\ $+ $r.c($d(6)),configuracion,umask)
  %tmp.emailr = $l.db(nickserv\ $+ $r.c($d(6)),configuracion,emailreg)
  g.db cregserv\canales\ $+ $r.c($d(5)) datos fundador $r.c($d(6))
  g.db cregserv\canales\ $+ $r.c($d(5)) datos fundadorm %tmp.emailr
  g.db cregserv\canales\ $+ $r.c($d(5)) datos mask %tmp.mask
  g.db cregserv\canales\ $+ $r.c($d(5)) datos fecha $ctime
  g.db cregserv\canales\ $+ $r.c($d(5)) datos estado ACEPTADO
  g.db cregserv\canales\ $+ $r.c($d(5)) datos password $d(7)
  g.db cregserv\canales\ $+ $r.c($d(5)) datos desc $q.c($d(8-))
  g.db cregserv\canales\ $+ $r.c($d(5)) datos apoyos 0
  g.db cregserv\canales\ $+ $r.c($d(5)) datos ultc $r.c($o)
  g.db cregserv\canales\ $+ $r.c($d(5)) datos ultcf $ctime
  g.db cregserv\nicks\ $+ $r.c($d(6)) apoyos $r.c($d(5)) Fundador - $f($ctime)
  cregserv.registrac $d(5) $d(6) $d(7) COMERCIAL $d(8-)
  m El canal12 $d(5) ha sido registrado como comercial.
  debugc $cregserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o registra el canal12 $d(5) como comercial (Fundador: $d(6) $+ )
  l.v
}

----------------

alias cregserv.registra2 {
  %tmp.mask = $l.db(usuarios.db,usuarios,$r.c($2))
  %tmp.ident = $gettok(%tmp.mask,1,32)
  %tmp.host = $gettok(%tmp.mask,2,32)
  %tmp.emailr = $l.db(nickserv\ $+ $r.c($2),configuracion,emailreg)
  g.db cregserv\canales\ $+ $r.c($1) datos fundador $2
  g.db cregserv\canales\ $+ $r.c($1) datos fundadorm %tmp.emailr
  g.db cregserv\canales\ $+ $r.c($1) datos mask %tmp.ident $+ $chr(64) $+ %tmp.host
  g.db cregserv\canales\ $+ $r.c($1) datos fecha $ctime
  g.db cregserv\canales\ $+ $r.c($1) datos estado ENREGISTRO
  g.db cregserv\canales\ $+ $r.c($1) datos password $3
  g.db cregserv\canales\ $+ $r.c($1) datos desc $q.c($4-)
  g.db cregserv\canales\ $+ $r.c($1) datos apoyos 0
  g.db cregserv\nicks\ $+ $r.c($2) apoyos $r.c($1) Fundador - $f($ctime)
  g.db nickserv\ $+ $r.c($2) configuracion enregistro $1
  s : $+ $cregserv %conf.metodo $2 : $+ El canal12 $1 ha sido aceptado para el registro.
  if ( $l.conf(cregserv,apoyos) >= 1 ) { m En los proximos siete días necesitará12 $l.conf(cregserv,apoyos) apoyos para que sea registrado. }
  else { s : $+ $cregserv %conf.metodo $2 : $+ El canal está a la espera de aprobación del registro por la administración. }
  if ( $l.conf(cregserv,ardia) == on ) {
    g.db nickserv\ $+ $r.c($2) configuracion cregr $calc($ctime + 86400)
  }
  debugc $cregserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $2 pone en proceso de registro el canal12 $1 $+ .
  if ( $l.conf(cregserv,apoyos) <= 0 ) {
    g.db cregserv\canales\ $+ $r.c($1) datos estado PENDIENTE
    b.db nickserv\ $+ $r.c($2) configuracion enregistro
    debugc $cregserv %conf.canal.admins $+ , $+ %conf.canal.opers El canal12 $1 está a la espera de aprobación del registro.
  }
  unset %creg.registra.e- [ $+ [ $1 ] ]
  unset %creg.registra.i- [ $+ [ $1 ] ]
  unset %creg.registra.op- [ $+ [ $1 ] ]
  l.v
}

alias cregserv.registrac {
  g.db chanserv\ $+ $r.c($1) estado $1 $4
  g.db chanserv\ $+ $r.c($1) configuracion fundador $r.c($2)
  g.db chanserv\ $+ $r.c($1) configuracion password $3
  g.db chanserv\ $+ $r.c($1) configuracion desc $q.c($5-)
  g.db chanserv\ $+ $r.c($1) configuracion horareg $ctime
  g.db chanserv\ $+ $r.c($1) configuracion ultuso $ctime
  g.db chanserv\ $+ $r.c($1) configuracion entrymsg $iif($4 == OFICIAL,$q.c(Canal Oficial de la Red %conf.red),$q.c($l.conf(cregserv,entrymsgd)))
  g.db chanserv\ $+ $r.c($1) configuracion keeptopic on
  g.db chanserv\ $+ $r.c($1) configuracion secure on
  g.db chanserv\ $+ $r.c($1) configuracion debug on
  g.db chanserv\ $+ $r.c($1) configuracion mlock +nt
  if ( $4 == OFICIAL ) || ( $4 == COMERCIAL ) { g.db chanserv\ $+ $r.c($1) configuracion noexpire on }
  g.db chanserv\ $+ $r.c($1) niveles autoop 300
  g.db chanserv\ $+ $r.c($1) niveles autohalfop 200
  g.db chanserv\ $+ $r.c($1) niveles autovoice 100
  g.db chanserv\ $+ $r.c($1) niveles autodeop -1
  g.db chanserv\ $+ $r.c($1) niveles nojoin -1
  g.db chanserv\ $+ $r.c($1) niveles invite 300
  g.db chanserv\ $+ $r.c($1) niveles opdeop 300
  g.db chanserv\ $+ $r.c($1) niveles halfopdehalfop 200
  g.db chanserv\ $+ $r.c($1) niveles voicedevoice 100
  g.db chanserv\ $+ $r.c($1) niveles kick 400
  g.db chanserv\ $+ $r.c($1) niveles unban 300
  g.db chanserv\ $+ $r.c($1) niveles akick 450
  g.db chanserv\ $+ $r.c($1) niveles set DIS
  g.db chanserv\ $+ $r.c($1) niveles clear DIS
  g.db chanserv\ $+ $r.c($1) niveles set DIS
  g.db chanserv\ $+ $r.c($1) niveles acc-list 0
  g.db chanserv\ $+ $r.c($1) niveles acc-change 450
  g.db chanserv\ $+ $r.c($1) niveles memo 450
  g.db chanserv\ $+ $r.c($1) niveles juegos 300
  g.db chanserv\ $+ $r.c($1) stats total.memos 0
  g.db chanserv\ $+ $r.c($1) stats total.memos.nuevos 0
  g.db nickserv\ $+ $2 fundador $r.c($1) Fundador
  %tmp.tnf = $l.db(nickserv\ $+ $2,stats,fundador.c)
  inc %tmp.tnf
  g.db nickserv\ $+ $2 stats fundador.c %tmp.tnf
  j $cregserv $1
  s : $+ $chanserv MODE $1 +o $cregserv
  a.t C:: $+ $1 $+ ::F $r.c($2)
  a.t C:: $+ $1 $+ ::M +nt
  a.t C:: $+ $1 $+ ::P $md5($3)
  %tipo.who = SINCRONIZAC
  s : $+ $chanserv WHO $1
  p $cregserv $1
  if ( $4 == OFICIAL ) { j $helpserv $1 }
}
