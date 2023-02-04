on 1:sockread:dbots: {
  if ( $d(2) == PRIVMSG ) || ( $d(2) == NOTICE ) && (( $d(3) == $centerserv ) || ( $d(3) == $centerserv $+ @ $+ %conf.servidor )) { p.m $centerserv | c.r CA | centerserv.procesa }
  if ( $d(2) == MODE ) && ( + isin $d(4) ) && ( o isincs $d(4) ) && ( $chr(35) !isin $d(3) ) && ( $l.db(bots.db,bots,$r.c($o)) == $null ) { debugc $centerserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o es ahora un 12IRCop. | g.db representantes.db ircops $r.c($o) IRCop }
  if ( $d(2) == DB) {
    if ( $gettok(%datos,4,32) == INS) && (%OPT) && (%opt.all == $null) {
      set %OPT.u $calc($d(5) + $calc($len($d(6-)) -2))
    }
    if ( $gettok(%datos,4,32) == FDR) && (%opt.all == $null) && (%OPT.n) {
      var %a = $l.db(tablas.db,tablas,$d(5))
      g.db tablas.db tablas $d(5) %OPT.u
      debugc $centerserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ %OPT.n optimiza la tabla12 $d(5) $+ , ahorrados12 $calc(%a - %OPT.u) bytes.
      s : $+ $centerserv %conf.metodo %OPT.n :Optimizada la tabla12 $d(5) $+ , ahorrados12 $calc(%a - %OPT.u) bytes.
      unset %OPT.u %OPT %OPT.n
    }
  }
}

alias centerserv.procesa {
  if ( $d(4) == AYUDA ) || ( $d(4) == HELP ) { centerserv.ayuda }
  if ( $d(4) == CLONES ) { centerserv.clones }
  if ( $d(4) == KILL ) { centerserv.kill }
  if ( $d(4) == GLINE ) { centerserv.gline }
  if ( $d(4) == PREOPER ) { centerserv.preoper }
  if ( $d(4) == KLINE ) { c.r A | centerserv.kline }
  if ( $d(4) == OPER ) { c.r A | centerserv.oper }
  if ( $d(4) == REGENERAR ) { c.r A | centerserv.regenerar }
  if ( $d(4) == UPDATE ) { c.r A | centerserv.update }
  if ( $d(4) == RESTART ) { c.r A | centerserv.restart }
  if ( $d(4) == SAJOIN ) { c.r A | centerserv.sajoin }
  if ( $d(4) == SAPART ) { c.r A | centerserv.sapart }
  if ( $d(4) == dclones) { c.r R | centerserv.dclones }
  if ( $d(4) == RAW ) { c.r R | centerserv.raw }
  if ( $d(4) == COADMIN ) { c.r R | centerserv.coadmin }
  if ( $d(4) == ADMIN ) { c.r R | centerserv.admin }
  if ( $d(4) == ROOT ) { c.r R | centerserv.root }
  if ( $d(4) == BOT ) { c.r R | centerserv.bot }
  if ( $d(4) == TABLA ) { c.r R | centerserv.tabla }
  if ( $d(4) == OPTIMIZA ) { c.r R | centerserv.optimiza }
  if ( $d(4) == QUIT ) { c.r R | centerserv.quit }
  if ( $d(4) == DEBUGC ) { c.r R | centerserv.debugc }
  if ( $d(4) == backup) { c.r R | centerserv.backup }
  if ( $d(4) == actualiza) { c.r R | centerserv.actualiza }
  if ( $d(4) == MODULO ) { c.r R | centerserv.modulo }
  if ( $d(4) == REMOPER) { c.r R | centerserv.remoper }
  if ( $d(4) == FSNOMASK) { c.r R | centerserv.fsnomask }
  if ( $d(4) == noraw) { c.r R | centerserv.noraw }
  if ( $d(4) == FMODE) { c.r R | centerserv.fmode }
  if ( $d(4) == WMODULO) { c.r R | centerserv.wmodulo }
  m Comando desconocido12 $strip($d(4)) $+ . "12/msg $centerserv AYUDA" para ayuda.
  l.v
}

---------------

alias centerserv.ayuda {
  if ($d(5)) { m.h $centerserv $o helps\ce.help $replace($d(5-),$chr(32),-) }
  else {
    m.h $centerserv $o helps\ce.help help-ca
    if ( $s.n($o) >= 7 ) { m.h $centerserv $o helps\ce.help help-a }
    if ( $s.n($o) >= 8 ) { m.h $centerserv $o helps\ce.help help-r }
    if ( $s.n($o) >= 7 ) { m.h $centerserv $o helps\ce.help help-f }
  }
  l.v
}

---------------------

alias centerserv.clones {
  if ( $d(5) == ADD ) {
    if ( $d(6) == $null ) || ( $d(7) == $null ) { m Error de Sintaxis: 12CLONES ADD <host> <clones> | l.v }
    if ( $l.db(ips.db,clones,$d(6)) != $null ) { m La ip12 $d(6) ya tiene clones asignados. | l.v }
    g.db ips.db clones $d(6) $d(7)
    a.t I:: $+ $d(6) $+ ::S * $+ $d(7)
    m Añadido12 $d(7) clones a la ip12 $d(6) $+ .
    debugc $centerserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o añade12 $d(7) clones a la ip12 $d(6) $+ .
    l.v
  }
  if ( $d(5) == DEL ) {
    if ( $d(6) == $null ) { m Error de Sintaxis: 12CLONES DEL <host> | l.v }
    if ( $l.db(ips.db,clones,$d(6)) == $null ) { m La ip12 $d(6) no tiene clones asignados. | l.v }
    b.db ips.db clones $d(6)
    a.t I:: $+ $d(6) $+ ::S
    m Borrados los clones asignados a la ip12 $d(6) $+ .
    debugc $centerserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o borra los clones asignados a la ip12 $d(6) $+ .
    l.v
  }
  if ( $d(5) == LIST ) {
    flushini $mircdirdatabase\ips.db
    %tmp.ruta = $mircdirdatabase\ips.db
    if ( $ini( %tmp.ruta , clones , 0) == 0 ) {
      m Lista vacia.
    }
    else {
      m Listado de Clones:
      clear @clones
      window -hl @clones
      loadbuf -tclones @clones $mircdirdatabase\ips.db
      %tmp.total = $line(@clones,0)
      %tmp.linea = 0
      while ( %tmp.linea < %tmp.total ) {
        inc %tmp.linea
        %tmp.l.linea = $line( @clones , %tmp.linea )
        %tmp.dforbid = $gettok(%tmp.l.linea,2-,61)
        m IP:12 $gettok(%tmp.l.linea,1,61) - Clones:12 $gettok(%tmp.l.linea,2-,61)
      }
      :f.i
      m Fin de la lista.
    }
    l.v
  }
  m Error de Sintaxis: 12CLONES $chr(123) $+ ADD $chr(124) DEL $chr(124) LIST $+ $chr(125)
  l.v
}

alias centerserv.kill {
  if ( $d(5) == $null ) || ( $d(6) == $null ) { m Error de Sintaxis: 12KILL <nick> <motivo>  | l.v }
  if ( $n.c($d(5)) == no ) { m El nick12 $d(5) no está conectado. | l.v }
  if ( $s.n($o) <= $s.n($d(5)) ) { m 4Permiso denegado. | l.v }
  k $o $d(5) $d(6-)
  m El usuario12 $d(5) ha sido expulsado.
  debugc $centerserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o utiliza KILL sobre12 $d(5) $+ . Motivo:12 $d(6-)
  l.v
}

