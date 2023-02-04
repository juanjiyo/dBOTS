on 1:sockread:dbots: {
  if ( $d(2) == PRIVMSG ) || ( $d(2) == NOTICE ) && (( $d(3) == $memoserv ) || ( $d(3) == $memoserv $+ @ $+ %conf.servidor )) { p.m $memoserv | memoserv.procesa }
}

alias memoserv.procesa {
  if ( $d(4) == AYUDA ) || ( $d(4) == HELP ) { memoserv.ayuda }
  if ( $d(4) == SEND ) { memoserv.send }
  if ( $d(4) == READ ) { memoserv.read }
  if ( $d(4) == LIST ) { memoserv.list }
  if ( $d(4) == DEL ) { memoserv.del }
  if ( $d(4) == NOMEMOS) { memoserv.nomemos }
  if ( $d(4) == SET ) { memoserv.set }
  if ( $d(4) == PREOPERS ) { c.r CA | memoserv.memo Pre-Operador $operserv $d(5-) }
  if ( $d(4) == OPERS ) { c.r CA | memoserv.memo Operador $operserv $d(5-) }
  if ( $d(4) == USERS ) { c.r A | memoserv.memo USERS $d(5) $d(6-) }
  if ( $d(4) == COADMINS ) { c.r R | memoserv.memo Co-Administrador $centerserv $d(5-) }
  if ( $d(4) == ADMINS ) { c.r R | memoserv.memo Administrador $centerserv $d(5-) }
  m Comando desconocido12 $strip($d(4)) $+ . "12/msg $memoserv AYUDA" para ayuda.
  l.v
}

alias memoserv.ayuda {
  if ($d(5)) { m.h $memoserv $o helps\me.help $replace($d(5-),$chr(32),-) }
  else {
    m.h $memoserv $o helps\me.help help
    if ( $s.n($o) >= 6 ) { m.h $memoserv $o helps\me.help help-ca }
    if ( $s.n($o) >= 7 ) { m.h $memoserv $o helps\me.help help-a }
    if ( $s.n($o) >= 8 ) { m.h $memoserv $o helps\me.help help-r }
    if ( $s.n($o) >= 6 ) { m.h $memoserv $o helps\me.help help-f }
  }
  l.v
}

alias memoserv.ayuda.coadmins {
  m
  m 10- Comandos de Co-Administradores:
  m
  m 12PREOPERS Envía un memo a todos los Pre-Operadores.
  m 12OPERS Envía un memo a todos los Operadores.
  if ( $s.n($o) >= 7 ) { memoserv.ayuda.admins }
}

alias memoserv.ayuda.admins {
  m
  m 10- Comandos de Administradores:
  m
  m 12USERS Envía un memo a todos los usuarios.
  if ( $s.n($o) >= 8 ) { memoserv.ayuda.root }
}

alias memoserv.ayuda.root {
  m
  m 10- Comandos de Roots:
  m
  m 12COADMINS Envía un memo a todos los Co-Administradores.
  m 12ADMINS Envía un memo a todos los Administradores.
}

alias memoserv.send {
  if ( $d(6) == $null ) { m Error de Sintaxis: 12SEND <nick/canal> <mensaje> | m 12/msg $memoserv AYUDA SEND para más información. | l.v }
  if ( $mid($d(5),1,1) == $chr(35) ) {
    if ( $ca.r($d(5)) == no ) { m El canal12 $d(5) no está registrado. | l.v }
    if ( $n.i($o) == no ) { m Debes identificarte antes de utilizar el comando 12SEND. | l.v }
    if ( $l.db(chanserv\ $+ $r.c($d(5)),stats,total.memos) >= $l.conf(memoserv,lmemoscanal) ) { m El canal12 $d(5) no puede recibir mas mensajes. | l.v }
    if ( $l.db(nicks.db,esperam,$r.c($o)) != $null ) && ( $s.n($o) < 5 ) { m Por favor espera12 30 segundos antes de utilizar el comando SEND de nuevo. | l.v }
  }
  else {
    if ( $n.i($o) == no ) { m Debes identificarte antes de utilizar el comando 12SEND. | l.v }
    if ( $n.r($d(5)) == no ) { m El nick12 $d(5) no está registrado. | l.v }
    if ( $l.db(nickserv\ $+ $r.c($d(5)),stats,total.memos) >= $l.conf(memoserv,lmemosnick) ) && ( $l.db(nickserv\ $+ $r.c($d(5)),representante,tipo) == $null ) || ( $l.db(nickserv\ $+ $r.c($d(5)),stats,total.memos) >= 100 ) { m El nick12 $d(5) no puede recibir más mensajes. | l.v }
    if ( $l.db(nicks.db,esperam,$r.c($o)) != $null ) && ( $s.n($o) < 5 ) { m Por favor espera12 30 segundos antes de utilizar el comando SEND de nuevo. | l.v }
    if ( $l.db(nickserv\ $+ $r.c($d(5)),nomemos,$o) ) { m No puedes mandar mensajes a12 $d(5) $+ , te tiene en la lista negra... | l.v }
  }
  memoserv.envia $d(5) $r.c($o) $d(6-)
  m Mensaje enviado a12 $d(5) $+ .
  g.db nicks.db esperam $r.c($o) *
  .timer $+ $r.c($o) $+ -e.m 1 30 b.db nicks.db esperam $r.c($o)
  l.v
}

