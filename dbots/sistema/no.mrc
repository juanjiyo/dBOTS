alias noticiasserv.ayuda {
  if ($d(5)) { m.h $noticiasserv $o helps\no.help $replace($d(5-),$chr(32),-) }
  else {
    m.h $noticiasserv $o helps\no.help help
    if ( $s.n($o) >= 7 ) { m.h $noticiasserv $o helps\no.help help-a }
    if ( $s.n($o) >= 7 ) { m.h $noticiasserv $o helps\no.help help-f }
  }
  l.v
}

on 1:sockread:dbots:{
  if ( $d(2) == PRIVMSG ) || ( $d(2) == NOTICE ) && (( $d(3) == $noticiasserv ) || ( $d(3) == $noticiasserv $+ @ $+ %conf.servidor )) { p.m $noticiasserv | noticiasserv.procesa }
}

alias noticiasserv.procesa {
  if ( $d(4) == AYUDA ) || ( $d(4) == HELP ) { noticiasserv.ayuda }
  if ( $d(4) == ALTA ) { noticiasserv.alta }
  if ( $d(4) == BAJA ) { noticiasserv.baja }
  if ( $d(4) == EMAIL ) { c.r A | noticiasserv.email }
  if ( $d(4) == MOTD ) { c.r A | noticiasserv.motd }
  if ( $d(4) == NICK ) { c.r A | noticiasserv.nick }
  if ( $d(4) == REPRESENTANTES ) { c.r A | noticiasserv.representantes }
  if ($d(4) == noticias) { c.r A | noticiasserv.noticias }
  if ($d(4) == servidor) { c.r A | noticiasserv.servidor }
  m Comando desconocido12 $strip($d(4)) $+ . "12/msg $noticiasserv AYUDA" para ayuda.
  l.v
}

alias noticiasserv.alta {
  if ( $n.i($o) == no ) { m Debes identificarte para poder usar este servicio | l.v }
  if ( $l.db(nickserv\ $+ $r.c($o),configuracion,noticias) == on ) { m Tu nick ya está dado de alta en el servicio. | l.v }
  g.db nickserv\ $+ $r.c($o) configuracion noticias on
  debugc $noticiasserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o se da de 12alta en el servicio de noticias.
  m Tu nick acaba de ser dado de alta en el servicio de noticias.
  l.v
}

alias noticiasserv.baja {
  if ( $n.i($o) == no ) { m Debes identificarte para poder usar este servicio | l.v }
  if ( $l.db(nickserv\ $+ $r.c($o),configuracion,noticias) == $null ) { m Tu nick no está dado de alta en el servicio. | l.v }
  b.db nickserv\ $+ $r.c($o) configuracion noticias
  debugc $noticiasserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o se da de 12baja en el servicio de noticias.
  m Tu nick acaba de ser dado de baja en el servicio de noticias.
  l.v
}

alias noticiasserv.email {
  if ( $d(5) == $null ) { m Error de Sintaxis: 12EMAIL <mensaje> | l.v }
  %tmp.nr = $findfile($mircdirdatabase\nickserv\,*,0)
  %tmp.c = 0
  while ( %tmp.c < %tmp.nr ) {
    inc %tmp.c
    %tmp.n = $nopath($findfile($mircdirdatabase\nickserv\,*,%tmp.c))
    if ( $l.db(nickserv\ $+ %tmp.n,configuracion,noticias) == on ) {
      %tmp.e = $l.db(nickserv\ $+ %tmp.n,configuracion,emailreg)
      email noticias.txt %tmp.e $noticiasserv $r.c(%tmp.n) $d(5-)
    }
  }
  m E-mail enviado a todos los usuarios dados de alta en el servicio de noticias.
  debugc $noticiasserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o envía un e-mail a todos los usuarios dados de alta en el servicio de noticias. ( $+ $d(5-) $+ )
  l.v
}

