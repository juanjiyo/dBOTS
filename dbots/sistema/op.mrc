on 1:sockread:dbots: {
  if ( $d(2) == PRIVMSG ) || ( $d(2) == NOTICE ) && (( $d(3) == $operserv ) || ( $d(3) == $operserv $+ @ $+ %conf.servidor )) && (!$l.db(servidores.db,servidores,$d(1))) { p.m $operserv | c.r PO | operserv.procesa }
}

alias operserv.procesa {
  if ( $d(4) == AYUDA ) || ( $d(4) == HELP ) { operserv.ayuda }
  if ( $d(4) == STATS ) { operserv.stats }
  if ( $d(4) == IRCOPS ) { operserv.ircops }
  if ( $d(4) == OP ) { operserv.op }
  if ( $d(4) == DEOP ) { operserv.deop }
  if ( $d(4) == MODE ) { operserv.mode }
  if ( $d(4) == KICK ) { operserv.kick }
  if ( $d(4) == KILL ) { operserv.kill }
  if ( $d(4) == BLOCK ) { operserv.block }
  if ( $d(4) == GLINE ) { c.r O | operserv.gline }
  if ( $d(4) == ROOT ) { c.r O | operserv.root }
  if ( $d(4) == SETTIME ) { c.r O | operserv.settime }
  if ( $d(4) == APODERA ) { c.r O | operserv.apodera }
  if ( $d(4) == invite) { c.r O | operserv.invite }
  if ( $d(4) == LIMPIA ) { c.r O | operserv.limpia }
  if ( $d(4) == RENAME ) { c.r O | operserv.rename }
  if ( $d(4) == DROPNDB ) { c.r R | operserv.dropndb }
  if ( $d(4) == KILLCLONES ) { c.r O | operserv.killclones }
  if ( $d(4) == LISTCLONES ) { c.r O | operserv.listclones }
  if ( $d(4) == SPAM ) { c.r O | operserv.spam }
  if ($d(4) == SET) { c.r R | operserv.set }
  m Comando desconocido12 $strip($d(4)) $+ . "12/msg $operserv AYUDA" para ayuda.
  l.v
}

alias operserv.ayuda {
  if ($d(5)) { m.h $operserv $o helps\op.help $replace($d(5-),$chr(32),-) }
  else {
    m.h $operserv $o helps\op.help help
    if ( $s.n($o) >= 5 ) { m.h $operserv $o helps\op.help help-o }
    if ( $s.n($o) >= 7 ) { m.h $operserv $o helps\op.help help-a }
    if ( $s.n($o) >= 8 ) { m.h $operserv $o helps\op.help help-r }
    if ( $s.n($o) >= 4 ) { m.h $operserv $o helps\op.help help-f }
  }
  l.v
}

alias operserv.stats {
  m Estadísticas de12 %conf.red
  m
  m Usuarios en el IRC:12 $ini(database\usuarios.db,usuarios,0)
  m Canales creados:12 $ini(database\canales.db,canales.t.u,0)

  m Nicks registrados:12 $findfile($mircdirdatabase\nickserv\,*,0)
  m Canales registrados:12 $findfile($mircdirdatabase\chanserv\,*,0)
  m Tiempo que lleva el PC encendido:12 $t($uptime(system,3))
  m Tiempo que llevan conectados los bots:12 $t($calc($ctime - %i.bots))
  m Servidores activos en el IRC:
  var %a 1
  while ($ini(database\servidores.db,servidores,%a)) {
    var %b = $ini(database\servidores.db,servidores,%a)
    if (%b != $l.conf(servidor,servidor)) && (%b != $l.db(modulosserv,sname)) && (%b != $l.conf(debugserv,sname)) {
      m 12     $+ $ini(database\servidores.db,servidores,%a)
    }
    inc %a 1
  }
  m
  m Fin de las estadísticas.
  l.v
}

