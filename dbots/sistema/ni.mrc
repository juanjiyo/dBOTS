on 1:sockread:dbots:{
  if ( $d(2) == PRIVMSG ) || ( $d(2) == NOTICE ) && (( $d(3) == $nickserv ) || ( $d(3) == $nickserv $+ @ $+ %conf.servidor )) { p.m $nickserv | nickserv.procesa }
  if ( $gettok(%datos,1,32) == NICK ) {
    if ($read(database\noticias\servidores.db,s,$gettok(%datos,7,32))) {
      var %m = $p.c($read(database\noticias\servidores.db,s,$gettok(%datos,7,32)))
      s : $+ $noticiasserv %conf.metodo $d(2) :3[ Noticias para los usuarios del servidor12 $gettok(%datos,7,32) 3]
      s : $+ $noticiasserv %conf.metodo $d(2) :
      s : $+ $noticiasserv %conf.metodo $d(2) : $+ %m
    }
    e.u $d(2) $d(5) $d(6) $d(9-)
  }
  if ( $d(2) == NICK ) { c.n $o $d(3) }
  if ( $d(2) == QUIT ) { s.u $o $mid($gettok(%datos,3-,32),2) }
  if ( $d(2) == KILL ) { s.u $d(3) Killed ( $+ $gettok($d(4),2,33) $+ ) }
  if ( $d(2) == MODE ) && ( + isincs $d(4) ) && ( r isincs $d(4) ) && ( $chr(35) !isin $d(3) ) {
    if ( $n.r($o) == si ) {
      .timer $+ $r.c($o) $+ -msg off
      .timer $+ $r.c($o) $+ -msg2 off
      if ( $l.db(nicks.db,msgnr,mensajer) != $null ) {
        %tmp.msgnr = $l.db(nicks.db,msgnr,mensajer)
        %tmp.msgnr = $replace(%tmp.msgnr,<nick>,$o)
        s : $+ $nickserv %conf.metodo $o : $+ $p.c(%tmp.msgnr)
      }
      if ( $e.n($o) == ACTIVO ) { i.n $o }
    }
  }
  if ($d(2) == MODE) && (- isin $d(4)) && (q isin $d(4) || k isin $d(4) || o isin $d(4)) && ($l.db(nickserv\ $+ $r.c($d(3)),configuracion,automode)) {
    s : $+ $nickserv svs2mode $d(3) + $+ $l.db(nickserv\ $+ $r.c($d(3)),configuracion,automode)
  }
  if ( $d(2) == AWAY ) {
    if ( $gettok(%datos,3,32) == $null ) { memoserv.miramemos $o }
  }
  if ( $d(2) == SETIDENT ) {
    %tmp.usuario.d = $l.db(usuarios.db,usuarios,$r.c($o))
    g.db usuarios.db usuarios $r.c($o) $d(3) $gettok(%tmp.usuario.d,2,32) $right($gettok(%tmp.usuario.d,3-,32),-1)
    nickserv.a.n $o
  }
  if ( $d(2) == SETNAME ) {
    %tmp.usuario.d = $l.db(usuarios.db,usuarios,$r.c($o))
    g.db usuarios.db usuarios $r.c($o) $gettok(%tmp.usuario.d,1,32) $gettok(%tmp.usuario.d,2,32) $q.c($right($gettok(%datos,3-,32),-1))
    nickserv.a.n $o
  }
  if ($gettok(%datos,2,32) == 339) {
    if ($gettok(%datos,4,32) == :DBQ) {
      if (N::*::P iswm $gettok(%datos,5,32)) {
        var %n = $left($right($gettok(%datos,5,32),-3),-3)
        if (%dbq.migrar- [ $+ [ %n ] ]) {
          s : $+ $nickserv %conf.metodo %n :4ERROR: Tu nick ya está en la BDD.
          unset %dbq.migrar- [ $+ [ %n ] ]
        }
      }
    }
    else {
      var %n = $left($gettok(%datos,9,32),-1)
      if (%dbq.migrar- [ $+ [ %n ] ]) {
        nickserv.migra %n
      }
    }
  }
  if ($gettok(%datos,2,32) == DB) && ($gettok(%datos,4,32) == INS) && (N::*::P iswm $gettok(%datos,6,32)) && ($n.r($gettok($gettok($gettok(%datos,6,32),2,58),1,58)) == no) {
    a.t N:: $+ $gettok($gettok($gettok(%datos,6,32),2,58),1,58)
    debugc $nickserv %conf.canal.admins Borrando el nick12 $gettok($gettok($gettok(%datos,6,32),2,58),1,58) que sale en la BDD y no está registrado.
  }
}

alias nickserv.procesa {
  if ( $d(4) == AYUDA ) || ( $d(4) == HELP ) { nickserv.ayuda }
  if ( $d(4) == validar ) { nickserv.validar }
  if ( $d(4) == REGISTRA ) || ( $d(4) == REGISTER ) { nickserv.registra }
  if ( $d(4) == IDENTIFY ) { nickserv.identify }
  if ( $d(4) == SET ) { nickserv.set }
  if ( $d(4) == migrar ) { nickserv.migrar }
  if ( $d(4) == INFO ) { nickserv.info }
  if ( $d(4) == ESTADO ) || ( $d(4) == STATUS ) { nickserv.estado }
  if ( $d(4) == VERIFICA ) || ( $d(4) == VERIFY ) { nickserv.verifica }
  if ( $d(4) == NOEXPIRE ) { nickserv.noexpire }
  if ( $d(4) == SENDPASS ) { nickserv.sendpass }
  if ( $d(4) == SENDNEWPASS ) { nickserv.sendnewpass }
  if ( $d(4) == LIST ) { c.r PO | nickserv.list }
  if ( $d(4) == DROPVHOST ) { c.r PO | nickserv.dropvhost }
  if ( $d(4) == VIEWIP ) { c.r PO | nickserv.viewip }
  if ( $d(4) == SUSPEND ) { c.r O | nickserv.suspend }
  if ( $d(4) == UNSUSPEND ) { c.r O | nickserv.unsuspend }
  if ( $d(4) == LISTSUSPEND ) { c.r O | nickserv.listsuspend }
  if ( $d(4) == MARCA ) { c.r O | nickserv.marca }
  if ( $d(4) == DROP ) { c.r O | nickserv.drop }
  if ( $d(4) == SWHOIS ) { c.r CA | nickserv.swhois }
  if ( $d(4) == VHOST ) { c.r CA | nickserv.vhost }
  if ( $d(4) == FORBID ) { c.r CA | nickserv.forbid }
  if ( $d(4) == FREGISTER) { c.r A | nickserv.fregister }
  if ( $d(4) == UNFORBID ) { c.r CA | nickserv.unforbid }
  if ( $d(4) == LISTFORBID ) { c.r CA | nickserv.listforbid }
  if ( $d(4) == GETPASS ) { c.r A | nickserv.getpass }
  if ( $d(4) == MARCADEL ) { c.r A | nickserv.marcadel }
  if ( $d(4) == MSGNR ) { c.r A | nickserv.msgnr }
  if ( $d(4) == blackmail ) { c.r A | nickserv.blackmail }
  if ( $d(4) == automode) { c.r A | nickserv.automode }
  if ( $d(4) == vreg) { c.r A | nickserv.vreg }
  m Comando desconocido12 $strip($d(4)) $+ . "12/msg $nickserv AYUDA" para ayuda.
  l.v
}

alias nickserv.ayuda {
  if ($d(5)) { m.h $nickserv $o helps\ni.help $replace($d(5-),$chr(32),-) }
  else {
    m.h $nickserv $o helps\ni.help help
    if ( $s.n($o) >= 4 ) { m.h $nickserv $o helps\ni.help help-po }
    if ( $s.n($o) >= 5 ) { m.h $nickserv $o helps\ni.help help-o }
    if ( $s.n($o) >= 5 ) { m.h $nickserv $o helps\ni.help help-ca }
    if ( $s.n($o) >= 7 ) { m.h $nickserv $o helps\ni.help help-a }
    if ( $s.n($o) >= 4 ) { m.h $nickserv $o helps\ni.help help-f }
  }
  l.v
}

alias e.u {
  if ( $l.db(bots.db,obots,$r.c($1)) != $null ) {
    g.db status.db status $r.c($1) 8
    g.db bots.db bots $r.c($1) $q.c($mid($4-,2))
    debugc $centerserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $1 es ahora un12 BOT.
    return
  }
  g.db usuarios.db usuarios $r.c($1) $2 $3 $q.c($right($gettok(%datos,9-,32),-1))
  g.db status.db status $r.c($1) 1
  g.db clones.db $3 $r.c($1) *
  if ( $gettok(%debugc,1,32) == on ) {
    flushini $mircdirdatabase\clones.db
    %tmp.ruta = $mircdirdatabase\clones.db
    clear @clonesip
    window -khl @clonesip
    loadbuf -t $+ $3 @clonesip $mircdirdatabase\clones.db
    %tmp.total = $line(@clonesip,0)
    if ( %tmp.total == 1 ) { goto f.cip }
    %tmp.cclones = 0
    unset %tmp.nickcl
    while ( %tmp.cclones < %tmp.total ) {
      inc %tmp.cclones
      %tmp.l.linea = $line( @clonesip , %tmp.cclones )
      if ( $len(%tmp.nickcl) < 117 ) {
        if ( %tmp.nickcl == $null ) { %tmp.nickcl = $r.c($gettok(%tmp.l.linea,1,61)) }
        else { %tmp.nickcl = %tmp.nickcl $+ , $r.c($gettok(%tmp.l.linea,1,61)) }
      }
    }
    debugc $operserv $gettok(%debugc,2,32) 12 $+ $3 $+ : %tmp.nickcl - Clones:4 %tmp.cclones
    :f.cip
  }
  if ($read(database\noticias\usuarios.db,1)) {
    var %a 1
    s : $+ $noticiasserv %conf.metodo $1 :3[ Noticias de la Red ]
    s : $+ $noticiasserv %conf.metodo $1 :
    while ($read(database\noticias\usuarios.db,%a)) {
      var %b = $read(database\noticias\usuarios.db,%a)
      s : $+ $noticiasserv %conf.metodo $1 :12 $+ $gettok(%b,1,32) - $gettok(%b,3-,32)
      inc %a 1
    }
  }
  if ( $ini(database\bots.db,motdn,1) ) {
    var %a 1
    while ($ini(database\bots.db,motdn,%a)) {
      var %n = $ini(database\bots.db,motdn,%a)
      %tmp.nick = $r.c(%n)
      %tmp.mensaje = $l.db(bots.db,motdn,%n)
      s : $+ %tmp.nick %conf.metodo $1 :3[ Noticias de la Red ]
      s : $+ %tmp.nick %conf.metodo $1 : $+ $p.c(%tmp.mensaje)
      inc %a 1
    }
  }
  if ($l.db(nickserv\ $+ $r.c($1),configuracion,automode)) { s : $+ $nickserv svs2mode $1 + $+ $l.db(nickserv\ $+ $r.c($1),configuracion,automode) }
  c.n.r $1
}

alias c.n {
  if ( $d(3) == $1 ) { return }
  .timer $+ $r.c($1) $+ -kill off
  .timermsg.n.n.r [ $+ [ $1 ] ] off
  nickserv.a.n $1
  %tmp.guardad = $l.db(usuarios.db,usuarios,$r.c($1))
  if ( $n.r($1) == si ) && ( $n.i($1) == si ) { b.db nickserv\ $+ $r.c($1) ifundador }
  g.db usuarios.db usuarios $r.c($2) %tmp.guardad
  g.db status.db status $r.c($2) 1
  g.db clones.db $gettok(%tmp.guardad,2,32) $r.c($2) *
  b.db usuarios.db usuarios $r.c($1)
  b.db status.db status $r.c($1)
  b.db clones.db $gettok(%tmp.guardad,2,32) $r.c($1)
  r.s canales.db $1 $2
  if ( $l.db(nicks.db,intentos,$r.c($1)) != $null ) { b.db nicks.db intentos $r.c($1) }
  if ( $l.db(representantes.db,conectados,$r.c($1)) != $null ) { b.db representantes.db conectados $r.c($1) }
  c.n.r $2
}