alias memoserv.list {
  if ( $mid($d(5),1,1) == $chr(35) ) {
    if ( $ca.r($d(5)) == no ) { m El canal12 $d(5) no está registrado. | l.v }
    if ( $n.i($o) == no ) { m Debes identificarte antes de utilizar el comando 12LIST. | l.v }
    if ( $l.db(nickserv\ $+ $r.c($o),ifundador,$r.c($d(5))) == $null ) && ( $l.db(chanserv\ $+ $r.c($d(5)),registros,$r.c($o)) == $null ) && ( $l.db(chanserv\ $+ $r.c($d(5)),configuracion,fundador) != $r.c($o) ) && ( $s.n($o) < 5 ) { m 4Permiso denegado. | l.v }
    if ( $l.db(nickserv\ $+ $r.c($o),ifundador,$r.c($d(5))) != $null ) || ( $l.db(chanserv\ $+ $r.c($d(5)),configuracion,fundador) == $r.c($o) ) || ( $s.n($o) >= 5 ) { %tmp.registro.o = 500 }
    else { %tmp.registro.o = $l.db(chanserv\ $+ $r.c($d(5)),registros,$r.c($o)) }
    if ( $l.db(chanserv\ $+ $r.c($d(5)),niveles,memo) == DIS ) { %tmp.memo = 500 }
    else { %tmp.memo = $l.db(chanserv\ $+ $r.c($d(5)),niveles,memo) }
    if ( %tmp.registro.o < %tmp.memo ) { m 4Permiso denegado. | l.v }
    if ( $d(6) == NEW ) {
      if ( $l.db(chanserv\ $+ $r.c($d(5)),stats,total.memos.nuevos) == 0 ) { m 12 $+ $d(5) no tiene mensajes nuevos. | l.v }
      flushini $mircdirdatabase\chanserv\ $+ $r.c($d(5))
      %tmp.ruta = $mircdirdatabase\chanserv\ $+ $r.c($d(5))
      clear @memonc
      window -hl @memonc
      loadbuf -tmemos @memonc $mircdirdatabase\chanserv\ $+ $r.c($d(5))
      %tmp.total = $line(@memonc,0)
      %tmp.linea = 0
      m Mensajes nuevos de12 $d(5) $+ .
      m Para leerlos, escribe: 12/msg $memoserv READ <numero>
      m
      while ( %tmp.linea < %tmp.total ) {
        inc %tmp.linea
        %tmp.l.linea = $line( @memonc , %tmp.linea )
        %tmp.rsdatos = $gettok(%tmp.l.linea,1,61)
        %tmp.rsdatos2 = $gettok(%tmp.l.linea,2,61)
        if ( $gettok(%tmp.rsdatos2,3,32) == 0 ) {
          %tmp.memo.origen = $gettok(%tmp.rsdatos2,1,32)
          %tmp.memo.fecha = $gettok(%tmp.rsdatos2,2,32)
          m Nº12 %tmp.rsdatos - Remitente:12 $r.c(%tmp.memo.origen) - Fecha:12 $f(%tmp.memo.fecha)
        }
      }
      l.v
    }
    if ( $l.db(chanserv\ $+ $r.c($d(5)),stats,total.memos) == 0 ) { m 12 $+ $d(5) no tiene mensajes. | l.v }
    %tmp.linea = 0
    flushini $mircdirdatabase\chanserv\ $+ $r.c($d(5))
    %tmp.ruta = $mircdirdatabase\chanserv\ $+ $r.c($d(5))
    if ( $initopic( %tmp.ruta , memos ) == 0 ) { goto f.mc }
    clear @memoc
    window -hl @memoc
    loadbuf -tmemos @memoc $mircdirdatabase\chanserv\ $+ $r.c($d(5))
    %tmp.total = $line(@memoc,0)
    m Mensajes Recibidos en12 $d(5) $+ .
    m Para leerlos, escribe: 12/msg $memoserv READ <numero>
    m
    while ( %tmp.linea < %tmp.total ) {
      inc %tmp.linea
      %tmp.l.linea = $line( @memoc , %tmp.linea )
      %tmp.rsdatos = $gettok(%tmp.l.linea,1,61)
      %tmp.rsdatos2 = $gettok(%tmp.l.linea,2,61)
      %tmp.memo.origen = $gettok(%tmp.rsdatos2,1,32)
      %tmp.memo.fecha = $gettok(%tmp.rsdatos2,2,32)
      %tmp.memo.datos = Nº12 %tmp.rsdatos - Remitente:12 $r.c(%tmp.memo.origen) - Fecha:12 $f(%tmp.memo.fecha)
      if ( $gettok(%tmp.rsdatos2,3,32) == 0 ) { %tmp.memo.datos = %tmp.memo.datos 4(No Leído) }
      m %tmp.memo.datos
    }
    :f.mc
    l.v
  }
  else {
    if ( $n.i($o) == no ) { m Debes identificarte antes de utilizar el comando 12LIST. | l.v }
    if ($d(5)) && ($d(5) != NEW) { m 4ERROR: Opción12 $d(5) desconocida. Opciones validas:12 NEW | l.v }
    if ( $d(5) == NEW) { 
      if ( $l.db(nickserv\ $+ $r.c($o),stats,total.memos.nuevos) == 0 ) { m No tiene mensajes nuevos. | l.v }
      flushini $mircdirdatabase\nickserv\ $+ $r.c($o)
      %tmp.ruta = $mircdirdatabase\nickserv\ $+ $r.c($o)
      clear @memonn
      window -hl @memonn
      loadbuf -tmemos @memonn $mircdirdatabase\nickserv\ $+ $r.c($o)
      %tmp.total = $line(@memonn,0)
      %tmp.linea = 0
      m Mensajes Nuevos.
      m Para leerlos, escribe: 12/msg $memoserv READ <numero>
      m
      while ( %tmp.linea < %tmp.total ) {
        inc %tmp.linea
        %tmp.l.linea = $line( @memonn , %tmp.linea )
        %tmp.rsdatos = $gettok(%tmp.l.linea,1,61)
        %tmp.rsdatos2 = $gettok(%tmp.l.linea,2,61)
        if ( $gettok(%tmp.rsdatos2,3,32) == 0 ) {
          %tmp.memo.origen = $gettok(%tmp.rsdatos2,1,32)
          %tmp.memo.fecha = $gettok(%tmp.rsdatos2,2,32)
          m Nº12 %tmp.rsdatos - Remitente:12 $r.c(%tmp.memo.origen) - Fecha:12 $f(%tmp.memo.fecha)
        }
      }
      l.v
    }
    if ( $l.db(nickserv\ $+ $r.c($o),stats,total.memos) == 0 ) { m No tiene mensajes. | l.v }
    flushini $mircdirdatabase\nickserv\ $+ $r.c($o)
    %tmp.ruta = $mircdirdatabase\nickserv\ $+ $r.c($o)
    clear @memon
    window -hl @memon
    loadbuf -tmemos @memon $mircdirdatabase\nickserv\ $+ $r.c($o)
    %tmp.total = $line(@memon,0)
    %tmp.linea = 0
    m Mensajes Recibidos.
    m Para leerlos, escribe: 12/msg $memoserv READ <numero>
    m
    while ( %tmp.linea < %tmp.total ) {
      inc %tmp.linea
      %tmp.l.linea = $line( @memon , %tmp.linea )
      %tmp.rsdatos = $gettok(%tmp.l.linea,1,61)
      %tmp.rsdatos2 = $gettok(%tmp.l.linea,2,61)
      %tmp.memo.origen = $gettok(%tmp.rsdatos2,1,32)
      %tmp.memo.fecha = $gettok(%tmp.rsdatos2,2,32)
      %tmp.memo.datos = Nº12 %tmp.rsdatos - Remitente:12 $r.c(%tmp.memo.origen) - Fecha:12 $f(%tmp.memo.fecha)
      if ( $gettok(%tmp.rsdatos2,3,32) == 0 ) { %tmp.memo.datos = %tmp.memo.datos 4(No Leído) }
      m %tmp.memo.datos
    }
    l.v
  }
}