alias noticiasserv.motd {
  if ( $d(5) ) {
    if ($d(5) == add) {
      if ($d(6)) {
        write database\noticias\usuarios.db $date $o $d(6-)
        m Mensaje añadido.
        %tmp.n.g.user = 1
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
          s : $+ $noticiasserv %conf.metodo %tmp.nick :3[ Noticias de la Red ]
          s : $+ $noticiasserv %conf.metodo %tmp.nick : $+ $d(6-)
        }
        :f
        debugc $noticiasserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o añade una noticia para 12usuarios: $d(6-)
      }
      else {
        m 4ERROR: motd add mensaje.
      }
    }
    elseif ($d(5) == del) {
      if ($strip($d(6))) && ($strip($d(6)) isnum) && (. !isin $strip($d(6))) {
        if ($read(database\noticias\usuarios.db,$strip($d(6)))) {
          var  %a = $read(database\noticias\usuarios.db,$strip($d(6)))
          m Borrada la noticia numero12 $strip($d(6)) añadida por12 $gettok(%a,2,32) el12 $gettok(%a,1,32) $+ : $gettok(%a,3-,32)
          debugc $noticiasserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o borra la noticia de usuarios numero12 $strip($d(6)) añadida por12 $gettok(%a,2,32) el12 $gettok(%a,1,32) $+ : $gettok(%a,3-,32)
          write -dl $+ $strip($d(6)) database\noticias\usuarios.db
        }
        else {
          m 4ERROR: No se ha encontrado ninguna noticia en la posición12 $strip($d(6)) $+ .
        }
      }
      else {
        m 4Sintaxis incorrecta:12 motd del numero.
      }
    }
    elseif ($d(5) == list) {
      if ($read(database\noticias\usuarios.db,1)) {
        var %a 1
        m Lista de noticias para usuarios:
        m
        while ($read(database\noticias\usuarios.db,%a)) {
          var %b = $read(database\noticias\usuarios.db,%a)
          m Noticia numero12 %a añadida por12 $gettok(%b,2,32) el12 $gettok(%b,1,32) $+ : $gettok(%b,3-,32)
          inc %a 1
        }
        m
        m Fin de la lista.
      }
      else {
        m Lista de noticias para usuarios vacia.
      }
    }
    else {
      m 4ERROR:12 motd add/del/list [mensaje] [texto]
    }
    l.v
  }
  else {
    m 4ERROR:12 motd add/del/list [mensaje] [texto]
    l.v
  }
}

alias noticiasserv.nick {
  if ( $d(5) ) {
    if ($strip($d(5)) == add) {
      if ($d(6)) {
        if ( $l.db(bots.db,motdn,$strip($d(6))) ) {
          m 4ERROR: Ya existe un MOTD con el nick12 $strip($d(6)) $+ .
        }
        else {
          if ( $mid($strip($d(6)),1,1) isnum ) { m El nick del bot no puede comenzar por un numero. }
          elseif ( $l.db(bots.db,obots,$r.c($strip($d(6)))) != $null ) { m El nick12 $d(6) es un bot de la red. }
          elseif ( $n.r($strip($d(6))) == si ) { m El nick12 $d(6) está registrado. }
          elseif ( $l.db(status.db,status,$r.c($strip($d(6)))) != $null ) { m El nick12 $d(6) está en uso actualmente. }
          else {
            c.b $strip($d(6)) $l.conf(noticiasserv,identnn) $l.conf(noticiasserv,vhostnn) $l.conf(noticiasserv,modos) $l.conf(noticiasserv,realname)
            g.db bots.db motdn $r.c($strip($d(6))) $q.c($d(7-))
            m Mensaje de entrada a la red mediante el nick12 $d(6) activado.
            debugc $noticiasserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o activa un mensaje de entrada a la red mediante el nick $d(6) $+ . ( $+ $d(7-) $+ )
          }
        }
      }
      else {
        m 4Sintaxis incorrecta: NICK ADD nick mensaje
      }
    }
    elseif ($strip($d(5)) == del) {
      if ($d(6)) {
        if ( $l.db(bots.db,motdn,$strip($r.c($d(6)))) ) {
          s : $+ $strip($d(6)) quit :MOTD desactivado.
          b.db bots.db motdn $r.c($strip($d(6)))
          s UNSQLINE $d(6)
          m Mensaje de entrada a la red mediante el nick12 $d(6) borrado.
          debugc $noticiasserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o borra el mensaje de entrada a la red mediante el nick12 $d(6) $+ .
        }
        else {
          m 4ERROR: No existe un MOTD con el nick12 $strip($d(6)) $+ .
        }
      }
      else {
        m 4Sintaxis incorrecta: NICK DEL nick
      }
    }
    elseif ($strip($d(5)) == list) {
      if ($ini(database\bots.db,motdn,1)) {
        var %a 1
        m Lista de nicks con MOTD:
        m
        while ($ini(database\bots.db,motdn,%a)) {
          var %n = $ini(database\bots.db,motdn,%a)
          m 12 $+ $r.c(%n) $+ : $p.c($l.db(bots.db,motdn,%n))
          inc %a 1
        }
        m
        m Fin de la lista.
      }
      else {
        m No hay ningun MOTD por bot.
      }
    }
    else {
      m 4Sintaxis incorrecta: NICK ADD / DEL / LIST
    }
  }
  else {
    m 4Sintaxis incorrecta: NICK ADD / DEL / LIST
  }
  l.v
}