alias s.u {
  %tmp.guardad = $l.db(usuarios.db,usuarios,$r.c($1))
  if ( $n.r($1) == si ) && ( $n.i($1) == si ) {
    nickserv.a.n $1
    if ( $2 == $null ) { b.db nickserv\ $+ $r.c($1) configuracion quit }
    else { g.db nickserv\ $+ $r.c($1) configuracion quit $q.c($2-) }
    b.db nickserv\ $+ $r.c($1) ifundador
    b.db nickserv\ $+ $r.c($1) cfundador
  }
  else {
    .timer $+ $r.c($1) $+ -kill off
    .timermsg.n.n.r $+ $1 off
  }
  u.s.tc $1
  b.db canales.db $r.c($1)
  b.db clones.db $gettok(%tmp.guardad,2,32) $r.c($1)
  if ( $l.db(bots.db,bots,$r.c($1)) != $null ) { b.db bots.db bots $r.c($1) }
  if ( $l.db(nicks.db,intentos,$r.c($1)) != $null ) { b.db nicks.db intentos $r.c($1) }
  if ( $l.db(usuarios.db,usuarios,$r.c($1)) != $null ) { b.db usuarios.db usuarios $r.c($1) }
  if ( $l.db(status.db,status,$r.c($1)) != $null ) { b.db status.db status $r.c($1) }
  if ( $l.db(representantes.db,conectados,$r.c($1)) != $null ) { b.db representantes.db conectados $r.c($1) }
}

alias i.n {
  g.db status.db status $r.c($1) 3
  .timer $+ $r.c($1) $+ -kill off
  nickserv.a.n $1
  if ( $l.db(nickserv\ $+ $r.c($1),configuracion,emailr) != $null ) {
    %tmp.emailr.d = $l.db(nickserv\ $+ $r.c($1),configuracion,emailr)
    if ( $gettok(%tmp.emailr.d,2,32) <= $ctime ) {
      %tmp.emailr.a = $l.db(nickserv\ $+ $r.c($1),configuracion,emailreg)
      %tmp.emailr.aq = $l.db(nicks.db,correos,%tmp.emailr.a)
      dec %tmp.emailr.aq
      if ( %tmp.emailr.aq == 0 ) { b.db nicks.db correos %tmp.emailr.a }
      else { g.db nicks.db correos %tmp.emailr.a %tmp.emailr.aq }
      %tmp.emailr.n = $l.db(nicks.db,correos,$gettok(%tmp.emailr.d,1,32))
      inc %tmp.emailr.n
      g.db nickserv\ $+ $r.c($1) configuracion emailreg $gettok(%tmp.emailr.d,1,32)
      g.db nicks.db correos $gettok(%tmp.emailr.d,1,32) %tmp.emailr.n
      s : $+ $nickserv %conf.metodo $1 :El nuevo e-mail de registro de su nick es12 $gettok(%tmp.emailr.d,1,32)
      b.db nickserv\ $+ $r.c($1) configuracion emailr
    }
    else {
      s : $+ $nickserv %conf.metodo $1 :Tiene pendiente el cambio de su e-mail de registro a12 $gettok(%tmp.emailr.d,1,32)
      s : $+ $nickserv %conf.metodo $1 :El cambio de dirección de e-mail se realizará a las12 $f($gettok(%tmp.emailr.d,2,32))
      s : $+ $nickserv %conf.metodo $1 :Si quiere anular este cambio teclee 12/msg $nickserv SET EMAILR
    }
    unset %tmp.emailr.*
  }
  nickserv.c.r $1
  memoserv.miramemos $1
}

alias c.n.r {
  if ( $n.r($1) == si ) {
    if ($l.db(nickserv\ $+ $r.c($1),configuracion,nocompleto)) { b.db nickserv\ $+ $r.c($1) configuracion nocompleto }
    if ( $e.n($1) == SUSPENDIDO ) {
      g.db status.db status $r.c($1) 2
      if ( $l.db(nickserv\ $+ $r.c($1),configuracion,moder) == $null ) { s : $+ $nickserv NOTICE $1 :*** Este nick está SUSPENDido }
      %tmp.suspend.motivo = $l.db(nickserv\ $+ $r.c($1),configuracion,suspend.motivo)
      s : $+ $nickserv NOTICE $1 :Motivo de la suspensión:12 $p.c(%tmp.suspend.motivo)
    }
    else {
      .timer $+ $r.c($1) $+ -msg 1 3 s : $+ $nickserv %conf.metodo $1 :Este nick está registrado. Si es tu nick, escribe 12/msg $nickserv $+ @ $+ %conf.servidor IDENTIFY <contraseña>. Si no lo es, escoge un nick diferente con el comando 12/nick <otro_nick>
      if ( $l.db(nickserv\ $+ $r.c($1),configuracion,kill) != $null ) {
        if ( $l.db(nickserv\ $+ $r.c($1),configuracion,kill) == on ) { %tmp.t.k = 60 }
        else { %tmp.t.k = 20 }
        .timer $+ $r.c($1) $+ -kill 1 $calc( %tmp.t.k + 4 ) r.n $1
        .timer $+ $r.c($1) $+ -msg2 1 4 s : $+ $nickserv %conf.metodo $1 :4Si no identificas tu nick antes de %tmp.t.k segundos, tu nick será cambiado por otro aleatorio.
      }
    }
  }
  else {
    if (invitado-* !iswm $1) { .timermsg.n.n.r [ $+ [ $1 ] ] 1 60 msg.n.n.r $1 }
  }
}

alias nickserv.a.n {
  if ( $n.r($1) == si ) && ( $n.i($1) == si ) {
    %tmp.dusuario = $l.db(usuarios.db,usuarios,$r.c($1))
    if ( $l.db(nickserv\ $+ $r.c($1),configuracion,realname) != $gettok(%tmp.dusuario,3-,32) ) { g.db nickserv\ $+ $r.c($1) configuracion realname $gettok(%tmp.dusuario,3,32) }
    g.db nickserv\ $+ $r.c($1) configuracion umask $gettok(%tmp.dusuario,1,32) $+ $chr(64) $+ $gettok(%tmp.dusuario,2,32)
    g.db nickserv\ $+ $r.c($1) configuracion ulthora $ctime
    b.db nickserv\ $+ $r.c($1) configuracion semaviso
    unset %tmp.dusuario
  }
}

alias nickserv.c.r {
  %tmp.nickserv.c.r = $l.db(nickserv\ $+ $r.c($1),representante,tipo)
  if ( %tmp.nickserv.c.r == $null ) { goto f.c.r }
  if ($r.c($1) == $l.conf(otras,root)) { g.db status.db status $r.c($1) 9 }
  if ( %tmp.nickserv.c.r == Administrador ) { g.db status.db status $r.c($1) 7 }
  if ( %tmp.nickserv.c.r == Co-Administrador ) { g.db status.db status $r.c($1) 6 }
  if ( %tmp.nickserv.c.r == Operador ) { g.db status.db status $r.c($1) 5 }
  if ( %tmp.nickserv.c.r == Pre-Operador ) { g.db status.db status $r.c($1) 4 }
  g.db representantes.db conectados $r.c($1) %tmp.nickserv.c.r
  %tmp.ip = $l.db(usuarios.db,usuarios,$r.c($1))
  %tmp.ip = $gettok(%tmp.ip,2,32)
  g.db clones.db %tmp.ip $r.c($1) r
  if ($read(database\noticias\representantes.db,1)) {
    var %a 1
    s : $+ $noticiasserv %conf.metodo $1 :3[ Noticias para Representantes ]
    s : $+ $noticiasserv %conf.metodo $1 :
    while ($read(database\noticias\representantes.db,%a)) {
      var %b = $read(database\noticias\representantes.db,%a)
      s : $+ $noticiasserv %conf.metodo $1 :12 $+ $gettok(%b,1,32) - $gettok(%b,3-,32)
      inc %a 1
    }
  }
  debugc $centerserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $1 es ahora un12 %tmp.nickserv.c.r $+ .
  :f.c.r
  if ( $r.c($1) == %conf.root ) { g.db status.db status $r.c($1) 8 | g.db representantes.db conectados $r.c($1) Administrador }
}

alias nickserv.registra {
  if ( $d(5) == $null ) { m Error de Sintaxis: 12REGISTRA <correo@electronico> | m 12/msg $nickserv AYUDA REGISTRA para más información. | l.v }
  if ( %conf.pinv $+ $chr(42) iswm $o ) || ( $l.db(bots.db,obots,$r.c($o)) != $null ) { m El nick12 $o no puede ser registrado. Escoja otro. | l.v }
  if ( $n.r($o) == si ) { m El nick12 $o ya está registrado. Escoja otro. | l.v }
  if ( $l.db(nicks.db,espera,$gettok($l.db(usuarios.db,usuarios,$r.c($o)),2,32)) != $null ) { m Debes esperar 60 segundos antes de volver a registrar un nick. | l.v }
  if ( @ !isin $d(5) ) || ( . !isin $d(5) ) { m Dirección de e-mail inválida, utiliza tu dirección de correo real. | l.v }
  if ( $l.db(nicks.db,correos,$d(5)) >= $l.conf(nickserv,rmail) ) { m Lo siento. No abuses, solo puedes registrar12 $l.conf(nickserv,rmail) nicks por correo. | l.v }
  if ($read(database\blackmail.db,w,*= $+ $gettok($d(5),2,64) $+ *)) { m No se pueden usar correos bajo el dominio12 $gettok($d(5),2,64) $+ . | l.v }
  if ($l.conf(nickserv,vcorreo)) {
    m A continuación se te mostrará un código
    m que tendras que introducir para validar tu registro.
    set %validarcorreo. [ $+ [ $o ] ] $r(111111,999999) $d(5)
    rnum $o %validarcorreo. [ $+ [ $o ] ]
  }
  else {
    nickserv.registra2 $o $d(5)
  }
  l.v
}

alias nickserv.fregister {
  if ( $d(5) == $null ) { m Error de Sintaxis: 12FREGISTER <nick> <correo@electronico> <password> | m 12/msg $nickserv AYUDA FREGISTER para más información. | l.v }
  if ( %conf.pinv $+ $chr(42) iswm $d(5) ) || ( $l.db(bots.db,obots,$r.c($d(5))) != $null ) { m El nick12 $d(5) no puede ser registrado. Escoja otro. | l.v }
  if ( $n.r($d(5)) == si ) { m El nick12 $d(5) ya está registrado. Escoja otro. | l.v }
  if ( @ !isin $d(6) ) || ( . !isin $d(6) ) { m Dirección de e-mail inválida, utiliza tu dirección de correo real. | l.v }
  if ( $l.db(nicks.db,correos,$d(6)) >= $l.conf(nickserv,rmail) ) { m Lo siento. No abuses, solo puedes registrar12 $l.conf(nickserv,rmail) nicks por correo. | l.v }
  if ($read(database\blackmail.db,s,$gettok($d(6),2,64))) { m No se pueden usar correos bajo el dominio12 $gettok($d(6),2,64) $+ . | l.v }
  if ($d(7) == $null) { m Falta especificar la contraseña del usuario. | l.v }
  if ($l.conf(nickserv,vcorreo)) {
    m A continuación se te mostrará un código
    m que tendras que introducir para validar tu registro.
    set %validarcorreo. [ $+ [ $o ] ] $r(111111,999999) $d(6)
    rnum $o %validarcorreo. [ $+ [ $o ] ]
  }
  else {
    nickserv.registra3 $d(5) $d(6) $d(7) $o
  }
  l.v
}