alias memoserv.read {
  if ( $mid($d(5),1,1) == $chr(35) ) {
    if ( $d(6) == $null ) { m Error de Sintaxis: 12READ <canal> <numero> | m 12/msg $memoserv AYUDA READ para más información. | l.v }
    if ( $ca.r($d(5)) == no ) { m El canal12 $d(5) no está registrado. | l.v }
    if ( $n.i($o) == no ) { m Debes identificarte antes de utilizar el comando 12READ. | l.v }
    if ( $l.db(nickserv\ $+ $r.c($o),ifundador,$r.c($d(5))) == $null ) && ( $l.db(chanserv\ $+ $r.c($d(5)),registros,$r.c($o)) == $null ) && ( $l.db(chanserv\ $+ $r.c($d(5)),configuracion,fundador) != $r.c($o) ) && ( $s.n($o) < 5 ) { m 4Permiso denegado. | l.v }
    if ( $l.db(nickserv\ $+ $r.c($o),ifundador,$r.c($d(5))) != $null ) || ( $l.db(chanserv\ $+ $r.c($d(5)),configuracion,fundador) == $r.c($o) ) || ( $s.n($o) >= 5 ) { %tmp.registro.o = 500 }
    else { %tmp.registro.o = $l.db(chanserv\ $+ $r.c($d(5)),registros,$r.c($o)) }
    if ( $l.db(chanserv\ $+ $r.c($d(5)),niveles,memo) == DIS ) { %tmp.memo = 500 }
    else { %tmp.memo = $l.db(chanserv\ $+ $r.c($d(5)),niveles,memo) }
    if ( %tmp.registro.o < %tmp.memo ) { m 4Permiso denegado. | l.v }
    if ( $l.db(chanserv\ $+ $r.c($d(5)),memos,$d(6)) == $null ) { m El mensaje12 $d(6) no existe. | l.v }
    %tmp.memo.datos = $l.db(chanserv\ $+ $r.c($d(5)),memos,$d(6))
    %tmp.memo.origen = $gettok(%tmp.memo.datos,1,32)
    %tmp.memo.fecha = $gettok(%tmp.memo.datos,2,32)
    %tmp.memo.mensaje = $gettok(%tmp.memo.datos,4-,32)
    if ( $gettok(%tmp.memo.datos,3,32) == 0 ) {
      %tmp.memo.nuevos = $l.db(chanserv\ $+ $r.c($d(5)),stats,total.memos.nuevos)
      dec %tmp.memo.nuevos
      g.db chanserv\ $+ $r.c($d(5)) memos $d(6) %tmp.memo.origen %tmp.memo.fecha 1 %tmp.memo.mensaje
      g.db chanserv\ $+ $r.c($d(5)) stats total.memos.nuevos %tmp.memo.nuevos
    }
    m Mensaje12 $d(6) de12 $r.c(%tmp.memo.origen) (12 $+ $f(%tmp.memo.fecha) $+ ). Para borrarlo, escriba 12/msg $memoserv DEL $d(6)
    m $p.c(%tmp.memo.mensaje)
    l.v
  }
  else {
    if ( $d(5) == $null ) { m Error de Sintaxis: 12READ <numero/last> | m 12/msg $memoserv AYUDA READ para más información. | l.v }
    if ( $n.i($o) == no ) { m Debes identificarte antes de utilizar el comando 12READ. | l.v }
    if ($d(5) == last) {
      if ($ini(database\nickserv\ $+ $r.c($o),memos,1)) {
        %tmp.memo.datos = $l.db(nickserv\ $+ $r.c($o),memos,$ini(database\nickserv\ $+ $r.c($o),memos,0))
        %tmp.memo.origen = $gettok(%tmp.memo.datos,1,32)
        %tmp.memo.fecha = $gettok(%tmp.memo.datos,2,32)
        %tmp.memo.mensaje = $gettok(%tmp.memo.datos,4-,32)
        if ( $gettok(%tmp.memo.datos,3,32) == 0 ) {
          %tmp.memo.nuevos = $l.db(nickserv\ $+ $r.c($o),stats,total.memos.nuevos)
          dec %tmp.memo.nuevos
          g.db nickserv\ $+ $r.c($o) memos $ini(database\nickserv\ $+ $r.c($o),memos,0) %tmp.memo.origen %tmp.memo.fecha 1 %tmp.memo.mensaje
          g.db nickserv\ $+ $r.c($o) stats total.memos.nuevos %tmp.memo.nuevos
        }
        m Mensaje12 $ini(database\nickserv\ $+ $r.c($o),memos,0) de12 $r.c(%tmp.memo.origen) (12 $+ $f(%tmp.memo.fecha) $+ ). Para borrarlo, escriba 12/msg $memoserv DEL $ini(database\nickserv\ $+ $r.c($o),memos,0)
        m $p.c(%tmp.memo.mensaje)
        l.v
      }
      m No tiene mensajes.
      l.v
    }
    if ( $l.db(nickserv\ $+ $r.c($o),memos,$d(5)) == $null ) { m El mensaje12 $d(5) no existe. | l.v }
    %tmp.memo.datos = $l.db(nickserv\ $+ $r.c($o),memos,$d(5))
    %tmp.memo.origen = $gettok(%tmp.memo.datos,1,32)
    %tmp.memo.fecha = $gettok(%tmp.memo.datos,2,32)
    %tmp.memo.mensaje = $gettok(%tmp.memo.datos,4-,32)
    if ( $gettok(%tmp.memo.datos,3,32) == 0 ) {
      %tmp.memo.nuevos = $l.db(nickserv\ $+ $r.c($o),stats,total.memos.nuevos)
      dec %tmp.memo.nuevos
      g.db nickserv\ $+ $r.c($o) memos $d(5) %tmp.memo.origen %tmp.memo.fecha 1 %tmp.memo.mensaje
      g.db nickserv\ $+ $r.c($o) stats total.memos.nuevos %tmp.memo.nuevos
    }
    m Mensaje12 $d(5) de12 $r.c(%tmp.memo.origen) (12 $+ $f(%tmp.memo.fecha) $+ ). Para borrarlo, escriba 12/msg $memoserv DEL $d(5)
    m $p.c(%tmp.memo.mensaje)
    l.v
  }
}

