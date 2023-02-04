on 1:sockread:dbots: {
  if ( $d(2) == PRIVMSG ) || ( $d(2) == NOTICE ) && (( $d(3) == $proxyserv ) || ( $d(3) == $proxyserv $+ @ $+ %conf.servidor )) { p.m $proxyserv | c.r CA | proxyserv.procesa }
  if ( $d(1) == NICK ) && ($longip($d(6))) && ($l.db(proxy.db,ignora,$d(6)) == $null) { set -u5 %proxy.scan. [ $+ [ $d(2) ] ] $d(6) }
  if ($d(2) == MODE) && (#* !iswm $d(3)) && (+ isin $d(4)) {
    if (%proxy.scan. [ $+ [ $d(1) ] ]) && ($l.conf(proxyserv,mode) == all) && ($s.n($d(1)) < 4) {
      if ($group(#dbl).status == off) { proxycheck %proxy.scan. [ $+ [ $d(1) ] ] #debug $d(1) }
      else { g.db proxy.db dbl %proxy.scan. [ $+ [ $d(1) ] ] #debug $d(1) }
    }
    if (r !isincs $d(4)) && (%proxy.scan. [ $+ [ $d(1) ] ]) && ($l.conf(proxyserv,mode) == noreg) {
      if ($group(#dbl).status == off) { proxycheck %proxy.scan. [ $+ [ $d(1) ] ] #debug $d(1) }
      else { g.db proxy.db dbl %proxy.scan. [ $+ [ $d(1) ] ] #debug $d(1) }
    }
  }
}

alias proxyserv.procesa {
  if ( $d(4) == AYUDA ) || ( $d(4) == HELP ) { proxyserv.ayuda }
  if ( $d(4) == IGNORA ) { proxyserv.ignora }
  if ( $d(4) == MSG) { proxyserv.msg }
  if ( $d(4) == MODE) { proxyserv.mode }
  m Comando desconocido12 $strip($d(4)) $+ . "12/msg $proxyserv AYUDA" para ayuda.
  l.v
}

alias proxyserv.ayuda {
  if ($d(5)) { m.h $proxyserv $o helps\pr.help $replace($d(5-),$chr(32),-) }
  else { m.h $proxyserv $o helps\pr.help help }
  l.v
}

alias proxyserv.ignora {
  if ( $d(5) == ADD ) {
    if ( $d(6) == $null ) { m Error de Sintaxis: 12IGNORA ADD <ip> | l.v }
    if ( $l.db(proxy.db,ignora,$d(6)) != $null ) { m La ip12 $d(6) ya está en la lista. | l.v }
    if ($longip($d(6)) == $Nnull) { m La ip12 $d(6) no parece valida... | l.v }
    g.db proxy.db ignora $d(6) *
    m Añadida la ip12 $d(6) a la lista.
    debugc $proxyserv %conf.canal.admins 12 $+ $o añade en la lista ips que no se escanearán4 $d(6) $+ .
    debugc $proxyserv %conf.canal.opers 12 $+ $o añade en la lista ips que no se escanearán4 $d(6) $+ .
    l.v
  }
  if ( $d(5) == DEL ) {
    if ( $d(6) == $null ) { m Error de Sintaxis: 12PUERTO DEL <ip> | l.v }
    if ( $l.db(proxy.db,ignora,$d(6)) == $null ) { m La ip12 $d(6) no está en la lista. | l.v }
    b.db proxy.db ignora $d(6)
    m Borrada la ip12 $d(6) de la lista.
    debugc $proxyserv %conf.canal.admins 12 $+ $o borra de la lista ips que no se escanearán4 $d(6) $+ .
    debugc $proxyserv %conf.canal.opers 12 $+ $o borra de la lista ips que no se escanearán4 $d(6) $+ .
    l.v
  }
  if ( $d(5) == LIST ) {
    flushini $mircdirdatabase\proxy.db
    %tmp.ruta = $mircdirdatabase\proxy.db
    if ( $initopic( %tmp.ruta , ignora ) == 0 ) {
      m Lista  vacia.
    }
    else {
      m Listado de ips que no se escanearán:
      clear @lignora
      window -hl @lignora
      loadbuf -tignora @lignora $mircdirdatabase\proxy.db
      %tmp.total = $line(@lignora,0)
      %tmp.linea = 0
      while ( %tmp.linea < %tmp.total ) {
        inc %tmp.linea
        %tmp.l.linea = $line( @lignora , %tmp.linea )
        %tmp.ignora = $gettok(%tmp.l.linea,1,61)
        m 12 $+ %tmp.ignora
      }
      :f.i
      m Fin de la lista.
    }
    l.v
  }
  m Error de Sintaxis: 12IGNORA $chr(123) $+ ADD $chr(124) DEL $chr(124) LIST $+ $chr(125)
  l.v
}

alias proxyserv.msg {
  if ($d(6)) {
    writeini dbots.conf proxyserv pmexpulsion $q.c($d(5-))
    m Mensaje cambiado.
    debugc $proxyserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o cambia el mensaje expulsión por: $d(5-)
  }
  else {
    m El mensaje privado para mandar es:
    m
    m $p.c($l.conf(proxyserv,pmexpulsion))
    m
    m Para cambiarlo escribe:
    m 12/msg $proxyserv PRIVMSG <mensaje>
    m 12/msg $proxyserv HELP MSG para más información.
  }
  l.v
}

alias proxyserv.mode {
  if ($d(5)) {
    if ($d(5) == ALL) {
      writeini dbots.conf proxyserv mode all
      m Modo cambiado. Se escaneará a todos los usuarios.
      debugc $proxyserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o cambia el modo a12 ALL. Todos los usuarios serán escaneados...
    }
    elseif ($d(5) == NOREG) {
      writeini dbots.conf proxyserv mode noreg
      m Modo cambiado. Se escaneará a los usuarios no registrados.
      debugc $proxyserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o cambia el modo a12 NOREG. Solo los usuarios no registrados serán escaneados...
    }
    else {
      m 4ERROR: La opción12 $d(5-) no es valida.
      m Usa12 ALL para scanear todos los usaurios
      m Usa12 NOREG para scanear solo a los usuarios que
      m conecten con un nick no registrado.
    }
  }
  else {
    m Usa12 MODE <opcion>
  }
  l.v
}

alias proxycheck {
  if ($1 == $null) { }
  elseif ($1 == callback) {
    if ($hget(dbl,found) > 0) {
      debugc $proxyserv %conf.canal.admins $+ , $+ %conf.canal.opers :IP12 $hget(dbl,ip) detectada en12 $+($hget(dbl,found),/,$hget(dbl,num)) sitios..
      var %i = 1
      var %s
      while (%i <= $hget(dbl,num)) {
        var %dbl = $gettok($hget(dbl,list),%i,44)
        if ($hget(dbl,%dbl)) { 
          %s = $+(%s,$chr(32),%dbl)
        }
        inc %i
      }
      debugc $proxyserv %conf.canal.admins $+ , $+ %conf.canal.opers 4 $+ %s
      s : $+ $binfo(info,nick) PRIVMSG $hget(dbl,nick) $replace($l.conf(proxyserv,pmexpulsion),<nick>,$hget(dbl,nick),<ip>,$hget(dbl,ip),<dnsbl>,%s)
      s : $+ %conf.servidor TKL + G $chr(42) $hget(dbl,ip) $proxyserv 0 $ctime : $+ $l.conf(proxyserv,mexpulsion)
    }
    hfree dbl
    mira.proxys
  }
  else {
    if ($1 == localhost) { tokenize 32 $ip $2 $3 }
    if ($longip($1)) {
      if ($hget(dbl)) { hfree dbl }
      hmake dbl
      hadd -m dbl list dnsbl.dronebl.org,rbl.efnetrbl.org
      hadd -m dbl num 2
      hadd -m dbl ip $1
      hadd -m dbl found 0
      hadd -m dbl chan $2
      hadd -m dbl nick $3
      .enable #dbl
      var %i = 1
      while (%i <= $hget(dbl,num)) {
        .dns $+($revip($1),.,$gettok($hget(dbl,list),%i,44))
        inc %i
      }
    }
    else { }
  }
}

alias mira.proxys {
  if ($ini(database\proxy.db,dbl,1)) {
    var %dbl = $l.db(proxy.db,dbl,$ini(database\proxy.db,dbl,%a))
    proxycheck $ini(database\proxy.db,dbl,1) %dbl
  }
  else { .disable #dbl }
}

#dbl off
on *:DNS:{
  var %dbl = $gettok($dns(1),5-,46)
  hadd -m dbl count $calc($hget(dbl,count) + 1)
  if ($dns(0).ip) { hadd -m dbl %dbl 1 | hadd -m dbl found $calc($hget(dbl,found) + 1) }
  if ($hget(dbl,count) == $hget(dbl,num)) { proxycheck callback | b.db proxy.db dbl $hget(dbl,ip) }
}

#dbl end

;-RevIP script by Patje from SwiftIRC.
alias revip { tokenize 46 $1 | return $+($4, ., $3, ., $2, ., $1) }