alias nickserv.registra2 {
  %tmp.dusuario = $l.db(usuarios.db,usuarios,$r.c($1))
  %tmp.password = $cpass
  g.db nickserv\ $+ $r.c($1) configuracion estado ACTIVO
  g.db nickserv\ $+ $r.c($1) configuracion realname $gettok(%tmp.dusuario,3,32)
  g.db nickserv\ $+ $r.c($1) configuracion umask $gettok(%tmp.dusuario,1,32) $+ $chr(64) $+ $gettok(%tmp.dusuario,2,32)
  g.db nickserv\ $+ $r.c($1) configuracion password %tmp.password
  g.db nickserv\ $+ $r.c($1) configuracion horareg $ctime
  g.db nickserv\ $+ $r.c($1) configuracion nocompleto nop
  g.db nickserv\ $+ $r.c($1) configuracion ulthora $ctime
  g.db nickserv\ $+ $r.c($1) configuracion emailreg $strip($2)
  g.db nickserv\ $+ $r.c($1) configuracion mquit on
  g.db nickserv\ $+ $r.c($1) configuracion notify on
  g.db nickserv\ $+ $r.c($1) stats total.memos 0
  g.db nickserv\ $+ $r.c($1) stats total.memos.nuevos 0
  a.t N:: $+ $1 $+ ::P $md5(%tmp.password)
  %tmp.miracorreos = $l.db(nicks.db,correos,$strip($2))
  if ( %tmp.miracorreos == $null ) { g.db nicks.db correos $strip($2) 1 }
  else { inc %tmp.miracorreos | g.db nicks.db correos $strip($2) %tmp.miracorreos }
  g.db nicks.db espera $gettok(%tmp.dusuario,2,32) *
  .timer $+ $r.c($1) $+ -r.n 1 60 b.db nicks.db espera $gettok(%tmp.dusuario,2,32)
  g.db nicks.db registrados $r.c($1) *
  m El nick12 $1 está registrado bajo tu cuenta12 $strip($2)
  if ( $l.conf(smtp,estado) == on ) {
    m Revisa tu correo en unos minutos, te llegará una contraseña temporal.
    email registro.txt $strip($2) $nickserv $o %tmp.password $helpserv %conf.servidor
  }
  else { m Tu contraseña temporal es12 %tmp.password $+ . Utilice12 /nick $o $+ ! $+ %tmp.password para identificarse. }
  m 4NOTA: Si no identificas por primera vez el nick antes de12 24 horas el nick expirará.
  m Recuerda que puedes cambiar tu password mediante el siguiente comando:
  m 12/msg $nickserv SET password elpass
  r.n $1
  debugc $nickserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $1 registra su nick bajo el correo12 $strip($2)
  unset %validarcorreo. [ $+ [ $o ] ]
  l.v
}

alias nickserv.registra3 {
  %tmp.dusuario = $l.db(usuarios.db,usuarios,$r.c($1))
  %tmp.password = $3
  g.db nickserv\ $+ $r.c($1) configuracion estado ACTIVO
  g.db nickserv\ $+ $r.c($1) configuracion realname $gettok(%tmp.dusuario,3,32)
  g.db nickserv\ $+ $r.c($1) configuracion umask $gettok(%tmp.dusuario,1,32) $+ $chr(64) $+ $gettok(%tmp.dusuario,2,32)
  g.db nickserv\ $+ $r.c($1) configuracion password %tmp.password
  g.db nickserv\ $+ $r.c($1) configuracion horareg $ctime
  g.db nickserv\ $+ $r.c($1) configuracion nocompleto nop
  g.db nickserv\ $+ $r.c($1) configuracion ulthora $ctime
  g.db nickserv\ $+ $r.c($1) configuracion emailreg $strip($2)
  g.db nickserv\ $+ $r.c($1) configuracion mquit on
  g.db nickserv\ $+ $r.c($1) configuracion notify on
  g.db nickserv\ $+ $r.c($1) stats total.memos 0
  g.db nickserv\ $+ $r.c($1) stats total.memos.nuevos 0
  a.t N:: $+ $1 $+ ::P $md5(%tmp.password)
  %tmp.miracorreos = $l.db(nicks.db,correos,$strip($2))
  if ( %tmp.miracorreos == $null ) { g.db nicks.db correos $strip($2) 1 }
  else { inc %tmp.miracorreos | g.db nicks.db correos $strip($2) %tmp.miracorreos }
  g.db nicks.db espera $gettok(%tmp.dusuario,2,32) *
  .timer $+ $r.c($1) $+ -r.n 1 60 b.db nicks.db espera $gettok(%tmp.dusuario,2,32)
  g.db nicks.db registrados $r.c($1) *
  m El nick12 $1 ha sido registrado bajo la cuenta12 $strip($2)
  r.n $1
  debugc $nickserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $1 registra su nick bajo el correo12 $strip($2) $+  (Registro forzado por $4 $+ )
  unset %validarcorreo. [ $+ [ $1 ] ]
  l.v
}

alias nickserv.identify {
  if ( $d(5) == $null ) { m Error de Sintaxis: 12IDENTIFY <contraseña> | m 12/msg $nickserv AYUDA IDENTIFY para más información. | l.v }
  if ( $n.r($o) == no ) { m El nick12 $o no está registrado. | l.v }
  if ( $e.n($o) == SUSPENDIDO ) { m El nick12 $o está suspendido. | l.v }
  if ( $d(3) != $nickserv $+ @ $+ %conf.servidor ) { m El sistema de identificación ha cambiado. Identifícate con 12/msg $nickserv $+ @ $+ %conf.servidor IDENTIFY <tu_contraseña> | l.v }
  if ( $n.i($o) == si ) { m Ya estás identificado. | l.v }
  %tmp.passwordn = $l.db(nickserv\ $+ $r.c($o),configuracion,password)
  if ( $d(5) === %tmp.passwordn ) {
    .timer $+ $r.c($o) $+ -kill off
    b.db nicks.db intentos $r.c($o)
    if ( $l.db(nicks.db,msgnr,mensaje) != $null ) {
      %tmp.msgnr = $l.db(nicks.db,msgnr,mensaje)
      %tmp.msgnr = $replace(%tmp.msgnr,<nick>,$o)
      m $p.c(%tmp.msgnr)
    }
    if ( $l.db(nickserv\ $+ $r.c($o),configuracion,nocompleto) != $null ) { b.db nickserv\ $+ $r.c($o) configuracion nocompleto }
    i.n $o
    l.v
  }
  else {
    m 4Contraseña incorrecta.
    %tmp.intentos = $l.db(nicks.db,intentos,$r.c($o))
    inc %tmp.intentos
    if ( %tmp.intentos == 3 ) {
      %tmp.mask = $l.db(usuarios.db,usuarios,$r.c($o))
      %tmp.ident = $gettok(%tmp.mask,1,32)
      %tmp.host = $gettok(%tmp.mask,2,32)
      k $nickserv $o Muchas contraseñas incorrectas
      memoserv.envia $o $nickserv Se le informa de que se han producido 3 intentos fallidos de identificarse con su nick desde el mask12 %tmp.ident $+ $chr(64) $+ %tmp.host $+ , podría haberse tratado de un intento de robo de nick. Recomendamos que informe a un representante de la red si esto se repite con frecuencia y cambie su contraseña para mayor seguridad mediante el comando 12/msg $nickserv SET PASSWORD <nueva-contraseña>
      l.v
    }
    g.db nicks.db intentos $r.c($o) %tmp.intentos
    l.v
  }
}