alias centerserv.gline {
  if ( $d(5) == ADD ) {
    if ( $d(8) == $null ) { m Error de Sintaxis: 12GLINE ADD <+expiración> <host> <motivo> | l.v }
    %tmp.expiracion = $check.exp($remove( $d(6) , +))
    if ( %tmp.expiracion < 0) { m El tiempo expecificado no es válido. | l.v }
    if ( %tmp.expiracion != 0) && (%tmp.expiracion < 300 ) { m El tiempo de G-Line debe ser como mínimo mayor ó igual a 5 minutos (300 segundos). | l.v }
    if ( $l.db(kline.db,kline,$d(7)) != $null ) { m 12 $+ $d(7) ya existe en la lista de K-Lines. | l.v }
    if ( $l.db(gline.db,gline,$d(7)) != $null ) { m 12 $+ $d(7) ya existe en la lista de G-Lines. | l.v }
    %tmp.ident = $gettok($d(7),1,64)
    %tmp.host = $gettok($d(7),2,64)
    if ( $chr(64) !isin $d(7) ) || ( * !isin %tmp.host ) && ( . !isin %tmp.host ) { m 12 $+ $d(7) no es un G-Line válido espicifique 12ident@host. | l.v }
    if ( %tmp.ident == $chr(42) ) && ( %tmp.host == $chr(42) ) {
      m No se permite un G-Line global.
      debugc $centerserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o intenta poner un G-Line global.
      l.v
    }
    e.gline
    if ( $gline.c.p(%tmp.host) == si ) {
      m 4Permiso denegado.
      debugc $centerserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o ha intentado poner un G-Line a un host de representante ( $+ %tmp.host $+ )
      l.v
    }
    g 1 %tmp.ident %tmp.host $o $check.exp(%tmp.expiracion) $d(8-)
    m Añadido un G-Line para12 $d(7) $+ .
    debugc $centerserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o añade un G-Line a12 $d(7) $+ . $iif(%tmp.expiracion == 0,4GLINE PERMANENTE,Duración $t(%tmp.expiracion)) $+ . Motivo:12 $d(8-)
    l.v
  }
  if ( $d(5) == DEL ) {
    if ( $d(6) == $null ) { m Error de Sintaxis: 12GLINE DEL <host> | l.v }
    e.gline
    %tmp.ident = $gettok($d(6),1,64)
    %tmp.host = $gettok($d(6),2,64)
    if ( $l.db(gline.db,gline,$d(6)) == $null ) { m 12 $+ $d(6) no fue encontrado en la lista de G-Lines. | l.v }
    s : $+ %conf.servidor TKL - G %tmp.ident %tmp.host $o
    b.db gline.db gline $d(6)
    m Retirado el G-Line para12 $d(6) $+ .
    debugc $centerserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o retira el G-Line a12 $d(6) $+ .
    l.v
  }
  if ( $d(5) == LIST ) {
    e.gline
    flushini $mircdirdatabase\gline.db
    %tmp.ruta = $mircdirdatabase\gline.db
    if ( $initopic( %tmp.ruta , gline ) == 0 ) {
      m Lista vacia.
    }
    else {
      m Lista de G-Lines:
      clear @lgline
      window -hl @lgline
      loadbuf -tgline @lgline $mircdirdatabase\gline.db
      %tmp.total = $line(@lgline,0)
      %tmp.linea = 0
      while ( %tmp.linea < %tmp.total ) {
        inc %tmp.linea
        %tmp.l.linea = $line( @lgline , %tmp.linea )
        %tmp.ip = $gettok(%tmp.l.linea,1,61)
        %tmp.datos = $gettok(%tmp.l.linea,2,61)
        %tmp.motivo = $gettok(%tmp.datos,4-,32)
        m %tmp.ip $p.c(%tmp.motivo)
      }
      :f.lg
      m Fin de la lista de G-Lines.
    }
    l.v
  }
  if ( $d(5) == VIEW ) {
    if ( $d(6) == $null ) { m Error de Sintaxis: 12GLINE VIEW <host> | l.v }
    e.gline
    if ( $l.db(gline.db,gline,$d(6)) == $null ) { m 12 $+ $d(6) no fue encontrado en la lista de G-Lines. | l.v }
    %tmp.dgline = $l.db(gline.db,gline,$d(6))
    %tmp.origen = $gettok(%tmp.dgline,1,32)
    %tmp.fechae = $gettok(%tmp.dgline,2,32)
    %tmp.fecha = $gettok(%tmp.dgline,3,32)
    %tmp.motivo = $gettok(%tmp.dgline,4-,32)
    m Información del G-Line12 $d(6) $+ :
    m
    m Puesto por:12 $r.c(%tmp.origen)
    m Fecha:12 $f(%tmp.fecha)
    m Fecha de expiración: $+ $iif(%tmp.fechae >= 1,12 $f(%tmp.fechae),4 INDEFINIDA)
    m Motivo:12 $p.c(%tmp.motivo)
    m
    m Fin de la Información.
    l.v
  }
  m Error de Sintaxis: 12GLINE $chr(123) $+ ADD $chr(124) DEL $chr(124) LIST $chr(124) VIEW $+ $chr(125)
  l.v
}

alias centerserv.preoper {
  if ( $d(5) == ADD ) {
    if ( $d(6) == $null ) { m Error de Sintaxis: 12PREOPER ADD <nick> | l.v }
    if ( $n.r($d(6)) == no ) { m El nick12 $d(6) no está registrado. | l.v }
    if ( $l.db(nickserv\ $+ $r.c($d(6)),representante,tipo) != $null ) { m 12 $+ $d(6) ya es un representante de la red. | l.v }
    g.db nickserv\ $+ $r.c($d(6)) representante tipo Pre-Operador
    g.db representantes.db preopers $r.c($d(6)) Pre-Operador
    a.t N:: $+ $d(6) $+ ::V $lower($d(6)) $+ .pre-oper. $+ $lower(%conf.red)
    g.db nickserv\ $+ $r.c($d(6)) configuracion vhostf $lower($d(6)) $+ .pre-oper. $+ $lower(%conf.red)
    r.n $d(6)
    m 12 $+ $d(6) añadido como Pre-Operador de la red.
    debugc $centerserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o añade como Pre-Operador a12 $d(6) $+ .
    l.v
  }
  if ( $d(5) == DEL ) {
    if ( $d(6) == $null ) { m Error de Sintaxis: 12PREOPER DEL <nick> | l.v }
    if ( $l.db(nickserv\ $+ $r.c($d(6)),representante,tipo) != Pre-Operador ) { m 12 $+ $d(6) no es un Pre-Operador de la red. | l.v }
    b.db nickserv\ $+ $r.c($d(6)) representante tipo
    b.db representantes.db preopers $r.c($d(6))
    a.t N:: $+ $d(6) $+ ::V
    b.db nickserv\ $+ $r.c($d(6)) configuracion vhostf
    if ( $l.db(representantes.db,acreg,$r.c($d(6))) != $null ) { b.db representantes.db acreg $r.c($d(6)) }
    r.n $d(6)
    m 12 $+ $d(6) borrado de Pre-Operador de la red.
    debugc $centerserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o borra de Pre-Operador a12 $d(6) $+ .
    l.v
  }
  if ( $d(5) == LIST ) {
    flushini $mircdirdatabase\representantes.db
    %tmp.ruta = $mircdirdatabase\representantes.db
    if ( $initopic( %tmp.ruta , preopers ) == 0 ) {
      m Lista vacia
    }
    else {
      m Listado de Pre-Operadores
      clear @preopers
      window -hl @preopers
      loadbuf -tpreopers @preopers $mircdirdatabase\representantes.db
      %tmp.total = $line(@preopers,0)
      %tmp.linea = 0
      while ( %tmp.linea < %tmp.total ) {
        inc %tmp.linea
        %tmp.l.linea = $line( @preopers , %tmp.linea )
        %tmp.npreoper = $gettok(%tmp.l.linea,1,61)
        m $r.c(%tmp.npreoper) $e(%tmp.npreoper)
      }
      :f.p
      m Fin de la lista.
    }
    l.v
  }
  m Error de Sintaxis: 12PREOPER $chr(123) $+ ADD $chr(124) DEL $chr(124) LIST $+ $chr(125)
  l.v
}

