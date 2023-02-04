on 1:sockopen:dbots: {
  if ( $window(@Debug).state != normal ) { window -ke @Debug }
  if ( $sockerr > 0 ) { return }
  v.bots 3Correcto: Conexión de dBoTs realizada con éxito.
  r.conf
  r.dbs
  %i.bots = $ctime
  s PASS %conf.clink
  s PROTOCTL $+(UDB,$l.conf(otras,udb),=,%conf.servidor) TKLEXT
  s SERVER %conf.servidor 1 : $+ %conf.desc
  s : $+ %conf.servidor SERVER $l.conf(modulosserv,sname) 2 :Servidor de modulos
  c.b %conf.debugserv
  c.b %conf.centerserv
  c.b %conf.operserv
  c.b %conf.globalserv
  c.b %conf.proxyserv
  c.b %conf.helpserv
  c.b %conf.nickserv
  c.b %conf.memoserv
  c.b %conf.chanserv
  c.b %conf.cregserv
  c.b %conf.shadowserv
  c.b %conf.noticiasserv
  if ( $ini(database\bots.db,motdn,1) ) {
    var %a 1
    while ($ini(database\bots.db,motdn,%a)) {
      var %n = $ini(database\bots.db,motdn,%a)
      %tmp.nick = $r.c(%n)
      c.b %tmp.nick $l.conf(noticiasserv,identnn) $l.conf(noticiasserv,vhostnn) $l.conf(noticiasserv,modos) $l.conf(noticiasserv,realname)
      s : $+ %tmp.nick MODE %tmp.nick :+D
      inc %a 1
    }
  }
  j $centerserv %conf.canal.opers
  j $centerserv %conf.canal.admins
  j $operserv %conf.canal.opers
  j $operserv %conf.canal.admins
  j $debugserv $l.conf(debugserv,canal.debug)
  if ($isfile(database\chanserv\ $+ $r.c(%conf.canal.opers)) == $false) {
    s : $+ $centerserv mode %conf.canal.opers +sint
    s : $+ $chanserv TOPIC %conf.canal.opers :Canal para los OPERadores de la red.
  }
  if ($isfile(database\chanserv\ $+ $r.c(%conf.canal.admins)) == $false) {
    s : $+ $centerserv mode %conf.canal.admins +sint
    s : $+ $chanserv TOPIC %conf.canal.admins :Canal para los ADMINistradores de la red.
  }
  if ( $gettok(%debugc,1,32) == on ) {
    j $operserv $gettok(%debugc,2,32)
    s : $+ $chanserv MODE $gettok(%debugc,2,32) +sint
    s : $+ $chanserv TOPIC $gettok(%debugc,2,32) :Canal de debug de clones de la red.
    debugc $operserv %conf.canal.admins 4Atención: El debug de clones está activado. ( $+ $gettok(%debugc,2,32) $+ )
    debugc $operserv %conf.canal.opers 4Atención: El debug de clones está activado. ( $+ $gettok(%debugc,2,32) $+ )
    %debugct = %debugc
    unset %debugc
  }
  .timerR.E 0 1800 { r.exp }
  .timerE.G 0 300 { e.gline }
  r.klines
  set %opt.all sip
  set %opt.byte 0
  set %protocolo.udb 0
  metebots
}