alias memoserv.del {
  if ( $mid($d(5),1,1) == $chr(35) ) {
    if ( $d(6) == $null ) { m Error de Sintaxis: 12DEL <canal> <numero> | m 12/msg $memoserv AYUDA DEL para más información. | l.v }
    if ( $ca.r($d(5)) == no ) { m El canal12 $d(5) no está registrado. | l.v }
    if ( $n.i($o) == no ) { m Debes identificarte antes de utilizar el comando 12DEL. | l.v }
    if ( $l.db(nickserv\ $+ $r.c($o),ifundador,$r.c($d(5))) == $null ) && ( $l.db(chanserv\ $+ $r.c($d(5)),registros,$r.c($o)) == $null ) && ( $l.db(chanserv\ $+ $r.c($d(5)),configuracion,fundador) != $r.c($o) ) && ( $s.n($o) < 5 ) { m 4Permiso denegado. | l.v }
    if ( $l.db(nickserv\ $+ $r.c($o),ifundador,$r.c($d(5))) != $null ) || ( $l.db(chanserv\ $+ $r.c($d(5)),configuracion,fundador) == $r.c($o) ) || ( $s.n($o) >= 5 ) { %tmp.registro.o = 500 }
    else { %tmp.registro.o = $l.db(chanserv\ $+ $r.c($d(5)),registros,$r.c($o)) }
    if ( $l.db(chanserv\ $+ $r.c($d(5)),niveles,memo) == DIS ) { %tmp.memo = 500 }
    else { %tmp.memo = $l.db(chanserv\ $+ $r.c($d(5)),niveles,memo) }
    if ( %tmp.registro.o < %tmp.memo ) { m 4Permiso denegado. | l.v }
    if ( $l.db(chanserv\ $+ $r.c($d(5)),stats,total.memos) == 0 ) { m El canal12 $d(5) no tiene mensajes | l.v }
    if ( $d(6) == ALL ) {
      b.db chanserv\ $+ $r.c($d(5)) memos
      g.db chanserv\ $+ $r.c($d(5)) stats total.memos 0
      g.db chanserv\ $+ $r.c($d(5)) stats total.memos.nuevos 0
      m Todos sus mensajes han sido borrados.
      l.v
    }
    if ( $l.db(chanserv\ $+ $r.c($d(5)),memos,$d(6)) == $null ) { m El mensaje12 $d(6) no existe. | l.v }
    %tmp.memo.datos = $l.db(chanserv\ $+ $r.c($d(5)),memos,$d(6))
    if ( $gettok(%tmp.memo.datos,3,32) == 0 ) {
      %tmp.memo.nuevos = $l.db(chanserv\ $+ $r.c($d(5)),stats,total.memos.nuevos)
      dec %tmp.memo.nuevos
      g.db chanserv\ $+ $r.c($d(5)) stats total.memos.nuevos %tmp.memo.nuevos
    }
    %tmp.memos = $l.db(chanserv\ $+ $r.c($d(5)),stats,total.memos)
    dec %tmp.memos
    b.db chanserv\ $+ $r.c($d(5)) memos $d(6)
    g.db chanserv\ $+ $r.c($d(5)) stats total.memos %tmp.memos
    m Mensaje12 $d(6) ha sido borrado.
    %tmp.memos.c = $d(6)
    :o.mc
    inc %tmp.memos.c
    if ( $l.db(chanserv\ $+ $r.c($d(5)),memos,%tmp.memos.c) == $null ) { goto f.omc }
    %tmp.memo.d = $l.db(chanserv\ $+ $r.c($d(5)),memos,%tmp.memos.c)
    g.db chanserv\ $+ $r.c($d(5)) memos $calc(%tmp.memos.c -1) %tmp.memo.d
    b.db chanserv\ $+ $r.c($d(5)) memos %tmp.memos.c
    goto o.mc
    :f.omc
    l.v
  }
  else {
    if ( $d(5) == $null ) { m Error de Sintaxis: 12DEL <numero> | m 12/msg $memoserv AYUDA DEL para más información. | l.v }
    if ( $n.i($o) == no ) { m Debes identificarte antes de utilizar el comando 12DEL. | l.v }
    if ( $d(5) == ALL ) {
      b.db nickserv\ $+ $r.c($o) memos
      g.db nickserv\ $+ $r.c($o) stats total.memos 0
      g.db nickserv\ $+ $r.c($o) stats total.memos.nuevos 0
      m Todos sus mensajes han sido borrados.
      l.v
    }
    if ( $l.db(nickserv\ $+ $r.c($o),memos,$d(5)) == $null ) { m El mensaje12 $d(5) no existe. | l.v }
    %tmp.memo.datos = $l.db(nickserv\ $+ $r.c($o),memos,$d(5))
    if ( $gettok(%tmp.memo.datos,3,32) == 0 ) {
      %tmp.memo.nuevos = $l.db(nickserv\ $+ $r.c($o),stats,total.memos.nuevos)
      dec %tmp.memo.nuevos
      g.db nickserv\ $+ $r.c($o) stats total.memos.nuevos %tmp.memo.nuevos
    }
    %tmp.memos = $l.db(nickserv\ $+ $r.c($o),stats,total.memos)
    dec %tmp.memos
    b.db nickserv\ $+ $r.c($o) memos $d(5)
    g.db nickserv\ $+ $r.c($o) stats total.memos %tmp.memos
    m Mensaje12 $d(5) ha sido borrado.
    %tmp.memos.c = $d(5)
    :o.mn
    inc %tmp.memos.c
    if ( $l.db(nickserv\ $+ $r.c($o),memos,%tmp.memos.c) == $null ) { goto f.omn }
    %tmp.memo.d = $l.db(nickserv\ $+ $r.c($o),memos,%tmp.memos.c)
    g.db nickserv\ $+ $r.c($o) memos $calc(%tmp.memos.c -1) %tmp.memo.d
    b.db nickserv\ $+ $r.c($o) memos %tmp.memos.c
    goto o.mn
    :f.omn
    l.v
  }
}