alias centerserv.kline {
  if ( $d(5) == ADD ) {
    if ( $d(7) == $null ) { m Error de Sintaxis: 12KLINE ADD <host> <motivo> | l.v }
    if ( $l.db(kline.db,kline,$d(6)) != $null ) { m 12 $+ $d(6) ya existe en la lista de K-Lines. | l.v }
    %tmp.ident = $gettok($d(6),1,64)
    %tmp.host = $gettok($d(6),2,64)
    if ( $chr(64) !isin $d(6) ) || ( * !isin %tmp.host ) && ( . !isin %tmp.host ) { m 12 $+ $d(7) no es un K-Line válido espicifique 12ident@host. | l.v }
    if ( %tmp.ident == $chr(42) ) && ( %tmp.host == $chr(42) ) {
      m No se permite un K-Line global.
      debugc $centerserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o intenta poner un K-Line global.
      l.v
    }
    if ( $gline.c.p(%tmp.host) == si ) {
      m 4Permiso denegado.
      debugc $centerserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o ha intentado poner un K-Line a un host de representante ( $+ %tmp.host $+ )
      l.v
    }
    s : $+ %conf.servidor TKL + k %tmp.ident %tmp.host $o 0 $ctime : $+ $d(7-)
    g.db kline.db kline $d(6) $r.c($o) $ctime $q.c($d(7-))
    m Añadido un K-Line para12 $d(6) $+ .
    debugc $centerserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o añade un K-Line a12 $d(6) $+ . Motivo:12 $d(7-)
    l.v
  }
  if ( $d(5) == DEL ) {
    if ( $d(6) == $null ) { m Error de Sintaxis: 12KLINE DEL <host> | l.v }
    if ( $l.db(kline.db,kline,$d(6)) == $null ) { m 12 $+ $d(6) no fue encontrado en la lista de K-Lines. | l.v }
    %tmp.ident = $gettok($d(6),1,64)
    %tmp.host = $gettok($d(6),2,64)
    s : $+ %conf.servidor TKL - k %tmp.ident %tmp.host $o
    b.db kline.db kline $d(6)
    m Retirado el K-Line para12 $d(6) $+ .
    debugc $centerserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o retira el K-Line a12 $d(6) $+ .
    l.v
  }
  if ( $d(5) == LIST ) {
    flushini $mircdirdatabase\kline.db
    %tmp.ruta = $mircdirdatabase\kline.db
    if ( $ini( %tmp.ruta , kline , 0 ) == 0 ) {
      m Lista vacia.
    }
    else {
      m Lista de K-Lines:
      clear @lkline
      window -hl @lkline
      loadbuf -tkline @lkline $mircdirdatabase\kline.db
      %tmp.total = $line(@lkline,0)
      %tmp.linea = 0
      while ( %tmp.linea < %tmp.total ) {
        inc %tmp.linea
        %tmp.l.linea = $line( @lkline , %tmp.linea )
        %tmp.ip = $gettok(%tmp.l.linea,1,61)
        %tmp.datos = $gettok(%tmp.l.linea,2,61)
        %tmp.motivo = $gettok(%tmp.datos,3-,32)
        m %tmp.ip $p.c(%tmp.motivo)
      }
      :f.lk
      m Fin de la lista de K-Lines.
    }
    l.v
  }
  if ( $d(5) == VIEW ) {
    if ( $d(6) == $null ) { m Error de Sintaxis: 12KLINE VIEW <host> | l.v }
    if ( $l.db(kline.db,kline,$d(6)) == $null ) { m 12 $+ $d(6) no fue encontrado en la lista de K-Lines. | l.v }
    %tmp.dgline = $l.db(kline.db,kline,$d(6))
    %tmp.origen = $gettok(%tmp.dgline,1,32)
    %tmp.fecha = $gettok(%tmp.dgline,2,32)
    %tmp.motivo = $gettok(%tmp.dgline,3-,32)
    m Información del K-Line12 $d(6) $+ :
    m
    m Puesto por:12 $r.c(%tmp.origen)
    m Fecha:12 $f(%tmp.fecha)
    m Motivo:12 $p.c(%tmp.motivo)
    m
    m Fin de la Información.
    l.v
  }
  m Error de Sintaxis: 12KLINE $chr(123) $+ ADD $chr(124) DEL $chr(124) LIST $chr(124) VIEW $+ $chr(125)
  l.v
}

alias centerserv.oper {
  if ( $d(5) == ADD ) {
    if ( $d(6) == $null ) { m Error de Sintaxis: 12OPER ADD <nick> | l.v }
    if ( $n.r($d(6)) == no ) { m El nick12 $d(6) no está registrado. | l.v }
    if ( $l.db(nickserv\ $+ $r.c($d(6)),representante,tipo) != $null ) { m 12 $+ $d(6) ya es un representante de la red. | l.v }
    a.t N:: $+ $d(6) $+ ::O *1
    g.db nickserv\ $+ $r.c($d(6)) representante tipo Operador
    g.db representantes.db opers $r.c($d(6)) Operador
    a.t N:: $+ $d(6) $+ ::V $lower($d(6)) $+ .oper. $+ $lower(%conf.red)
    g.db nickserv\ $+ $r.c($d(6)) configuracion vhostf $lower($d(6)) $+ .oper. $+ $lower(%conf.red)
    r.n $d(6)
    m 12 $+ $d(6) añadido como Operador de la red.
    debugc $centerserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o añade como Operador a12 $d(6) $+ .
    l.v
  }
  if ( $d(5) == DEL ) {
    if ( $d(6) == $null ) { m Error de Sintaxis: 12OPER DEL <nick> | l.v }
    if ( $l.db(nickserv\ $+ $r.c($d(6)),representante,tipo) != Operador ) { m 12 $+ $d(6) no es un Operador de la red. | l.v }
    a.t N:: $+ $d(6) $+ ::O
    b.db nickserv\ $+ $r.c($d(6)) representante tipo
    b.db representantes.db opers $r.c($d(6))
    a.t N:: $+ $d(6) $+ ::V
    b.db nickserv\ $+ $r.c($d(6)) configuracion vhostf
    if ( $l.db(representantes.db,roots,$r.c($d(6))) != $null ) { b.db representantes.db roots $r.c($d(6)) }
    if ( $l.db(representantes.db,acreg,$r.c($d(6))) != $null ) { b.db representantes.db acreg $r.c($d(6)) }
    r.n $d(6)
    m 12 $+ $d(6) borrado de Operador de la red.
    debugc $centerserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o borra de Operador a12 $d(6) $+ .
    l.v
  }
  if ( $d(5) == LIST ) {
    flushini $mircdirdatabase\representantes.db
    %tmp.ruta = $mircdirdatabase\representantes.db
    if ( $initopic( %tmp.ruta , opers ) == 0 ) {
      m Lista vacia.
    }
    else {
      m Listado de Operadores
      clear @opers
      window -hl @opers
      loadbuf -topers @opers $mircdirdatabase\representantes.db
      %tmp.total = $line(@opers,0)
      %tmp.linea = 0
      while ( %tmp.linea < %tmp.total ) {
        inc %tmp.linea
        %tmp.l.linea = $line( @opers , %tmp.linea )
        %tmp.noper = $gettok(%tmp.l.linea,1,61)
        m $r.c(%tmp.noper) $e(%tmp.noper)
      }
      :f.o
      m Fin de la lista.
    }
    l.v
  }
  m Error de Sintaxis: 12OPER $chr(123) $+ ADD $chr(124) DEL $chr(124) LIST $+ $chr(125)
  l.v
}