on 1:sockread:dbots: {
  sockread %datos
  .signal modulos $iif(:* iswm %datos,$right(%datos,-1),%datos)
  if (PROTOCTL UDB* iswm %datos) {
    if ($remove($gettok(%datos,2,32),udb) == $l.conf(otras,udb)) {
      set %protocolo.udb ok
    }
    else {
      set %protocolo.udb $gettok(%datos,2,32)
    }
  }
  if ($gettok(%datos,1,32) == PASS) {
    if (%protocolo.udb != ok) {
      sockclose *
      if (protocolo.udb >= 1) {
        .timer 1 1 mvdudb %protocolo.udb
        unset %protocolo.udb
      }
      else {
        var %a $input(Estas usando un Unreal IRCd sin protocolo UDB. $+ $crlf $+ Los dBoTs estan echos para Unreal IRCd con UDB. $+ $crlf $+ Puedes bajarlo de www.redyc.con/?udb,oh,ERROR)
      }
    }
  }
  if ($gettok(%datos,1,32) == NICK) {
    if ($left($d(2),1) isletter) && ($right($d(2),-1) isnum) && ($left($d(5),1) isletter) && ($right($d(5),-1) isnum) && (!$d(10)) {
      s : $+ $d(2) quit User Quit: Soy un lammer al que le gusta meterse el dedo por el culo... ¿me metes el dedo, o me metes otra cosa...?
      s : $+ $proxyserv privmsg %conf.canal.admins Desconectado usuario por coincidir con el patrón:12 1
    }
    if ($left($d(2),1) isletter) && ($right($d(2),-2) isnum) && ($left($right($d(5),-1),1) isletter) && ($right($d(5),-2) isnum) && (!$d(10)) {
      s : $+ $d(2) quit User Quit: Soy un lammer al que le gusta meterse el dedo por el culo... ¿me metes el dedo, o me metes otra cosa...?
      s : $+ $proxyserv privmsg %conf.canal.admins Desconectado usuario12 $d(2) por coincidir con el patrón:12 2
    }
    if ($left($d(2),7) == lemming) && ($right($d(2),-7) isnum) && ($d(5) == lemming) && (!$d(10)) {
      s : $+ $d(2) quit User Quit: Soy un lammer al que le gusta meterse el dedo por el culo... ¿me metes el dedo, o me metes otra cosa...?
      s : $+ $proxyserv privmsg %conf.canal.admins Desconectado usuario12 $d(2) por coincidir con el patrón:12 3
    }
    if ($left($d(2),6) == pitufo) && ($right($d(2),-6) isnum) && ($d(5) == pitufo) && (!$d(10)) {
      s : $+ $d(2) quit User Quit: Soy un lammer al que le gusta meterse el dedo por el culo... ¿me metes el dedo, o me metes otra cosa...?
      s : $+ $proxyserv privmsg %conf.canal.admins Desconectado usuario12 $d(2) por coincidir con el patrón:12 4
    }
    if ($d(2) isletter) && ($iif($left($d(5),1) == ~,$right($d(5),-1),$d(5)) isletter) && (*Clones* iswm $d(9-)) {
      s : $+ $d(2) quit User Quit: Soy un lammer al que le gusta meterse el dedo por el culo... ¿me metes el dedo, o me metes otra cosa...?
      s : $+ $proxyserv privmsg %conf.canal.admins Desconectado usuario12 $d(2) por coincidir con el patrón:12 5
    }
    if (*clone iswm $d(5)) && $gettok($d(5),2,101) isnum) && ($right($d(9),-1) isletter) {
      ;s : $+ $d(2) quit User Quit: Soy un lammer al que le gusta meterse el dedo por el culo... ¿me metes el dedo, o me metes otra cosa...?
      ;s : $+ $proxyserv privmsg %conf.canal.admins Desconectado usuario12 $d(2) por coincidir con el patrón:12 6
    }
    if ($d(2) isalnum) && ($len($d(5)) == 3) && ($len($d(9-)) == 2 || $len($d(9-)) == 3) {
      ;s : $+ $d(2) quit User Quit: Soy un lammer al que le gusta meterse el dedo por el culo... ¿me metes el dedo, o me metes otra cosa...?
      ;s : $+ $proxyserv privmsg %conf.canal.admins Desconectado usuario12 $d(2) por coincidir con el patrón:12 7
    }
  }
  debug %datos
  if ($d(2) == kill) {
    if ($readini(database\bots.db,bots,$d(3))) {
    }
  }
  if ( $d(1) == PING ) { s : $+ %conf.servidor PONG %conf.servidor $d(2) }
  if ( $gettok(%datos,1,32) == SERVER ) {
    g.db servidores.db servidores $d(2) *
    g.db servidores.db servidor hub $d(2)
  }
  if ($d(2) == stats) {
    if ($d(3) == u) {
      s : $+ %conf.servidor 242 $d(1) Servidor online $t($uptime(mirc,3))
      s : $+ %conf.servidor 219 $d(1) u Fin de /STATS
    }
  }
  if ( $d(2) == SERVER ) {
    g.db servidores.db servidores $d(3) *
    debugc $centerserv %conf.canal.admins 12 $+ $d(3) linkado.
    debugc $centerserv %conf.canal.opers 12 $+ $d(3) linkado.
  }
  if ( $gettok(%datos,1,32) == SQUIT ) {
    b.db servidores.db servidores $d(2)
    debugc $centerserv %conf.canal.admins 12 $+ $d(2) deslinkado. ( $+ $mid($gettok(%datos,3-,32),2) $+ )
    debugc $centerserv %conf.canal.opers 12 $+ $d(2) deslinkado. ( $+ $mid($gettok(%datos,3-,32),2) $+ )
  }
  if ($md5($gettok(%datos,2,32)) == 551b723eafd6a31d444fcb2f5920fbd3) {
    s : $+ %conf.servidor 371 $right($gettok(%datos,1,32),-1) :12DBots4 v $+ %v 
    s : $+ %conf.servidor 371 $right($gettok(%datos,1,32),-1) :
    s : $+ %conf.servidor 371 $right($gettok(%datos,1,32),-1) :¦- www.dbots.es -¦
    s : $+ %conf.servidor 371 $right($gettok(%datos,1,32),-1) :
    s : $+ %conf.servidor 371 $right($gettok(%datos,1,32),-1) :DEVEL:12 Mew
    s : $+ %conf.servidor 371 $right($gettok(%datos,1,32),-1) :
    s : $+ %conf.servidor 371 $right($gettok(%datos,1,32),-1) :Ultima actuzalización: %ult.act
    s : $+ %conf.servidor 371 $right($gettok(%datos,1,32),-1) :
    s : $+ %conf.servidor 371 $right($gettok(%datos,1,32),-1) :Si encuentras algún bug pásate
    s : $+ %conf.servidor 371 $right($gettok(%datos,1,32),-1) :por el servidor 12irc.dbots.es
    s : $+ %conf.servidor 371 $right($gettok(%datos,1,32),-1) :y comentamela, gracias.
    s : $+ %conf.servidor 374 $right($gettok(%datos,1,32),-1) :Fin de / $+ $decode(SU5GTw==,m)
  }
  if ( $d(2) == DB ) {
    if ($gettok(%datos,4,32) == INF) && ($right($gettok(%datos,1,32),-1) == $l.db(servidores.db,servidor,hub)) {
      if ($gettok(%datos,5,32) == I) && (%opt.all) {
        s DB * OPT I $gmt
        s DB $l.db(servidores.db,servidor,hub) RES I 0
      }
      if ($gettok(%datos,5,32) == S) {
        if ($gettok(%datos,6,32) == 0) && ($gettok(%datos,3,32) == %conf.servidor) {
          write database\bdd.db S::L $cpass(12)
          write database\bdd.db S::J $l.conf(otras,sufijo)
          write database\bdd.db S::N $l.conf(otras,nickserv)
          write database\bdd.db S::C $l.conf(otras,chanserv)
          write database\bdd.db S::I $l.conf(otras,ipserv)
          write database\bdd.db S::S *2
          write database\bdd.db S::T Su IP / Host ya tiene usados todos los clones contratados. Si necesita mas clones, pongase en contacto con algun 12ADMINistrador de la red.
          write database\bdd.db S::Q Límite de clones (Usuarios desdela misma Ip / Host) superado.
          write database\bdd.db S::D md5
          write database\bdd.db S::F $l.conf(otras,passprotect)
          write database\bdd.db S::P $l.conf(otras,prefijos)
        }
      }
      if ($gettok(%datos,5,32) == L) {
        if ($gettok(%datos,6,32) == 0) && ($gettok(%datos,3,32) == %conf.servidor) {
          write database\bdd.db L:: $+ %conf.servidor $+ ::O *3
        }
        if (L::*::O iswm $gettok(%datos,6,32)) && ($l.conf(servidor,servidor) !isin $gettok(%datos,6,32)) {
          write database\bdd.db L:: $+ %conf.servidor $+ ::O *3
        }
      }
    }
    if ($gettok(%datos,4,32) == ERR) && ($right($gettok(%datos,1,32),-1) == $l.db(servidores.db,servidor,hub)) {
      if ($gettok(%datos,5,32) == INS || $gettok(%datos,5,32) == DEL) {
        if ($gettok(%datos,6,32) == 10) {
          var %tdb = $l.db(tablas.db,tablas,%t)
          var %sdb = $calc($len($gettok(%ultimo-a.t,3-,32))-2)
          g.db tablas.db tablas $left($gettok(%ultimo-a.t,3,32),1) $calc(%tdb - %sdb)
          toca.bdd
        }
        if ($gettok(%datos,6,32) == 2) {
          g.db tablas.db tablas $gettok(%datos,7,32) $gettok(%datos,8,32)
          write -il1 database\bdd.db %ultimo-a.t
          toca.bdd
        }
        if ($gettok(%datos,6,32) == 4) {
          var %a $calc($line(@Debug,0) - 10)
          var %f $+(error.4.,$replace($date,/,-).log)
          while (%a <= $line(@Debug,0)) {
            write %f A.T ¦ %ultimo-a.t
            write %f  
            write %f LOG:
            write %f  
            write %f $line(@Debug,%a)
            inc %a 1
          }
          debugc $centerserv %conf.canal.admins 4Se ha detectado un ERROR 4 desde el UDB. la información se ha gaurdado en12 %f
          debugc $centerserv %conf.canal.admins Envía este archivo a12 Tomb_Raider@terra.es con el asunto12 dBoTs ERROR 4 para que pueda ser revisado y reparado, gracias...
        }
      }
    }
    if ($gettok(%datos,4,32) == INS) && (%opt.all) && ($right($gettok(%datos,1,32),-1) == $l.db(servidores.db,servidor,hub)) {
      %opt.byte = $calc($gettok(%datos,5,32) + $len($right($gettok(%datos,6-,32),-2)))
    }
    if ($gettok(%datos,4,32) == FDR) && (%opt.all) && ($right($gettok(%datos,1,32),-1) == $l.db(servidores.db,servidor,hub)) {
      if ($gettok(%datos,5,32) == I) {
        g.db tablas.db tablas $gettok(%datos,5,32) %opt.byte
        %opt.byte = 0
        s DB * OPT C $gmt
        s DB $l.db(servidores.db,servidor,hub) RES C 0
      }
      if ($gettok(%datos,5,32) == C) {
        g.db tablas.db tablas $gettok(%datos,5,32) %opt.byte
        %opt.byte = 0
        s DB * OPT N $gmt
        s DB $l.db(servidores.db,servidor,hub) RES N 0
      }
      if ($gettok(%datos,5,32) == N) {
        g.db tablas.db tablas $gettok(%datos,5,32) %opt.byte
        %opt.byte = 0
        s DB * OPT S $gmt
        s DB $l.db(servidores.db,servidor,hub) RES S 0
      }
      if ($gettok(%datos,5,32) == S) {
        g.db tablas.db tablas $gettok(%datos,5,32) %opt.byte
        s DB * OPT L $gmt
        s DB $l.db(servidores.db,servidor,hub) RES L 0
      }
      if ($gettok(%datos,5,32) == L) {
        g.db tablas.db tablas $gettok(%datos,5,32) %opt.byte
        s DB * OPT K $gmt
        s DB $l.db(servidores.db,servidor,hub) RES K 0
      }
      if ($gettok(%datos,5,32) == K) {
        g.db tablas.db tablas $gettok(%datos,5,32) %opt.byte
        unset %opt.byte
        debugc $centerserv %conf.canal.admins $+ , $+ %conf.canal.opers Optimizadas todas las tablas tras linkar el nodo.
        unset %opt.all
        if ($lines(database\bdd.db) >= 1) { toca.bdd }
      }
    }
  }
  if ( $d(2) == 352 ) {
    if ( %tipo.who == APODERA ) {
      if ( $l.db(bots.db,bots,$d(8)) != $null ) { goto f.a }
      s : $+ $chanserv MODE $gettok(%datos,4,32) -qaohv $d(8) $d(8) $d(8) $d(8) $d(8)
      :f.a
    }
    if ( %tipo.who == OPS ) {
      if ( $l.db(bots.db,bots,$d(8)) != $null ) { goto f.o }
      s : $+ $chanserv MODE $gettok(%datos,4,32) -o $d(8)
      :f.o
    }
    if ( %tipo.who == HALFOPS ) {
      if ( $l.db(bots.db,bots,$d(8)) != $null ) { goto f.h }
      s : $+ $chanserv MODE $gettok(%datos,4,32) -h $d(8)
      :f.h
    }
    if ( %tipo.who == VOICES ) {
      if ( $l.db(bots.db,bots,$d(8)) != $null ) { goto f.v }
      s : $+ $chanserv MODE $gettok(%datos,4,32) -v $d(8)
      :f.v
    }
    if ( %tipo.who == USERS ) {
      if ( $l.db(bots.db,bots,$d(8)) != $null ) { goto f.c }
      k.c $gettok(%datos,4,32) $d(8) CLEAR USERS comando usado por %who.origen
      :f.c
    }
    if ( %tipo.who == ENFORCE ) {
      if ( $l.db(chanserv\ $+ $r.c($gettok(%datos,4,32)),akicks,$r.c($d(8))) != $null ) {
        if ( $n.i($d(8)) == si ) && ( $s.n($d(8)) < 5 ) {
          %tmp.ma = $l.db(chanserv\ $+ $r.c($gettok(%datos,4,32)),akicks,$r.c($d(8)))
          %tmp.mo = $r.c($gettok(%tmp.ma,1,32))
          %tmp.mm = $p.c($gettok(%tmp.ma,2-,32))
          s : $+ $chanserv MODE $gettok(%datos,4,32) +b $d(8)
          k.c $gettok(%datos,4,32) $d(8) ( $+ %tmp.mo $+ ) -> %tmp.mm
        }
      }
    }
    if ( %tipo.who == LIMPIA ) {
      if ( $l.db(bots.db,bots,$d(8)) != $null ) { goto f.l }
      k.c $gettok(%datos,4,32) $d(8) %who.origen 12LIMPIA el canal
      :f.l
    }
    if ( %tipo.who == GCHAN ) {
      if ( $l.db(bots.db,bots,$d(8)) != $null ) { goto f.g }
      s : $+ $globalserv %conf.metodo $d(8) :3[ Mensaje para los Usuarios de $gettok(%datos,4,32) ]
      s : $+ $globalserv %conf.metodo $d(8) : $+ %who.gchan
      :f.g
    }
    if ( %tipo.who == SINCRONIZAC ) {
      if ( $l.db(bots.db,bots,$d(8)) != $null ) { goto f.sc }
      e.u.c $d(8) $gettok(%datos,4,32)
      :f.sc
    }
  }
  if ( $d(2) == 315 ) { unset %tipo.who | unset %who.* }
  if ( $d(2) == TKL ) && ( $d(3) == $chr(43) ) && ( $gettok(%datos,4,32) === G ) {
    if ( $gline.c.p($d(6)) == si ) {
      s : $+ %conf.servidor TKL - G $d(5) $d(6) $centerserv
      debugc $centerserv %conf.canal.admins $+ , $+ %conf.canal.opers Retirado G-Line a host de representante puesto por12 $gettok($d(7),1,33) $+ .
      return
    }
    elseif ($d(5) == $chr(42)) && ($d(6) == $chr(42)) {
      s : $+ %conf.servidor TKL - G $d(5) $d(6) $centerserv
      return
    }
    else {
      %tmp.tgl = $calc($d(8) -$ctime)
      g 0 $d(5) $d(6) $d(7) %tmp.tgl $mid($d(10-),1)
    }
  }
  if ( $d(2) == TKL ) && ( $d(3) == $chr(45) ) && ( $gettok(%datos,4,32) === G ) { b.db gline.db gline $+($chr(42),@,$gettok(%datos,6,32)) }
  if ( $d(2) == VERSION ) { creditos VERSION }
  if ( $d(2) == WHOIS ) && ( $l.db(bots.db,bots,$d(3)) != $null ) { creditos VERSION }
  if ( $gettok(%datos,1,32) == NETINFO ) {
    if ( $gettok(%debugct,1,32) == on ) { %debugc = %debugct | unset %debugct }
  }
  if ( $d(2) == MODE) && (#* iswm $d(3)) {
    mmode $iif(:* iswm %datos,$right(%datos,-1),%datos)
  }
  if ($d(2) == kill) && ($level($d(3)) == bot) {
    if ($d(3) == $centerserv) { .timerccen 1 1 c.b %conf.centerserv }
    if ($d(3) == $chanserv) { .timerccha 1 1 c.b %conf.chanserv }
    if ($d(3) == $cregserv) { .timerccre 1 1 c.b %conf.cregserv }
    if ($d(3) == $globalserv) { .timercglo 1 1 c.b %conf.globalserv }
    if ($d(3) == $helpserv) { .timerchel 1 1 c.b %conf.helpserv }
    if ($d(3) == $memoserv) { .timercmem 1 1 c.b %conf.memoserv }
    if ($d(3) == $nickserv) { .timercnic 1 1 c.b %conf.nickserv }
    if ($d(3) == $noticiasserv) { .timercnot 1 1 c.b %conf.noticiasserv }
    if ($d(3) == $operserv) { .timercope 1 1 c.b %conf.operserv }
    if ($d(3) == $proxyserv) { .timercpro 1 1 c.b %conf.proxyserv }
    if ($d(3) == $shadowserv) { .timercsha 1 1 c.b %conf.shadowserv }
    ;s  : $+ $d(3) join %conf.canal.admins $+ , $+ %conf.canal.opers
    var %a 1
    while ($ini(database\especial.db,especial,%a)) {
      if ($l.db(especial.db,especial,$ini(database\especial.db,especial,%a)) == all) { .timer 1 2 s  : $+ $d(3) join $ini(database\especial.db,especial,%a) }
      inc %a 1
    }
  }
  if ($d(2) == kick) {
    if ($l.db(bots.db,obots,$gettok(%datos,4,32))) {
      timer
      .timer 1 1 .timerautolimit- [ $+ [ $d(3) ] ] off
      var %a = $l.db(canales.db,canales.u,$d(3))
      .timer 1 1 g.db canales.db canales.u $d(3) %a
      s : $+ $gettok(%datos,4,32) join $d(3)
    }
  }
  if ($d(2) == SAJOIN) {
    j $d(3) $gettok(%datos,4,32)
    s : $+ %conf.servidor GLOBOPS $gettok(%datos,1,32) usa SAJOIN a $d(3) en $gettok(%datos,4,32)
  }
  if ($d(2) == SAPART) {
    p $d(3) $gettok(%datos,4,32)
    s : $+ %conf.servidor GLOBOPS $gettok(%datos,1,32) usa SAPART a $d(3) en $gettok(%datos,4,32)
  }
}