alias memoserv.set {
  if ( $d(5) == NOTIFY ) {
    if ( $n.i($o) == no ) { m Debes identificarte antes de utilizar el comando 12NOTIFY. | l.v }
    if ( $d(6) == ON ) {
      g.db nickserv\ $+ $r.c($o) configuracion notify on
      m 12 $+ $memoserv te notificará tus mensajes cuando te conectes o cuando te los envie.
      l.v
    }
    if ( $d(6) == LOGON ) {
      g.db nickserv\ $+ $r.c($o) configuracion notify logon
      m 12 $+ $memoserv te notificará tus mensajes cuando te conectes o canceles tu modo /AWAY.
      l.v
    }
    if ( $d(6) == NEW ) {
      g.db nickserv\ $+ $r.c($o) configuracion notify new
      m 12 $+ $memoserv te notificará tus mensajes cuando te sean enviados.
      l.v
    }
    if ( $d(6) == OFF ) {
      b.db nickserv\ $+ $r.c($o) configuracion notify
      m 12 $+ $memoserv no te notificará tus mensajes.
      l.v
    }
    m Sintaxis: 12SET NOTIFY $chr(123) $+ ON $chr(124) LOGON $chr(124) NEW $chr(124) OFF $+ $chr(125)
    m 12/msg $memoserv AYUDA SET NOTIFY para más información.
    l.v
  }
  m Error de Sintaxis: 12SET <opcion> <parametros>
  m 12/msg $memoserv AYUDA SET para más información.
  l.v
}