alias centerserv.regenerar {
  %tmp.ccifrado = $cpass(12)
  a.t S::L %tmp.ccifrado
  debugc $centerserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o regenera la clave de cifrado de IPs virtuales.
  m Clave de cifrado regenerada con éxito, usando:12 %tmp.ccifrado
  l.v
}

alias centerserv.update {
  debugc $centerserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o ejecuta 4UPDATE. Actualizando bases de datos...
  r.exp
  e.gline
  m Bases de datos actualizadas.
  debugc $centerserv %conf.canal.admins $+ , $+ %conf.canal.opers 3Bases de datos actualizadas correctamente.
  l.v
}

alias centerserv.restart {
  m Reiniciando los Servicios de Red.
  debugc $centerserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o ha utilizado el comando 12RESTART.
  debugc $centerserv %conf.canal.admins $+ , $+ %conf.canal.opers Reiniciando los Servicios de Red.
  sockclose dbots
  .timer* off
  .timer 1 3 sockopen dbots %conf.ip %conf.puerto
  l.v
}

alias centerserv.sajoin {
  if ( $d(6) == $null ) { m Error de Sintaxis: 12SAJOIN <nick> <canal> | l.v }
  if ( $n.c($d(5)) == no ) { m El nick12 $d(5) no está conectado. | l.v }
  if ( $mid($d(6),1,1) != $chr(35) ) { m El canal debe comenzar por12 $chr(35) | l.v }
  s SAJOIN $d(5) $d(6)
  m Forzada la entrada a12 $d(5) al canal12 $d(6) $+ .
  debugc $centerserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o fuerza la entrada a12 $d(5) al canal12 $d(6) $+ .
  l.v
}

alias centerserv.sapart {
  if ( $d(6) == $null ) { m Error de Sintaxis: 12SAPART <nick> <canal> | l.v }
  if ( $n.c($d(5)) == no ) { m El nick12 $d(5) no está conectado. | l.v }
  if ( $mid($d(6),1,1) != $chr(35) ) { m El canal debe comenzar por12 $chr(35) | l.v }
  s SAPART $d(5) $d(6)
  m Forzada la salida a12 $d(5) del canal12 $d(6) $+ .
  debugc $centerserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o fuerza la salida a12 $d(5) del canal12 $d(6) $+ .
  l.v
}

alias centerserv.dclones {
  if ($d(5)) && ($d(5) isnum) && (. !isin  $d(5)) {
    m Cambiando el número de clones por defecto a12 $d(5)
    a.t S::S * $+ $strip($d(5))
    debugc $centerserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o cambia el limite de clones por defecto a12 $d(5) $+ .
  }
  else {
    m 4Sintaxis incorrecta:12 DCLONES número.
  }
  l.v
}

alias centerserv.raw {
  if ( $d(5) == $null ) { m Error de Sintaxis: 12RAW <raw> | l.v }
  if ($read(database\noraw.db,s,$d(5)) || $read(database\noraw.db,s,$d(6)) || $read(database\noraw.db,s,$d(7)) || $read(database\noraw.db,s,$d(8))) {
    m Lo siento, el comando12 $gettok($read(database\noraw.db,$readn),1,32) está 4bloqueado y no puede ser enviado por RAW.
    debugc $centerserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o intento enviar12 $gettok($read(database\noraw.db,$readn),1,32)  por RAW ->12 $d(5-)
    l.v
  }
  s $gettok(%datos,5-,32)
  m Ejecutado12 $gettok(%datos,5-,32) $+ .
  debugc $centerserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o usa RAW para12 $gettok(%datos,5-,32) $+ .
  l.v
}

alias centerserv.coadmin {
  if ( $d(5) == ADD ) {
    if ( $d(6) == $null ) { m Error de Sintaxis: 12COADMIN ADD <nick> | l.v }
    if ( $n.r($d(6)) == no ) { m El nick12 $d(6) no está registrado. | l.v }
    if ( $l.db(nickserv\ $+ $r.c($d(6)),representante,tipo) != $null ) { m 12 $+ $d(6) ya es un representante de la red. | l.v }
    if ( $r.c($o) != %conf.root ) { m Solo el Root principal puede añadir a otros Co-Administradores. | l.v }
    a.t N:: $+ $d(6) $+ ::O *3
    g.db nickserv\ $+ $r.c($d(6)) representante tipo Co-Administrador
    g.db representantes.db coadmins $r.c($d(6)) Co-Administrador
    a.t N:: $+ $d(6) $+ ::V $lower($d(6)) $+ .coadmin. $+ $lower(%conf.red)
    g.db nickserv\ $+ $r.c($d(6)) configuracion vhostf $lower($d(6)) $+ .coadmin. $+ $lower(%conf.red)
    r.n $d(6)
    m 12 $+ $d(6) añadido como Co-Administrador de la red.
    debugc $centerserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o añade como Co-Administrador a12 $d(6) $+ .
    l.v
  }
  if ( $d(5) == DEL ) {
    if ( $d(6) == $null ) { m Error de Sintaxis: 12COADMIN DEL <nick> | l.v }
    if ( $l.db(nickserv\ $+ $r.c($d(6)),representante,tipo) != Co-Administrador ) { m 12 $+ $d(6) no es un Co-Administrador de la red. | l.v }
    if ( $r.c($o) != %conf.root ) { m Solo el Root principal puede borrar a otros Co-Administradores. | l.v }
    a.t N:: $+ $d(6) $+ ::O
    b.db nickserv\ $+ $r.c($d(6)) representante tipo
    b.db representantes.db coadmins $r.c($d(6))
    a.t N:: $+ $d(6) $+ ::V
    b.db nickserv\ $+ $r.c($d(6)) configuracion vhostf
    if ( $l.db(representantes.db,roots,$r.c($d(6))) != $null ) { b.db representantes.db roots $r.c($d(6)) }
    if ( $l.db(representantes.db,acreg,$r.c($d(6))) != $null ) { b.db representantes.db acreg $r.c($d(6)) }
    r.n $d(6)
    m 12 $+ $d(6) borrado de Co-Administrador de la red.
    debugc $centerserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o borra de Co-Administrador a12 $d(6) $+ .
    l.v
  }
  if ( $d(5) == LIST ) {
    flushini $mircdirdatabase\representantes.db
    %tmp.ruta = $mircdirdatabase\representantes.db
    if ( $initopic( %tmp.ruta , coadmins ) == 0 ) {
      m Lista vacia.
    }
    else {
      m Listado de Co-Administradores
      clear @coadmins
      window -hl @coadmins
      loadbuf -tcoadmins @coadmins $mircdirdatabase\representantes.db
      %tmp.total = $line(@coadmins,0)
      %tmp.linea = 0
      while ( %tmp.linea < %tmp.total ) {
        inc %tmp.linea
        %tmp.l.linea = $line( @coadmins , %tmp.linea )
        %tmp.ncoadmin = $gettok(%tmp.l.linea,1,61)
        m $r.c(%tmp.ncoadmin) $e(%tmp.ncoadmin)
      }
      :f.c
      m Fin de la lista.
    }
    l.v
  }
  m Error de Sintaxis: 12COADMIN $chr(123) $+ ADD $chr(124) DEL $chr(124) LIST $+ $chr(125)
  l.v
}

