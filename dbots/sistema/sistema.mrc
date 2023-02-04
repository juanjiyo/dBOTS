on 1:start:{
  .disable #todook.connect
  if ($version < $l.conf(otras,mirc)) {
    var %a dBoTs3 necesita mIRC $l.conf(otras,mirc) para funcionar correctamente.
    var %b Tu estas usando mIRC $version y puede haber problemas.
    var %c Pulsa "Yes" para continuar con mIRC $version
    var %d Pulsa "No" para salir y bajarte el mIRC %mircvr
    var %i $input(%a $+ $crlf $+ $crlf $+ %b $+ $crlf $+ $crlf $+ %c $+ $crlf $+ $crlf $+ %d,dyw,mIRC incorrecto.)
    if (%i == $true) {
      var %a $input(Has decidido usar dBoTs3 con mIRC $version $+ $chr(44) cualquier bug o error por usar esta versión no sera atendido por mi. $+ $crlf $+ $crlf $+ Atentamene: Mew.,ox,Usas dBoTs3 con mIRC $version bajo tu responsabilidad.)
      goto inicio
    }
    else { url -n http://www.dbots.es/mirc.exe | exit }
    halt
  }
  if ($sslready == $false) {
    var %a dBoTs3 necesita las librerias SSL para enviar correos.
    var %b No se han detectado dichas librerias instaladas en tu pc.
    var %c Pulsa "Yes" para continuar con mIRC sin soporte para SSL.
    var %d Pulsa "No" para salir y bajarte las librerias SSL necesarias
    var %i $input(%a $+ $crlf $+ $crlf $+ %b $+ $crlf $+ $crlf $+ %c $+ $crlf $+ $crlf $+ %d,dyw,mIRC sin SSL.)
    if (%i == $true) { var %a $input(Has decidido usar dBoTs3 sin SSL $+ $chr(44) así que no podrás enviár correos.,ox,Usando dBoTs3 sin SSL.) | goto inicio }
    else {  url -n http://www.dbots.es/ssl_mirc.zip | exit }
    halt

  }
  :inicio
  titlebar $version con dBoTs %v para $l.conf(otras,unreal)
  echo -s 12DBots4 v $+ %v
  echo -s 
  echo -s Autores:
  echo -s - Hasta la versión 2 12Davidlig
  echo -s - Desde la versión 3 12Mew
  echo -s 
  echo -s URL: 12http://www.dbots.es
  echo -s E-Mail: 12admin@dbots.es
  echo -s 
  echo -s 4Prohibido modificar el código de los bots y sus créditos.
  echo -s 
  echo -s Haz doble clic para: 12Configurar15_12dBoTs ¦ 12Conectarlos ¦ 12Actualizarlos ¦ 12Noticias ¦12 Ayuda15_12OnLine
  unset %away.*
  .timer 1 1 checkfiles
}

alias centerserv { return $gettok(%conf.centerserv,1,32) }
alias operserv { return $gettok(%conf.operserv,1,32) }
alias nickserv { return $gettok(%conf.nickserv,1,32) }
alias globalserv { return $gettok(%conf.globalserv,1,32) }
alias proxyserv { return $gettok(%conf.proxyserv,1,32) }
alias helpserv { return $gettok(%conf.helpserv,1,32) }
alias chanserv { return $gettok(%conf.chanserv,1,32) }
alias noticiasserv { return $gettok(%conf.noticiasserv,1,32) }
alias shadowserv { return $gettok(%conf.shadowserv,1,32) }
alias memoserv { return $gettok(%conf.memoserv,1,32) }
alias cregserv { return $gettok(%conf.cregserv,1,32) }
alias debugserv { return $gettok(%conf.debugserv,1,32) }

alias s {
  echo -s < $1-
  sockwrite -nt dbots $1-
  .signal modulos $iif(:* iswm $1-,$right($1-,-1),$1-)
  if ($2 != ping) && ($1 != ping) && ($2 != PONG) && ($2 != INFO) {
    echo @debug ( $+ $date - $time $+ ) => $1-
  }
}

alias j {
  s : $+ $1 JOIN $2
  if ($ca.r($2) == si) {
    var %a = $iif($l.db(canales.db,canales.b,$r.c($2)),$l.db(canales.db,canales.b,$r.c($2)),0)
    g.db canales.db canales.b $r.c($2) $calc(%a + 1)
    if ($l.db(chanserv\ $+ $r.c($2),configuracion,autolimit)) { chanserv.auto-limit $2 }
  }
}

alias p {
  s : $+ $1 PART $2 $iif($3,: $+ $3-)
  if ($ca.r($2) == si) {
    var %a = $calc($iif($l.db(canales.db,canales.b,$r.c($2)),$l.db(canales.db,canales.b,$r.c($2)),0) - 1)
    if (%a >= 2) {
      g.db canales.db canales.b $r.c($2) %a
      if ($l.db(chanserv\ $+ $r.c($2),configuracion,autolimit)) { chanserv.auto-limit $2 }
    }
    else {
      b.db canales.db canales.b $r.c($2)
      if ($l.db(chanserv\ $+ $r.c($2),configuracion,autolimit)) { chanserv.auto-limit $2 }
    }
  }
}

alias k {
  s KILL $2 : $+ $3-
  s.u $2 Killed ( $+ $3- $+ )
}

alias k.c {
  s : $+ $chanserv KICK $1 $2 : $+ $3-
  u.s.c $2 $1
}

alias g {
  %tmp.glinet = $iif($5 >= 1,$calc($ctime + $5),0)
  if ( $1 == 1 ) { s : $+ %conf.servidor TKL + G $2 $3 $4 %tmp.glinet $ctime : $+ $6- }
  g.db gline.db gline $2 $+ $chr(64) $+ $3 $r.c($gettok($4,1,33)) %tmp.glinet $ctime $q.c($6-)
}

alias e.c { return $l.db(chanserv\ $+ $r.c($1),estado,$r.c($1)) }
alias e.n { return $l.db(nickserv\ $+ $r.c($1),configuracion,estado,) }

alias u.c {
  if ( $l.db(canales.db,$r.c($1),$r.c($2)) != $null ) { return si }
  else { return no }
}

alias ex.c {
  if ( $l.db(canales.db,canales.u,$r.c($1)) != $null ) { return si }
  else { return no }
}

alias t {
  var %a = 1
  var %b = $1
  var %años = 0
  var %meses = 0
  var %semanas = 0
  var %dias = 0
  var %horas = 0
  var %minutos = 0
  var %segundos = 0
  while ($calc(%b - 31536000) >= 0) {
    dec %b 31536000
    inc %años 1
  }
  var %a = 1
  while ($calc(%b - 2678400) >= 0) {
    inc %meses 1
    dec %b 2678400
  }
  var %a = 1
  while ($calc(%b - 604800) >= 0) {
    inc %semanas 1
    dec %b 604800
  }
  var %a = 1
  while ($calc(%b - 86400) >= 0) {
    inc %dias 1
    dec %b 86400
  }
  var %a = 1
  while ($calc(%b - 3600) >= 0) {
    inc %horas 1
    dec %b 3600
  }
  var %a = 1
  while ($calc(%b - 60) >= 0) {
    inc %minutos 1
    dec %b 60
  }
  inc %segundos %b
  return $iif(%años, $+ %años $iif(%años > 1,años,año)) $iif(%meses, $+ %meses $iif(%meses > 1,meses,mes)) $iif(%semanas, $+ %semanas $iif(%semanas > 1,semanas,semana)) $iif(%dias, $+ %dias $iif(%dias > 1,días,día)) $iif(%horas, $+ %horas $iif(%horas > 1,horas,hora)) $iif(%minutos, $+ %minutos $iif(%minutos > 1,minutos,minuto)) $iif(%segundos, $+ %segundos $iif(%segundos > 1,segundos,segundo))
}

alias a.t {
  if ($read(database\bdd.db,1)) {
    write database\bdd.db $1-
  }
  else {
    write database\bdd.db $1-
    .timertocabdd 1 2 toca.bdd
  }
}

alias toca.bdd {
  if ($read(database\bdd.db,1)) {
    set %ultimo-a.t $read(database\bdd.db,1)
    write -dl1 database\bdd.db
    var %a = $l.db(tablas.db,tablas,$left(%ultimo-a.t,1))
    %tmp.nserie = $iif(%a,%a,0)
    %tmp.rdatos = %ultimo-a.t
    .timer 1 1 s DB * $iif($gettok(%ultimo-a.t,2,32),INS,DEL) %tmp.nserie %tmp.rdatos
    g.db tablas.db tablas $left(%ultimo-a.t,1) $calc(($len(%ultimo-a.t) -2) + %a)
  }
}

alias p.m { %tmp.m.bot = $1 | %tmp.m.origen = $o }

alias m {
  if ( $1 == $null ) { s : $+ %tmp.m.bot %conf.metodo %tmp.m.origen : }
  else { s : $+ %tmp.m.bot %conf.metodo %tmp.m.origen : $+ $1- }
}

alias c.b {
  s NICK $1 1 $ctime $2 $3 %conf.servidor 0 : $+ $5-
  s : $+ $1 MODE $1 : $+ $4
  s SQLINE $1 : $+ $5-
  g.db bots.db bots $r.c($1) $5-
}

alias l.conf {
  if ( $readini -n dbots.conf $1 $2 == $null ) { v.bots 4Error: Falta12 $2 en la sección12 $1 de dbots.conf. Puede que los bots no funcionen correctamente. }
  else { return $readini -n dbots.conf $1 $2 }
}
alias b.conf { return remini dbots.conf $1- }
alias g.conf { return writeini dbots.conf $1 $2- }

alias l.db { return $readini -n $mircdirdatabase\ $+ $1 $2 $3 }

alias g.db {
  if ($4 || $4 == $chr(48)) { writeini -n $mircdirdatabase\ $+ $1 $2 $3 $4- }
}

alias b.db {
  remini -n $mircdirdatabase\ $+ $1 $2-
}

alias r.dbs {
  b.db bots.db bots
  b.db servidores.db servidores
  b.db servidores.db servidor
  b.db status.db status
  b.db usuarios.db usuarios
  b.db ips.db gline
  b.db correos.db pendientes
  b.db nicks.db registrados
  b.db nicks.db espera
  b.db nicks.db noexpirec
  b.db nicks.db intentos
  b.db nicks.db esperam
  b.db gline.db gline
  b.db proxy.db dbl
  b.db representantes.db conectados
  b.db expiracion.db nicks
  b.db expiracion.db creg
  b.db expiracion.db canales
  .remove $mircdirdatabase\canales.db
  g.db canales.db dbots version %v
  b.db canales.db dbots
  .remove $mircdirdatabase\clones.db
  g.db clones.db dbots version %v
  b.db clones.db dbots
  %tmp.n.r = $findfile($mircdirdatabase\nickserv\,*,0)
  %tmp.n = 0
  while ( %tmp.n < %tmp.n.r ) {
    inc %tmp.n
    %tmp.n.a = nickserv\ $+ $nopath($findfile($mircdirdatabase\nickserv\,*,%tmp.n))
    b.db %tmp.n.a ifundador
    b.db %tmp.n.a cfundador
  }
  unset %tmp.*
}

alias d {
  return $iif(:* iswm $gettok(%datos,$1,32),$right($gettok(%datos,$1,32),-1),$gettok(%datos,$1,32))
}

asd {
  if ( $1 == 1 ) { return $gettok(%datos,1,32) } 
  if ( $1 == 2 ) { return $gettok(%datos,2,32) }
  if ( $1 == 3 ) { return $gettok(%datos,3,32) }
  if ( $1 == 4 ) { return $mid($gettok(%datos,4,32),2) }
  if ( $1 == 5 ) { return $gettok(%datos,5,32) }
  if ( $1 == 6 ) { return $gettok(%datos,6,32) }
  if ( $1 == 7 ) { return $gettok(%datos,7,32) }
  if ( $1 == 8 ) { return $gettok(%datos,8,32) }
  if ( $1 == 9 ) { return $gettok(%datos,9,32) }
  if ( $1 == 10 ) { return $gettok(%datos,10,32) }
  if ( $1 == 11 ) { return $gettok(%datos,11,32) }
  if ( $1 == 5- ) { return $gettok(%datos,5-,32) }
  if ( $1 == 6- ) { return $gettok(%datos,6-,32) }
  if ( $1 == 7- ) { return $gettok(%datos,7-,32) }
  if ( $1 == 8- ) { return $gettok(%datos,8-,32) }
  if ( $1 == 9- ) { return $gettok(%datos,9-,32) }
  if ( $1 == 10- ) { return $gettok(%datos,10-,32) }
  if ( $1 == 11- ) { return $gettok(%datos,11-,32) }
}

alias r.e {
  if ( <d3> isin $1- ) { %mail.r.e = $replace($1- ,<d3>,$gettok(%mail.datos,3,32)) }
  else { %mail.r.e = $1- }
  if ( <d4> isin $1- ) { %mail.r.e = $replace(%mail.r.e ,<d4>,$gettok(%mail.datos,4,32)) }
  if ( <d5> isin $1- ) { %mail.r.e = $replace(%mail.r.e ,<d5>,$gettok(%mail.datos,5,32)) }
  if ( <d6> isin $1- ) { %mail.r.e = $replace(%mail.r.e ,<d6>,$gettok(%mail.datos,6,32)) }
  if ( <d7> isin $1- ) { %mail.r.e = $replace(%mail.r.e ,<d7>,$gettok(%mail.datos,7,32)) }
  if ( <d8> isin $1- ) { %mail.r.e = $replace(%mail.r.e ,<d8>,$gettok(%mail.datos,8,32)) }
  if ( <d9> isin $1- ) { %mail.r.e = $replace(%mail.r.e ,<d9>,$gettok(%mail.datos,9,32)) }
  if ( <d10> isin $1- ) { %mail.r.e = $replace(%mail.r.e ,<d10>,$gettok(%mail.datos,10,32)) }
  if ( <d4-> isin $1- ) { %mail.r.e = $replace(%mail.r.e ,<d4->,$gettok(%mail.datos,4-,32)) }
  if ( <d5-> isin $1- ) { %mail.r.e = $replace(%mail.r.e ,<d5->,$gettok(%mail.datos,5-,32)) }
  if ( <d6-> isin $1- ) { %mail.r.e = $replace(%mail.r.e ,<d6->,$gettok(%mail.datos,6-,32)) }
  if ( <d7-> isin $1- ) { %mail.r.e = $replace(%mail.r.e ,<d7->,$gettok(%mail.datos,7-,32)) }
  if ( <d8-> isin $1- ) { %mail.r.e = $replace(%mail.r.e ,<d8->,$gettok(%mail.datos,8-,32)) }
  if ( <d9-> isin $1- ) { %mail.r.e = $replace(%mail.r.e ,<d9->,$gettok(%mail.datos,9-,32)) }
  if ( <d10-> isin $1- ) { %mail.r.e = $replace(%mail.r.e ,<d10->,$gettok(%mail.datos,10-,32)) }
  if ( <n.red> isin $1- ) { %mail.r.e = $replace(%mail.r.e ,<n.red>,%conf.red) }
  if ( <c.ayuda> isin $1- ) { %mail.r.e = $replace(%mail.r.e ,<c.ayuda>,%conf.canal.ayuda) }
  if (<fecha.caduca> isin $1-) {
    if ($gettok(%mail.datos,1,32) == caduco.txt) {
      %mail.r.e = $replace(%mail.r.e ,<fecha.caduca>,$date($gettok(%mail.datos,-1,32)))
    }
    else {
      %mail.r.e = $replace(%mail.r.e ,<fecha.caduca>,$date($calc($ctime + 518400)))
    }
  }
  if ( <t> isin $1- ) { %mail.r.e = $replace(%mail.r.e ,<t>,$chr(9)) }
  return %mail.r.e
}

alias e.u.c {
  if ( $ex.c($2) == no ) {
    chanserv.create $2
    %tmp.u.c = 0
  }
  else { %tmp.u.c = $l.db(canales.db,canales.u,$r.c($2)) }
  inc %tmp.u.c
  g.db canales.db canales.u $r.c($2) %tmp.u.c
  g.db canales.db $r.c($1) $r.c($2) *
}

alias e.u.c.nr {
  if (!$l.db(bots.db,obots,$r.c($2))) {
    var %u
    if ($l.db(canales.db,canales.t.u,$r.c($1))) {
      %u = $calc($l.db(canales.db,canales.t.u,$r.c($1)) + 1)
    }
    else {
      %u = 1
    }
    g.db canales.db canales.t.u $r.c($1) %u
  }
}

alias u.s.c.nr {
  var %u = $l.db(canales.db,canales.t.u,$r.c($1))
  dec %u 1
  if (%u) {
    g.db canales.db canales.t.u $r.c($1) %u
  }
  else {
    b.db canales.db canales.t.u $r.c($1)
  }
}

alias u.s.c {
  b.db canales.db $r.c($1) $r.c($2)
  %tmp.u.c = $l.db(canales.db,canales.u,$r.c($2))
  dec %tmp.u.c
  if ( %tmp.u.c <= 0 ) {
    b.db canales.db canales.u $r.c($2)
    b.db canales.db modos.c $r.c($2)
    b.db canales.db password.c $r.c($2)
  }
  else { g.db canales.db canales.u $r.c($2) %tmp.u.c }
  if ( $ca.r($2) == si ) && ( $e.c($2) != SUSPENDIDO ) {
    if ( $n.i($1) == si ) {
      if ( $l.db(chanserv\ $+ $r.c($2),niveles,autoop) == DIS ) { %tmp.n.autoop = 500 }
      else { %tmp.n.autoop = $l.db(chanserv\ $+ $r.c($2),niveles,autoop) }
      if ( $l.db(chanserv\ $+ $r.c($2),registros,$r.c($1)) != $null ) { %tmp.registro = $l.db(chanserv\ $+ $r.c($2),registros,$r.c($1)) }
      else { %tmp.registro = 0 }
      if ( $l.db(chanserv\ $+ $r.c($2),configuracion,fundador) == $r.c($1) ) { %tmp.registro = 500 }
      if ( %tmp.registro >= %tmp.n.autoop ) { chanserv.a.c $2 }
    }
    if ($l.db(chanserv\ $+ $r.c($2),configuracion,autolimit)) { chanserv.auto-limit $2 }
  }
}

alias u.s.tc {
  flushini $mircdirdatabase\canales.db
  %tmp.ruta = $mircdirdatabase\canales.db
  if ( $initopic( %tmp.ruta , $r.c($1) ) == 0 ) { goto f.s }
  clear @scanales
  window -hl @scanales
  loadbuf -t $+ $r.c($1) @scanales $mircdirdatabase\canales.db
  %tmp.total = $line(@scanales,0)
  %tmp.linea = 0
  while ( %tmp.linea < %tmp.total ) {
    inc %tmp.linea
    %tmp.l.linea = $line( @scanales , %tmp.linea )
    %tmp.scanal = $gettok(%tmp.l.linea,1,61)
    u.s.c $1 %tmp.scanal
  }
  :f.s
}

alias gline.c.p {
  flushini $mircdirdatabase\clones.db
  %tmp.ruta = $mircdirdatabase\clones.db
  if ( $initopic( %tmp.ruta , $1 ) == 0 ) { goto f.g.c.p }
  clear @clonesr
  window -hl @clonesr
  loadbuf -t $+ $1 @clonesr $mircdirdatabase\clones.db
  %tmp.total = $line( @clonesr,0)
  %tmp.linea = 0
  while ( %tmp.linea < %tmp.total ) {
    inc %tmp.linea
    %tmp.l.linea = $line(  @clonesr , %tmp.linea )
    %tmp.nick = $r.c($gettok(%tmp.l.linea,1,61))
    %tmp.tipo = $gettok(%tmp.l.linea,2,61)
    if ( %tmp.tipo === r ) { return si }
  }
  :f.g.c.p
  return no
}

alias r.s {
  flushini $mircdirdatabase\ $+ $1
  %tmp.ruta = $mircdirdatabase\ $+ $1
  if ( $initopic( %tmp.ruta , $r.c($2) ) == 0 ) { goto f.s }
  clear @rseccion
  window -hl @rseccion
  loadbuf -t $+ $r.c($2) @rseccion $mircdirdatabase\ $+ $1
  %tmp.total = $line(@rseccion,0)
  %tmp.linea = 0
  while ( %tmp.linea < %tmp.total ) {
    inc %tmp.linea
    %tmp.l.linea = $line( @rseccion , %tmp.linea )
    %tmp.rsdatos = $gettok(%tmp.l.linea,1,61)
    %tmp.rsdatos2 = $gettok(%tmp.l.linea,2,61)
    g.db $1 $r.c($3) %tmp.rsdatos %tmp.rsdatos2
  }
  :f.s
  b.db $1 $r.c($2)
}

alias r.c {
  if ( $chr(34) isin $1 ) { %tmp.r.c = $replace($1 ,$chr(34),$chr(229)) }
  else { %tmp.r.c = $1 }
  if ( $chr(42) isin $1 ) { %tmp.r.c = $replace(%tmp.r.c ,$chr(42),$chr(230)) }
  if ( $chr(46) isin $1 ) { %tmp.r.c = $replace(%tmp.r.c ,$chr(46),$chr(216)) }
  if ( $chr(47) isin $1 ) { %tmp.r.c = $replace(%tmp.r.c ,$chr(47),$chr(131)) }
  if ( $chr(60) isin $1 ) { %tmp.r.c = $replace(%tmp.r.c ,$chr(60),$chr(248)) }
  if ( $chr(62) isin $1 ) { %tmp.r.c = $replace(%tmp.r.c ,$chr(62),$chr(198)) }
  if ( $chr(63) isin $1 ) { %tmp.r.c = $replace(%tmp.r.c ,$chr(63),$chr(222)) }
  if ( $chr(91) isin $1 ) { %tmp.r.c = $replace(%tmp.r.c ,$chr(91),$chr(165)) }
  if ( $chr(92) isin $1 ) { %tmp.r.c = $replace(%tmp.r.c ,$chr(92),$chr(188)) }
  if ( $chr(93) isin $1 ) { %tmp.r.c = $replace(%tmp.r.c ,$chr(93),$chr(177)) }
  if ( $chr(124) isin $1 ) { %tmp.r.c = $replace(%tmp.r.c ,$chr(124),$chr(189)) }
  if ( $chr(131) isin $1 ) { %tmp.r.c = $replace(%tmp.r.c ,$chr(131),$chr(47)) }  
  if ( $chr(165) isin $1 ) { %tmp.r.c = $replace(%tmp.r.c ,$chr(165),$chr(91)) }
  if ( $chr(177) isin $1 ) { %tmp.r.c = $replace(%tmp.r.c ,$chr(177),$chr(93)) }
  if ( $chr(188) isin $1 ) { %tmp.r.c = $replace(%tmp.r.c ,$chr(188),$chr(92)) }
  if ( $chr(189) isin $1 ) { %tmp.r.c = $replace(%tmp.r.c ,$chr(189),$chr(124)) }
  if ( $chr(198) isin $1 ) { %tmp.r.c = $replace(%tmp.r.c ,$chr(198),$chr(62)) }
  if ( $chr(216) isin $1 ) { %tmp.r.c = $replace(%tmp.r.c ,$chr(216),$chr(46)) }
  if ( $chr(222) isin $1 ) { %tmp.r.c = $replace(%tmp.r.c ,$chr(222),$chr(63)) }
  if ( $chr(229) isin $1 ) { %tmp.r.c = $replace(%tmp.r.c ,$chr(229),$chr(34)) }
  if ( $chr(230) isin $1 ) { %tmp.r.c = $replace(%tmp.r.c ,$chr(230),$chr(42)) }
  if ( $chr(248) isin $1 ) { %tmp.r.c = $replace(%tmp.r.c ,$chr(248),$chr(60)) }
  return %tmp.r.c
}

alias q.c {
  %tmp.q.c = $encode($1-,m)
  return %tmp.q.c
}

alias p.c {
  %tmp.p.c = $decode($1-,m)
  return %tmp.p.c
}

alias o { return $d(1) }
alias s.n { return $l.db(status.db,status,$r.c($1)) }
alias r.n {
  if ( $l.db(status.db,status,$r.c($1)) == $null ) { return }
  :o.r
  %tmp.rename = %conf.pinv $+ $rand(0,9) $+ $rand(0,9) $+ $rand(0,9) $+ $rand(0,9)
  if ( $l.db(status.db,status,%tmp.rename) != $null ) || ( $n.r(%tmp.rename) == si ) { goto o.r }
  s SVSNICK $1 %tmp.rename $ctime
  unset %tmp.rename
}

alias r.conf {
  %conf.ip = $l.conf(servidor,ip)
  %conf.puerto = $l.conf(servidor,puerto)
  %conf.servidor = $l.conf(servidor,servidor)
  %conf.desc = $l.conf(servidor,desc)
  %conf.clink = $l.conf(servidor,clink)
  %conf.canal.ayuda = $l.conf(canales,ayuda)
  %conf.canal.admins = $l.conf(canales,admins)
  %conf.canal.opers = $l.conf(canales,opers)
  %conf.smtp.estado = $l.conf(smtp,estado)
  %conf.red = $l.conf(otras,nombrered)
  %conf.root = $r.c($l.conf(otras,root))
  %conf.pinv = $l.conf(otras,pinvitado)
  %conf.metodo = $l.conf(otras,metodo)
  %conf.tbots = $l.conf(otras,tbots)
  :obot
  inc %tmp.bots
  %tmp.bot = $gettok(%conf.tbots,%tmp.bots,32)
  if ( %tmp.bot == $null ) { unset %tmp.* | goto finbots }
  set %conf. $+ %tmp.bot $l.conf(%tmp.bot,nick) $l.conf(%tmp.bot,ident) $l.conf(%tmp.bot,vhost) $l.conf(%tmp.bot,modos) $l.conf(%tmp.bot,realname)
  goto obot
  :finbots
}

alias l.v {
  unset %datos
  unset %tmp.*
  halt
}

alias v.bots {
  if ( $window(@Bots).state != normal ) { window -k @Bots }
  echo @Bots ( $+ $date - $time $+ ) => $1-
}

alias debug {
  if ( %debugv == si ) {
    if ( $gettok(%datos,1,32) == PING ) || ( $gettok(%datos,2,32) == PING ) || ( $gettok(%datos,2,32) == PONG ) || ( $gettok(%datos,2,32) == away) { return }
    elseif ($2 == 302) && ($3 == $operserv) && ($4 == :) { return }
    elseif ($l.db(servidores.db,servidores,$right($1,-1))) && ($2 == notice) && (ChgHost Error: requested host is same as current host isin $4-) { return }
    elseif ( $window(@Debug).state != normal ) { window -ke @Debug }
    echo @Debug ( $+ $date - $time $+ ) <= $1-
  }
}

alias debugc { s : $+ $1 PRIVMSG $2 : $+ $3- }

alias c.r {
  if ( $1 == PO ) { %tmp.nivel = 4 }
  if ( $1 == O ) { %tmp.nivel = 5 }
  if ( $1 == CA ) { %tmp.nivel = 6 }
  if ( $1 == A ) { %tmp.nivel = 7 }
  if ( $1 == R ) { %tmp.nivel = 8 }
  if ( $s.n($o) < %tmp.nivel ) {
    ;m 4Permiso denegado.
    l.v
  }
}

alias n.c {
  if ( $l.db(usuarios.db,usuarios,$r.c($1)) != $null ) { return si }
  else { return no }
}

alias n.r {
  if ( $exists($mircdirdatabase\nickserv\ $+ $r.c($1)) == $true ) { return si }
  else { return no }
}

alias ca.r {
  if ( $exists($mircdirdatabase\chanserv\ $+ $r.c($1)) == $true ) { return si }
  else { return no }
}

alias n {
  if ($readini(database\usuarios.db,usuarios,$1)) {
    if ($prop) {
      if ($prop == ip) { return $gettok($readini(database\usuarios.db,usuarios,$1),2,32) }
    }
    else { return si }
  }
}

alias n.i {
  if ( $s.n($1) >= 3 ) { return si }
  else { return no }
}

alias email {
  if ( $l.conf(smtp,estado) == off ) { 
    debugc $centerserv %conf.canal.admins No se ha podido enviar el e-mail a la dirección12 $2 el SMTP no está activo.
    debugc $centerserv %conf.canal.opers No se ha podido enviar el e-mail a la dirección12 $2 el SMTP no está activo.
    return
  }
  if ($sock(e.c).ip) { email.cola $1 $2 $r.c($3) $4- | return }
  if ($isfile(txt\ $+ $1) == $false) {
    debugc $centerserv %conf.canal.admins No se puede enviar un email, el archivo12 $1 no existe en la carpeta 12TXT.
    debugc $centerserv %conf.canal.admins Si tienes dudas conectate a12 villablino.hopto.org y habla con12 Mew.
    return
  }
  %mail.datos = $1 $2 $3 $4-
  if ( $exists($mircdirtxt\ $+ $gettok(%mail.datos,1,32)) == $false ) { unset %mail.* | return }
  sockopen $iif($l.conf(smtp,ssl),-e,-t) e.c $l.conf(smtp,smtp) $l.conf(smtp,port)
}

alias email.cola {
  if ( $l.db(correos.db,pendientes,total) == $null ) { g.db correos.db pendientes total 1 | %tmp.email.total.cola = 1 }
  else { %tmp.email.total.cola = $l.db(correos.db,pendientes,total) | inc %tmp.email.total.cola }
  g.db correos.db pendientes total %tmp.email.total.cola
  g.db correos.db pendientes %tmp.email.total.cola $1-
}

alias email.otro {
  %tmp.ordena.e = $l.db(correos.db,pendientes,total)
  if ( %tmp.ordena.e == 0 ) || ( %tmp.ordena.e == $null ) { unset %tmp.* | return }
  %tmp.envia.n = 1
  %tmp.envia = $l.db(correos.db,pendientes,%tmp.envia.n)
  b.db correos.db pendientes %tmp.envia.n
  :o.e
  inc %tmp.envia.n
  if ( $l.db(correos.db,pendientes,%tmp.envia.n) == $null ) { goto f.o.e }
  %tmp.ordena.e2 = $l.db(correos.db,pendientes,%tmp.envia.n)
  g.db correos.db pendientes $calc(%tmp.envia.n -1) %tmp.ordena.e2
  b.db correos.db pendientes %tmp.envia.n
  goto o.e
  :f.o.e
  dec %tmp.ordena.e
  g.db correos.db pendientes total %tmp.ordena.e
  email %tmp.envia
}

alias f {
  %tmp.tfecha = $asctime($1)
  %tmp.tfecha = $replace(%tmp.tfecha,Jan,Ene)
  %tmp.tfecha = $replace(%tmp.tfecha,Feb,Feb)
  %tmp.tfecha = $replace(%tmp.tfecha,Mar,Mar)
  %tmp.tfecha = $replace(%tmp.tfecha,Apr,Abril)
  %tmp.tfecha = $replace(%tmp.tfecha,May,May)
  %tmp.tfecha = $replace(%tmp.tfecha,Jun,Jun)
  %tmp.tfecha = $replace(%tmp.tfecha,Jul,Jul)
  %tmp.tfecha = $replace(%tmp.tfecha,Aug,Ago)
  %tmp.tfecha = $replace(%tmp.tfecha,Sep,Sep)
  %tmp.tfecha = $replace(%tmp.tfecha,Oct,Oct)
  %tmp.tfecha = $replace(%tmp.tfecha,Nov,Nov)
  %tmp.tfecha = $replace(%tmp.tfecha,Dec,Dic)
  %tmp.tfecha = $gettok(%tmp.tfecha,4,32) $gettok(%tmp.tfecha,3,32) $+ / $+ $gettok(%tmp.tfecha,2,32) $+ / $+ $gettok(%tmp.tfecha,5,32)
  return %tmp.tfecha
}

alias e { if ( $n.i($1) == si ) { return 3(Conectado) } }

alias r.klines {
  flushini $mircdirdatabase\kline.db
  %tmp.ruta = $mircdirdatabase\kline.db
  if ( $initopic( %tmp.ruta , kline ) == 0 ) { goto f.rk }
  clear @rkline
  window -hl @rkline
  loadbuf -tkline @rkline $mircdirdatabase\kline.db
  %tmp.total = $line(@rkline,0)
  %tmp.linea = 0
  while ( %tmp.linea < %tmp.total ) {
    inc %tmp.linea
    %tmp.l.linea = $line( @rkline , %tmp.linea )
    %tmp.ip = $gettok(%tmp.l.linea,1,61)
    %tmp.kdatos = $gettok(%tmp.l.linea,2,61)
    %tmp.korigen = $gettok(%tmp.kdatos,1,32)
    %tmp.mkline = $gettok(%tmp.kdatos,3,32)
    s : $+ %conf.servidor TKL + k * %tmp.ip $r.c(%tmp.korigen) 0 $ctime : $+ $p.c(%tmp.mkline)
  }
  :f.rk
}

alias e.gline {
  flushini $mircdirdatabase\gline.db
  %tmp.ruta = $mircdirdatabase\gline.db
  if ( $initopic( %tmp.ruta , gline ) == 0 ) { goto f.eg }
  clear @egline
  window -hl @egline
  loadbuf -tgline @egline $mircdirdatabase\gline.db
  %tmp.total = $line(@egline,0)
  %tmp.linea = 0
  while ( %tmp.linea < %tmp.total ) {
    inc %tmp.linea
    %tmp.l.linea = $line( @egline , %tmp.linea )
    %tmp.ip = $gettok(%tmp.l.linea,1,61)
    %tmp.egline = $gettok(%tmp.l.linea,2,32)
    if (%tmp.egline > $ctime($date(dd/mm/yyyy) 00:00)) && (%tmp.egline < $ctime($date(dd/mm/yyyy) 23:59:59)) { .timer [ $+ [ %tmp.ip ] ] $time(%tmp.egline,HH:nn) 1 $time(%tmp.egline,ss) debugc $operserv %conf.canal.admins $+ , $+ %conf.canal.opers Expirado el G-Line para12 %tmp.ip $+ . }
    if ( $ctime > %tmp.egline ) && (%tmp.egline >= 1) { b.db gline.db gline %tmp.ip }
  }
  :f.eg
}

alias creditos {
  if ($1 == version) {
    e.t $1 12DBots 4v $+ %v By 12Mew
    e.t $1 Para ver los créditos de los dBoTs usa12 /msg $helpserv creditos
    e.t $1
  }
  else {
    e.t $1 12DBots 4v $+ %v
    e.t $1
    e.t $1 Autores:
    e.t $1 - Hasta la versión 2 12Davidlig (David Abuin Fontán)
    e.t $1 - Desde la versión 3 12Mew (Tomás Castro Prada)
    e.t $1
    e.t $1 URL: 12http://www.dbots.es
    e.t $1 E-Mail: 12contacto@dbots.es
    e.t $1
    e.t $1 Si encuentras algún bug pásate por el servidor
    e.t $1 12irc.dbots.es o bien envía un un e-mail
    e.t $1 a la dirección de correo 12bugs@dbots.es
    e.t $1
    var %a = $iif($script(debug.mrc),1,0)
    var %b = $lines(sistema\modulos\modulos.txt)
    var %c $calc(%a + %b)
    e.t $1 Sistema de módulos creado por 12Mew $+ $iif(%c >= 1,$chr(44) módulos actualmente cargados:,$chr(44) no hay módulos cargados...)
    var %a 1
    if (%c >= 1) {
      e.t $1 
      if ($script(debug.mrc)) { e.t $1 12 $ginfo(debug,info,nick) }
      while ($read(sistema\modulos\modulos.txt,%a)) {
        e.t $1 12 $ginfo($gettok($read(sistema\modulos\modulos.txt,%a),1,32),info,nick)
        inc %a 1
      }
    }
    e.t $1
    e.t $1 Servidor de los Bots:3 %conf.servidor
    e.t $1 Servidores de los módulos:3 $l.conf(modulosserv,sname)
    e.t $1 Servidor de debug:3 $l.conf(debugserv,sname)
    e.t $1 Tiempo conectados:12 $t($calc($ctime - %i.bots))
    e.t $1 Actualizaciones automáticas: $+ $iif(%actualizar == si,3 Activadas,4 Desactivadas)
    e.t $1 Última actualización:12 $gettok(%ult.act,2-,32)
    e.t $1
    e.t $1 12Davidlig:
    e.t $1 Dedico este trabajo a 12Yasss
    e.t $1 por volver a dar sentido a mi vida. 4Te quiero :@
    e.t $1
    e.t $1 3David y Yasmina Forever [1-2-2004]
    e.t $1 (12 $+ $t($calc($ctime -1075672800)) $+ )
    e.t $1
    e.t $1 12Mew:
    e.t $1 Dedico este trabajo a 4toda la gente que está
    e.t $1 con nosotros en esta red, por que sin vosotros,
    e.t $1 esto no seria posible. Gracias por estar aqui :)
    e.t $1
    e.t $1 Agradecimientos:
    e.t $1  12Eric Por dejarme algunos bots que habia
    e.t $1  creado para ponerlos como módulos de los dbots.
    e.t $1
    e.t $1  12JcRs Por todas las sugerencias que me ha dado.
    e.t $1
    e.t $1  12chuk y 12FsDk Por las cuentas de SMTP rápidas,
    e.t $1  fiables, y para todos los usuarios de los dBoTs.
    l.v
  }
}

alias r.exp {
  a.n.c
  exp.nick
  nicks.reg
  exp.creg
  exp.chan
  unset %tmp2.*
}

alias a.n.c {
  flushini $mircdirdatabase\status.db
  %tmp2.ruta = $mircdirdatabase\status.db
  if ( $initopic( %tmp2.ruta , status ) == 0 ) { goto f.an }
  clear @astatus
  window -hl @astatus
  loadbuf -tstatus @astatus $mircdirdatabase\status.db
  %tmp2.total = $line(@astatus,0)
  %tmp2.linea = 0
  while ( %tmp2.linea < %tmp2.total ) {
    inc %tmp2.linea
    %tmp2.l.linea = $line( @astatus , %tmp2.linea )
    %tmp2.n = $gettok(%tmp2.l.linea,1,61)
    nickserv.a.n $r.c(%tmp2.n)
  }
  :f.an
}

alias exp.nick {
  %tmp2.nr = $findfile($mircdirdatabase\nickserv\,*,0)
  %tmp2.c = 0
  while ( %tmp2.c < %tmp2.nr ) {
    inc %tmp2.c
    %tmp2.n = $nopath($findfile($mircdirdatabase\nickserv\,*,%tmp2.c))
    %tmp2.uh = $l.db(nickserv\ $+ %tmp2.n,configuracion,ulthora)
    if ( $l.db(nickserv\ $+ %tmp2.n,configuracion,noexpire) == on ) { goto o.n }
    if ( $l.db(nickserv\ $+ %tmp2.n,configuracion,nocompleto) != $null ) {
      %tmp2.uhnc = $calc(86400 + %tmp2.uh)
      if ( %tmp2.uhnc <= $ctime ) { g.db expiracion.db nicks %tmp2.n * }
      goto o.n
    }
    if ( $l.db(nickserv\ $+ %tmp2.n,configuracion,noexpire) < $ctime ) { b.db nickserv\ $+ %tmp2.n configuracion noexpire }
    if ( $l.db(nickserv\ $+ %tmp2.n,configuracion,noexpirep) < $ctime ) { b.db nickserv\ $+ %tmp2.n configuracion noexpirep }
    if ( $l.db(nickserv\ $+ %tmp2.n,configuracion,noexpire) != $null ) { goto o.n }
    if ( $l.db(nickserv\ $+ %tmp2.n,representante,tipo) != $null ) { goto o.n }
    %tmp2.uh = $calc( ( 86400 * $l.conf(nickserv,caducanicks) ) + %tmp2.uh )
    if ( $calc( %tmp2.uh - 604800 ) < $ctime ) && ( $l.db(nickserv\ $+ %tmp2.n,configuracion,semaviso) == $null ) {
      debugc $nickserv %conf.canal.admins $+ , $+ %conf.canal.opers Al nick12 $r.c(%tmp2.n) le queda menos de una semana para caducar, enviandole e-mail de aviso a su correo12 $l.db(nickserv\ $+ %tmp2.n,configuracion,emailreg)
      g.db nickserv\ $+ %tmp2.n configuracion semaviso ok
      email nexpire.txt $l.db(nickserv\ $+ %tmp2.n,configuracion,emailreg) NiCK $r.c(%tmp2.n) $l.db(nickserv\ $+ %tmp2.n,configuracion,password) HeLP deep.space
    }
    if ( %tmp2.uh <= $ctime ) {
      g.db expiracion.db nicks %tmp2.n *
      .signal drop nick $r.c(%tmp2.n)
      debugc $nickserv %conf.canal.admins $+ , $+ %conf.canal.opers El nick12 $r.c(%tmp2.n) ha caducado, enviandole e-mail de aviso a su correo12 $l.db(nickserv\ $+ %tmp2.n,configuracion,emailreg)
      email caduco.txt $l.db(nickserv\ $+ %tmp2.n,configuracion,emailreg) NiCK $r.c(%tmp2.n) $l.db(nickserv\ $+ %tmp2.n,configuracion,password) HeLP deep.space %tmp2.uh
    }
    :o.n
  }
  flushini $mircdirdatabase\expiracion.db
  %tmp2.ruta = $mircdirdatabase\expiracion.db
  if ( $initopic( %tmp2.ruta , nicks ) == 0 ) { goto f.en }
  clear @expnicks
  window -hl @expnicks
  loadbuf -tnicks @expnicks $mircdirdatabase\expiracion.db
  %tmp2.total = $line(@expnicks,0)
  %tmp2.linea = 0
  while ( %tmp2.linea < %tmp2.total ) {
    inc %tmp2.linea
    %tmp2.l.linea = $line( @expnicks , %tmp2.linea )
    %tmp2.n = $gettok(%tmp2.l.linea,1,61)
    nickserv.dropn $r.c(%tmp2.n)
    if ( $len(%tmp2.ne) < 117 ) {
      if ( %tmp2.ne == $null ) { %tmp2.ne = $r.c(%tmp2.n) }
      else { %tmp2.ne = %tmp2.ne $+ ,12 $r.c(%tmp2.n) }
    }
  }
  if ( $len(%tmp2.ne) >= 117 ) { %tmp2.ne = %tmp2.ne $+ ... }
  debugc $nickserv %conf.canal.admins $+ , $+ %conf.canal.opers Nicks expirados ( $+ %tmp2.linea $+ ):12 %tmp2.ne
  b.db expiracion.db nicks
  :f.en
}

alias nicks.reg {
  flushini $mircdirdatabase\nicks.db
  %tmp2.ruta = $mircdirdatabase\nicks.db
  if ( $initopic( %tmp2.ruta , registrados ) == 0 ) { goto f.nnr }
  clear @nicksregs
  window -hl @nicksregs
  loadbuf -tregistrados @nicksregs $mircdirdatabase\nicks.db
  %tmp2.total = $line(@nicksregs,0)
  %tmp2.linea = 0
  while ( %tmp2.linea < %tmp2.total ) {
    inc %tmp2.linea
    %tmp2.l.linea = $line( @nicksregs , %tmp2.linea )
    %tmp2.n = $gettok(%tmp2.l.linea,1,61)
    if ( $len(%tmp2.nnr) < 117 ) {
      if ( %tmp2.nnr == $null ) { %tmp2.nnr = $r.c(%tmp2.n) }
      else { %tmp2.nnr = %tmp2.nnr $+ ,12 $r.c(%tmp2.n) }
    }
  }
  if ( $len(%tmp2.nnr) >= 117 ) { %tmp2.nnr = %tmp2.nnr $+ ... }
  debugc $nickserv %conf.canal.admins $+ , $+ %conf.canal.opers Nicks registrados ( $+ %tmp2.linea $+ ):12 %tmp2.nnr
  b.db nicks.db registrados
  :f.nnr
}

alias exp.creg {
  %tmp2.cc = $findfile($mircdirdatabase\cregserv\canales\,*,0)
  %tmp2.c = 0
  while ( %tmp2.c < %tmp2.cc ) {
    inc %tmp2.c
    %tmp2.ccc = $nopath($findfile($mircdirdatabase\cregserv\canales\,*,%tmp2.c))
    if ( $l.db(cregserv\canales\ $+ %tmp2.ccc,datos,estado) == ENREGISTRO ) {
      %tmp2.fpc = $l.db(cregserv\canales\ $+ %tmp2.ccc,datos,fecha)
      %tmp2.fpc = $calc(604800+ %tmp2.fpc)
      if ( %tmp2.fpc <= $ctime ) { g.db expiracion.db creg %tmp2.ccc * }
    }
  }
  flushini $mircdirdatabase\expiracion.db
  %tmp2.ruta = $mircdirdatabase\expiracion.db
  if ( $initopic( %tmp2.ruta , creg ) == 0 ) { goto f.ec }
  clear @expcreg
  window -hl @expcreg
  loadbuf -tcreg @expcreg $mircdirdatabase\expiracion.db
  %tmp2.total = $line(@expcreg,0)
  %tmp2.linea = 0
  while ( %tmp2.linea < %tmp2.total ) {
    inc %tmp2.linea
    %tmp2.l.linea = $line( @expcreg , %tmp2.linea )
    %tmp2.ccc = $gettok(%tmp2.l.linea,1,61)
    %tmp2.fundador = $l.db(cregserv\canales\ $+ %tmp2.ccc,datos,fundador)
    b.db nickserv\ $+ %tmp2.fundador configuracion enregistro
    .remove $mircdirdatabase\cregserv\canales\ $+ %tmp2.ccc
    debugc $cregserv %conf.canal.admins $+ , $+ %conf.canal.opers El registro del canal12 $r.c(%tmp2.ccc) ha sido cancelado por no conseguir los apoyos necesarios en 7 días.
  }
  b.db expiracion.db creg
  :f.ec
}

alias exp.chan {
  %tmp2.cr = $findfile($mircdirdatabase\chanserv\,*,0)
  %tmp2.c = 0
  while ( %tmp2.c < %tmp2.cr ) {
    inc %tmp2.c
    %tmp2.cc = $nopath($findfile($mircdirdatabase\chanserv\,*,%tmp2.c))
    %tmp2.uu = $l.db(chanserv\ $+ %tmp2.cc,configuracion,ultuso)
    %tmp2.uu = $calc((86400* $l.conf(chanserv,caducacanales))+ %tmp2.uu)
    if ( $l.db(chanserv\ $+ %tmp2.cc,configuracion,noexpire) == on ) { goto o.c }
    if ( %tmp2.uu <= $ctime ) { g.db expiracion.db canales %tmp2.cc * }
    :o.c
  }
  flushini $mircdirdatabase\expiracion.db
  %tmp2.ruta = $mircdirdatabase\expiracion.db
  if ( $initopic( %tmp2.ruta , canales ) == 0 ) { goto f.ecc }
  clear @expchan
  window -hl @expchan
  loadbuf -tcanales @expchan $mircdirdatabase\expiracion.db
  %tmp2.total = $line(@expchan,0)
  %tmp2.linea = 0
  while ( %tmp2.linea < %tmp2.total ) {
    inc %tmp2.linea
    %tmp2.l.linea = $line( @expchan , %tmp2.linea )
    %tmp2.ccc = $r.c($gettok(%tmp2.l.linea,1,61))
    %tmp2.fundador = $r.c($l.db(chanserv\ $+ %tmp2.ccc,configuracion,fundador))
    chanserv.dropc %tmp2.ccc
    debugc $chanserv %conf.canal.admins $+ , $+ %conf.canal.opers El canal12 %tmp2.ccc propiedad de12 %tmp2.fundador expirado por falta de uso.
  }
  b.db expiracion.db canales
  :f.ecc
}

alias e.t {
  if ( $1 == PRIVADO ) { m $2- }
  if ( $1 == VERSION ) { s : $+ %servidorbots 666 $o : $+ $2- }
}

on ^1:HOTLINK:Configurar_nodo_de_debug:*:return
on 1:hotlink:Configurar_nodo_de_debug:*:if ($active == Status Window) { debug.conf }

on ^1:HOTLINK:configurar_dbots:*:return
on 1:hotlink:configurar_dbots:*:if ($active == Status Window) { conf }

on ^1:HOTLINK:conectarlos:*:return
on 1:hotlink:conectarlos:*:if ($active == Status Window) { conectar }

on ^1:HOTLINK:actualizarlos:*:return
on 1:hotlink:actualizarlos:*:if ($active == Status Window) { actualizar }

on ^1:HOTLINK:noticias:*:return
on 1:hotlink:noticias:*:if ($active == Status Window) { noticias }

on ^1:HOTLINK:ayuda_online:*:return
on 1:hotlink:ayuda_online:*:if ($active == Status Window) { ayuda.online }

on 1:signal:cmmodes:{
  if ($l.db(chanserv\ $+ $r.c($1),estado,$r.c($1)) == OFICIAL || $l.db(chanserv\ $+ $r.c($1),estado,$r.c($1)) == COMERCIAL) {
    if ($istok(CeNTeR.CHaN.CReG.GLoBaL.HeLP.MeMO.NiCK.NoTiCiaS.OPeR.PRoXy.SHaDoW,$3,46)) { ;s : $+ $3 mode $1 $+(-,$right($2,-1)) $3 }
  }
}

on 1:input:@debug:{ s $1- }

menu @smtp.debug {
  L I M P I A R:clear
}

alias checkfiles {
  if (!$isfile(sistema\sockets.mrc)) { var %a $input(Flata el fichero sockets.mrc $+ $crlf $+ Puede que el antivirus lo haya elimiando. $+ $crlf $+ Restauralo antes de volver a iniciar los dBoTs,o,ERROR) }
  elseif (!$script(sockets.mrc)) { load -rs2 sistema\sockets.mrc }
  elseif (!$isfile(sistema\de.mrc)) { var %a $input(Flata el fichero sistema\de.mrc $+ $crlf $+ Puede que el antivirus lo haya elimiando. $+ $crlf $+ Restauralo antes de volver a iniciar los dBoTs,o,ERROR) }
  elseif (!$script(de.mrc)) { load -rs sistema\de.mrc }
  elseif (!$isfile(sistema\ni.mrc)) { var %a $input(Flata el fichero sistema\ni.mrc $+ $crlf $+ Puede que el antivirus lo haya elimiando. $+ $crlf $+ Restauralo antes de volver a iniciar los dBoTs,o,ERROR) }
  elseif (!$script(ni.mrc)) { load -rs sistema\ni.mrc }
  elseif (!$isfile(sistema\ch.mrc)) { var %a $input(Flata el fichero sistema\ch.mrc $+ $crlf $+ Puede que el antivirus lo haya elimiando. $+ $crlf $+ Restauralo antes de volver a iniciar los dBoTs,o,ERROR) }
  elseif (!$script(ch.mrc)) { load -rs sistema\ch.mrc }
  elseif (!$isfile(sistema\ce.mrc)) { var %a $input(Flata el fichero sistema\ce.mrc $+ $crlf $+ Puede que el antivirus lo haya elimiando. $+ $crlf $+ Restauralo antes de volver a iniciar los dBoTs,o,ERROR) }
  elseif (!$script(ce.mrc)) { load -rs sistema\ce.mrc }
  elseif (!$isfile(sistema\cr.mrc)) { var %a $input(Flata el fichero sistema\cr.mrc $+ $crlf $+ Puede que el antivirus lo haya elimiando. $+ $crlf $+ Restauralo antes de volver a iniciar los dBoTs,o,ERROR) }
  elseif (!$script(cr.mrc)) { load -rs sistema\cr.mrc }
  elseif (!$isfile(sistema\op.mrc)) { var %a $input(Flata el fichero sistema\op.mrc $+ $crlf $+ Puede que el antivirus lo haya elimiando. $+ $crlf $+ Restauralo antes de volver a iniciar los dBoTs,o,ERROR) }
  elseif (!$script(op.mrc)) { load -rs sistema\op.mrc }
  elseif (!$isfile(sistema\pr.mrc)) { var %a $input(Flata el fichero sistema\pr.mrc $+ $crlf $+ Puede que el antivirus lo haya elimiando. $+ $crlf $+ Restauralo antes de volver a iniciar los dBoTs,o,ERROR),o,ERROR) }
  elseif (!$script(pr.mrc)) { load -rs sistema\pr.mrc }
  elseif (!$isfile(sistema\me.mrc)) { var %a $input(Flata el fichero sistema\me.mrc $+ $crlf $+ Puede que el antivirus lo haya elimiando. $+ $crlf $+ Restauralo antes de volver a iniciar los dBoTs,o,ERROR) }
  elseif (!$script(me.mrc)) { load -rs sistema\me.mrc }
  elseif (!$isfile(sistema\no.mrc)) { var %a $input(Flata el fichero sistema\no.mrc $+ $crlf $+ Puede que el antivirus lo haya elimiando. $+ $crlf $+ Restauralo antes de volver a iniciar los dBoTs,o,ERROR) }
  elseif (!$script(no.mrc)) { load -rs sistema\no.mrc }
  elseif (!$isfile(sistema\he.mrc)) { var %a $input(Flata el fichero sistema\he.mrc $+ $crlf $+ Puede que el antivirus lo haya elimiando. $+ $crlf $+ Restauralo antes de volver a iniciar los dBoTs,o,ERROR) }
  elseif (!$script(he.mrc)) { load -rs sistema\he.mrc }
  elseif (!$isfile(sistema\gl.mrc)) { var %a $input(Flata el fichero sistema\gl.mrc $+ $crlf $+ Puede que el antivirus lo haya elimiando. $+ $crlf $+ Restauralo antes de volver a iniciar los dBoTs,o,ERROR) }
  elseif (!$script(gl.mrc)) { load -rs sistema\gl.mrc }
  elseif (!$isfile(sistema\dialog.mrc)) { var %a $input(Flata el fichero sismte\dialog.mrc $+ $crlf $+ Puede que el antivirus lo haya elimiando. $+ $crlf $+ Restauralo antes de volver a iniciar los dBoTs,o,ERROR) }
  elseif (!$script(dialog.mrc)) { load -rs sistema\dialog.mrc }
  else {
    .enable #todook.connect
    chequea.modulos
    window -kn @smtp.debug
    if (%conf.noticias == si) { noticias }
    if ( %actualizar == si ) { actualizar | .timerAutoUpDate 0 86400 AutoUpDate }
    .timer 1 2 pffborralamierdadelascarpetas
    .timer 1 2 chanserv.espe.mira
    ;socklisten dbots.escucha $calc($l.conf(servidor,puerto) +1)
    if ($lock(decode)) { lock.decode.on }
    if ($gettok(%auto.conectar,1,32) == si) {
      v.bots 4Auto-connect activado... Conectando los dBoTs en12 $gettok(%auto.conectar,2,32) segundos...
      .timerautoconnect 1 $gettok(%auto.conectar,2,32) conectar
    }
  }
}

alias check.exp {
  if ($1 isnum || $1 == 0) { return $1 }
  else {
    var %a 1
    var %d
    var %h
    var %m
    var %n
    var %c
    while ($mid($1,%a,1)) {
      if ($mid($1,%a,1) isnum) { %c = %c $+ $mid($1,%a,1) }
      elseif ($mid($1,%a,1) == d) { %d = $calc(86400 * %c) | var %c }
      elseif ($mid($1,%a,1) == h) { %h = $calC(3600 * %c) | var %c }
      elseif ($mid($1,%a,1) == m) { %m = $calc(60 * %c) | var %c }
      elseif ($mid($1,%a,1) == s) { %s = %c | var %c }
      else { return 0 | halt }
      inc %a 1
    }
    return $calc(%d + %h + %m + %s)
  }
}

#todook.connect on
#todook.connect end