alias memoserv.envia {
  if ( $mid($1,1,1) == $chr(35) ) {
    %tmp.t.memos = $l.db(chanserv\ $+ $r.c($1),stats,total.memos)
    %tmp.t.memosn = $l.db(chanserv\ $+ $r.c($1),stats,total.memos.nuevos)
    inc %tmp.t.memos
    inc %tmp.t.memosn
    g.db chanserv\ $+ $r.c($1) memos %tmp.t.memos $2 $ctime 0 $q.c($3-)
    g.db chanserv\ $+ $r.c($1) stats total.memos %tmp.t.memos
    g.db chanserv\ $+ $r.c($1) stats total.memos.nuevos %tmp.t.memosn
  }
  else {
    %tmp.t.memos = $l.db(nickserv\ $+ $r.c($1),stats,total.memos)
    %tmp.t.memosn = $l.db(nickserv\ $+ $r.c($1),stats,total.memos.nuevos)
    inc %tmp.t.memos
    inc %tmp.t.memosn
    g.db nickserv\ $+ $r.c($1) memos %tmp.t.memos $2 $ctime 0 $q.c($3-)
    g.db nickserv\ $+ $r.c($1) stats total.memos %tmp.t.memos
    g.db nickserv\ $+ $r.c($1) stats total.memos.nuevos %tmp.t.memosn
    if ( $n.i($1) == si ) {
      if ( $l.db(nickserv\ $+ $r.c($1),configuracion,notify) == on ) || ( $l.db(nickserv\ $+ $r.c($1),configuracion,notify) == new ) { s : $+ $memoserv %conf.metodo $1 :Tienes un mensaje nuevo de12 $2 $+ . Mensaje numero12 %tmp.t.memos $+ . Escribe /msg $memoserv READ LAST para leerlo. }
    }
  }
}