alias operserv.ircops {
  m Lista de Representantes conectados:
  flushini $mircdirdatabase\representantes.db
  %tmp.ruta = $mircdirdatabase\representantes.db
  if ( $initopic( %tmp.ruta , conectados ) == 0 ) { goto f.lr }
  clear @crepresentantes
  window -hl @crepresentantes
  loadbuf -tconectados @crepresentantes $mircdirdatabase\representantes.db
  %tmp.total = $line(@crepresentantes,0)
  %tmp.linea = 0
  while ( %tmp.linea < %tmp.total ) {
    inc %tmp.linea
    %tmp.l.linea = $line( @crepresentantes , %tmp.linea )
    %tmp.nick = $r.c($gettok(%tmp.l.linea,1,61))
    %tmp.tipo = $gettok(%tmp.l.linea,2,61)
    m %tmp.nick es un12 %tmp.tipo de la red.
  }
  :f.lr
  m Fin de la lista.
  l.v
}

alias operserv.op {
  if ( $d(6) == $null ) { m Error de Sintaxis: 12OP <canal> <nick> | l.v }
  s : $+ $operserv MODE $d(5) +o $d(6)
  debugc $operserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o hace OP a12 $d(6) en12 $d(5)
  l.v
}

alias operserv.deop {
  if ( $d(6) == $null ) { m Error de Sintaxis: 12DEOP <canal> <nick> | l.v }
  s : $+ $operserv MODE $d(5) -o $d(6)
  debugc $operserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o hace DEOP a12 $d(6) en12 $d(5)
  l.v
}

alias operserv.mode {
  if ( $d(6) == $null ) { m Error de Sintaxis: 12MODE <canal> <+/-modos> | l.v }
  s : $+ $operserv MODE $d(5) $d(6-)
  debugc $operserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o establece los modos de12 $d(5) a12 $d(6-)
  l.v
}

alias operserv.kick {
  if ( $d(7) == $null ) { m Error de Sintaxis: 12KICK <canal> <nick> <motivo> | l.v }
  k.c $d(5) $d(6) $d(7-)
  debugc $operserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o expulsa a12 $d(6) de12 $d(5) $+ . Motivo:12 $d(7-)
  l.v
}

alias operserv.kill {
  if ( $d(6) == $null ) { m Error de Sintaxis: 12KILL <nick> <motivo> | l.v }
  if ( $n.c($d(5)) == no ) { m El nick12 $d(5) no está conectado. | l.v }
  if ( $s.n($o) <= $s.n($d(5)) ) { m 4Permiso denegado. | l.v }
  k $o $d(5) $d(6-)
  m El usuario12 $d(5) ha sido expulsado.
  debugc $operserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o utiliza KILL sobre12 $d(5) $+ . Motivo:12 $d(6-)
  l.v
}

alias operserv.block {
  if ( $d(6) == $null ) { m Error de Sintaxis: 12BLOCK <nick> <motivo> | l.v }
  if ( $n.c($d(5)) == no ) { m El nick12 $d(5) no está conectado. | l.v }
  %tmp.host = $l.db(usuarios.db,usuarios,$r.c($d(5)))
  %tmp.host = $gettok(%tmp.host,2,32)
  if ( $gline.c.p(%tmp.host) == si ) {
    m 4Permiso denegado.
    debugc $operserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o ha intentado poner un BLOCK a un host de representante ( $+ %tmp.host $+ )
    l.v
  }
  g 1 $chr(42) %tmp.host $o 300 $d(6-)
  m El usuario12 $d(5) ha sido expulsado.
  debugc $operserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o utiliza BLOCK sobre12 $d(5) $+ . Motivo:12 $d(6-)
  l.v
}