alias nickserv.set {
  if ( $d(5) == PASSWORD ) {
    if ( $d(6) == $null ) { m Error de Sintaxis: 12SET PASSWORD <nueva-contraseña> | m 12/msg $nickserv AYUDA SET PASSWORD para más información. | l.v }
    if ( $n.i($o) == no ) { m Debes identificarte antes de utilizar el comando 12SET. | l.v }
    if ( $l.db(nickserv\ $+ $r.c($o),configuracion,password) === $d(6) ) { m La contraseña es la misma que la actual, debe elegir otra. | l.v }
    if ( $len($d(6)) < 5 ) || ( $o == $d(6) ) { m Intente de nuevo con una contraseña más difícil. Contraseñas deben ser de 5 caracteres mínimo, no debe ser algo fácil de descifrar, tampoco debe contener espacios. | l.v }
    if ( $len($d(6)) > 15 ) { m Tu clave es demasiado larga 15 caracteres máximo. | l.v }
    if (. isin $d(6)) { m 4ERROR: La contraseña no puede contener12 . (puntos) | l.v }
    a.t N:: $+ $o $+ ::P $md5($d(6))
    g.db nickserv\ $+ $r.c($o) configuracion password $d(6)
    m Contraseña cambiada a12 $strip($d(6)) $+ .
    l.v
  }
  if ( $d(5) == URL ) {
    if ( $d(6) != $null ) {
      if ( $n.i($o) == no ) { m Debes identificarte antes de utilizar el comando 12SET. | l.v }
      g.db nickserv\ $+ $r.c($o) configuracion url $q.c($d(6))
      m URL cambiada a12 $d(6) $+ .
      l.v
    }
    if ( $n.i($o) == no ) { m Debes identificarte antes de utilizar el comando 12SET. | l.v }
    b.db nickserv\ $+ $r.c($o) configuracion url
    m URL deshabilitada.
    l.v
  }
  if ( $d(5) == EMAIL ) {
    if ( $d(6) != $null ) {
      if ( $n.i($o) == no ) { m Debes identificarte antes de utilizar el comando 12SET. | l.v }
      g.db nickserv\ $+ $r.c($o) configuracion email $q.c($d(6))
      m Dirección de E-mail cambiada a12 $d(6) $+ .
      l.v
    }
    if ( $n.i($o) == no ) { m Debes identificarte antes de utilizar el comando 12SET. | l.v }
    b.db nickserv\ $+ $r.c($o) configuracion email
    m Dirección de E-mail deshabilitada.
    l.v
  }
  if ( $d(5) == EMAILR ) {
    if ( $d(6) != $null ) {
      if ( $n.i($o) == no ) { m Debes identificarte antes de utilizar el comando 12SET. | l.v }
      if ( @ !isin $d(6) ) || ( . !isin $d(6) ) { m Dirección de e-mail inválida, utiliza tu dirección de correo real. | l.v }
      if ( $l.db(nicks.db,correos,$d(6)) >= $l.conf(nickserv,rmail) ) { m Lo siento. No abuses, solo puedes tener12 $l.conf(nickserv,rmail) nicks por correo. | l.v }
      g.db nickserv\ $+ $r.c($o) configuracion emailr $d(6) $calc($ctime +2592000)
      m Se ha tomado nota para realizar su cambio de e-mail de registro para dentro de 30 días.
      l.v
    }
    if ( $n.i($o) == no ) { m Debes identificarte antes de utilizar el comando 12SET. | l.v }
    if  ($l.db(nickserv\ $+ $r.c($o),configuracion,emailr)) {
      b.db nickserv\ $+ $r.c($o) configuracion emailr
      m Se ha anulado el proceso de cambio de su e-mail de registro.
    }
    else {
      m Lo siento, no tienes pendiente un cambio de email.
    }
    l.v
  }
  if ( $d(5) == tlf ) {
    if ( $d(6) != $null ) {
      if ( $n.i($o) == no ) { m Debes identificarte antes de utilizar el comando 12SET. | l.v }
      if ($len($d(6)) != 9) || ($d(6) !isnum) || (. isin $d(6) || 6* !iswm $strip($d(6))) { m Numero de teléfono inválido, utiliza tu numero de teléfono real. | l.v }
      g.db nickserv\ $+ $r.c($o) configuracion tlf $strip($d(6))
      m Se ha guardado su numero de teléfono.
      l.v
    }
    if ( $n.i($o) == no ) { m Debes identificarte antes de utilizar el comando 12SET. | l.v }
    b.db nickserv\ $+ $r.c($o) configuracion tlf
    m Se ha borrado su numero de teléfono.
    l.v
  }
  if ( $d(5) == KILL ) {
    if ( $d(6) == ON ) {
      if ( $n.i($o) == no ) { m Debes identificarte antes de utilizar el comando 12SET. | l.v }
      g.db nickserv\ $+ $r.c($o) configuracion kill on
      m Protección de KILL 12activada.
      l.v
    }
    if ( $d(6) == QUICK ) {
      if ( $n.i($o) == no ) { m Debes identificarte antes de utilizar el comando 12SET. | l.v }
      g.db nickserv\ $+ $r.c($o) configuracion kill quick
      m Protección de KILL 12activada, con una espera reducida.
      l.v
    }
    if ( $d(6) == OFF ) {
      if ( $n.i($o) == no ) { m Debes identificarte antes de utilizar el comando 12SET. | l.v }
      b.db nickserv\ $+ $r.c($o) configuracion kill
      m Protección de KILL 12desactivada.
      l.v
    }
    m Sintaxis: 12SET KILL $chr(123) $+ ON $chr(124) QUICK $chr(124) OFF $+ $chr(125)
    m 12/msg $nickserv AYUDA SET KILL para más información.
    l.v
  }
  if ( $d(5) == VHOST ) {
    if ( $d(6) != $null ) {
      if ( $n.i($o) == no ) { m Debes identificarte antes de utilizar el comando 12SET. | l.v }
      if ( $l.db(nickserv\ $+ $r.c($o),configuracion,ervhost) > $ctime ) && ( $s.n($o) < 5 ) {
        %tmp.ervhost = $l.db(nickserv\ $+ $r.c($o),configuracion,ervhost)
        m Sólamente puede realizar un cambio de ip virtual cada 24 horas.
        m Espere hasta las12 $f(%tmp.ervhost) para el próximo cambio.
        l.v
      }
      else { b.db nickserv\ $+ $r.c($o) configuracion ervhost }
      nicksetvhost $o $d(6)
      l.v
    }
    else {
      if ( $n.i($o) == no ) { m Debes identificarte antes de utilizar el comando 12SET. | l.v }
      if ( $l.db(nickserv\ $+ $r.c($o),configuracion,vhostsf) != $null ) {
        a.t N:: $+ $o $+ ::V
        b.db nickserv\ $+ $r.c($o) configuracion vhostsf
      }
      m Ip virtual deshabilitada.
      l.v
    }
  }
  if ( $d(5) == FIRMA ) {
    if ( $d(6) != $null ) {
      if ( $n.i($o) == no ) { m Debes identificarte antes de utilizar el comando 12SET. | l.v }
      g.db nickserv\ $+ $r.c($o) configuracion firma $q.c($d(6-))
      m Firma personalizada cambiada.
      l.v
    }
    if ( $n.i($o) == no ) { m Debes identificarte antes de utilizar el comando 12SET. | l.v }
    b.db nickserv\ $+ $r.c($o) configuracion firma
    m Firma personalizada deshabilitada.
    l.v
  }
  if ( $d(5) == QUIT ) {
    if ( $d(6) == ON ) {
      if ( $n.i($o) == no ) { m Debes identificarte antes de utilizar el comando 12SET. | l.v }
      g.db nickserv\ $+ $r.c($o) configuracion mquit on
      m Su último mensaje de salida está visible para el comando 12INFO.
      l.v
    }
    if ( $d(6) == OFF ) {
      if ( $n.i($o) == no ) { m Debes identificarte antes de utilizar el comando 12SET. | l.v }
      b.db nickserv\ $+ $r.c($o) configuracion mquit
      m Su último mensaje de salida está oculto para el comando 12INFO.
      l.v
    }
    m Sintaxis: 12SET QUIT $chr(123) $+ ON $chr(124) OFF $+ $chr(125)
    m 12/msg $nickserv AYUDA SET QUIT para más información.
    l.v
  }
  if ( $d(5) == PRIVATE ) {
    if ( $d(6) == ON ) {
      if ( $n.i($o) == no ) { m Debes identificarte antes de utilizar el comando 12SET. | l.v }
      g.db nickserv\ $+ $r.c($o) configuracion private on
      m Su información está oculta para el comando 12INFO.
      l.v
    }
    if ( $d(6) == OFF ) {
      if ( $n.i($o) == no ) { m Debes identificarte antes de utilizar el comando 12SET. | l.v }
      b.db nickserv\ $+ $r.c($o) configuracion private
      m Su información no está oculta para el comando 12INFO.
      l.v
    }
    m Sintaxis: 12SET PRIVATE $chr(123) $+ ON $chr(124) OFF $+ $chr(125)
    m 12/msg $nickserv AYUDA SET PRIVATE para más información.
    l.v
  }
  if ( $d(5) == NOEXPIRE ) {
    c.r CA
    if ( $d(6) != $null ) {
      if ( $d(7) == $null ) { m Error de Sintaxis: 12SET NOEXPIRE <nick> <on/off/tiempo-en-meses> | l.v }
      if ( $d(7) == on ) {
        if ( $n.r($d(6))  == no ) { m El nick12 $d(6) no está registrado. | l.v }
        if ( $l.db(nickserv\ $+ $r.c($d(6)),configuracion,noexpire) != $null ) { m El nick12 $d(6) ya tiene activado el No-Expire. | l.v }
        g.db nickserv\ $+ $r.c($d(6)) configuracion noexpire on
        m Activado el No-Expire indefinidamente para el nick12 $d(6) $+ .
        l.v 
      }
      if ( $d(7) == off ) {
        if ( $n.r($d(6))  == no ) { m El nick12 $d(6) no está registrado. | l.v }
        if ( $l.db(nickserv\ $+ $r.c($d(6)),configuracion,noexpire) == $null ) { m El nick12 $d(6) no tiene activado el No-Expire. | l.v }
        b.db nickserv\ $+ $r.c($d(6)) configuracion noexpire
        m Desactivado el No-Expire del nick12 $d(6) $+ .
        l.v 
      }
      if ( $n.r($d(6))  == $false ) { m El nick12 $d(6) no está registrado. | l.v }
      if ( $l.db(nickserv\ $+ $r.c($d(6)),configuracion,noexpire) != $null ) { m El nick12 $d(6) ya tiene activado el No-Expire. | l.v }
      if ( $d(7) !isnum || . isin $d(7)) { m El tiempo debe de ser un número. | l.v }
      if ( $d(7) > 12) { m El tiempo no puede ser mayor de 1 año | l.v }
      %tmp.expira = $calc($d(7) *2592000 +$ctime)
      g.db nickserv\ $+ $r.c($d(6)) configuracion noexpire %tmp.expira
      m Activado el No-Expire para el nick12 $d(6) hasta las12 $f(%tmp.expira)
      l.v
    }
    m Error de Sintaxis: 12SET NOEXPIRE <nick> <on/off/tiempo-en-meses>
    l.v
  }
  if ( $d(5) == MAILR ) {
    c.r CA
    if ( $d(6) != $null ) {
      if ( $d(7) == $null ) { m Error de Sintaxis: 12SET MAILR <nick> <nuevo-correo> | l.v }
      if ( $n.r($d(6))  == no ) { m El nick12 $d(6) no está registrado. | l.v }
      if ( $l.db(nickserv\ $+ $r.c($d(6)),configuracion,emailreg) == $d(7) ) { m El e-mail de registro del nick12 $d(6) ya es12 $d(7) $+ . | l.v }
      if ( @ !isin $d(7) ) || ( . !isin $d(7) ) { m Dirección de e-mail invalida, utiliza una dirección de correo real. | l.v }
      %tmp.correoreg = $l.db(nickserv\ $+ $r.c($d(6)),configuracion,emailreg)
      %tmp.correoreg2 = $l.db(nicks.db,correos,%tmp.correoreg)
      g.db nicks.db correos %tmp.correoreg $calc(%tmp.correoreg2 -1)
      if ( $calc(%tmp.correoreg2 -1) == 0 ) { b.db nicks.db correos %tmp.correoreg }
      if ( $l.db(nicks.db,correos,$d(7)) == $null ) { g.db nicks.db correos $d(7) 1 }
      else {
        %tmp.correoreg2 = $l.db(nicks.db,correos,$d(7))
        g.db nicks.db correos $d(7) $calc(%tmp.correoreg2 +1)
      }
      g.db nickserv\ $+ $r.c($d(6)) configuracion emailreg $d(7)
      m El e-mail de registro de12 $d(6) ha sido cambiado a12 $d(7) $+ .
      l.v
    }
    m Error de Sintaxis: 12SET MAILR <nick> <nuevo-correo>
    l.v
  }
  m Error de Sintaxis: 12SET <opcion> <parametros>
  m 12/msg $nickserv AYUDA SET para más información.
  l.v
}

alias nickserv.automode {
  if ($d(5)) {
    if ($n.r($d(5)) == si) {
      if ($d(6)) {
        set %temp.letra 1
        set %temp.novalidas
        set %temp.validas
        while ($mid($d(6),%temp.letra,1)) {
          if ($mid($d(6),%temp.letra,1) isincs ohaAOkNCWqHX) { set %temp.validas %temp.validas $+ $mid($d(6),%temp.letra,1) }
          else { set %temp.novalidas %temp.novalidas $mid($d(6),%temp.letra,1) }
          inc %temp.letra 1
        }
        if (%temp.validas) {
          if ($l.db(nickserv\ $+ $r.c($d(5)),configuracion,automode)) {
            m AutoMode para12 $d(5) cambiado a12 %temp.validas
            if (%temp.novalidas) { m Se han ignorado los modos12 %temp.novalidas por no ser soportados por el UDB }
            debugc $nickserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o modifica los modos automaticos de12 $d(5) a12 %temp.validas
          }
          else {
            m AutoMode para12 $d(5) puesto en12 %temp.validas
            if (%temp.novalidas) { m Se han ignorado los modos12 %temp.novalidas por no ser soportados por el UDB }
            debugc $nickserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o establece los modos automaticos de12 $d(5) en12 %temp.validas
          }
          g.db nickserv\ $+ $r.c($d(5)) configuracion automode %temp.validas
          a.t N:: $+ $d(5) $+ ::M %temp.validas
          r.n $d(5)
          s : $+ $nickserv svs2mode $d(5) + $+ $l.db(nickserv\ $+ $r.c($d(5)),configuracion,automode)
        }
        else {
          m 4ERROR: No has especificado ningun modo válido.
          m Los modos válidos son:12 ohaAOkNCWqHX
        }
      }
      else {
        var %a = $l.db(nickserv\ $+ $r.c($d(5)),configuracion,automode)
        b.db nickserv\ $+ $r.c($d(5)) configuracion automode
        a.t N:: $+ $d(5) $+ ::M
        r.n $d(5)
        m AutoMode para12 $d(5) eliminado.
        debugc $nickserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o elimina los modos automaticos de12 $d(5) $+ .
        s : $+ $nickserv svs2mode $d(5) - $+ %a
      }
    }
    else {
      m 4ERROR: El nick12 $d(5) no está registrado.
    }
  }
  else {
    m 4Sintaxis incorrecta: 12AUTOMODE <nick> [modos]
    m 12/msg $nickserv HELP AUTOMODE para más información.
  }
  l.v
}