alias memoserv.miramemos {
  if ( $mid($1,1,1) == $chr(35) ) {
    if ( $l.db(chanserv\ $+ $r.c($1),stats,total.memos.nuevos) > 0 ) {
      if ( $l.db(nickserv\ $+ $r.c($2),fundador,$r.c($1)) == $null ) && ( $l.db(chanserv\ $+ $r.c($1),registros,$r.c($2)) == $null ) && ( $l.db(chanserv\ $+ $r.c($1),configuracion,fundador) != $r.c($2) ) && ( $s.n($2) < 5 ) { return }
      if ( $l.db(nickserv\ $+ $r.c($2),fundador,$r.c($1)) != $null ) || ( $l.db(chanserv\ $+ $r.c($1),configuracion,fundador) == $r.c($2) ) || ( $s.n($2) >= 5 ) { %tmp.registro.o = 500 }
      else { %tmp.registro.o = $l.db(chanserv\ $+ $r.c($1),registros,$r.c($2)) }
      if ( $l.db(chanserv\ $+ $r.c($1),niveles,memo) == DIS ) { %tmp.memo = 500 }
      else { %tmp.memo = $l.db(chanserv\ $+ $r.c($1),niveles,memo) }
      if ( %tmp.registro.o < %tmp.memo ) { return }
      %tmp.memos.nuevos = $l.db(chanserv\ $+ $r.c($1),stats,total.memos.nuevos)
      if ( %tmp.memos.nuevos == 1 ) { %tmp.memo.nuevos.texto = mensaje nuevo del canal12 $1 $+ . }
      else { %tmp.memo.nuevos.texto = mensajes nuevos del canal12 $1 $+ . }
      s : $+ $memoserv %conf.metodo $2 :Tienes12 %tmp.memos.nuevos  $+ %tmp.memo.nuevos.texto
      s : $+ $memoserv %conf.metodo $2 :Escribe 12/msg $memoserv LIST $1 NEW para darte una lista de mensajes nuevos.
    }
  }
  else {
    if ( $n.i($1) == si ) {
      if ( $l.db(nickserv\ $+ $r.c($1),stats,total.memos.nuevos) > 0 ) {
        if ( $l.db(nickserv\ $+ $r.c($1),configuracion,notify) == on ) || ( $l.db(nickserv\ $+ $r.c($1),configuracion,notify) == logon ) {
          %tmp.memos.nuevos = $l.db(nickserv\ $+ $r.c($1),stats,total.memos.nuevos)
          if ( %tmp.memos.nuevos == 1 ) { %tmp.memo.nuevos.texto = mensaje nuevo. }
          else { %tmp.memo.nuevos.texto = mensajes nuevos. }
          s : $+ $memoserv %conf.metodo $1 :Tienes12 %tmp.memos.nuevos  $+ %tmp.memo.nuevos.texto
          s : $+ $memoserv %conf.metodo $1 :Escribe 12/msg $memoserv LIST NEW para darte una lista de mensajes nuevos.
        }
      }
    }
  }
}