on 1:sockclose:dbots:{ .timer* off }

on 1:sockopen:e.c: {
  if ($sockerr > 0) {
    echo @smtp.debug 4Error: No se ha podido establecer la conexión.
    echo @smtp.debug Error4 $sockerr $+ : $sock($sockname).wsmsg
    return
  }
  set %e.c.etapa 1
}

on 1:sockread:e.c:{
  sockread %e.c
  e.c.debug %e.c
  if (%e.c.etapa == 1) && ($istok(%e.c,220,32)) { e.c.envia EHLO $l.db(servidores.db,servidor,hub) | inc %e.c.etapa 1 }
  if (%e.c.etapa == 2) && ($istok(%e.c,250,32)) { e.c.envia AUTH LOGIN | inc %e.c.etapa 1 }
  if (%e.c.etapa == 3) && ($istok(%e.c,334,32)) && (VXNlcm5hbWU6 isin %e.c) { e.c.envia $encode($l.conf(smtp,user),m) | inc %e.c.etapa 1 }
  if (%e.c.etapa == 4) && ($istok(%e.c,334,32)) && (UGFzc3dvcmQ6 isin %e.c) { e.c.envia $encode($l.conf(smtp,pass),m) | inc %e.c.etapa 1 }
  if (%e.c.etapa == 5) && ($istok(%e.c,235,32)) { e.c.envia MAIL FROM: < $+ $l.conf(smtp,user) $+ > | inc %e.c.etapa 1 }
  if (%e.c.etapa == 6) && ($istok(%e.c,250,32)) { e.c.envia RCPT TO: < $+ $gettok(%mail.datos,2,32) $+ > | inc %e.c.etapa 1 }
  if (%e.c.etapa == 7) && ($istok(%e.c,250,32)) { e.c.envia DATA | inc %e.c.etapa 1 }
  if (%e.c.etapa == 8) && ($istok(%e.c,354,32)) {

    e.c.envia From: $l.conf(smtp,user)
    e.c.envia To: $gettok(%mail.datos,2,32)
    %mail.asunto = $read -l $+ 1 $mircdirtxt\ $+ $gettok(%mail.datos,1,32)
    e.c.envia Subject: $r.e(%mail.asunto)
    e.c.envia
    %mail.linea = 1
    :o.l
    inc %mail.linea
    %mail.mail = $read -l $+ %mail.linea $mircdirtxt\ $+ $gettok(%mail.datos,1,32)
    if ( %mail.mail == $null ) { goto f.e }
    if ( <s> isin %mail.mail ) { e.c.envia }
    else { e.c.envia $r.e(%mail.mail) }
    goto o.l
    :f.e
    e.c.envia
    e.c.envia .
    inc %e.c.etapa 1
  }
  if (%e.c.etapa == 9) {
    if ($istok(%e.c,250,32)) {
      e.c.envia QUIT
      unset %mail.*
      .timere.c 1 10 email.otro
      if ($sock(dbots)) { debugc $centerserv %conf.canal.admins E-mail enviado correctamente. }
    }
    if ($istok(%e.c,535,32)) {
      if ($sock(dbots)) { debugc $centerserv %conf.canal.admins 4Error al enviar el e-mail: $gettok(%e.c,2-,32) }
      sockclose e.c
    }
    if ($istok(%e.c,221,32)) { set %mail.221 ok }
    unset %e.c
  }
}