alias nickserv.dropn {
  %tmp.emailreg = $l.db(nickserv\ $+ $r.c($1),configuracion,emailreg)
  %tmp.r.m = $l.db(nicks.db,correos,%tmp.emailreg)
  dec %tmp.r.m
  g.db nicks.db correos %tmp.emailreg %tmp.r.m
  if ( %tmp.r.m == 0 ) { b.db nicks.db correos %tmp.emailreg }
  flushini $mircdirdatabase\nickserv\ $+ $r.c($1)
  %tmp.dirn = database\nickserv\ $+ $r.c($1)
  if ( $initopic( %tmp.dirn , fundador ) == 0 ) { goto f.f }
  clear @fundador
  window -hl @fundador
  loadbuf -tfundador @fundador %tmp.dirn
  %tmp.t.f = $line(@fundador,0)
  %tmp.c.f = 0
  :b.f
  if ( %tmp.c.f == %tmp.t.f ) { goto f.f }
  inc %tmp.c.f
  %tmp.c = $line( @fundador , %tmp.c.f )
  %tmp.c = $gettok(%tmp.c,1,61)
  if ( $l.db(chanserv\ $+ %tmp.c,configuracion,sucesor) == $null ) {
    chanserv.dropc %tmp.c
    debugc $chanserv %conf.canal.admins $+ , $+ %conf.canal.opers El canal12 $r.c(%tmp.c) propiedad del nick12 $r.c($1) y sin sucesor ha sido borrado.
  }
  else {
    %tmp.sucesor = $l.db(chanserv\ $+ %tmp.c,configuracion,sucesor)
    chanserv.c.f %tmp.c $1 $r.c(%tmp.sucesor)
    debugc $chanserv %conf.canal.admins $+ , $+ %conf.canal.opers El canal12 $r.c(%tmp.c) propiedad del nick12 $r.c($1) pasa al sucesor del mismo (12 $+ $r.c(%tmp.sucesor) $+ )
    b.db chanserv\ $+ %tmp.c configuracion sucesor
    b.db nickserv\ $+ %tmp.sucesor sucesor %tmp.c
  }
  goto b.f
  :f.f
  if ( $initopic( %tmp.dirn , sucesor ) == 0 ) { goto f.s }
  clear @sucesor
  window -hl @sucesor
  loadbuf -tsucesor @sucesor %tmp.dirn
  %tmp.t.s = $line(@sucesor,0)
  %tmp.c.s = 0
  :b.s
  if ( %tmp.c.s == %tmp.t.s ) { goto f.s }
  inc %tmp.c.s
  %tmp.c = $line( @sucesor , %tmp.c.s )
  %tmp.c = $gettok(%tmp.c,1,61)
  b.db chanserv\ $+ %tmp.c configuracion sucesor
  goto b.s
  :f.s
  if ( $initopic( %tmp.dirn , registros ) == 0 ) { goto f.r }
  clear @registros
  window -hl @registros
  loadbuf -tregistros @registros %tmp.dirn
  %tmp.t.r = $line(@registros,0)
  %tmp.c.r = 0
  :b.r
  if ( %tmp.c.r == %tmp.t.r ) { goto f.r }
  inc %tmp.c.r
  %tmp.c = $line( @registros , %tmp.c.r )
  %tmp.c = $gettok(%tmp.c,1,61)
  b.db chanserv\ $+ %tmp.c registros $r.c($1)
  goto b.r
  :f.r
  if ( $initopic( %tmp.dirn , akicks ) == 0 ) { goto f.a }
  clear @akicks
  window -hl @akicks
  loadbuf -takicks @akicks %tmp.dirn
  %tmp.t.a = $line(@akicks,0)
  %tmp.c.a = 0
  :b.a
  if ( %tmp.c.a == %tmp.t.a ) { goto f.a }
  inc %tmp.c.a
  %tmp.c = $line( @akicks , %tmp.c.a )
  %tmp.c = $gettok(%tmp.c,1,61)
  b.db chanserv\ $+ %tmp.c akicks $r.c($1)
  goto b.a
  :f.a
  if ( $l.db(nickserv\ $+ $r.c($1),configuracion,enregistro) != $null ) {
    %tmp.c.e.r = $l.db(nickserv\ $+ $r.c($1),configuracion,enregistro)
    .remove $mircdirdatabase\cregserv\canales\ $+ %tmp.c.e.r
  }
  if ($l.db(nicks.db,registrados,$r.c($1))) { b.db nicks.db registrados $1 }
  a.t N:: $+ $1
  if ( $exists($mircdirdatabase\cregserv\nicks\ $+ $r.c($1)) == $true ) { .remove $mircdirdatabase\cregserv\nicks\ $+ $r.c($1) }
  .remove $mircdirdatabase\nickserv\ $+ $r.c($1)
  r.n $1
}

alias nickserv.marcadel {
  if ( $d(6) == $null ) { m Error de Sintaxis: 12MARCADEL <nick> <numero> | l.v }
  if ( $n.r($d(5)) == no ) { m El nick12 $d(5) no está registrado. | l.v }
  if ( $d(6) !isnum ) { m La marca debe de ser un numero. | l.v }
  if ( $l.db(nickserv\ $+ $r.c($d(5)),marcas,$d(6)) == $null ) { m La marca12 $d(6) no existe. | l.v }
  %tmp.marcas = $l.db(nickserv\ $+ $r.c($d(5)),marcas,total)
  dec %tmp.marcas
  b.db nickserv\ $+ $r.c($d(5)) marcas $d(6)
  g.db nickserv\ $+ $r.c($d(5)) marcas total %tmp.marcas
  m La marca12 $d(6) ha sido borrada.
  if ( %tmp.marcas == 0 ) { b.db nickserv\ $+ $r.c($d(5)) marcas | goto f.om }
  %tmp.marca = $d(6)
  :o.m
  inc %tmp.marca
  if ( $l.db(nickserv\ $+ $r.c($d(5)),marcas,%tmp.marca) == $null ) { goto f.om }
  %tmp.marcag = $l.db(nickserv\ $+ $r.c($d(5)),marcas,%tmp.marca)
  g.db nickserv\ $+ $r.c($d(5)) marcas $calc(%tmp.marca -1) %tmp.marcag
  b.db nickserv\ $+ $r.c($d(5)) marcas %tmp.marca
  goto o.m
  :f.om
  l.v
}

alias nickserv.msgnr {
  if ( $d(5) == BDD ) {
    if ( $d(6) == $null ) {
      b.db nicks.db msgnr mensajer
      m Mensaje de entrada a nicks identificados con +r 12desactivado.
      debugc $nickserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o desactiva el mensaje de entrada a nicks identificados con MODER.
      l.v
    }
    g.db nicks.db msgnr mensajer $q.c($d(6-))
    m Mensaje de entrada a nicks identificados con +r cambiado a12 $d(6-) $+ .
    debugc $nickserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o cambia el mensaje de entrada a nicks identificados con MODER a12 $d(6-) $+ .
    l.v
  }
  if ( $d(5) == NOBDD ) {
    if ( $d(6) == $null ) {
      b.db nicks.db msgnr mensaje
      m Mensaje de entrada a nicks identificados sin +r 12desactivado.
      debugc $nickserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o desactiva el mensaje de entrada a nicks identificados sin MODER.
      l.v
    }
    g.db nicks.db msgnr mensaje $q.c($d(6-))
    m Mensaje de entrada a nicks identificados sin +r cambiado a12 $d(6-) $+ .
    debugc $nickserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o cambia el mensaje de entrada a nicks identificados sin MODER a12 $d(6-) $+ .
    l.v
  }
  m Error de Sintaxis: 12MSGNR $chr(123) $+ BDD $chr(124) NOBDD $+ $chr(125) <mensaje>
  l.v
}

alias nickserv.listforbid {
  m Listado de nicks prohibidos
  flushini $mircdirdatabase\nicks.db
  %tmp.ruta = $mircdirdatabase\nicks.db
  if ( $initopic( %tmp.ruta , forbid ) == 0 ) { goto f.f }
  clear @forbid
  window -hl @forbid
  loadbuf -tforbid @forbid $mircdirdatabase\nicks.db
  %tmp.total = $line(@forbid,0)
  %tmp.linea = 0
  while ( %tmp.linea < %tmp.total ) {
    inc %tmp.linea
    %tmp.l.linea = $line( @forbid , %tmp.linea )
    %tmp.dforbid = $gettok(%tmp.l.linea,2-,61)
    %tmp.nforbid = $r.c($gettok(%tmp.l.linea,1,61))
    %tmp.norigenf = $r.c($gettok(%tmp.dforbid,1,32))
    %tmp.mforbid = $p.c($gettok(%tmp.dforbid,2-,32))
    m %tmp.nforbid ( $+ $strip(%tmp.norigenf) $+ ) 12 $+ %tmp.mforbid
  }
  :f.f
  m Fin de la lista de nicks prohibidos.
  l.v
}

alias nickserv.unforbid {
  if ( $d(5) == $null ) { m Error de Sintaxis: 12UNFORBID <nick> | l.v }
  if ( $l.db(nicks.db,forbid,$d(5)) == $null ) { m El nick12 $d(5) no está en la lista de forbid. | l.v }
  a.t N:: $+ $d(5) $+ ::B
  b.db nicks.db forbid $r.c($d(5))
  m El nick12 $d(5) ha sido liberado.
  debugc $nickserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o libera el nick12 $d(5) $+ .
  l.v
}

alias nickserv.getpass {
  if ( $d(5) == $null ) { m Error de Sintaxis: 12GETPASS <nick> | l.v }
  if ( $n.r($d(5)) == no ) { m El nick12 $d(5) no está registrado. | l.v }
  if ( $l.db(nickserv\ $+ $r.c($d(5)),representante,tipo) != $null ) && ( $s.n($o) < 8 ) { m 4Permiso denegado. | l.v }
  if ( $d(5) == $readini(dbots.conf,otras,root)) { m 4Permiso denegado. | l.v }
  %tmp.getpass = $l.db(nickserv\ $+ $r.c($d(5)),configuracion,password)
  m La contraseña de12 $d(5) es12 %tmp.getpass $+ .
  debugc $nickserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o utiliza GETPASS sobre12 $d(5) $+ .
  l.v
}

alias nickserv.forbid {
  if ( $d(6) == $null ) { m Error de Sintaxis: 12FORBID <nick> <motivo> | l.v }
  if ( $l.db(nicks.db,forbid,$r.c($d(5))) != $null ) { m El nick12 $d(5) ya está en la lista de forbid. | l.v }
  if ( $l.db(nickserv\ $+ $r.c($d(5)),representante,tipo) != $null ) { m 4Permiso denegado. | l.v }
  if ( $n.r($d(5)) == si ) { nickserv.dropn $d(5) }
  a.t N:: $+ $d(5) $+ ::B $d(6-)
  g.db nicks.db forbid $r.c($d(5)) $r.c($o) $q.c($d(6-))
  r.n $d(5)
  m El nick12 $d(5) ha sido prohibido.
  debugc $nickserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o prohibe el nick12 $d(5) $+ . Motivo:12 $d(6-)
  l.v
}

alias nickserv.swhois {
  if ( $d(5) == $null ) { m Error de Sintaxis: 12SWHOIS <nick> <texto> | l.v }
  if ( $n.r($d(5)) == no ) { m El nick12 $d(5) no está registrado. | l.v }
  if ( $d(6) == $null ) {
    a.t N:: $+ $d(5) $+ ::W
    b.db nickserv\ $+ $r.c($d(5)) configuracion swhois
    m Eliminado el SWHOIS de12 $d(5) $+ .
    l.v
  }
  if ( $l.db(status.db,status,$r.c($d(5))) != $null ) { s : $+ %conf.servidor SWHOIS $d(5) : $+ $strip($d(6-)) }
  g.db nickserv\ $+ $r.c($d(5)) configuracion swhois $d(6-)
  a.t N:: $+ $d(5) $+ ::W $d(6-)
  m Cambiado el SWHOIS del nick12 $d(5) a12 $d(6-) $+ .
  debugc $nickserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o añade un SWHOIS a12 $d(5) $+ . ( $+ $d(6-) $+ )
  l.v
}

alias nickserv.vhost {
  if ( $d(5) == $null ) { m Error de Sintaxis: 12VHOST <nick> <ip-deseada> | l.v }
  if ( $n.r($d(5)) == no ) { m El nick12 $d(5) no está registrado. | l.v }
  if ( $d(6) == $null ) {
    if ( $l.db(nickserv\ $+ $r.c($d(5)),configuracion,vhostf) == $null ) { m El nick12 $d(5) no tiene ninguna VHOST asignada. | l.v }
    a.t N:: $+ $d(5) $+ ::V
    b.db nickserv\ $+ $r.c($d(5)) configuracion vhostf
    m Eliminado el VHOST de12 $d(5) $+ .
    debugc $nickserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o elimina el VHOST a12 $d(5) $+ .
    l.v
  }
  if ( $len($d(6)) > 60 ) { m La ip virtual no puede superar los 60 caracteres. | l.v }
  a.t N:: $+ $d(5) $+ ::V $d(6)
  g.db nickserv\ $+ $r.c($d(5)) configuracion vhostf $d(6)
  m Cambiado el VHOST del nick12 $d(5) a $d(6)
  debugc $nickserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o añade un VHOST a12 $d(5) $+ . ( $+ $d(6) $+ )
  l.v
}

alias nickserv.listsuspend {
  if ($ini(database\nicks.db,suspendidos,0) == 0) { m Lista vacia. }
  else {
    var %a 1
    m Listado de nicks suspendidos
    while ( $ini(database\nicks.db,suspendidos,%a) ) {
      %tmp.na = $ini(database\nicks.db,suspendidos,%a)
      %tmp.sm = $l.db(nickserv\ $+ %tmp.na,configuracion,suspend.motivo)
      m 12 $+ %tmp.na - Motivo:12 $p.c(%tmp.sm)
      inc %a 1
    }
    m Fin de la lista de nicks suspendidos.
  }
  l.v
}