alias centerserv.admin {
  if ( $d(5) == ADD ) {
    if ( $d(6) == $null ) { m Error de Sintaxis: 12ADMIN ADD <nick> | l.v }
    if ( $n.r($d(6)) == no ) { m El nick12 $d(6) no está registrado. | l.v }
    if ( $l.db(nickserv\ $+ $r.c($d(6)),representante,tipo) != $null ) { m 12 $+ $d(6) ya es un representante de la red. | l.v }
    a.t N:: $+ $d(6) $+ ::O *3
    g.db nickserv\ $+ $r.c($d(6)) representante tipo Administrador
    g.db representantes.db admins $r.c($d(6)) Administrador
    a.t N:: $+ $d(6) $+ ::V $lower($d(6)) $+ .admin. $+ $lower(%conf.red)
    g.db nickserv\ $+ $r.c($d(6)) configuracion vhostf $lower($d(6)) $+ .admin. $+ $lower(%conf.red)
    r.n $d(6)
    m 12 $+ $d(6) añadido como Administrador de la red.
    debugc $centerserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o añade como Administrador a12 $d(6) $+ .
    l.v
  }
  if ( $d(5) == DEL ) {
    if ( $d(6) == $null ) { m Error de Sintaxis: 12ADMIN DEL <nick> | l.v }
    if ( $l.db(nickserv\ $+ $r.c($d(6)),representante,tipo) != Administrador ) { m 12 $+ $d(6) no es un Administrador de la red. | l.v }
    a.t N:: $+ $d(6) $+ ::O
    b.db nickserv\ $+ $r.c($d(6)) representante tipo
    b.db representantes.db admins $r.c($d(6))
    a.t N:: $+ $d(6) $+ ::V
    b.db nickserv\ $+ $r.c($d(6)) configuracion vhostf
    if ( $l.db(representantes.db,roots,$r.c($d(6))) != $null ) { b.db representantes.db roots $r.c($d(6)) }
    if ( $l.db(representantes.db,acreg,$r.c($d(6))) != $null ) { b.db representantes.db acreg $r.c($d(6)) }
    r.n $d(6)
    m 12 $+ $d(6) borrado de Administrador de la red.
    debugc $centerserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o borra de Administrador a12 $d(6) $+ .
    l.v
  }
  if ( $d(5) == LIST ) {
    flushini $mircdirdatabase\representantes.db
    %tmp.ruta = $mircdirdatabase\representantes.db
    if ( $initopic( %tmp.ruta , admins ) == 0 ) {
      m Lista vacia.
    }
    else {
      m Listado de Administradores
      clear @admins
      window -hl @admins
      loadbuf -tadmins @admins $mircdirdatabase\representantes.db
      %tmp.total = $line(@admins,0)
      %tmp.linea = 0
      while ( %tmp.linea < %tmp.total ) {
        inc %tmp.linea
        %tmp.l.linea = $line( @admins , %tmp.linea )
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

alias centerserv.root {
  if ( $d(5) == ADD ) {
    if ( $d(7) == $null ) { m Error de Sintaxis: 12ROOT ADD <nick> <contraseña> | l.v }
    if ( $n.r($d(6)) == no ) { m El nick12 $d(6) no está registrado. | l.v }
    if ( $r.c($o) != %conf.root ) { m Solo el Root principal puede añadir a otros Roots. | l.v }
    if ( $r.c($d(6)) == %conf.root ) { m Ya eres root. | l.v }
    if ( $l.db(nickserv\ $+ $r.c($d(6)),representante,tipo) == $null ) { m 12 $+ $d(6) no es un representante de la red. | l.v }
    if ( $l.db(nickserv\ $+ $r.c($d(6)),representante,tipo) == Pre-Operador ) { m Un Pre-Operador no puede tener acceso a los comandos de los Roots. | l.v }
    if ( $l.db(representantes.db,roots,$r.c($d(6))) != $null ) { m 12 $+ $d(6) ya es un root de la red. | l.v }
    g.db representantes.db roots $r.c($d(6)) $d(7)
    a.t N:: $+ $d(6) $+ ::O *7
    a.t N:: $+ $d(6) $+ ::V $lower($d(6)) $+ .root. $+ $lower(%conf.red)
    m 12 $+ $d(6) añadido como Root de la red.
    debugc $centerserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o añade como Root a12 $d(6) $+ .
    l.v
  }
  if ( $d(5) == DEL ) {
    if ( $d(6) == $null ) { m Error de Sintaxis: 12ROOT DEL <nick> | l.v }
    if ( $l.db(representantes.db,roots,$r.c($d(6))) == $null ) { m 12 $+ $d(6) no es un root de la red. | l.v }
    if ( $r.c($o) != %conf.root ) { m Solo el Root principal puede borrar a otros Roots. | l.v }
    b.db representantes.db roots $r.c($d(6))
    a.t N:: $+ $d(6) $+ ::O
    a.t N:: $+ $d(6) $+ ::V
    m 12 $+ $d(6) borrado de Root de la red.
    debugc $centerserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o borra de Root a12 $d(6) $+ .
    l.v
  }
  if ( $d(5) == LIST ) {
    flushini $mircdirdatabase\representantes.db
    %tmp.ruta = $mircdirdatabase\representantes.db
    if ( $initopic( %tmp.ruta , roots ) == 0 ) {
      m Lista vacia.
    }
    else {
      m Listado de Roots
      clear @roots
      window -hl @roots
      loadbuf -troots @roots $mircdirdatabase\representantes.db
      %tmp.total = $line(@roots,0)
      %tmp.linea = 0
      while ( %tmp.linea < %tmp.total ) {
        inc %tmp.linea
        %tmp.l.linea = $line( @roots , %tmp.linea )
        %tmp.nroot = $gettok(%tmp.l.linea,1,61)
        m $r.c(%tmp.nroot) $e(%tmp.nroot)
      }
      :f.r
      m Fin de la lista.
    }
    l.v
  }
  m Error de Sintaxis: 12ROOT $chr(123) $+ ADD $chr(124) DEL $chr(124) LIST $+ $chr(125)
  l.v
}

alias centerserv.bot {
  if ( $d(5) == ADD ) {
    if ( $d(6) == $null ) { m Error de Sintaxis: 12BOT ADD <nick> | l.v }
    if ( $l.db(bots.db,obots,$r.c($d(6))) != $null ) { m 12 $+ $d(6) ya está en la lista de bots de la red. | l.v }
    if ( $n.r($d(6)) == si ) { m El nick12 $d(6) está registrado. | l.v }
    g.db bots.db obots $r.c($d(6)) *
    m 12 $+ $d(6) añadido como BOT oficial de la red.
    debugc $centerserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o añade como BOT oficial a12 $d(6) $+ .
    l.v
  }
  if ( $d(5) == DEL ) {
    if ( $d(6) == $null ) { m Error de Sintaxis: 12BOT DEL <nick> | l.v }
    if ( $l.db(bots.db,obots,$r.c($d(6))) == $null ) { m 12 $+ $d(6) no está en la lista de bots de la red. | l.v }
    b.db bots.db obots $r.c($d(6))
    m 12 $+ $d(6) borrado como BOT oficial de la red.
    debugc $centerserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o borra de BOT oficial a12 $d(6) $+ .
    l.v
  }
  if ( $d(5) == LIST ) {
    flushini $mircdirdatabase\bots.db
    %tmp.ruta = $mircdirdatabase\bots.db
    if ( $initopic( %tmp.ruta , obots ) == 0 ) { m Lista vacia. }
    else {
      m Listado de bots oficiales
      clear @obots
      window -hl @obots
      loadbuf -tobots @obots $mircdirdatabase\bots.db
      %tmp.total = $line(@obots,0)
      %tmp.linea = 0
      while ( %tmp.linea < %tmp.total ) {
        inc %tmp.linea
        %tmp.l.linea = $line( @obots , %tmp.linea )
        %tmp.nbot = $gettok(%tmp.l.linea,1,61)
        m $r.c(%tmp.nbot)
      }
      :f.r
      m Fin de la lista.
    }
    l.v
  }
  m Error de Sintaxis: 12BOT $chr(123) $+ ADD $chr(124) DEL $chr(124) LIST $+ $chr(125)
  l.v
}

alias centerserv.fmode {
  if ($d(5)) {
    if (#* iswm $d(5)) {
      s mode $d(5) $d(6-)
      m Modos de12 $d(5) cambiados.
    }
    else {
      s svs2mode $d(5) : $+ $d(6)
      m Modos de12 $d(5) cambiados.
    }
    debugc $centerserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o usa 12FMODE sobre12 $d(5) $+ , forzando modos:12 $d(6-)
  }
  else {
    m 4Sintaxis incorrecta:12 fmode nick/#canal +/- modos
  }
  l.v
}

alias centerserv.fsnomask {
  if ($d(5)) {
    if (-* iswm $d(6) || +* iswm $d(6)) {
      s svs2sno $d(5) $d(6)
      m Snomask de12 $d(5) cambiados.
    }
    else {
      m 4Sintaxis incorrecta:12 fsnomask <nick> <+/-modos>
    }
  }
  else {
    m 4Sintaxis incorrecta:12 fsnomask <nick> <+/-modos>
  }
  l.v
}

alias centerserv.remoper {
  if ($d(5)) {
    s svso $d(5) -
    m Quitados modos de OPER, IRCop, ADMIN o RooT de12 $2  $+ .
    debugc $centerserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o usa 12REMOPER sobre12 $d(5) $+ , quitandole posibles modos de IRCop, OPER, ADMIN o RooT.
  }
  else {
    m 4Sintaxis incorrecta:12 remoper nick
  }
  l.v
}

alias centerserv.optimiza {
  if ($d(5)) {
    if ($ini(database\tablas.db,tablas,$d(5))) {
      s DB * OPT $upper($d(5)) $gmt
      set %OPT.n $o
      set %OPT $upper($d(5))
      s DB $l.db(servidores.db,servidor,hub) RES $upper($d(5)) 0
      l.v
    }
    else {
      m 4ERROR: El bloque12 $d(5) no existe.
      l.v
    }
  }
  m Error de Sintaxis: 12optimiza <tabla>
  l.v
}

alias centerserv.tabla {
  if ($d(5)) && (?::* iswm $d(5)) {
    if ($d(6)) {
      a.t $d(5-)
      debugc $centerserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o toca el bloque12 $upper($left($d(5),1)) $+ , contenido:12 $d(5-)
      m Añadido12 $d(5-) al bloque12 $upper($left($d(5),1)) $+ .
      l.v
    }
    a.t $d(5-)
    debugc $centerserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o toca el bloque12 $upper($left($d(5),1)) $+ , contenido:12 $d(5-)
    m Borrado12 $d(5-) del bloque12 $upper($left($d(5),1)) $+ .
    l.v
  }
  m Error de Sintaxis: 12TABLA bloque::item::subitem valor
  l.v
}

alias centerserv.quit {
  m Desconectando los Servicios de Red.
  debugc $centerserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o ha utilizado el comando 12QUIT.
  debugc $centerserv %conf.canal.admins $+ , $+ %conf.canal.opers Desconectando los Servicios de Red.
  sockclose dbots
  exit
  l.v
}

alias centerserv.debugc {
  if ( $d(5) == ON ) {
    if ( $d(6) == $null ) { m Error de Sintaxis: 12DEBUGC ON <canal> | l.v }
    if ( $mid($d(6),1,1) != $chr(35) ) { m El canal debe comenzar por12 $chr(35) | l.v }
    if ( $gettok(%debugc,1,32) == on ) { m El debug ya está activado. | l.v }
    %debugc = on $d(6)
    j $operserv $gettok(%debugc,2,32)
    s : $+ $chanserv MODE $gettok(%debugc,2,32) +Rntis
    s : $+ $chanserv TOPIC $gettok(%debugc,2,32) :Canal de debug de clones de la red.
    m Activado el DEBUG de clones en el canal12 $d(6)
    debugc $centerserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o activa el debug de clones. ( $+ $d(6) $+ )
    l.v
  }
  if ( $d(5) == OFF ) {
    p $operserv $gettok(%debugc,2,32)
    unset %debugc
    m Desactivado el DEBUG de clones.
    debugc $centerserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o desactiva el debug de clones.
    l.v
  }
  m Error de Sintaxis: 12DEBUGC <ON/OFF> <canal>
  l.v
}

alias centerserv.modulo {
  if ($d(5) == add) {
    if ($script($d(6) $+ .mrc)) {
      m 4ERROR: El módulo12 $d(6) ya esta cargado.
    }
    else {
      if ($isfile($scriptdirmodulos\ $+ $d(6) $+ \ $+ $d(6) $+ .mrc)) {
        .load -rs sistema\modulos\ $+ $d(6) $+ \ $+ $d(6) $+ .mrc
        if ($read(sistema\modulos\modulos.txt,s,$d(6)) == $NULL) { write sistema\modulos\modulos.txt $d(6) ok }
        m Cargado el módulo12 $d(6)
        debugc $centerserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o carga el módulo12 $d(6)
        mmete $d(6)
      }
      else {
        m 4ERROR: EL módulo12 $d(6) no existe.
      }
    }
  }
  elseif ($d(5) == del) {
    if ($script($d(6) $+ .mrc) || $read(sistema\modulos\modulos.txt,s,$d(6))) {
      .unload -rs $d(6) $+ .mrc
      write -ds $+ $d(6) sistema\modulos\modulos.txt
      m Descargado el módulo12 $d(6)
      debugc $centerserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o descarga el módulo12 $d(6)
      s : $+ $ginfo($d(6),info,nick) quit :Quit: Modulo descargado.
      .ruser bot $ginfo($d(6),info,nick)
    }
    else {
      if ($isfile($scriptdirmodulos\ $+ $d(6) $+ \ $+ $d(6) $+ .mrc)) {
        m 4ERROR: El módulo12 $d(6) no esta cargado.
      }
      else {
        m 4ERROR: EL módulo12 $d(6) no existe.
      }
    }
  }
  elseif ($d(5) == list) {
    if ($finddir(sistema\modulos\,*,1)) {
      var %a 1
      m Lista de módulos 3cargados y 4descargados:
      m
      while ($finddir(sistema\modulos\,*,%a,0)) {
        var %b = sistema\modulos\ $+ $nopath($finddir(sistema\modulos\,*,%a,0)) $+ \ $+ $nopath($finddir(sistema\modulos\,*,%a,0)) $+ .ini
        m 12 $+ %a $iif($script($nopath($finddir(sistema\modulos\,*,%a,0)) $+ .mrc),03,04) $+ $nopath($finddir(sistema\modulos\,*,%a,0)) $+ : $readini(%b,info,desc)
        inc %a 1
      }
      m
      m Fin de la lista.
    }
    else {
      m No ahi módulos disponibles.
      m Puedes descargar módulos para los dbots3 desde12 http://devel.dbots.es
    }
  }
  elseif ( $d(5) == WLIST) {
    if ($sock(wmodulo.list. [ $+ [ $o ] ])) { sockclose wmodulo.list. [ $+ [ $o ] ] }
    sockopen wmodulo.list. [ $+ [ $o ] ] $l.conf(updates,host) 80
    m Conectando para listar modulos disponibles...
  }
  elseif ($d(5) == info) {
    if ($d(6)) {
      if ($isdir(sistema\modulos\ $+ $d(6))) {
        m NICK:12 $ginfo($d(6),info,nick)
        m IDENT:12 $ginfo($d(6),info,ident)
        m HOST:12 $ginfo($d(6),info,host)
        m REALNAME:12 $ginfo($d(6),info,realname)
        m MODOS:12 $ginfo($d(6),info,modos)
        m AUTOJOIN:12 $ginfo($d(6),info,join)
        m DESCRIPCIÓN:12 $ginfo($d(6),info,desc)
      }
      else {
        m 4ERROR: El módulo12 $d(6) no existe.
      }
    }
    else {
      m 4Sintaxis incorrecta:12 /msg $centerserv modulo info módulo
    }
  }
  elseif ( $d(5) == install) {
    if ( $d(6) ) {
      if ($isdir(sistema\modulos\ $+ $d(6))) {
        m 4ERROR: Ya hay un módulo con ese nombre.
      }
      else {
        sockopen wmodulo.down. [ $+ [ $o ] $+ . $+ [ $d(6) ] ] $l.conf(updates,host) 80
        m Conectando para descargar el módulo12 $d(6)
      }
    }
    else {
      m Sintaxis incorrecta:12 INSTALL nombre
      m 12/msg $centerserv HELP WMODULO para más información
    }
  }
  elseif ( $d(5) == uninstall ) {
    if ( $d(6) ) {
      if ($isdir(sistema\modulos\ $+ $d(6))) {
        .unload -rs $d(6) $+ .mrc
        write -ds $+ $d(6) sistema\modulos\modulos.txt
        m Desinstalando el módulo12 $d(6)
        debugc $centerserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o desinstala el módulo12 $d(6)
        s : $+ $ginfo($d(6),info,nick) quit :Quit: Modulo desinstalado...
        .ruser bot $ginfo($d(6),info,nick)
        write del. $+ $d(6) $+ .bat rd /S/Q C:\dBoTs\sistema\modulos\ $+ $d(6)
        .timerdel1 1 1 run del. $+ $d(6) $+ .bat
        .timerdel2 1 2 .remvoe del. $+ $d(6) $+ .bat
      }
      else {
        m 4ERROR: No se encuentra el módulo12 $d(6) $+ ...
      }
    }
    else {
      m Sintaxis incorrecta:12 MODULO UNINSTALL nombre
    }
  }
  elseif ( $d(5) == update ) {
    if ( $d(6) ) {
      if ($isdir(sistema\modulos\ $+ $d(6))) {
        sockopen wmodulo.update. [ $+ [ $o ] $+ . $+ [ $d(6) ] ] $l.conf(updates,host) 80
        m Buscando si hay actualizaciones para12 $d(6)
      }
      else {
        m 4ERROR: No se ha encontrado el módulo12 $d(6)
      }
    }
    else {
      m Sintaxis incorecta:12 /mg $centerserv MODULO UPDATE nombre
      m Para más información:12 /msg $centerserv help MODULO
    }
  }
  else {
    m 4Sintaxis incorrecta: Para más información usar:
    m 12/msg $centerserv HELP MODULO
  }
  l.v
}

alias centerserv.backup {
  if ($isfile(backup\chanserv.zip)) { .remove backup\chanserv.zip }
  if ($isfile(backup\cregserv.zip)) { .remove backup\cregserv.zip }
  if ($isfile(backup\nickserv.zip)) { .remove backup\nickserv.zip }
  m Realizando copia de seguridad de chanserv, nickserv y cregserv...
  backup.chan $o
  l.v
}

alias centerserv.actualiza {
  set %actualizar.nickmsg $o
  actualizar
  l.v
}

alias centerserv.noraw {
  if ($o == $l.conf(otras,root)) {
    if ($d(5) == add) {
      if ($d(6)) {
        if ($read(database\noraw.db,s,$d(6))) {
          m El comando12 $d(6) ya está en la lista.
        }
        else {
          write database\noraw.db $d(6) $ctime
          m 4Bloqueado el comando12 $d(6)
        }
      }
      else {
        m 4Sintaxis incorrecta:12 NORAW ADD comando
      }
    }
    elseif ($d(5) == del) {
      if ($d(6)) {
        if ($read(database\noraw.db,s,$d(6))) {
          write -ds $+ $d(6) database\noraw.db
          m 3Liberado el comando12 $d(6)
        }
        else {
          m El comando12 $d(6) no está en la lista.
        }
      }
      else {
        m 4Sintaxis incorrecta:12 NORAW DEL comando
      }
    }
    elseif ($d(5) == list) {
      if ($read(database\noraw.db,1)) {
        m Lista de comandos4 bloqueados para RAW:
        m
        var %a 1
        while ($read(database\noraw.db,%a)) {
          var %r = $read(database\noraw.db,%a)
          m Comando12 $gettok(%r,1,32) añadido el12 $date($gettok(%r,2,32))
          inc %a 1
        }
        m
        m Fin de la lista.
      }
      else {
        m Lista vacia.
      }
    }
    else {
      m 4Opción incorrecta. Para más información usa
      m 12/msg $centerserv HELP NORAW
    }
  }
  else {
    m Comando solo disponible para el root principal.
  }
  l.v
}

on 1:sockopen:wmodulo.list.*:{
  if ( $sockerr > 0 ) { s : $+ $centerserv %conf.metodo $gettok($sockname,3,46) :4ERROR: No se ha podido establecer la conexión. | return }
  s : $+ $centerserv %conf.metodo $gettok($sockname,3,46) :Listando módulos:
  s : $+ $centerserv %conf.metodo $gettok($sockname,3,46) :
  sockwrite -n $sockname GET / HTTP/1.1
  sockwrite -n $sockname Accept: */*
  sockwrite -n $sockname Host: $l.conf(updates,host)
  sockwrite -n $sockname User-Agent: Mew
  sockwrite -n $sockname $crlf
}

on 1:sockread:wmodulo.list.*:{
  sockread % [ $+ [ $sockname ] ]
  if (<a>UDB</a> isin % [ $+ [ $sockname ] ]) { unset % [ $+ [ $sockname ] $+ [ .ok ] ] }
  elseif (% [ $+ [ $sockname ] $+ [ .ok ] ]) {
    if (id="menu-item- isin % [ $+ [ $sockname ] ]) {
      var %r = $gettok($gettok(% [ $+ [ $sockname ] ],3,62),1,60)
      s : $+ $centerserv %conf.metodo $gettok($sockname,3,46) : 10-12 %r $iif($isdir(sistema\modulos\ $+ %r),3INSTALADO,4NO INSTALADO)
    }
  }
  elseif (<a>módulos</a> isin % [ $+ [ $sockname ] ]) { set % [ $+ [ $sockname ] $+ [ .ok ] ] ok | unset % [ $+ [ $sockname ] ] }
}

on 1:sockclose:wmodulo.list.*:{
  s : $+ $centerserv %conf.metodo $gettok($sockname,3,46) :
  s : $+ $centerserv %conf.metodo $gettok($sockname,3,46) :Fin de la lista.
  s : $+ $centerserv %conf.metodo $gettok($sockname,3,46) :Para instalar un módulo escibre:
  s : $+ $centerserv %conf.metodo $gettok($sockname,3,46) :12/msg $centerserv MODULO INSTALL nombre
  unset % [ $+ [ $sockname ] ]
}

on 1:sockopen:wmodulo.down.*:{
  if ($sockerr) { s : $+ $centerserv %conf.metodo $gettok($sockname,3,46) :4ERROR: No se ha podido establecer la conexion | return }
  s : $+ $centerserv %conf.metodo $gettok($sockname,3,46) :Conectado con12 $l.conf(updates,host) y descargando módulo12 $gettok($sockname,4,46)
  ;write -c $+(",$mircdir,$gettok($sockname,4,46),.zip,")
  sockwrite -n $sockname GET / $+ $gettok($sockname,4,46) $+ .zip HTTP/1.1
  sockwrite -n $sockname Accept: *.*
  sockwrite -n $sockname HOST: $l.conf(updates,host)
  sockwrite -n $sockname User-Agent: dBoTs
  sockwrite -n $sockname $crlf
}

on 1:sockread:wmodulo.down.*:{
  if ($sockerr) { s : $+ $centerserv %conf.metodo $gettok($sockname,3,46) :4ERROR AL LEER: $sock($sockname).wsmsg | return }
  sockread % [ $+ [ $sockname ] ]
  if (404 Not Found isin % [ $+ [ $sockname ] ]) {
    s : $+ $centerserv %conf.metodo $gettok($sockname,3,46) :4ERROR: No se ha podido descargar el módulo12 $gettok($sockname,4,46)
    s : $+ $centerserv %conf.metodo $gettok($sockname,3,46) :Asegurate de que el nombre esté bien...
    if ($isfile($gettok($sockname,4,46) $+ .zip)) { .remove $gettok($sockname,4,46) $+ .zip }
    sockclose $sockname
    ;halt
  }
  else {
    if ($sockbr) && (% [ $+ [ $sockname ] ] == $null) {
      sockread & [ $+ [ $sockname ] ]
      bwrite $+(",$mircdir,$gettok($sockname,4,46),.zip,") -1 & [ $+ [ $sockname ] ]
    }
    else { break }
  }
}

on 1:sockclose:wmodulo.down.*:{
  unset % [ $+ [ $sockname ] ]
  if ($isfile($gettok($sockname,4,46) $+ .zip)) {
    dll mUnzip.dll Unzip -do $gettok($sockname,4,46) $+ .zip sistema\modulos\
    .load -rs sistema\modulos\ $+ $gettok($sockname,4,46) $+ \ $+ $gettok($sockname,4,46) $+ .mrc
    if ($script($gettok($sockname,4,46) $+ .mrc)) {
      mmete $gettok($sockname,4,46)
      s : $+ $centerserv %conf.metodo $gettok($sockname,3,46) :Cargado el módulo12 $gettok($sockname,4,46)
      debugc $centerserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $gettok($sockname,3,46) instala el módulo12 $gettok($sockname,4,46)
    }
    else {
      s : $+ $centerserv %conf.metodo $gettok($sockname,3,46) :4ERROR: No se ha cargado el módulo...
      s : $+ $centerserv %conf.metodo $gettok($sockname,3,46) :Revisa que esté bien instalado mediante
      s : $+ $centerserv %conf.metodo $gettok($sockname,3,46) :12/msg $centerserv MODULO LIST
    }
    .remove $gettok($sockname,4,46) $+ .zip
  }
}

on 1:sockopen:wmodulo.update.*:{
  if ($sockerr) {
    s : $+ $centerserv %conf.metodo $gettok($sockname,3,46) :4ERROR: Fallo al conectar con la web...
    return
  }
  set % [ $+ [ $sockname ] $+ [ .actualizar.es ] ] OK
  sockwrite -n $sockname GET / $+ $gettok($sockname,4,46) $+ .zip HTTP/1.1
  sockwrite -n $sockname Accept: *.*
  sockwrite -n $sockname HOST: $l.conf(updates,host)
  sockwrite -n $sockname User-Agent: dBoTs
  sockwrite -n $sockname $crlf
}

on 1:sockread:wmodulo.update.*:{
  if ($sockerr) {
    s : $+ $centerserv %conf.metodo $gettok($sockname,3,46) :Error al leer: $sock($sockname).wsmsg $+ .
    return
  }
  while (1) {
    if (% [ $+ [ $sockname ] $+ [ .actualizar.es ] ] == OK) { sockread % [ $+ [ $sockname ] $+ [ .read ] ] }
    else { sockread & [ $+ [ $sockname ] ] }
    if ( Last-Modified* iswm % [ $+ [ $sockname ] $+ [ .read ] ] ) {
      var %ult.act. [ $+ [ $gettok($sockname,4,46) ] ] $iif($ginfo($gettok($sockname,4,46),info,lastupdate),$ifmatch,Thu Jan 01 01:00:00 1970)
      if ( $gettok(% [ $+ [ $sockname ] $+ [ .read ] ],2-,32) == %ult.act. [ $+ [ $gettok($sockname,4,46) ] ] ) {
        s : $+ $centerserv %conf.metodo $gettok($sockname,3,46) :El módulo12 $gettok($sockname,4,46) ya está actualizado.
        sockclose $sockname
      }
      else {
        writeini sistema\modulos\ $+ $gettok($sockname,4,46) $+ \ $+ $gettok($sockname,4,46) $+ .ini info lastupdate $gettok(% [ $+ [ $sockname ] $+ [ .read ] ],2-,32)
        s : $+ $centerserv %conf.metodo $gettok($sockname,3,46) :Se ha encontrado una actualización para el módulo12 $gettok($sockname,4,46) $+ .
        s : $+ $centerserv %conf.metodo $gettok($sockname,3,46) :Comienza la descarga de la actualización.
      }
    }
    if ($sockbr) {
      if ( % [ $+ [ $sockname ] $+ [ .actualizar.es ] ] == OK ) && ( % [ $+ [ $sockname ] $+ [ .read ] ] == $null ) { set % [ $+ [ $sockname ] $+ [ .actualizar.es ] ] okk }
      elseif (% [ $+ [ $sockname ] $+ [ .actualizar.es ] ] == OKK) { bwrite $+(",$mircdir,$gettok($sockname,4,46),.zip,") -1 & [ $+ [ $sockname ] ] }
    }
    else { break }
  }
}

on 1:sockclose:wmodulo.update.*:{
  .remove sistema\modulos\ $+ $gettok($sockname,4,46) $+ \ $+ $gettok($sockname,4,46) $+ .mrc
  s : $+ $centerserv %conf.metodo $gettok($sockname,3,46) :Descarga terminada.
  s : $+ $centerserv %conf.metodo $gettok($sockname,3,46) :Actualizando módulo.
  dll mUnzip.dll Unzip -do $gettok($sockname,4,46) $+ .zip sistema\modulos\ $+ $gettok($sockname,4,46) $+ \
  .reload -rs sistema\modulos\ $+ $gettok($sockname,4,46) $+ \ $+ $gettok($sockname,4,46) $+ .mrc
  s : $+ $centerserv %conf.metodo $gettok($sockname,3,46) :Módulo12 $gettok($sockname,4,46) actualizado correctamente.
  .remove $+(",$mircdir,$gettok($sockname,4,46),.zip,")
  unset % [ $+ [ $sockname ] $+ [ .actualizar.es ] ]
  unset % [ $+ [ $sockname ] $+ [ .read ] ]
}

------------------

alias backup.chan {
  var %a = $dll(szip.dll,SZipFolder,database\chanserv\ > chanserv.zip)
  if (%a == Z_OK) {
    s : $+ $centerserv %conf.metodo $1 :Backup de 12chanserv realizado con exito.
  }
  else {
    s : $+ $centerserv %conf.metodo $1 :4ERROR en el backup de12 chanserv: $gettok(%a,2-,32)
  }
  .timerbackup.nick 1 1 backup.nick $1
}

alias backup.nick {
  var %a = $dll(szip.dll,SZipFolder,database\nickserv\ > nickserv.zip)
  if (%a == Z_OK) {
    s : $+ $centerserv %conf.metodo $1 :Backup de 12nickserv realizado con exito.
  }
  else {
    s : $+ $centerserv %conf.metodo $1 :4ERROR en el backup de12 nickserv: $gettok(%a,2-,32)
  }
  .timerbackup.creg 1 1 backup.creg $1
}

alias backup.creg {
  var %a = $dll(szip.dll,SZipFolder,database\cregserv\ > cregserv.zip)
  if (%a == Z_OK) {
    s : $+ $centerserv %conf.metodo $1 :Backup de 12cregserv realizado con exito.
  }
  else {
    s : $+ $centerserv %conf.metodo $1 :4ERROR en el backup de12 cregserv: $gettok(%a,2-,32)
  }
  .timerbackup.creg 1 1 backup.fin $1
}

alias backup.fin {
  if ($isfile(chanserv.zip)) { .rename chanserv.zip backup\chanserv.zip }
  if ($isfile(nickserv.ziP)) { .rename nickserv.zip backup\nickserv.zip }
  if ($isfile(cregserv.zip)) { .rename cregserv.zip backup\cregserv.zip }
  s : $+ $centerserv %conf.metodo $1 :Backup realizado correctamente...
}