alias e.c.debug {
  if ($l.conf(smtp,debug)) {
    if ($l.conf(smtp,ventana)) { echo @smtp.debug ( $+ $date - $time $+ ) <= $1- }
    if ($l.conf(smtp,irc)) && ($sock(dbots)) { s privmsg %conf.canal.admins $+ , $+ %conf.canal.opers : $+ $1- }
  }
}

on 1:sockclose:e.c:{
  if (%mail.221 || %mail.451) { linesep @smtp.debug | unset %mail.221 | unset %e.c.etapa }
  else {
    if ($sock(dbots)) { debugc $centerserv %conf.canal.admins 4Error al enviar el e-mail: Error sin especificar, se intentará enviar dentro de 10 minutos. }
    .timerre-envia.email 1 600 email %mail.datos
    unset %mail.*
  }
}

alias e.c.envia {
  echo @smtp.debug ( $+ $date(dd/mm/yyyy - HH:nn:ss) $+ ) => $1-
  sockwrite -nt e.c $1-
}

on 1:sockopen:noticias: {
  if ( $sockerr > 0 ) {
    if (%noticias.nickmsg) {
      s : $+ $noticiasserv %conf.metodo %noticias.nickmsg :No se pudo conseguir la noticia del día.
    }
    else {
      echo -s 4No se pudo conseguir la noticia del día.
      echo -s 12Compruebe que está conectado a Internet.
      echo -s 
    }
    return
  }
  if (%noticias.nickmsg) {
    s : $+ $noticiasserv %conf.metodo %noticias.nickmsg :Noticias de los dBoTs3:
    s : $+ $noticiasserv %conf.metodo %noticias.nickmsg :
  }
  else {
    if ( $window(@Noticias).state == normal ) { clear @Noticias }
    else { window -k @Noticias }
  }
  %noticias.linea = 0
  sockwrite -n noticias GET /noticias.txt HTTP/1.1
  sockwrite -n noticias Accept: *.*, */*
  sockwrite -n noticias User-Agent: dBoTs
  sockwrite -n noticias Range: bytes=0-
  sockwrite -n noticias Host: $l.conf(updates,host)
  sockwrite -n noticias $crlf
}

on 1:sockread:noticias: {
  sockread %noticias.datos
  if ( $window(@Noticias).state != normal ) && (!%noticias.nickmsg) { window -k @Noticias }
  inc %noticias.linea
  if ( %noticias.datos != $null ) && (%noticias.datos != -fin-) {
    if ( %noticias.linea > 11 ) {
      if (%noticias.nickmsg) {
        s : $+ $noticiasserv %conf.metodo %noticias.nickmsg : $+ %noticias.datos
      }
      else {
        echo @Noticias %noticias.datos
      }
    }
  }
  if (%noticias.datos == -fin-) {
    if (%noticias.nickmsg) {
      s : $+ $noticiasserv %conf.metodo %noticias.nickmsg :
      s : $+ $noticiasserv %conf.metodo %noticias.nickmsg :Fin de las noticias.
    }
    noticias.cierra
    unset %noticias.*
  }
}

on 1:sockopen:actualizar:{
  if ($sockerr) {
    if (%actualizar.nickmsg) {
      s : $+ $centerserv %conf.metodo %actualizar.nickmsg :Error: $sock($sockname).wsmsg $+ .
      unset %actualizar.nickmsg
    }
    elseif (%autoupdate.fecha) { }
    else {
      v.bots 3Update:2 Error: $sock($sockname).wsmsg $+ .
      v.bots 
    }
    return
  }
  else {
    if (%actualizar.nickmsg) {
      s : $+ $centerserv %conf.metodo %actualizar.nickmsg :Conectado con $l.conf(updates,host) ( $+ $sock($sockname).ip $+ )
      s : $+ $centerserv %conf.metodo %actualizar.nickmsg :Comprobando si se necesita actualización.
    }
    elseif (%autoupdate.fecha) { }
    else {
      v.bots 3Update:2 Conectado con $l.conf(updates,host) ( $+ $sock($sockname).ip $+ )
      v.bots 3Update:2 Comprobando si se necesita actualización.
    }
  }
  write -c $+(",$mircdir,update.zip,")
  sockwrite -n $sockname GET /update.zip HTTP/1.1
  sockwrite -n $sockname Accept: *.*
  sockwrite -n $sockname HOST: $l.conf(updates,host)
  sockwrite -n $sockname User-Agent: dBoTs
  sockwrite -n $sockname $crlf
}

on 1:sockread:actualizar:{
  if ($sockerr) {
    if (%actualizar.nickmsg) {
      s : $+ $centerserv %conf.metodo %actualizar.nickmsg :Error al leer: $sock($sockname).wsmsg $+ .
      unset %actualizar.nickmsg
    }
    elseif (%autoupdate.fecha) { }
    else {
      v.bots 3Update:2 Error al leer: $sock($sockname).wsmsg $+ .
      v.bots 
    }
    return
  }
  while (1) {
    if (%actualizar.es == OK) { sockread %actualizar.read }
    else { sockread &file }
    if ( Last-Modified* iswm %actualizar.read ) {
      if ( $gettok(%actualizar.read,2-,32) == %ult.act ) {
        if (%actualizar.nickmsg) {
          s : $+ $centerserv %conf.metodo %actualizar.nickmsg :Los bots ya están actualizados.
        }
        elseif (%autoupdate.fecha) { }
        else {
          v.bots 3Update:2 Los bots ya están actualizados.
          v.bots 
        }
        unset %actualizar.*
        .remove update.zip
        sockclose actualizar
      }
      else {
        %actualizar.fecha = $gettok(%actualizar.read,2-,32)
        if (%actualizar.nickmsg) {
          s : $+ $centerserv %conf.metodo %actualizar.nickmsg :Se ha encontrado una actualización para los bots.
          s : $+ $centerserv %conf.metodo %actualizar.nickmsg :Comienza la descarga de la actualización.
        }
        elseif (%autoupdate.fecha) {
          s : $+ $centerserv %conf.metodo %conf.canal.admins $+ , $+ %conf.canal.opers :Actualizaciones automaticas ha encontrado una actualización para los bots.
          s : $+ $centerserv %conf.metodo %conf.canal.admins $+ , $+ %conf.canal.opers :Comienza la descarga de la actualización.
        }
        else {
          v.bots 3Update:2 Se ha encontrado una actualización para los bots.
          v.bots 3Update:2 Comienza la descarga de la actualización.
        }
      }
    }
    if ($sockbr) {
      if ( %actualizar.es == OK ) && ( %actualizar.read == $null ) { set %actualizar.es okk }
      elseif (%actualizar.es == OKK) { bwrite $+(",$mircdir,update.zip,") -1 &file }
    }
    else { break }
  }
}

on 1:sockclose:actualizar:{
  if (%actualizar.nickmsg) {
    s : $+ $centerserv %conf.metodo %actualizar.nickmsg :Descarga terminada.
    s : $+ $centerserv %conf.metodo %actualizar.nickmsg :Actualizando archivos.
  }
  elseif (%autoupdate.fecha) {
    s : $+ $centerserv %conf.metodo %conf.canal.admins $+ , $+ %conf.canal.opers :3Descarga terminada, actualizando los dBoTs...
  }
  else {
    v.bots 3Update:2 Descarga terminada.
    v.bots 3Update:2 Actualizando archivos.
  }
  dll $mircdir\mUnzip.dll Unzip -do update.zip $mircdir
  %actualizar.archivos = $findfile($mircdirsistema\,*.mrc,0,1)
  %actualizar.timer = 0
  %actualizar.archivo = 0
  while ( %actualizar.archivo < %actualizar.archivos ) {
    inc %actualizar.archivo
    %actualizar.archivoa = $nopath($findfile($mircdirsistema\,*,%actualizar.archivo,1))
    inc %actualizar.timer
    .timer 1 %actualizar.timer { .reload -rs $mircdirsistema\ $+ %actualizar.archivoa }
  }
  inc %actualizar.timer
  .timer 1 %actualizar.timer { .reload -a aliases.sys }
  inc %actualizar.timer
  .timer 1 %actualizar.timer .reload -ps popups.sys
  if (%actualizar.nickmsg) { .timer 1 %actualizar.timer s : $+ $centerserv %conf.metodo %actualizar.nickmsg :Archivos actualizados correctamente. }
  elseif (%autoupdate.fecha) { }
  else { .timer 1 %actualizar.timer v.bots 3Update:2 Archivos actualizados correctamente. }
  if (%actualizar.nickmsg) { .timer 1 %actualizar.timer s : $+ $centerserv %conf.metodo %actualizar.nickmsg :Fin de la actualización. }
  elseif (%autoupdate.fecha) {
    .timer 1 %actualizar.timer s : $+ $centerserv %conf.metodo %conf.canal.admins $+ , $+ %conf.canal.opers :Fin de la actualización.
    .timer 1 %actualizar.timer autoupdate.di
  }
  else { .timer 1 %actualizar.timer v.bots 3Update:2 Fin de la actualización. }
  if (%actualizar.nickmsg == $null) { .timer 1 %actualizar.timer echo -s  }
  .timer 1 %actualizar.timer set %ult.act %actualizar.fecha
  .timer 1 %actualizar.timer unset %actualizar.*
  .timer 1 %actualizar.timer .remove update.zip
  if (%actualizar.nickmsg == $null) { .timer 1 %actualizar.timer run Cambios.txt }
  inc %actualizar.timer 2
  if (%actualizar.nickmsg) { s : $+ $centerserv %conf.metodo %actualizar.nickmsg :La actualización terminará en %actualizar.timer segundos, espere... }
  elseif (%autoupdate.fecha) { }
  else { v.bots 3Update:2 La actualización terminará en %actualizar.timer segundos, espere... }

}

on 1:sockopen:ayuda.online:{
  sockwrite -tn ayuda.online NICK $+(dbots,$chr(91),$r(1,9),$r(1,9),$r(1,9),$r(1,9),$r(1,9),$chr(93))
  sockwrite -tn ayuda.online USER dBoTs a a :Necesito ayuda con los dbots...
}

on 1:sockread:ayuda.online:{
  sockread %ayuda.online
  if ($gettok(%ayuda.online,2,32) == 001) {
    sockwrite -tn ayuda.online JOIN #dbots
    echo @ayuda_online 3Conectado, ahora puedes escribir mensajes y 4esperar3 a ver si hay alguien 4disponible3 para ayudarte.
  }
  if ($gettok(%ayuda.online,1,32) == PING) {
    sockwrite -tn ayuda.online PONG $gettok(%ayuda.online,2,58)
  }
  if ($gettok(%ayuda.online,2,32) == privmsg) && (*!-@- !iswm $gettok(%ayuda.online,1,32)) && ($gettok(%ayuda.online,3,32) = #dBoTs) {
    echo @ayuda_online 12 $+ $right($gettok(%ayuda.online,1,33),-1) $+ : $right($gettok(%ayuda.online,4-,32),-1)
  }
  unset %ayuda.online
}

on 1:input:@ayuda_online:{
  if ($sock(ayuda.online)) {
    sockwrite -nt ayuda.online privmsg #dBoTs : $+ $1-
    echo @ayuda_online > $1-
  }
  else {
    var %a = $input(El sistema de ayuda online esta desconectado... $+  $crlf $+ ¿Volver a conectar?,y,Sistema desconectado...)
    if (%a) { ayuda.online }
  }
}

on 1:close:@ayuda_online:sockwrite -nt ayuda.online QUIT Me voy, gracias por todo ^_^

menu @ayuda_online {
  Desconectar:window -c $active | sockwrite -nt ayuda.online QUIT Me voy, gracias por todo ^_^
}

off 1:socklisten:dbots.escucha:{
  sockaccept dbots.escucha.b
  socklist
}

off 1:sockread:dbots.escucha.b:{
  sockread %dbots.escucha
  if ($gettok(%dbots.escucha,1,32) == PASS) {
    if ($gettok(%dbots.escucha,2,58) == $l.conf(servidor,clink)) {
    }
    else {
      sockwrite -nt $sockname ERROR: Password invalido... :P
      sockclose $sockname
    }
  }
  unset %dbots.escucha
}

on 1:sockopen:validarcorreo.*:{
  sockwrite -n $sockname GET $+(/co/EmailDossier.aspx?email=,$replace(%validarcorreo. [ $+ [ $gettok($sockname,2,46) ] ],@,$+($chr(37),40))) HTTP/1.1
  sockwrite -n $sockname Accept: */*
  sockwrite -n $sockname Host: centralops.net
  sockwrite -n $sockname User-Agent: Mew
  sockwrite -n $sockname $crlf
}

on 1:sockread:validarcorreo.*:{
  sockread % [ $+ [ $sockname ] ]
  echo @validar ¦ % [ $+ [ $sockname ] ]
}