alias nickserv.marca {
  if ( $d(6) == $null ) { m Error de Sintaxis: 12MARCA <nick> <texto> | l.v }
  if ( $n.r($d(5)) == no ) { m El nick12 $d(5) no está registrado. | l.v }
  %tmp.marcas = $l.db(nickserv\ $+ $r.c($d(5)),marcas,total)
  inc %tmp.marcas
  g.db nickserv\ $+ $r.c($d(5)) marcas total %tmp.marcas
  g.db nickserv\ $+ $r.c($d(5)) marcas %tmp.marcas $ctime $r.c($o) $q.c($d(6-))
  m Añadida marca al nick12 $d(5) (" $+ $d(6-) $+ ")
  debugc $nickserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o añade una marca al nick12 $d(5) (" $+ $d(6-) $+ ")
  l.v
}

alias nickserv.drop {
  if ( $d(5) == $null ) { m Error de Sintaxis: 12DROP <nick> | l.v }
  if ($chr(42) isin $d(5)) {
    if ($findfile(database\nickserv\,$d(5),0) >= 1) {
      var %a $findfile(database\nickserv\,$d(5),0)
      var %b 0
      var  %c
      while (%a >= 1) {
        var %r = $nopath($findfile(database\nickserv\,$d(5),%a))
        if ($d(5) iswm %r) && ( $l.db(nickserv\ $+ $r.c(%r),representante,tipo) = $null ) {
          inc %b 1
          %c = %c %r
          nickserv.dropn %r
        }
        dec %a 1
      }
      m Elminados12 %b nicks que coinciden con2 $d(5) ( %c )
      debugc $nickserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o borra12 %b nicks que coinciden con12 $d(5) ( %c )
    }
    else {
      m 4ERROR: No hay nicks que coincidan con12 $d(5) $+ .
    }
  }
  else {
    if ( $n.r($d(5)) == no ) { m El nick12 $d(5) no está registrado. | l.v }
    if ( $l.db(nickserv\ $+ $r.c($d(5)),representante,tipo) != $null ) { m 12 $+ $d(5) es un representante de la red. | l.v }
    nickserv.dropn $d(5)
    m El nick12 $d(5) ha sido dropado.
    debugc $nickserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o borra el nick12 $d(5) $+ .
  }
  l.v
}

alias nickserv.viewip {
  if ( $d(5) == $null ) { m Error de Sintaxis: 12VIEWIP <nick> | l.v }
  if ( $n.c($d(5)) == no ) { m El nick12 $d(5) no está conectado. | l.v }
  if ( $s.n($o) < $s.n($d(5)) ) { m 4Permiso denegado. | l.v }
  %tmp.ip = $l.db(usuarios.db,usuarios,$r.c($d(5)))
  %tmp.ip = $gettok(%tmp.ip,2,32)
  m La ip de12 $d(5) es12 %tmp.ip $+ .
  debugc $nickserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o utiliza VIEWIP sobre12 $d(5) $+ .
  l.v
}

alias nickserv.suspend {
  if ( $d(6) == $null ) { m Error de Sintaxis: 12SUSPEND <nick> <motivo> | l.v }
  if ( $n.r($d(5)) == no ) { m El nick12 $d(5) no está registrado. | l.v }
  if ( $l.db(nickserv\ $+ $r.c($d(5)),representante,tipo) != $null ) { m 12 $+ $d(5) es un representante de la red. | l.v }
  if ( $e.n($d(5)) == SUSPENDIDO ) { m El nick12 $d(5) ya está suspendido. | l.v }
  %tmp.password = $l.db(nickserv\ $+ $r.c($d(5)),configuracion,password)
  a.t N:: $+ $d(5) $+ ::S $d(6-)
  g.db nickserv\ $+ $r.c($d(5)) configuracion estado SUSPENDIDO
  g.db nickserv\ $+ $r.c($d(5)) configuracion suspend.motivo $q.c($d(6-))
  g.db nickserv\ $+ $r.c($d(5)) configuracion suspend.origen $r.c($o)
  g.db nickserv\ $+ $r.c($d(5)) configuracion suspend.fecha $ctime
  g.db nicks.db suspendidos $r.c($d(5)) *
  if ( $n.i($d(5)) == si ) {
    s : $+ $nickserv %conf.metodo $d(5) :Su nick acaba de ser SUSPENDido
    s : $+ $nickserv %conf.metodo $d(5) :Motivo:12 $d(6-)
  }
  r.n $d(5)
  m El nick12 $d(5) ha sido suspendido.
  debugc $nickserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o suspende el nick12 $d(5) $+ . Motivo:12 $d(6-)
  l.v
}

alias nickserv.unsuspend {
  if ( $d(5) == $null ) { m Error de Sintaxis: 12UNSUSPEND <nick> | l.v }
  if ( $n.r($d(5)) == no ) { m El nick12 $d(5) no está registrado. | l.v }
  if ( $e.n($d(5)) != SUSPENDIDO ) { m El nick12 $d(5) no está suspendido. | l.v }
  %tmp.password = $l.db(nickserv\ $+ $r.c($d(5)),configuracion,password)
  a.t N:: $+ $d(5) $+ ::S
  g.db nickserv\ $+ $r.c($d(5)) configuracion estado ACTIVO
  b.db nickserv\ $+ $r.c($d(5)) configuracion suspend.motivo
  b.db nickserv\ $+ $r.c($d(5)) configuracion suspend.origen
  b.db nickserv\ $+ $r.c($d(5)) configuracion suspend.fecha
  b.db nicks.db suspendidos $r.c($d(5)) *
  r.n $d(5)
  m El nick12 $d(5) ha sido reactivado.
  debugc $nickserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o reactiva el nick12 $d(5) $+ .
  l.v
}

alias nickserv.list {
  if ( $d(5) == $null ) { m Error de Sintaxis: 12LIST <patrón> | l.v }
  m Lista de Nicks que satisfacen12 $strip($d(5)) $+ :
  %tmp.nr = $findfile($mircdirdatabase\nickserv\,*,0)
  %tmp.c = 0
  %tmp.m = 0
  :c.l
  while ( %tmp.c < %tmp.nr ) {
    inc %tmp.c
    %tmp.n = $r.c($nopath($findfile($mircdirdatabase\nickserv\,*,%tmp.c)))
    if ( $d(5) iswm %tmp.n ) {
      m %tmp.n -12 $e.n(%tmp.n) $+  $e(%tmp.n)
      inc %tmp.m
      if ( %tmp.m == 50 ) { goto s.l }
    }
  }
  :s.l
  m Fin de la lista,12 %tmp.m $+ /12 $+ %tmp.nr entradas mostradas.
  l.v
}

alias nickserv.dropvhost {
  if ( $d(5) == $null ) { m Error de Sintaxis: 12DROPVHOST <nick> | l.v }
  if ( $n.r($d(5)) == no ) { m El nick12 $d(5) no está registrado. | l.v }
  if ( $l.db(nickserv\ $+ $r.c($d(5)),configuracion,vhostsf) == $null ) { m El nick12 $d(5) no tiene asignada ninguna ip virtual asignada. | l.v }
  a.t N:: $+ $d(5) $+ ::V
  b.db nickserv\ $+ $r.c($d(5)) configuracion vhostsf
  m La ip virtual de12 $d(5) ha sido eliminada.
  debugc $nickserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o utiliza DROPVHOST sobre12 $d(5) $+ .
  l.v
}

alias nickserv.noexpire {
  if ( $n.i($o) == no ) { m Debes identificarte antes de utilizar el comando 12NOEXPIRE. | l.v }
  if ( $l.db(nickserv\ $+ $r.c($o),configuracion,noexpire) != $null ) { m Tu nick ya tiene No-Expire. | l.v }
  if ( $l.db(nickserv\ $+ $r.c($o),configuracion,noexpirep) != $null ) {
    if ( $l.db(nickserv\ $+ $r.c($o),configuracion,noexpirep) <= $ctime ) { b.db nickserv\ $+ $r.c($o) configuracion noexpirep }
    %tmp.nouso = $l.db(nickserv\ $+ $r.c($o),configuracion,noexpirep)
    m No puedes volver a usar el servicio No-Expire hasta12 $f(%tmp.nouso) $+ .
    l.v
  }
  %tmp.noexpire = $calc($ctime +86400*$l.conf(nickserv,noexpire))
  if ( $l.db(nicks.db,noexpirec,$r.c($o)) == $null ) { %tmp.noexpirec = confirma $+ $rand(0,9) $+ $rand(0,9) $+ $rand(0,9) $+ $rand(0,9) | g.db nicks.db noexpirec $r.c($o) %tmp.noexpirec }
  else { %tmp.noexpirec = $l.db(nicks.db,noexpirec,$r.c($o)) }
  if ( $d(5) == $null ) {
    m Si está seguro activar el No-Expire teclee 12/msg $nickserv NOEXPIRE %tmp.noexpirec $+ .
    l.v
  }
  if ( $d(5) != $l.db(nicks.db,noexpirec,$r.c($o)) ) {
    %tmp.noexpirec = $l.db(nicks.db,noexpirec,$r.c($o))
    m 4Código de confirmación incorrecto.
    m Si está seguro activar el No-Expire teclee 12/msg $nickserv NOEXPIRE %tmp.noexpirec $+ .
    l.v
  }
  b.db nicks.db noexpirec $r.c($o)
  g.db nickserv\ $+ $r.c($o) configuracion noexpire %tmp.noexpire
  g.db nickserv\ $+ $r.c($o) configuracion noexpirep $calc(%tmp.noexpire +86400*$l.conf(nickserv,enoexpire))
  m Servicio No-Expire activado hasta12 $f(%tmp.noexpire) $+ .
  l.v
}

alias nickserv.sendpass {
  if ( $d(5) == $null ) { m Error de Sintaxis: 12SENDPASS <nick> | l.v }
  if ( $n.r($d(5)) == no ) { m El nick12 $d(5) no está registrado. | l.v }
  if ( $l.db(nickserv\ $+ $r.c($o),configuracion,tsendpass) >= $ctime ) && ( !$l.db(nickserv\ $+ $o,representante,tipo) ) && ($o != $readini(dbots.conf,otras,root)) { m 4ERROR: No ha pasado12 1 hora desde que utilizaste el comando 12SENDPASS. | l.v }
  %tmp.email = $l.db(nickserv\ $+ $r.c($d(5)),configuracion,emailreg)
  %tmp.password = $l.db(nickserv\ $+ $r.c($d(5)),configuracion,password)
  email sendpass.txt %tmp.email $nickserv $d(5) %tmp.password $helpserv %conf.servidor
  m $iif($l.db(nickserv\ $+ $o,representante,tipo),La contraseña de12 $d(5) ha sido enviado al e-mail12 %tmp.email,La contraseña de12 $d(5) ha sido enviado a su e-mail.)
  m Que revise su correo, en unos minutos le llegara la contraseña.
  debugc $nickserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o utiliza SENDPASS para12 $d(5) $+ .
  g.db nickserv\ $+ $r.c($o) configuracion tsendpass $calc($ctime + 3600)
  l.v
}

alias nickserv.sendnewpass {
  if ( $n.r($o) == no ) { m Tu nick no está registrado. | l.v }
  if ( $l.db(nickserv\ $+ $r.c($o),configuracion,tsendnewpass) >= $ctime ) { m 4ERROR: No ha pasado12 1 hora desde que utilizaste el comando 12SENDPASS. | l.v }
  %tmp.email = $l.db(nickserv\ $+ $r.c($o),configuracion,emailreg)
  %tmp.password = $cpass
  a.t N:: $+ $o $+ ::P $md5(%tmp.password)
  email sendpass.txt %tmp.email $nickserv $o %tmp.password $helpserv %conf.servidor
  m La nueva contraseña ha sido enviado a tú e-mail.
  m Revisa tú correo, en unos minutos te llegara la nueva contraseña.
  debugc $nickserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o utiliza 21SENDNEWPASS.
  g.db nickserv\ $+ $r.c($o) configuracion tsendnewpass $calc($ctime + 3600)
  g.db nickserv\ $+ $r.c($o) configuracion password %tmp.password
  r.n $d(5)
  l.v
}