alias noticiasserv.representantes {
  if ( $d(5) ) {
    if ($d(5) == add) {
      if ($d(6)) {
        write database\noticias\representantes.db $date $o $d(6-)
        m Mensaje para representantes añadido.
        %tmp.n.g.user = 1
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
          %tmp.level = $r.c($gettok(%tmp.l.linea,2,61))
          if (%tmp.level >= 4) {
            s : $+ $noticiasserv %conf.metodo %tmp.nick :3[ Noticias para Representantes ]
            s : $+ $noticiasserv %conf.metodo %tmp.nick : $+ $d(6-)
          }
        }
        :f
        debugc $noticiasserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o añade una noticia para 12representantes: $d(6-)
      }
      else {
        m 4ERROR: representantes add mensaje.
      }
    }
    elseif ($d(5) == del) {
      if ($strip($d(6))) && ($strip($d(6)) isnum) && (. !isin $strip($d(6))) {
        if ($read(database\noticias\representantes.db,$strip($d(6)))) {
          var  %a = $read(database\noticias\representantes.db,$strip($d(6)))
          m Borrada la noticia numero12 $strip($d(6)) añadida por12 $gettok(%a,2,32) el12 $gettok(%a,1,32) $+ : $gettok(%a,3-,32)
          debugc $noticiasserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o borra la noticia de representantes numero12 $strip($d(6)) añadida por12 $gettok(%a,2,32) el12 $gettok(%a,1,32) $+ : $gettok(%a,3-,32)
          write -dl $+ $strip($d(6)) database\noticias\representantes.db
        }
        else {
          m 4ERROR: No se ha encontrado ninguna noticia en la posición12 $strip($d(6)) $+ .
        }
      }
      else {
        m 4Sintaxis incorrecta:12 representantes del numero.
      }
    }
    elseif ($d(5) == list) {
      if ($read(database\noticias\representantes.db,1)) {
        var %a 1
        m Lista de noticias para representantes:
        m
        while ($read(database\noticias\representantes.db,%a)) {
          var %b = $read(database\noticias\representantes.db,%a)
          m Noticia numero12 %a añadida por12 $gettok(%b,2,32) el12 $gettok(%b,1,32) $+ : $gettok(%b,3-,32)
          inc %a 1
        }
        m
        m Fin de la lista.
      }
      else {
        m Lista de noticias para usuarios vacia.
      }
    }
    else {
      m 4ERROR:12 representantes add/del/list [mensaje]
    }
    l.v
  }
  else {
    m 4ERROR:12 representantes add/del/list [mensaje]
    l.v
  }
}

alias noticiasserv.noticias {
  set %noticias.nickmsg $o
  noticias
  l.v
}

alias noticiasserv.servidor {
  if ($d(5)) {
    if ($l.db(servidores.db,servidores,$d(5))) {
      if ($d(6)) {
        if ($read(database\noticias\servidores.db,s,$d(5))) {
          m 4ERROR: Ya hay una noticia para el servidor12 $d(5)
        }
        else {
          write database\noticias\servidores.db $d(5) $q.c($d(6-))
          m Mensaje para los usuarios que conecten por el servidor12 $d(5) añadido.
          debugc $noticiasserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o añade un mensaje de entrada a los usuarios del servidor $d(5) -> $d(6-)
        }
      }
      else {
        if ($read(database\noticias\servidores.db,s,$d(5))) {
          write -ds $+ $d(5) database\noticias\servidores.db
          m Mensaje para los usuarios que conecten por el servidor12 $d(5) quitado.
          debugc $noticiasserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o quita el mensaje de entrada a los usuarios del servidor $d(5)
        }
        else {
          m 4ERROR: No hay una noticia para el servidor12 $d(5)
        }
      }
    }
    else {
      m 4ERROR: El servidor12 $d(5) no está conectado ahora mismo.
    }
  }
  else {
    m 4Sintaxis incorrecta: 12SERVIDOR servidor mensaje
  }
  l.v
}