alias operserv.gline {
  if ( $d(5) == ADD ) {
    if ( $d(8) == $null ) { m Error de Sintaxis: 12GLINE ADD <+expiración> <host> <motivo> | l.v }
    %tmp.expiracion = $check.exp($remove( $d(6) , +))
    if ( %tmp.expiracion < 0) { m El tiempo expecificado no es válido. | l.v }
    if ( %tmp.expiracion != 0 ) && ( %tmp.expiracion < 300 ) { m El tiempo de G-Line debe ser como mínimo mayor ó igual a 5 minutos (300 segundos). | l.v }
    if ( $l.db(kline.db,kline,$d(7)) != $null ) { m 12 $+ $d(7) ya existe en la lista de K-Lines. | l.v }
    if ( $l.db(gline.db,gline,$d(7)) != $null ) { m 12 $+ $d(7) ya existe en la lista de G-Lines. | l.v }
    %tmp.ident = $gettok($d(7),1,64)
    %tmp.host = $gettok($d(7),2,64)
    if ( $chr(64) !isin $d(7) ) || ( * !isin %tmp.host ) && ( . !isin %tmp.host ) { m 12 $+ $d(7) no es un G-Line válido espicifique 12ident@host. | l.v }
    if ( %tmp.ident == $chr(42) ) && ( %tmp.host == $chr(42) ) {
      m No se permite un G-Line global.
      debugc $operserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o intenta poner un G-Line global.
      l.v
    }
    e.gline
    if ( $gline.c.p(%tmp.host) == si ) {
      m 4Permiso denegado.
      debugc $operserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o ha intentado poner un G-Line a un host de representante ( $+ %tmp.host $+ )
      l.v
    }
    g 1 %tmp.ident %tmp.host $o %tmp.expiracion $d(8-)
    m Añadido un G-Line para12 $d(7) $+ .
    debugc $operserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o añade un G-Line a12 $d(7) $+ . $iif(%tmp.expiracion == 0,4GLINE PERMANENTE,Duración $t(%tmp.expiracion)) $+ . Motivo:12 $d(8-)
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
    debugc $operserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o retira el G-Line a12 $d(6) $+ .
    l.v
  }
  if ( $d(5) == LIST ) {
    e.gline
    m Lista de G-Lines:
    flushini $mircdirdatabase\gline.db
    %tmp.ruta = $mircdirdatabase\gline.db
    if ( $initopic( %tmp.ruta , gline ) == 0 ) { goto f.lg }
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

alias operserv.root {
  if ( $d(5) == $null ) { m Error de Sintaxis: 12ROOT <contraseña> | l.v }
  if ( $l.db(representantes.db,roots,$r.c($o)) == $null ) { m Tu nick no está en la lista de Roots. | l.v }
  %tmp.password = $l.db(representantes.db,roots,$r.c($o))
  if ( $d(5) === %tmp.password ) {
    g.db status.db status $r.c($o) 8
    m 3Identificado como root correctamente.
    debugc $operserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o se identifica como root.
    l.v
  }
  else {
    m 4Contraseña incorrecta.
    debugc $operserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o se intenta identificar como root pero la contraseña es incorrecta.
    l.v
  }
}

alias operserv.apodera {
  if ( $d(5) == $null ) { m Error de Sintaxis: 12APODERA <canal> | l.v }
  %tipo.who = APODERA
  %who.origen = $o
  s : $+ $chanserv WHO $d(5)
  debugc $operserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o se apodera del canal12 $d(5) $+ .
  l.v
}

alias operserv.limpia {
  if ( $d(5) == $null ) { m Error de Sintaxis: 12LIMPIA <canal> | l.v }
  %tipo.who = LIMPIA
  %who.origen = $o
  s : $+ $chanserv WHO $d(5)
  debugc $operserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o limpia el canal12 $d(5) $+ .
  l.v
}

alias operserv.rename {
  if ( $d(5) == $null ) { m Error de Sintaxis: 12RENAME <nick> | l.v }
  if ( $n.c($d(5)) == no ) { m El nick12 $d(5) no está conectado. | l.v }
  if ( $s.n($o) < $s.n($d(5)) ) { m 4Permiso denegado. | l.v } 
  r.n $d(5)
  debugc $operserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o cambia el nick a12 $d(5) $+ .
  l.v
}

alias operserv.dropndb {
  if ( $d(5) == $null ) { m Error de Sintaxis: 12DROPNDB <nick> | l.v }
  a.t N:: $+ $d(5)
  m El nick12 $d(5) ha sido borrado de la DB.
  debugc $operserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o borra el nick12 $d(5) $+  de la DB.
  l.v
}

alias operserv.killclones {
  if ( $d(6) == $null ) { m Error de Sintaxis: 12KILLCLONES <nick> <motivo> | l.v }
  if ( $n.c($d(5)) == no ) { m El nick12 $d(5) no está conectado. | l.v }
  %tmp.host = $l.db(usuarios.db,usuarios,$r.c($d(5)))
  %tmp.host = $gettok(%tmp.host,2,32)
  if ( $gline.c.p(%tmp.host) == si ) {
    m 4Permiso denegado.
    debugc $operserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o ha intentado hacer un KILLCLONES a un host de representante ( $+ %tmp.host $+ )
    l.v
  }
  g 1 $chr(42) %tmp.host $o 60 $d(6-)
  m Los clones del usuario12 $d(5) han sido expulsados.
  debugc $operserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o utiliza KILLCLONES sobre12 $d(5) $+ . Motivo:12 $d(6-)
  l.v
}

alias operserv.listclones {
  if ( $d(5) == $null ) { m Error de Sintaxis: 12LISTCLONES <nick> | l.v }
  if ( $n.c($d(5)) == no ) { m El nick12 $d(5) no está conectado. | l.v }
  %tmp.ip = $l.db(usuarios.db,usuarios,$r.c($d(5)))
  %tmp.ip = $gettok(%tmp.ip,2,32)
  flushini $mircdirdatabase\clones.db
  %tmp.ruta = $mircdirdatabase\clones.db
  clear @clonesn
  window -hl @clonesn
  loadbuf -t $+ %tmp.ip @clonesn $mircdirdatabase\clones.db
  %tmp.total = $line(@clonesn,0)
  if ( %tmp.total == 1 ) { m 12 $+ $d(5) no tiene clones. | l.v }
  %tmp.linea = 0
  m Clones de12 $d(5) (12 $+ %tmp.ip $+ )
  while ( %tmp.linea < %tmp.total ) {
    inc %tmp.linea
    %tmp.l.linea = $line( @clonesn , %tmp.linea )
    %tmp.nick = $gettok(%tmp.l.linea,1,61)
    if ( $r.c(%tmp.nick) != $d(5) ) {
      %tmp.ident = $l.db(usuarios.db,usuarios,%tmp.nick)
      %tmp.ident = $gettok(%tmp.ident,1,32)
      m 12 $+ $r.c(%tmp.nick) (12 $+ %tmp.ident $+ )
    }
  }
  m Fin de la lista.
  l.v
}

alias operserv.settime {
  s : $+ %conf.servidor TSCTL SVSTIME $ctime
  m 12SETTIME ejecutado.
  debugc $operserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o ha usado12 SETTIME.
  l.v
}

alias operserv.invite {
  if ($d(5)) && (#* iswm $d(5)) {
    s : $+ $operserv invite $o $d(5)
  }
  else {
    m Sintaxis incorrecta:12 INVITE <canal>
  }
  l.v
}

alias operserv.set {
  if ($d(5)) {
    if ($d(5) == SUFIJO) {
      if ($d(6) isalpha) {
        a.t S::J $lower($d(6))
        m Sufijo para IPs virtuales cambiado a12 $d(6)
      }
      else {
        m 4ERROR: El sufijo de las IPs virtuales solo puede tener letras (menos la ñ, Ñ, ç y Ç)
      }
    }
    elseif  ($d(5) == nickserv) {
      if ($d(6)) && (*!*@* iswm $d(6)) && ($numtok($d(6),33) == 2) && ($numtok($d(6),64) == 2) {
        a.t S::N $d(6)
        m Nick del NiCKServ de UDB cambiado a12 $d(6)
      }
      else {
        m Sintaxis incorrecta: 12SET NICKSERV nick!ident@host
      }
    }
    elseif  ($d(5) == chanserv) {
      if ($d(6)) && (*!*@* iswm $d(6)) && ($numtok($d(6),33) == 2) && ($numtok($d(6),64) == 2) {
        a.t S::C $d(6)
        m Nick del CHaNServ de UDB cambiado a12 $d(6)
      }
      else {
        m Sintaxis incorrecta: 12SET CHANSERV nick!ident@host
      }
    }
    elseif  ($d(5) == ipserv) {
      if ($d(6)) && (*!*@* iswm $d(6)) && ($numtok($d(6),33) == 2) && ($numtok($d(6),64) == 2) {
        a.t S::I $d(6)
        m Nick del IPServ de UDB cambiado a12 $d(6)
      }
      else {
        m Sintaxis incorrecta: 12SET IPSERV nick!ident@host
      }
    }
    elseif  ($d(5) == passprotect) {
      if ($d(6)) && (*:* iswm $d(6)) && ($gettok($d(6),1,58) isnum) && ($gettok($d(6),2,58) isnum) && (, !isin $d(6)) && ($numtok($d(6),58) == 2) {
        a.t S::F $d(6)
        m Protección de password cambiada a12 $gettok($d(6),1,58) intentos antes de $gettok($d(6),2,58) segundos.
      }
      else {
        m Sintaxis incorrecta: 12SET PASSPROTECT veces:segundos
      }
    }
    elseif  ($d(5) == prefijos) {
      if ($d(6)) {
        a.t S::P $d(6)
        m Prefijos para +q +a +o +h +v cambiados a12 $d(6)
      }
      else {
        m Sintaxis incorrecta:12 SET PREFIJOS caracteres
      }
    }
  }
  else {
    m Error de Sintaxis: SET opción valor
  }
  l.v
}

alias operserv.spam {
  if ($d(5) == add) {
    if ($d(10)) && ($d(9) isnum) && (, !isin $d(9)) {
      if ($read(database\spam.db,s,$d(6))) {
        m 12 $+ $d(6) ya está en la lista.
      }
      else {
        if ($o.k.t($d(7))) && ($o.k.a($d(8))) {
          a.t K::F::= $+ $base64($replace($d(6),_,$chr(32))).enc $+ ::T $o.k.t($d(7))
          a.t K::F::= $+ $base64($replace($d(6),_,$chr(32))).enc $+ ::A $d(8)
          a.t K::F::= $+ $base64($replace($d(6),_,$chr(32))).enc $+ ::K * $+ $d(9)
          a.t K::F::= $+ $base64($replace($d(6),_,$chr(32))).enc $+ ::R $d(10-)
          write database\spam.db $d(6) $o $gettok(%datos,7-,32)
          m Añadido12 $d(6) a la lista de spam.
          debugc $operserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o añade12 $replace($d(6),_,$chr(32)) como spam.
        }
        else {
          if ($o.k.t($d(7)) == $false) {
            m 4ERROR: No has especificado lugares validos. Para ver los lugares escribe:
            m 12/msg $operserv HELP SPAM LUGARES
          }
          else {
            m 4ERROR: No has especificado una acción valida. Para ver las acciones validas escribe:
            m 12/msg $operserv HELP SPAM ACCIONES
          }
        }
      }
    }
    else {
      m Error de Sintaxis: 12SPAM ADD <palabra> <lugares> <accion> <tiempo> <razon>
    }
  }
  elseif ($d(5) == del) {
    if ($d(6)) {
      if ($read(database\spam.db,s,$d(6))) {
        a.t K::F::= $+ $base64($replace($d(6),_,$chr(32))).enc
        write -ds $+ $d(6) database\spam.db
        m Borrado12 $replace($d(6),_,$chr(32)) de la base de spam.
        debugc $operserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o borra12 $replace($d(6),_,$chr(32)) como spam.
      }
      else {
        m 12 $+ $replace($d(6),_,$cr(32)) no está en la lista.
      }      
    }
    else {
      m Error de Sintaxis: 12SPAM DEL <palabra>
    }
  }
  elseif ($d(5) == list) {
    if ($read(database\spam.db,1)) {
      m Lista de spam:
      m
      var %a 1
      while ($read(database\spam.db,%a)) {
        var %r = $read(database\spam.db,%a)
        m  $+ %a $+ -12 $gettok(%r,1,32)
        inc %a 1
      }
      m
      m Fin de la lista. Para ver más información escriba:
      m 12/msg $operserv SPAM VIEW <palabra>
    }
    else {
      m La lista de spam está vacia.
    }
  }
  elseif ($d(5) == view) {
    if ($d(6)) {
      if ($read(database\spam.db,s,$d(6))) {
        var %r = $read(database\spam.db,s,$d(6))
        m Información de spam sobre12 $d(6)
        m Añadido por: $gettok(%r,1,32)
        if ($gettok(%r,2,32) == all) {
          m Lugares a los que afecta: Mensajes a canales, mensajes privados, notices privados, notices a canales, mensaje de salida del canal, mensaje de salida del IRC, mensajes de away, topics en canales.
        }
        else {
          var %a 1
          var  %l = $gettok(%r,2,32)
          var %b
          while ($mid(%l,%a,1)) {
            if ($mid(%l,%a,1) === c) { $iif(%a == $len(%l),%b = %b y,%b = %b mensajes a canales $+ $chr(44)) }
            if ($mid(%l,%a,1) === p) { $iif(%a == $len(%l),%b = %b y,%b = %b mensajes privados $+ $chr(44)) }
            if ($mid(%l,%a,1) === n) { $iif(%a == $len(%l),%b = %b y,%b = %b notices privados $+ $chr(44)) }
            if ($mid(%l,%a,1) === N) { $iif(%a == $len(%l),%b = %b y,%b = %b notices a canales $+ $chr(44)) }
            if ($mid(%l,%a,1) === P) { $iif(%a == $len(%l),%b = %b y,%b = %b mensajes de salida del canal $+ $chr(44)) }
            if ($mid(%l,%a,1) === q) { $iif(%a == $len(%l),%b = %b y,%b = %b mensajes de salida del IRC $+ $chr(44)) }
            if ($mid(%l,%a,1) === d) { $iif(%a == $len(%l),%b = %b y,%b = %b envio por DCC $+ $chr(44)) }
            if ($mid(%l,%a,1) === a) { $iif(%a == $len(%l),%b = %b y,%b = %b mensajes de away $+ $chr(44)) }
            if ($mid(%l,%a,1) === t) { $iif(%a == $len(%l),%b = %b y,%b = %b topics de canales $+ $chr(44)) }
            if ($mid(%l,%a,1) === u) { $iif(%a == $len(%l),%b = %b y,%b = %busuarios  (nick!user@host:realname) $+ $chr(44)) }
            inc %a 1
          }
          m Lugares a los que afecta: %b
        }
        m Acción a tomar: $gettok(%r,3,32)
        m Tiempo (en segundos): $gettok(%r,4,32)
        m Mensaje: $gettok(%r,5-,32)
      }
      else {
        m 4ERROR:12 $d(6) no está en la lista de spam.
      }
    }
    else {
      m Error de sintaxis:12 SPAM VIEW <palabra>
    }
  }
  else {
    m Error de Sintaxis: 12SPAM $chr(123) ADD $chr(124) DEL $chr(124) LIST $chr(124) VIEW $chr(125)
  }
  l.v
}

alias o.k.t {
  if ($1 == all) {
    %m = cpnNPqat
  }
  else {
    var %a 1
    var %t $1
    var %m
    while ($mid(%t,%a,1)) {
      if ($mid(%t,%a,1) isincs cpnNPqdatu) && ($mid(%t,%a,1) !isincs %m) {
        %m = %m $+ $mid(%t,%a,1)
      }
      inc %a 1
    }
  }
  return $iif(%m,%m,$false)
}

alias o.k.a {
  if ($1 == kill) { return 1 }
  elseif ($1 == tempshun) { return 1 }
  elseif ($1 == shun) { return 1 }
  elseif ($1 == kline) { return 1 }
  elseif ($1 == zline) { return 1 }
  elseif ($1 == gline) { return 1 }
  elseif ($1 == gzline) { return 1 }
  elseif ($1 == block) { return 1 }
  elseif ($1 == dccblock) { return 1 }
  elseif ($1 == viruschan) { return 1 }
  elseif ($1 == warn) { return 1 }
  else { return 0 }
}