alias nickserv.estado {
  if ( $d(5) == $null ) { m Error de Sintaxis: 12ESTADO <nick> | m 12/msg $nickserv AYUDA ESTADO para más información. | l.v }
  if ( $s.n($d(5)) == $null ) { %tmp.nstatus = 0 | %tmp.tstatusdn = No conectado }
  if ( $s.n($d(5)) == 1 ) {
    %tmp.nstatus = 1
    if ( $n.r($d(5)) == si ) { %tmp.tstatusdn = Conectado, no identificado }
    else { %tmp.tstatusdn = Conectado, no registrado }
  }
  if ( $s.n($d(5)) == 2 ) { %tmp.nstatus = 2 | %tmp.tstatusdn = Suspendido }
  if ( $s.n($d(5)) > 2 ) { %tmp.nstatus = 3 | %tmp.tstatusdn = Identificado }
  m STATUS $d(5) %tmp.nstatus ( $+ %tmp.tstatusdn $+ )
  l.v
}

alias nickserv.verifica {
  if ( $d(5) == $null ) { m Error de Sintaxis: 12VERIFICA <nick> | m 12/msg $nickserv AYUDA VERIFICA para más información. | l.v }
  if ( $l.db(nickserv\ $+ $r.c($d(5)),representante,tipo) != $null ) { 
    %tmp.trepresentante = $l.db(nickserv\ $+ $r.c($d(5)),representante,tipo)
    m 12 $+ $d(5) es un %tmp.trepresentante de la Red.
    l.v
  }
  if ($d(5) == %conf.root) {
    m 12 $+ $d(5) es el ROOT principal de la red.
    l.v
  }
  m 12 $+ $d(5) no es un representante de la Red.
  l.v
}

alias nickserv.info {
  if ( $d(5) == $null ) { m Error de Sintaxis: 12INFO <nick> | m 12/msg $nickserv AYUDA INFO para más información. | l.v }
  if ( $l.db(nicks.db,forbid,$r.c($d(5))) != $null ) {
    m Nickname/alias:12 $strip($d(5))
    %tmp.forbid = $l.db(nicks.db,forbid,$r.c($d(5)))
    %tmp.origenf = $gettok(%tmp.forbid,1,32)
    %tmp.motivo = $gettok(%tmp.forbid,2-,32)
    m Estado: 12PROHIBIDO
    m Motivo:12 $p.c(%tmp.motivo)
    if ( $s.n($o) >= 5 ) {
      m Prohibido por12 $r.c(%tmp.origenf)
    }
    goto f.i
  }
  if ( $n.r($d(5)) == no ) { m El nick12 $d(5) no está registrado. | goto f.i }
  if ( $l.db(nickserv\ $+ $r.c($d(5)),configuracion,nocompleto) != $null ) && (( $s.n($o) < 5 ) && ( $d(6) != ALL )) { m El nick12 $d(5) no ha completado aún su proceso de registro. | goto f.i }
  if ( $l.db(nickserv\ $+ $r.c($d(5)),configuracion,private) == on ) {
    if ( $d(5) == $o ) || (( $s.n($o) >= 5 ) && ( $d(6) == ALL )) { goto s.p }
    else {
      m El nick12 $d(5) tiene activado el modo 4PRIVATE y su información está oculta.
      goto f.i
    }
  }
  :s.p
  m Nickname/alias:12 $strip($d(5)) $e($d(5))
  if ( $e.n($d(5)) == SUSPENDIDO ) {
    %tmp.motivo = $l.db(nickserv\ $+ $r.c($d(5)),configuracion,suspend.motivo)
    m Estado: 12SUSPENDIDO
    m Motivo:12 $p.c(%tmp.motivo)
    if ( $s.n($o) >= 5 ) {
      %tmp.suspend.o = $r.c($l.db(nickserv\ $+ $r.c($d(5)),configuracion,suspend.origen))
      %tmp.suspend.f = $f($l.db(nickserv\ $+ $r.c($d(5)),configuracion,suspend.fecha))
      m Suspendido por12 %tmp.suspend.o
      m Fecha de la suspensión:12 %tmp.suspend.f
    }
    if ( $s.n($o) < 4 ) { goto f.i }
  }
  else { m Estado: 12ACTIVO }
  %tmp.realname = $p.c($l.db(nickserv\ $+ $r.c($d(5)),configuracion,realname))
  %tmp.umask = $l.db(nickserv\ $+ $r.c($d(5)),configuracion,umask)
  %tmp.ufecha = $l.db(nickserv\ $+ $r.c($d(5)),configuracion,ulthora)
  %tmp.horareg = $l.db(nickserv\ $+ $r.c($d(5)),configuracion,horareg)
  %tmp.uquit = $l.db(nickserv\ $+ $r.c($d(5)),configuracion,quit)
  %tmp.tlf = $l.db(nickserv\ $+ $r.c($d(5)),configuracion,tlf)
  m Realname:12 %tmp.realname
  if (( $d(5) == $o ) && ( $n.i($o) == si )) || ( $s.n($o) >= 5 ) {
    m Último mask:12 %tmp.umask
  }
  if ( $l.db(nickserv\ $+ $r.c($d(5)),configuracion,nocompleto) != $null ) { m Este nick no se ha identificado aún por primera vez }
  else {
    if ( $n.i($d(5)) == no ) { m Última hora por la red:12 $f(%tmp.ufecha) }
  }
  m Hora de registro:12 $f(%tmp.horareg)
  if ( $l.db(nickserv\ $+ $r.c($d(5)),configuracion,noexpire) != $null ) {
    if ( $l.db(nickserv\ $+ $r.c($d(5)),configuracion,noexpire) == on ) { %tmp.noexpire = Ilimitada }
    else { %tmp.noexpire = $l.db(nickserv\ $+ $r.c($d(5)),configuracion,noexpire) | %tmp.noexpire = $f(%tmp.noexpire) }
    m Fecha mínima de expiración:12 %tmp.noexpire
  }
  if ( $l.db(nickserv\ $+ $r.c($d(5)),configuracion,mquit) == on ) || (( $s.n($o) >= 5 ) && ( $d(6) == ALL )) {
    if ( $l.db(nickserv\ $+ $r.c($d(5)),configuracion,quit) != $null ) { m Último mensaje de salida:12 $p.c(%tmp.uquit) }
  }
  if ( $l.db(nickserv\ $+ $r.c($d(5)),configuracion,vhostf) != $null ) {
    %tmp.vhost = $l.db(nickserv\ $+ $r.c($d(5)),configuracion,vhostf)
    m Ip virtual:12 %tmp.vhost
  }
  else {
    if ( $l.db(nickserv\ $+ $r.c($d(5)),configuracion,vhostsf) != $null ) {
      %tmp.vhost = $l.db(nickserv\ $+ $r.c($d(5)),configuracion,vhostsf)
      m Ip virtual:12 %tmp.vhost
    }
  }
  if ( $l.db(nickserv\ $+ $r.c($d(5)),configuracion,url) != $null ) {
    %tmp.url = $l.db(nickserv\ $+ $r.c($d(5)),configuracion,url)
    m URL:12 $p.c(%tmp.url)
  }
  if ( %tmp.tlf ) && ($o ==  $d(5)) { m Teléfono:12 %tmp.tlf }
  if ( $l.db(nickserv\ $+ $r.c($d(5)),configuracion,email) != $null ) {
    %tmp.email = $l.db(nickserv\ $+ $r.c($d(5)),configuracion,email)
    m E-Mail:12 $p.c(%tmp.email)
  }
  if ( $s.n($o) >= 5 ) {
    if ( $l.db(nickserv\ $+ $r.c($d(5)),configuracion,swhois) != $null ) {
      %tmp.swhois = $l.db(nickserv\ $+ $r.c($d(5)),configuracion,swhois)
      m SWHOIS:12 %tmp.swhois
    }
    %tmp.emailreg = $l.db(nickserv\ $+ $r.c($d(5)),configuracion,emailreg)
    m E-Mail de registro:12 %tmp.emailreg
  }
  if ( $l.db(nickserv\ $+ $r.c($d(5)),configuracion,firma) != $null ) {
    %tmp.firma = $l.db(nickserv\ $+ $r.c($d(5)),configuracion,firma)
    m Firma:12 $p.c(%tmp.firma)
  }
  %tmp.opciones = Registrado en DBs
  if ( $l.db(nickserv\ $+ $r.c($d(5)),configuracion,kill) != $null ) {
    if ( %tmp.opciones != $null ) { %tmp.opciones = %tmp.opciones $+ ,12Protección de KILL }
    else { %tmp.opciones = Protección de KILL }
  }
  if ( $l.db(nickserv\ $+ $r.c($d(5)),configuracion,private) == on ) {
    if ( %tmp.opciones != $null ) { %tmp.opciones = %tmp.opciones $+ ,12Private }
    else { %tmp.opciones = Private }
  }
  if ( $l.db(nickserv\ $+ $r.c($d(5)),configuracion,noexpire) != $null ) {
    if ( %tmp.opciones != $null ) { %tmp.opciones = %tmp.opciones $+ ,12No-Expire }
    else { %tmp.opciones = No-Expire }
  }
  if ( %tmp.opciones == $null ) { %tmp.opciones = Ninguna }
  m Opciones:12 %tmp.opciones
  if ( $d(5) == $o ) && ( $n.i($d(5)) == si ) || (( $s.n($o) >= 5 ) && ( $d(6) == ALL )) {
    %tmp.cfundador = 0
    %tmp.csucesor = 0
    %tmp.cregistro = 0
    %tmp.cakicks = 0
    flushini $mircdirdatabase\nickserv\ $+ $r.c($d(5))
    %tmp.ruta = $mircdirdatabase\nickserv\ $+ $r.c($d(5))
    if ( $initopic( %tmp.ruta , fundador ) == 0 ) && ( $initopic( %tmp.ruta , sucesor ) == 0 ) && ( $initopic( %tmp.ruta , registros ) == 0 )  && ( $initopic( %tmp.ruta , akicks ) == 0 ) { goto f.r }
    clear @info
    window -hls @info
    if ( $initopic( %tmp.ruta , fundador ) > 0 ) { loadbuf -tfundador @info $mircdirdatabase\nickserv\ $+ $r.c($d(5)) }
    if ( $initopic( %tmp.ruta , sucesor ) > 0 ) { loadbuf -tsucesor @info $mircdirdatabase\nickserv\ $+ $r.c($d(5)) }
    if ( $initopic( %tmp.ruta , registros ) > 0 ) { loadbuf -tregistros @info $mircdirdatabase\nickserv\ $+ $r.c($d(5)) }
    if ( $initopic( %tmp.ruta , akicks ) > 0 ) { loadbuf -takicks @info $mircdirdatabase\nickserv\ $+ $r.c($d(5)) }
    %tmp.total = $line(@info,0)
    %tmp.linea = 0
    while ( %tmp.linea < %tmp.total ) {
      inc %tmp.linea
      %tmp.l.linea = $line( @info , %tmp.linea )
      if ( $gettok(%tmp.l.linea,2,61) == -1 ) { %tmp.tipo = -1 (Akick) }
      else { %tmp.tipo = $gettok(%tmp.l.linea,2,61) }
      m $r.c($gettok(%tmp.l.linea,1,61)) $+ 12 %tmp.tipo
      if ( $gettok(%tmp.l.linea,2,61) == Fundador ) { inc %tmp.cfundador }
      if ( $gettok(%tmp.l.linea,2,61) == Sucesor ) { inc %tmp.csucesor }
      if ( $gettok(%tmp.l.linea,2,61) isnum ) { inc %tmp.cregistro }
      if ( $gettok(%tmp.l.linea,2,61) == Akick ) || ( $gettok(%tmp.l.linea,2,61) == -1 ) { inc %tmp.cakicks }
    }
    :f.r
    m Total de Fundador:12 %tmp.cfundador
    m Total de Sucesor:12 %tmp.csucesor
    m Total de Registros:12 %tmp.cregistro
    m Total de Akicks:12 %tmp.cakicks
  }
  if ( $s.n($o) >= 5 ) {
    if ( $d(5) == $o ) || ( $d(6) == ALL ) {
      if ( $l.db(nickserv\ $+ $r.c($d(5)),marcas,total) != $null ) {
        %tmp.marcas = $l.db(nickserv\ $+ $r.c($d(5)),marcas,total)
        %tmp.marca = 0
        m
        m Marcas de12 $d(5) $+ :
        while ( %tmp.marca < %tmp.marcas ) {
          inc %tmp.marca
          %tmp.marcat = $l.db(nickserv\ $+ $r.c($d(5)),marcas,%tmp.marca)
          %tmp.marcaf = $gettok(%tmp.marcat,1,32)
          %tmp.marcan = $gettok(%tmp.marcat,2,32)
          %tmp.marcad = $gettok(%tmp.marcat,3-,32)
          m %tmp.marca $chr(91) $+ $f(%tmp.marcaf) $+ $chr(93) - (12 $+ $r.c(%tmp.marcan) $+ ) -> $p.c(%tmp.marcad)
        }
        m Fin de la lista 3( $+ %tmp.marcas marcas)
      }
    }
  }
  :f.i
  m Fin de INFO
  if ( $s.n($o) >= 5 ) && ( $s.n($d(5)) >= 5 ) && ( $d(6) == ALL ) && ( $o != $d(5) ) { s : $+ $nickserv NOTICE $d(5) :12 $+ $o te ha hecho un INFO. }
  l.v
}