alias memoserv.memo {
  if ( $d(4) == USERS ) {
    if ( $3 == $null ) { m Error de Sintaxis:12 USERS <nick> <mensaje> | l.v }
  }
  if ( $3 == $null ) { m Error de Sintaxis:12 $upper($d(4)) <mensaje> | l.v }
  %tmp.n.r = $findfile($mircdirdatabase\nickserv\,*,0)
  %tmp.n = 0
  while ( %tmp.n < %tmp.n.r ) {
    inc %tmp.n
    %tmp.n.a = $nopath($findfile($mircdirdatabase\nickserv\,*,%tmp.n))
    if ( $l.db(nickserv\ $+ %tmp.n.a,representante,tipo ) == $1 ) { memoserv.envia $r.c(%tmp.n.a) $2- }
    if ( $1 == USERS ) { memoserv.envia $r.c(%tmp.n.a) $2 $3- }
  }
  debugc $memoserv %conf.canal.admins 12 $+ $o envía un mensaje a los $upper($d(4)) de la red.
  debugc $memoserv %conf.canal.opers 12 $+ $o envía un mensaje a los $upper($d(4)) de la red.
  m Mensaje enviado.
  l.v
}

alias memoserv.nomemos {
  if ($d(5)) && ($d(5) == add || $d(5) == del || $d(5) == list) {
    if ($d(5) == add) {
      if ($d(6)) {
        if ($n.r($d(6)) == si) {
          if ($l.db(nickserv\ $+ $r.c($o),nomemos,$d(6))) {
            m 4ERROR: El usuario12 $d(6) ya está en tu lista negra.
            l.v
          }
          g.db nickserv\ $+ $r.c($o) nomemos $d(6)) $ctime
          m Añadido el usuario12 $d(6) a la lista negra.
          l.v
        }
        m 4ERROR: El nick12 $d(6) no está registrado.
        l.v
      }
      m Error de Sintaxis: 12NOMEMOS ADD <nick>
      l.v
    }
    if ($d(5) == del) {
      if ($d(6)) {
        if ($l.db(nickserv\ $+ $r.c($o),nomemos,$d(6))) {
          b.db nickserv\ $+ $r.c($o) nomemos $d(6))
          m Borrado el usuario12 $d(6) de la lista negra.
          l.v
        }
        m 4ERROR: El usuario12 $d(6) no está en tu lista negra.
        l.v
      }
      m Error de Sintaxis: 12NOMEMOS DEL <nick>
      l.v
    }
    if ($d(5) == list) {
      if ($ini(database\nickserv\ $+ $r.c($o),nomemos,0) >= 1) {
        m Lista de usuarios que no podran mandarte mesajes via memo:
        m
        var %a 1
        while ($ini(database\nickserv\ $+ $r.c($o),nomemos,%a)) {
          var %d = $l.db(nickserv\ $+ $r.c($o),nomemos,$ini(database\nickserv\ $+ $r.c($o),nomemos,%a))
          m 06 $+ %a $+ -12 $ini(database\nickserv\ $+ $r.c($o),nomemos,%a) añadido el12 $date(%d) a las12 $time(%d) 6(GMT +01:006)
          inc %a 1
        }
        m
        m Fin de la lista, total de entradas12 %a $+ .
        l.v
      }
      m Lista negra 3vacia.
      l.v
    }
  }
  m Error de Sintaxis: 12NOMEMOS $chr(123) $+ ADD $chr(124) DEL $chr(124) LIST $+ $chr(125) <nick>
  m 12/msg $memosev AYUDA NOMEMOS para más información.
  l.v
}