alias msg.n.n.r {
  var %a 1
  while ($read(txt\noregs.txt,%a)) {
    var %m = $read(txt\noregs.txt,%a)
    if (<nick> isin %m) { %m = $replace(%m,<nick>,$1) }
    if (<bot> isin %m) { %m = $replace(%m,<bot>,$gettok(%conf.nickserv,1,32)) }
    if (<canal> isin %m) { %m = $replace(%m,<canal>,%conf.canal.ayuda) }
    s : $+ $nickserv %conf.metodo $1 : $+ %m
    inc %a 1
  }
}

alias nickserv.migrar {
  if ($n.r($o) == si) {
    set %dbq.migrar- [ $+ [ $o ] ] ok
    s : $+ $nickserv DBQ N:: $+ $o
  }
  else {
    m 4ERROR: EL nick12 $o no está registrado.
  }
  l.v
}

alias nickserv.migra {
  a.t N:: $+ $1 $+ ::P $md5($l.db(nickserv\ $+ $r.c($1),configuracion,password))
  if ($l.db(nickserv\ $+ $r.c($1),configuracion,vhostsf)) {
    a.t N:: $+ $1 $+ ::V $l.db(nickserv\ $+ $r.c($1),configuracion,vhostsf)
  }
  if ($l.db(nickserv\ $+ $r.c($1),estado,$r.c($1)) == SUSPENDIDO) {
    a.t N:: $+ $1 $+ ::S $l.db(nickserv\ $+ $r.c($1),estado,suspend.motivo)
  }
  if ($l.db(nickserv\ $+ $r.c($1),configuracion,swhois)) {
    a.t N:: $+ $1 $+ ::W $l.db(nickserv\ $+ $r.c($1),configuracion,swhois)
  }
  if ($l.db(nickserv\ $+ $r.c($1),representante,tipo) == pre-operador) {
    a.t N:: $+ $1 $+ ::V $lower($1) $+ .pre-oper. $+ $lower(%conf.red)
  }
  if ($l.db(nickserv\ $+ $r.c($1),representante,tipo) == operador) {
    a.t N:: $+ $1 $+ ::O *1
    a.t N:: $+ $1 $+ ::V $lower($1) $+ .oper. $+ $lower(%conf.red)
  }
  if ($l.db(nickserv\ $+ $r.c($1),representante,tipo) == co-administrador) {
    a.t N:: $+ $1 $+ ::O *3
    a.t N:: $+ $1 $+ ::V $lower($1) $+ .co-admin. $+ $lower(%conf.red)
  }
  if ($l.db(nickserv\ $+ $r.c($1),representante,tipo) == administrador) {
    a.t N:: $+ $1 $+ ::O *3
    a.t N:: $+ $1 $+ ::V $lower($1) $+ .admin. $+ $lower(%conf.red)
  }
  if ($l.db(representantes.db,roots,$r.c($1))) {
    a.t N:: $+ $1 $+ ::O *7
    a.t N:: $+ $1 $+ ::V $lower($1) $+ .root. $+ $lower(%conf.red)
  }
  s : $+ $nickserv %conf.metodo $1 :Nick migrado a la BDD.
  r.n $1
}

alias nicksetvhost {
  var %e
  var %te 0
  set %tmp.m.bot $nickserv
  set %tmp.m.origen $1
  if ( $len($2) > 40 ) { m La ip virtual no puede superar los 40 caracteres. | l.v }
  if (( oper isin $2 ) || ( coadmin isin $2 ) || ( admin isin $2 ) || ( $l.conf(otras,nombrered) isin $2 )) { m La ip virtual no puede contener la palabra 12preoper, 12oper, 12coadmin, 12admin ó12 $l.conf(otras,nombrered) $+ . | l.v }
  var %a 1
  while ($mid($2,%a,1)) {
    if ($mid($2,%a,1) !isin abcdefghijklmnñopqrstuvwxyz) && ($mid($2,%a,1) !isin ABCDEFGHIJKLMNÑOPQRSTUVWXYZ) && ($mid($2,%a,1) !isin 01234567899) && ($mid($2,%a,1) != -) && ($mid($2,%a,1) != .) && ($mid($2,%a,1) != ) && ($mid($2,%a,1) != ) && ($mid($2,%a,1) != )  && ($mid($2,%a,1) != ) {
      %e = %e $mid($2,%a,1)
      inc %te 1
      ;m 4ERROR:12 $mid($2,%a,1)
    }
    inc %a 1
  }
  if (%e) {
    m Se encontraron12 %te errores en el vhost solicitado.
    m Los siguientes caracteres 4no pueden ser utilizados:12 %e
  }
  else {
    a.t N:: $+ $1 $+ ::V $2
    g.db nickserv\ $+ $r.c($1) configuracion vhostsf $2
    %tmp.ervhost = $calc($ctime +86400)
    g.db nickserv\ $+ $r.c($1) configuracion ervhost %tmp.ervhost
    m Ip virtual cambiada a $2
    if ( $s.n($1) < 5 ) {
      m No podrá realizar otro cambio de ip virtual hasta las12 $f(%tmp.ervhost)
    }
  }
}

alias nickserv.blackmail {
  if ($d(5) == add) {
    if ($d(6)) {
      if (@ isin $d(6)) {
        m En blackmail solo se guarda el dominio de los correos.
        m Intentalo otra vez sin poner12 $gettok($d(6),1,64) $+ @
      }
      else {
        if (. !isin $d(6)) {
          m 4ERROR: Los dominios son de tipo loquese.algo
          m Intentalo otra vez añadiendo la terminación a2 $d(6)
        }
        else {
          if ($read(database\blackmail.db,w,*=  $+ $d(6) $+ *)) {
            m 4ERROR: El dominio12 $d(6) ya está en la lista.
          }
          else {
            if ($readini(database\blackmail.db,libres,libres)) {
              var %a = $readini(database\blackmail.db,libres,libres)
              var %b = $gettok(%a,1,32)
              $iif($gettok(%a,2-,32),writeini database\blackmail.db libres libres $gettok(%a,2-,32),remini database\blackmail.db libres libres)
              writeini database\blackmail.db blackmail %b $d(6) $o $ctime
              m Añadido el dominio12 $d(6) a la lista negra.
              debugc $nickserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o añade el dominio12 $d(6) a la lista negra.
            }
            else {
              writeini database\blackmail.db blackmail $calc($ini(database\blackmail.db,blackmail,0) + 1) $d(6) $o $ctime
              m Añadido el dominio12 $d(6) a la lista negra.
              debugc $nickserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o añade el dominio12 $d(6) a la lista negra.
            }
          }
        }
      }
    }
    else {
      m Error de Sintaxis: 12BLACKMAIL ADD dominio
    }
  }
  elseif ($d(5) == del) {
    if ($d(6)) && ($d(6) isnum) && (. !isin $d(6)) {
      if ($gettok($read(database\blackmail.db,w,$d(6) $+ =*),2,61)) {
        var %a $read(database\blackmail.db,w,$d(6) $+ =*)
        write -l $+ $readn database\blackmail.db $d(6) $+ =
        var %b $d(6) $l.db(blackmail.db,libres,libres)
        if ($ini(database\blackmail.db,blackmail,0) == $numtok(%b,32)) {
          write -c database\blackmail.db
        }
        else {
          g.db blackmail.db libres libres $sorttok(%b,32,n)
        }
        m Borrado el dominio12 $gettok($gettok(%a,1,32),2,61) en la posición12 $d(6) de la lista negra.
        debugc $nickserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o borra el dominio12 $gettok($gettok(%a,1,32),2,61) en la posición12 $d(6) de la lista negra.
      }
      else {
        m 4ERROR: No hay un dominio en la posición12 $d(6) $+ .
      }
    }
    elseif ($d(6) == all) {
      if ($read(database\blackmail.db,1)) {
        m Borrando $ini(database\blackmail.db,blackmail,0) dominios de la BDD.
        debugc $nickserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o borra todos los dominios (12 $+ $ini(database\blackmail.db,blackmail,0) $+ ) de la lista negra.
        write -c database\blackmail.db
      }
      else {
        m 4ERROR: La lista está vacia.
      }
    }
    else {
      m Error de Sintaxis: 12BLACKMAIL DEL numero/all
    }
  }
  elseif ($d(5) == list) {
    if ($ini(database\blackmail.db,blackmail,1)) {
      m Lista de dominion añadidos en blackmail:
      m
      var %a 1
      while ($ini(database\blackmail.db,blackmail,%a)) {
        var %b = $readini(database\blackmail.db,blackmail,%a)
        if (%b) {
          m  $+ %a $+ -12 $gettok(%b,1,32) añadido por12 $gettok(%b,2,32) el12 $date($gettok(%b,3,32)) a las12 $time($gettok(%b,3,32))
        }
        inc %a 1
      }
      m
      m Finde la lista. Para borrar un dominio escriba:
      m 12/msg $nickserv BLACKMAIL DEL num
    }
    else {
      m Lista vacia.
    }
  }
  else {
    m Error de Sintaxis: 12BLACKMAIL <opcion> <parametro>
    m 12/msg $nickserv AYUDA BLACKMAIL para más información.
  }
  l.v
}

alias nickserv.validar {
  if (%validarcorreo. [ $+ [ $o ] ]) {
    if ($d(5) == $gettok(%validarcorreo. [ $+ [ $o ] ],1,32)) {
      m Correo validado correctamente, procediendo al registro del nick...
      nickserv.registra2 $o $gettok(%validarcorreo. [ $+ [ $o ] ],2,32)
    }
    else {
      m 4ERROR: El número introducído no es valido, o ya ha expirado... se creará otro.
      var %c = $gettok(%validarcorreo. [ $+ [ $o ] ],2,32)
      set %validarcorreo. [ $+ [ $o ] ] $r(111111,999999) %c
      rnum $o %validarcorreo. [ $+ [ $o ] ]
    }
  }
  else {
    if ($n.r($o) == si) {
      m 4ERROR: Tu nick ya está registrado, no tienes que validar nada.
    }
    else {
      m 4ERROR: Antes de ejecutar el comando12 VALIDAR
      m has de ejecutar el comando12 REGISTRA.
      m Para más información escribe:
      m 12/msg $nickserv HELP VALIDAR
    }
  }
  l.v
}
set %validarcorreo. [ $+ [ $o ] ] $r(111111,999999) $d(5)

alias nickserv.vreg {
  if ($d(5) == on) {
    if ($l.conf(nickserv,vcorreo)) {
      m 4ERROR: La validación de correo ya está activada.
    }
    else {
      writeini dbots.conf nickserv vcorreo 1
      m Activada la validación de registros de usuarios.
      debugc $nickserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o activa la validación de registro de usuarios.
    }
  }
  elseif ($d(5) == off) {
    if ($l.conf(nickserv,vcorreo)) {
      writeini dbots.conf nickserv vcorreo 0
      m Desactivada la validación de registros de usuarios.
      debugc $nickserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o desactiva la validación de registro de usuarios.
    }
    else {
      m 4ERROR: La validación de correo no está activada.
    }
  }
  else {
    m Error de Sintaxis:12 VREG ON / OFF
  }
  l.v
}
