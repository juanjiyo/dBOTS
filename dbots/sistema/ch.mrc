on 1:sockread:dbots: {
  if ($right($gettok(%datos,1,32),-1) == $l.db(servidores.db,servidor,hub)) && ($d(2) == MODE) && (#* iswm $d(3)) && ( $l.db(chanserv\ $+ $r.c($d(3)),configuracion,especial) != $null ) {
    %tmp.especial = $l.db(chanserv\ $+ $r.c($d(3)),configuracion,especial)
    %tmp.especialc = 0
    :e.b
    inc %tmp.especialc
    %tmp.especialb = $gettok(%tmp.especial,%tmp.especialc,32)
    if ( %tmp.especialb == $null ) { goto f.es }
    chanserv.especialj $d(3) %tmp.especialb
    goto e.b
    :f.es
  }
  if ( $d(2) == JOIN ) {
    if ($chr(44) isin $d(3)) {
      var %a 1
      var %b = $numtok($d(3),44)
      while (%a <= %b) {
        if (Ã‘ isin $gettok($d(3),%a,44)) {
          s : $+ $shadowserv join $gettok($d(3),%a,44)
          s : $+ $shadowserv privmsg $gettok($d(3),%a,44) :Lo siento12 $o $+ , pero no se pueden usar canales con letra 4Ñ en mayúscula...
          s : $+ $shadowserv privmsg $gettok($d(3),%a,44) :Usa el canal12 $replace($d(3),Ã‘,ñ) que tiene la 4ñ en minúscula...
          s : $+ $shadowserv mode $gettok($d(3),%a,44) +mntisk-o $cpass $o
          s : $+ $shadowserv privmsg $gettok($d(3),%a,44) :Por favor, abandona este canal.
          s : $+ $shadowserv privmsg $gettok($d(3),%a,44) :Gracias!
          .timer 1 30 s : $+ $shadowserv kick $d(3) $o :vete para el canal $replace($d(3),Ã‘,ñ) !!
        }
        else {
          chanserv.c.r $o $gettok($d(3),%a,44)
          e.u.c.nr $gettok($d(3),%a,44) $o
        }
        inc %a 1
      }
    }
    elseif ($d(3) isnum) { u.s.tc $o }
    else {
      if (Ã‘ isin $d(3)) {
        s : $+ $shadowserv join $d(3)
        s : $+ $shadowserv privmsg $d(3) :Lo siento12 $o $+ , pero no se pueden usar canales con letra4 Ñ en mayúscula...
        s : $+ $shadowserv privmsg $d(3) :Usa el canal12 $replace($d(3),Ã‘,ñ) que tiene la 4ñ en minúscula...
        s : $+ $shadowserv mode $d(3) +mntisk-o $cpass $o
        s : $+ $shadowserv privmsg $d(3) :Por favor, abandona este canal.
        s : $+ $shadowserv privmsg $d(3) :Gracias!
        .timer 1 30 s : $+ $shadowserv kick $d(3) $o :vete para el canal $replace($d(3),Ã‘,ñ) !!
      }
      else {
        chanserv.c.r $o $d(3)
        e.u.c.nr $d(3) $o 
      }
    }
  }
  if ( $d(2) == PART ) {
    if ( $ca.r($d(3)) == si ) { u.s.c $o $d(3) }
    u.s.c.nr $d(3)
  }
  if ( $d(2) == KICK ) {
    if ( $ca.r($d(3)) == si ) { u.s.c $gettok(%datos,4,32) $d(3) }
  }
  if ( $d(2) == MODE ) && ( $mid($d(3),1,1) == $chr(35) ) && ( $ca.r($d(3)) == si ) {
    if ( $e.c($d(3)) == SUSPENDIDO ) { return }
    else {
      %tmp.unrealms = bekfLlqaohv
      %tmp.unrealmn = psmntirRcOAQKVGCuzNSMTkfLl
      %tmp.modosc = $gettok(%datos,4,32)
      %tmp.t = $len(%tmp.modosc)
      %tmp.datosc = $gettok(%datos,5-,32)
      %tmp.cl = 0
      %tmp.cl2 = 0
      %tmp.cl3 = 0
      %tmp.cl4 = 0
      %tmp.c = 0
      %tmp.c2 = 0
      %tmp.c3 = 0
      %tmp.c4 = 0
      %tmp.c5 = 0
      %tmp.c6 = 0
      inc %tmp.c
      if ( $mid(%tmp.modosc,%tmp.c,1) == $null ) { goto f }
      if ( $mid(%tmp.modosc,%tmp.c,1) == + ) { goto p }
      if ( $mid(%tmp.modosc,%tmp.c,1) == - ) { goto n }
      :p
      inc %tmp.c
      if ( $mid(%tmp.modosc,%tmp.c,1) == $null ) { goto f }
      if ( $mid(%tmp.modosc,%tmp.c,1) == + ) { goto p }
      if ( $mid(%tmp.modosc,%tmp.c,1) == - ) { goto n }
      %tmp.mp = %tmp.mp $+ $mid(%tmp.modosc,%tmp.c,1)
      if ( $mid(%tmp.modosc,%tmp.c,1) isincs %tmp.unrealmn ) { chanserv.p.m $d(3) $mid(%tmp.modosc,%tmp.c,1) }
      if ( $mid(%tmp.modosc,%tmp.c,1) isincs %tmp.unrealms ) {
        inc %tmp.c2
        %tmp.mp2 = %tmp.mp2 $gettok(%tmp.datosc,%tmp.c2,32)
      }
      goto p
      :n
      inc %tmp.c
      if ( $mid(%tmp.modosc,%tmp.c,1) == $null ) { goto f }
      if ( $mid(%tmp.modosc,%tmp.c,1) == + ) { goto p }
      if ( $mid(%tmp.modosc,%tmp.c,1) == - ) { goto n }
      %tmp.mn = %tmp.mn $+ $mid(%tmp.modosc,%tmp.c,1)
      if ( $mid(%tmp.modosc,%tmp.c,1) isincs %tmp.unrealmn ) { chanserv.q.m $d(3) $mid(%tmp.modosc,%tmp.c,1) }
      if ( $mid(%tmp.modosc,%tmp.c,1) isincs %tmp.unrealms ) {
        inc %tmp.c2
        %tmp.mn2 = %tmp.mn2 $gettok(%tmp.datosc,%tmp.c2,32)
      }
      goto n
      :f
      %tmp.modos.a = $l.db(canales.db,modos.c,$r.c($d(3)))
      while ( %tmp.cl < $len(%tmp.mp) ) {
        inc %tmp.cl
        if ( $mid(%tmp.mp,%tmp.cl,1) === i ) {
          if ( i isincs %tmp.modos.a ) { j $shadowserv $d(3) | goto f.s }
        }
        if ( $mid(%tmp.mp,%tmp.cl,1) === k ) {
          if ( k isincs %tmp.modos.a ) { j $shadowserv $d(3) | goto f.s }
        }
        if ( $mid(%tmp.mp,%tmp.cl,1) === R ) {
          if ( R isincs %tmp.modos.a ) { j $shadowserv $d(3) | goto f.s }
        }
      }
      while ( %tmp.cl2 < $len(%tmp.mn) ) {
        inc %tmp.cl2
        if ( $mid(%tmp.mn,%tmp.cl2,1) === i ) {
          if ( i !isincs %tmp.modos.a ) && ( k !isincs %tmp.modos.a ) && ( R !isincs %tmp.modos.a ) { p $shadowserv $d(3) | goto f.s }
        }
        if ( $mid(%tmp.mn,%tmp.cl2,1) === k ) {
          if ( k !isincs %tmp.modos.a ) && ( i !isincs %tmp.modos.a ) && ( R !isincs %tmp.modos.a ) { p $shadowserv $d(3) | goto f.s }
        }
        if ( $mid(%tmp.mn,%tmp.cl2,1) === R ) {
          if ( R !isincs %tmp.modos.a ) && ( i !isincs %tmp.modos.a ) && ( k !isincs %tmp.modos.a ) { p $shadowserv $d(3) | goto f.s }
        }
      }
      :f.s
      while ( %tmp.c3 < $len(%tmp.mn) ) {
        inc %tmp.c3
        if ( $mid(%tmp.mn,%tmp.c3,1) === k ) {
          if ( $l.db(chanserv\ $+ $r.c($d(3)),configuracion,mlock) != $null ) { c.mlock $l.db(chanserv\ $+ $r.c($d(3)),configuracion,mlock) }
          if ( k isincs %tmp.m.p ) {
            %tmp.clave = $l.db(chanserv\ $+ $r.c($d(3)),configuracion,clave)
            s : $+ $chanserv MODE $d(3) +k $decode(%tmp.clave,m)
          }
        }
      }
      while ( %tmp.c4 < $len(%tmp.mp) ) {
        inc %tmp.c4
        if ( $mid(%tmp.mp,%tmp.c4,1) !isincs %tmp.unrealms ) { goto s.m }
        inc %tmp.c5
        %tmp.datop = $gettok(%tmp.mp2,%tmp.c5,32)
        if ( $mid(%tmp.mp,%tmp.c4,1) === q ) {
          %tmp.fundador = $l.db(chanserv\ $+ $r.c($d(3)),configuracion,fundador)
          if ( %tmp.datop != %tmp.fundador ) && ( $s.n(%tmp.datop) < 5 ) { s : $+ $chanserv MODE $d(3) -q %tmp.datop }
        }
        if ( $mid(%tmp.mp,%tmp.c4,1) === a ) {
          %tmp.sucesor = $l.db(chanserv\ $+ $r.c($d(3)),configuracion,sucesor)
          if ( %tmp.datop != %tmp.sucesor ) && ( $s.n(%tmp.datop) < 5 ) { s : $+ $chanserv MODE $d(3) -a %tmp.datop }
        }
        if ( $mid(%tmp.mp,%tmp.c4,1) === o ) {
          if ( $l.db(chanserv\ $+ $r.c($d(3)),configuracion,fundador) == $r.c(%tmp.datop) ) && ( $n.i(%tmp.datop) == si ) { %tmp.registro = 500 }
          else {
            if ( $l.db(chanserv\ $+ $r.c($d(3)),registros,$r.c(%tmp.datop)) != $null ) { %tmp.registro = $l.db(chanserv\ $+ $r.c($d(3)),registros,$r.c(%tmp.datop)) }
            else { %tmp.registro = 0 }
          }
          if ( $l.db(chanserv\ $+ $r.c($d(3)),niveles,autoop) == DIS ) { %tmp.n.autoop = 500 }
          else { %tmp.n.autoop = $l.db(chanserv\ $+ $r.c($d(3)),niveles,autoop) }
          if ( $l.db(servidores.db,servidores,$o) != $null ) || ( $l.db(chanserv\ $+ $r.c($d(3)),configuracion,secureops) == on ) {
            if ( %tmp.registro < %tmp.n.autoop ) && ( $s.n(%tmp.datop) < 5 ) { s : $+ $chanserv MODE $d(3) -o %tmp.datop }
          }
        }
        if ( $mid(%tmp.mp,%tmp.c4,1) === h ) {
          if ( $l.db(chanserv\ $+ $r.c($d(3)),configuracion,fundador) == $r.c(%tmp.datop) ) && ( $n.i(%tmp.datop) == si ) { %tmp.registro = 500 }
          else {
            if ( $l.db(chanserv\ $+ $r.c($d(3)),registros,$r.c(%tmp.datop)) != $null ) { %tmp.registro = $l.db(chanserv\ $+ $r.c($d(3)),registros,$r.c(%tmp.datop)) }
            else { %tmp.registro = 0 }
          }
          if ( $l.db(chanserv\ $+ $r.c($d(3)),niveles,autohalfop) == DIS ) { %tmp.n.autohalfop = 500 }
          else { %tmp.n.autohalfop = $l.db(chanserv\ $+ $r.c($d(3)),niveles,autohalfop) }
          if ( $l.db(servidores.db,servidores,$o) != $null ) || ( $l.db(chanserv\ $+ $r.c($d(3)),configuracion,securehalfops) == on ) {
            if ( %tmp.registro < %tmp.n.autohalfop ) && ( $s.n(%tmp.datop) < 5 ) { s : $+ $chanserv MODE $d(3) -h %tmp.datop }
          }
        }
        if ( $mid(%tmp.mp,%tmp.c4,1) === k ) {
          g.db canales.db password.c $r.c($d(3)) %tmp.datop
          if ( $l.db(chanserv\ $+ $r.c($d(3)),configuracion,clave) != $null ) {
            %tmp.clave = $decode($l.db(chanserv\ $+ $r.c($d(3)),configuracion,clave),m)
            if ( %tmp.clave === %tmp.datop ) { unset %tmp.clave }
            else {
              s : $+ $chanserv MODE $d(3) +k %tmp.clave
              g.db canales.db password.c $r.c($d(3)) %tmp.clave
            }
          }
          else {
            if ( $l.db(chanserv\ $+ $r.c($d(3)),configuracion,mlock) != $null ) { c.mlock $l.db(chanserv\ $+ $r.c($d(3)),configuracion,mlock) }
            if ( k isincs %tmp.m.n ) { s : $+ $chanserv MODE $d(3) -k %tmp.datop }
          }
        }
        :s.m
      }
      while ( %tmp.c6 < $len(%tmp.unrealmn) ) {
        inc %tmp.c6
        if ( $mid(%tmp.unrealmn,%tmp.c6,1) isincs %tmp.mp ) { %tmp.mp = $removecs(%tmp.mp,$mid(%tmp.unrealmn,%tmp.c6,1)) }
        if ( $mid(%tmp.unrealmn,%tmp.c6,1) isincs %tmp.mn ) { %tmp.mn = $removecs(%tmp.mn,$mid(%tmp.unrealmn,%tmp.c6,1)) }
      }
      if ( $l.db(chanserv\ $+ $r.c($d(3)),configuracion,mlock) != $null ) {
        %tmp.mlock = $l.db(chanserv\ $+ $r.c($d(3)),configuracion,mlock)
        if ( l isincs %tmp.mlock ) { %tmp.mlock = $removecs(%tmp.mlock,l) }
        if ( f isincs %tmp.mlock ) { %tmp.mlock = $removecs(%tmp.mlock,f) }
        s : $+ $chanserv MODE $d(3) %tmp.mlock
        if ( $l.db(chanserv\ $+ $r.c($d(3)),configuracion,limite) != $null ) {
          %tmp.limite = $l.db(chanserv\ $+ $r.c($d(3)),configuracion,limite)
          s : $+ $chanserv MODE $d(3) +l %tmp.limite
        }
      }
    }
    unset %tmp.*
  }
  if ( $d(2) == TOPIC ) {
    if ( $ca.r($d(3)) == si ) && ( $e.c($d(3)) != SUSPENDIDO ) {
      if ( $l.db(chanserv\ $+ $r.c($d(3)),configuracion,topiclock) == on ) {
        if ( $l.db(chanserv\ $+ $r.c($d(3)),configuracion,topic) != $null ) {
          %tmp.topic = $p.c($l.db(chanserv\ $+ $r.c($d(3)),configuracion,topic))
          s : $+ $chanserv TOPIC $d(3) : $+ %tmp.topic
        }
        else { s : $+ $chanserv TOPIC $d(3) : }
      }
      else {
        if ( $l.db(chanserv\ $+ $r.c($d(3)),configuracion,keeptopic) == on ) && ( $l.db(chanserv\ $+ $r.c($d(3)),configuracion,deftopic) == $null ) && ( $l.db(servidores.db,servidores,$o) == $null ) {
          if ( $mid($d(6),2) != $null ) {
            g.db chanserv\ $+ $r.c($d(3)) configuracion topic $q.c($d(6-))
            g.db chanserv\ $+ $r.c($d(3)) configuracion ptopic $r.c($o)
          }
          else {
            b.db chanserv\ $+ $r.c($d(3)) configuracion topic
            b.db chanserv\ $+ $r.c($d(3)) configuracion ptopic
          }
        }
      }
    }
  }
  if ($d(2) == 352) {
    if (%chanserv.autolimit. [ $+ [ $gettok(%datos,4,32) ] ]) {
      inc %chanserv.autolimit. [ $+ [ $gettok(%datos,4,32) ] ] 1
    }
  }
  if ($d(2) == 315) {
    if (%chanserv.autolimit. [ $+ [ $gettok(%datos,4,32) ] ]) {
      s : $+ $chanserv mode $gettok(%datos,4,32) +l %chanserv.autolimit. [ $+ [ $gettok(%datos,4,32) ] ]
      unset %chanserv.autolimit. [ $+ [ $gettok(%datos,4,32) ] ]
    }
  }
  if ($d(2) == 339) {
    if (%migrac. [ $+ [ $remove($d(9),.) ] ] || %migrac. [ $+ [ $gettok($d(5),2,58) ] ]) {
      if ($d(4) == no) && (se encuentra el bloque isin $d(5-)) {
        var %a = $remove($d(9),.)
        var %o
        if ($l.db(chanserv\ $+ $r.c(%a),configuracion,pmode)) { inc %o 2 }
        if ($l.db(chanserv\ $+ $r.c(%a),configuracion,pbans)) { inc %o 1 }
        s : $+ $chanserv %conf.metodo %migrac. [ $+ [ $remove($d(9),.) ] ] :Migrando el canal12 $remove($d(9),.) a la BDD.
        a.t C:: $+ %a $+ ::F $l.db(chanserv\ $+ $r.c(%a),configuracion,fundador)
        a.t C:: $+ %a $+ ::P $md5($l.db(chanserv\ $+ $r.c(%a),configuracion,password))
        a.t C:: $+ %a $+ ::M nt
        if (%o) { a.t C:: $+ %a $+ ::O * $+ %o }
        if ($l.db(chanserv\ $+ $r.c(%a),estado,suspendido)) { a.t C:: $+ %a $+ ::S $l.db(chanserv\ $+ $r.c(%a),estado,suspend.motivo) }
        if ($l.db(chanserv\ $+ $r.c(%a),estado,forbid)) { a.t C:: $+ %a $+ ::B $p.c($gettok($readini(database\canalesp.db,forbid,%a),2-,32)) }
        unset %migrac. [ $+ [ $remove($d(9),.) ] ]
      }
      else {
        s : $+ $chanserv %conf.metodo %migrac. [ $+ [ $gettok($d(5),2,58) ] ] :El canal12 $gettok($d(5),2,58) ya está en la BDD.
        unset %migrac. [ $+ [ $gettok($d(5),2,58) ] ]
      }
    }
  }
  if ( $d(2) == 332) && (%chanpillatopic. [ $+ [ $d(4) ] ]) {
    g.db chanserv\ $+ $r.c($d(4)) configuracion topic $q.c($d(5-))
    a.t C:: $+ $d(4) $+ ::T $d(5-)
    unset %chanpillatopic. $+ $d(4)
  }
  if ( $d(2) == 339) {
    if ( %bfounder. [ $+ [ $gettok($gettok(%datos,5,32),2,58) ] ] ) {
      if (DBQ isin $gettok(%datos,4,32)) {
        a.t $d(5)
        debugc $chanserv %conf.canal.admins 12 $+ %bfounder. [ $+ [ $gettok($gettok(%datos,5,32),2,58) ] ] borra la entrada FOUNDER del canal12 $gettok($gettok(%datos,5,32),2,58) en el UDB.
        s : $+ $chanserv %conf.metodo %bfounder. [ $+ [ $gettok($gettok(%datos,5,32),2,58) ] ] :Borrada la entrada FOUNDER del canal12 $gettok($gettok(%datos,5,32),2,58) en el UDB.
      }
      else {
        s : $+ $chanserv %conf.metodo $eval($var(bfounder.*,1),2) :4ERROR: No hay founder para el canal12 $gettok($var(bfounder.*,1),2,46) en el UDB.
      }
      unset $var(bfounder.*,1)
    }
  }
  if ( $d(2) == PRIVMSG ) || ( $d(2) == NOTICE ) && (( $d(3) == $chanserv ) || ( $d(3) == $chanserv $+ @ $+ %conf.servidor )) { p.m $chanserv | chanserv.procesa }
}

alias chanserv.procesa {
  if ( $d(4) == AYUDA ) || ( $d(4) == HELP ) { chanserv.ayuda }
  if ( $d(4) == INFO ) { chanserv.info }
  if ( $d(4) == OP ) || ( $d(4) == DEOP ) || ( $d(4) == HALFOP ) || ( $d(4) == DEHALFOP ) || ( $d(4) == VOICE ) || ( $d(4) == DEVOICE ) { chanserv.ohv $o $d(5) $d(4) $d(6) }
  if ( $d(4) == INVITE ) { chanserv.invite }
  if ( $d(4) == KICK ) { chanserv.kick }
  if ( $d(4) == UNBAN ) { chanserv.unban }
  if ( $d(4) == CLEAR ) { chanserv.clear }
  if ( $d(4) == IDENTIFY ) { chanserv.identify }
  if ( $d(4) == ACCESS ) { chanserv.access }
  if ( $d(4) == DELACCESS ) { chanserv.delaccess }
  if ( $d(4) == AKICK ) { chanserv.akick }
  if ( $d(4) == SET ) { chanserv.set | chanserv.set }
  if ( $d(4) == LEVELS ) { chanserv.levels }
  if ( $d(4) == LIST ) { c.r PO | chanserv.list }
  if ( $d(4) == DROP ) { c.r O | chanserv.drop }
  if ( $d(4) == SUSPEND ) { c.r O | chanserv.suspend }
  if ( $d(4) == UNSUSPEND ) { c.r O | chanserv.unsuspend }
  if ( $d(4) == LISTSUSPEND ) { c.r O | chanserv.listsuspend }
  if ( $d(4) == GETPASS ) { c.r CA | chanserv.getpass }
  if ( $d(4) == FORBID ) { c.r CA | chanserv.forbid }
  if ( $d(4) == UNFORBID ) { c.r CA | chanserv.unforbid }
  if ( $d(4) == LISTFORBID ) { c.r CA | chanserv.listforbid }
  if ( $d(4) == ESPECIAL ) { c.r CA | chanserv.especial }
  if ( $d(4) == BFOUNDER ) { c.r CA | chanserv.bfounder }
  if ( $d(4) == migrar ) { chanserv.migrar }
  m Comando desconocido12 $strip($d(4)) $+ . "12/msg $chanserv AYUDA" para ayuda.
  l.v
}

-------------------

alias chanserv.ayuda {
  if ($d(5)) { m.h $chanserv $o helps\ch.help $replace($d(5-),$chr(32),-) }
  else {
    m.h $chanserv $o helps\ch.help help
    if ( $s.n($o) >= 4 ) { m.h $chanserv $o helps\ch.help help-po }
    if ( $s.n($o) >= 5 ) { m.h $chanserv $o helps\ch.help help-o }
    if ( $s.n($o) >= 6 ) { m.h $chanserv $o helps\ch.help help-ca }
    if ( $s.n($o) >= 4 ) { m.h $chanserv $o helps\ch.help help-f }
  }
  l.v
}

---------------------

alias chanserv.info {
  if ( $d(5) == $null ) { m Error de Sintaxis: 12INFO <canal> | m 12/msg $chanserv AYUDA INFO para más información. | l.v }
  if ( $l.db(canalesp.db,forbid,$r.c($d(5))) != $null ) {
    m Información del canal12 $d(5) $+ :
    %tmp.forbid = $l.db(canalesp.db,forbid,$r.c($d(5)))
    %tmp.origenf = $gettok(%tmp.forbid,1,32)
    %tmp.motivo = $gettok(%tmp.forbid,2-,32)
    m Estado: 12PROHIBIDO
    m Motivo:12 $p.c(%tmp.motivo)
    if ( $s.n($o) >= 5 ) {
      m Prohibido por12 $r.c(%tmp.origenf)
    }
    goto f.i
  }
  if ( $ca.r($d(5)) == no ) { m El canal12 $d(5) no está registrado. | goto f.i }
  m Información del canal12 $d(5) $+ :
  if ( $e.c($d(5)) == SUSPENDIDO ) {
    %tmp.motivo = $p.c($l.db(chanserv\ $+ $r.c($d(5)),estado,suspend.motivo))
    m Estado: 12SUSPENDIDO
    m Motivo:12 %tmp.motivo
    if ( $s.n($o) >= 5 ) {
      %tmp.suspend.o = $r.c($l.db(chanserv\ $+ $r.c($d(5)),estado,suspend.origen))
      %tmp.suspend.f = $f($l.db(chanserv\ $+ $r.c($d(5)),estado,suspend.fecha))
      m Suspendido por12 %tmp.suspend.o
      m Fecha de la suspensión:12 %tmp.suspend.f
    }
    if ( $s.n($o) < 4 ) { goto f.i }
  }
  else { m Estado: 12ACTIVO }
  %tmp.fundador = $r.c($l.db(chanserv\ $+ $r.c($d(5)),configuracion,fundador))
  if ( $l.db(chanserv\ $+ $r.c($d(5)),configuracion,sucesor) != $null ) { %tmp.sucesor = $r.c($l.db(chanserv\ $+ $r.c($d(5)),configuracion,sucesor)) }
  %tmp.desc = $p.c($l.db(chanserv\ $+ $r.c($d(5)),configuracion,desc))
  %tmp.horareg = $f($l.db(chanserv\ $+ $r.c($d(5)),configuracion,horareg))
  %tmp.ultuso = $f($l.db(chanserv\ $+ $r.c($d(5)),configuracion,ultuso))
  m Fundador:12 %tmp.fundador $e(%tmp.fundador)
  if ( $l.db(chanserv\ $+ $r.c($d(5)),configuracion,sucesor) != $null ) { m Sucesor:12 %tmp.sucesor $e(%tmp.sucesor) }
  m Descripción:12 %tmp.desc
  m Registrado:12 %tmp.horareg
  m Ultimo uso:12 %tmp.ultuso
  if ( $l.db(chanserv\ $+ $r.c($d(5)),configuracion,private) == $null ) || (( $s.n($o) >= 5 ) && ( $d(6) == ALL )) {
    if ( $l.db(chanserv\ $+ $r.c($d(5)),configuracion,topic) != $null ) {
      %tmp.topic = $p.c($l.db(chanserv\ $+ $r.c($d(5)),configuracion,topic))
      %tmp.ptopic = $r.c($l.db(chanserv\ $+ $r.c($d(5)),configuracion,ptopic))
      %tmp.ttopic = $l.db(chanserv\ $+ $r.c($d(5)),configuracion,ttopic)
      m Ultimo tópico:12 %tmp.topic
      m Tópico ajustado por:12 %tmp.ptopic $iif(%tmp.ttopic,el12 $date(%tmp.ttopic) a las12 $time(%tmp.ttopic))
    }
  }
  if ( $s.n($o) >= 5 ) && ( $d(6) == ALL ) {
    if ( $l.db(chanserv\ $+ $r.c($d(5)),configuracion,entrymsg) != $null ) {
      %tmp.entrymsg = $p.c($l.db(chanserv\ $+ $r.c($d(5)),configuracion,entrymsg))
      m Mensaje de entrada:12 %tmp.entrymsg
    }
  }
  if ( $l.db(chanserv\ $+ $r.c($d(5)),configuracion,url) != $null ) {
    %tmp.url = $p.c($l.db(chanserv\ $+ $r.c($d(5)),configuracion,url))
    m URL:12 %tmp.url
  }
  if ( $l.db(chanserv\ $+ $r.c($d(5)),configuracion,email) != $null ) {
    %tmp.email = $p.c($l.db(chanserv\ $+ $r.c($d(5)),configuracion,email))
    m E-Mail:12 %tmp.email
  }
  %tmp.opciones = Registrado en DBs
  if ( $l.db(chanserv\ $+ $r.c($d(5)),configuracion,keeptopic) == on ) {
    if ( %tmp.opciones != $null ) { %tmp.opciones = %tmp.opciones $+ ,12 Retención de tópico }
    else { %tmp.opciones = Retención de tópico }
  }
  if ( $l.db(chanserv\ $+ $r.c($d(5)),configuracion,autolimit) ) {
    if ( %tmp.opciones != $null ) { %tmp.opciones = %tmp.opciones $+ ,12 Límite automático }
    else { %tmp.opciones = Límite automático }
  }
  if ( $l.db(chanserv\ $+ $r.c($d(5)),configuracion,topiclock) == on ) {
    if ( %tmp.opciones != $null ) { %tmp.opciones = %tmp.opciones $+ ,12 Candado de tópico }
    else { %tmp.opciones = Candado de tópico }
  }
  if ( $l.db(chanserv\ $+ $r.c($d(5)),configuracion,deftopic) == on ) {
    if ( %tmp.opciones != $null ) { %tmp.opciones = %tmp.opciones $+ ,12 Tópico por defecto }
    else { %tmp.opciones = Tópico por defecto }
  }
  if ( $l.db(chanserv\ $+ $r.c($d(5)),configuracion,private) == on ) {
    if ( %tmp.opciones != $null ) { %tmp.opciones = %tmp.opciones $+ ,12 Privado }
    else { %tmp.opciones = Privado }
  }
  if ( $l.db(chanserv\ $+ $r.c($d(5)),configuracion,restricted) == on ) {
    if ( %tmp.opciones != $null ) { %tmp.opciones = %tmp.opciones $+ ,12 Acceso restringido }
    else { %tmp.opciones = Acceso restringido }
  }
  if ( $l.db(chanserv\ $+ $r.c($d(5)),configuracion,secure) == on ) {
    if ( %tmp.opciones != $null ) { %tmp.opciones = %tmp.opciones $+ ,12 Seguro }
    else { %tmp.opciones = Seguro }
  }
  if ( $l.db(chanserv\ $+ $r.c($d(5)),configuracion,securehalfops) == on ) {
    if ( %tmp.opciones != $null ) { %tmp.opciones = %tmp.opciones $+ ,12 Secure HalfOps }
    else { %tmp.opciones = Secure HalfOps }
  }
  if ( $l.db(chanserv\ $+ $r.c($d(5)),configuracion,secureops) == on ) {
    if ( %tmp.opciones != $null ) { %tmp.opciones = %tmp.opciones $+ ,12 Secure Ops }
    else { %tmp.opciones = Secure Ops }
  }
  if ( %tmp.opciones == $null ) { %tmp.opciones = Ninguna }
  m Opciones:12 %tmp.opciones
  if ( $l.db(chanserv\ $+ $r.c($d(5)),configuracion,mlock) != $null ) {
    %tmp.mlock = $l.db(chanserv\ $+ $r.c($d(5)),configuracion,mlock)
    %tmp.mlock = $gettok(%tmp.mlock,1,32)
    m Candado de modo:12 %tmp.mlock
  }
  if ( $l.db(chanserv\ $+ $r.c($d(5)),configuracion,noexpire) == on ) && ( $s.n($o) >= 5 ) { m Este canal tiene el 12No-Expire activado. }
  :f.i
  m Fin de INFO
  l.v
}

alias chanserv.ohv {
  if ($3 == $null) { m Error de Sintaxis:12 <opción> <canal> <nick> | m 12/msg $chanserv AYUDA para más información. | l.v }
  if ( $4 == $null ) { m Error de Sintaxis:12 $3 <canal> <nick> | m 12/msg $chanserv AYUDA $3 para más información. | l.v }
  if ( $ca.r($2) == no ) { m El canal12 $2 no está registrado. | l.v }
  if ( $e.c($2) == SUSPENDIDO ) { m El canal12 $2 está suspendido. | l.v }
  if ( $n.i($1) == no ) { m Debes identificarte antes de utilizar el comando12 $3 $+ . | l.v }
  if ( $u.c($4,$2) == no ) { m El usuario12 $4 no está en el canal. | l.v }
  if ( $l.db(nickserv\ $+ $r.c($1),ifundador,$r.c($2)) == $null ) && ( $l.db(chanserv\ $+ $r.c($2),registros,$r.c($1)) == $null ) && ( $l.db(chanserv\ $+ $r.c($2),configuracion,fundador) != $r.c($1) ) && ( $s.n($1) < 5 ) { goto p.d }
  if ( $n.i($4) == si ) && ( $l.db(chanserv\ $+ $r.c($2),registros,$r.c($4)) != $null ) { %tmp.registro.d = $l.db(chanserv\ $+ $r.c($2),registros,$r.c($4)) }
  if ( $l.db(nickserv\ $+ $r.c($1),ifundador,$r.c($2)) != $null ) || ( $l.db(chanserv\ $+ $r.c($2),configuracion,fundador) == $r.c($1) ) || ( $s.n($1) >= 5 ) { %tmp.registro.o = 500 }
  else { %tmp.registro.o = $l.db(chanserv\ $+ $r.c($2),registros,$r.c($1)) }
  if ( $s.n($4) >= 5 ) { %tmp.registro.d = 500 }
  if ( $l.db(chanserv\ $+ $r.c($2),niveles,opdeop) == DIS ) { %tmp.opdeop = 500 }
  else { %tmp.opdeop = $l.db(chanserv\ $+ $r.c($2),niveles,opdeop) }
  if ( $3 == OP ) {
    if ( %tmp.registro.o < %tmp.opdeop ) { goto p.d }
    if ( $l.db(chanserv\ $+ $r.c($2),configuracion,secureops) == on ) {
      if ( %tmp.registro.d >= %tmp.opdeop || %tmp.registro.o >= %tmp.opdeop ) { s : $+ $chanserv MODE $2 +o $4 | goto f.c }
      goto p.d
    }
    else {
      if ( %tmp.registro.o < %tmp.opdeop ) { goto p.d }
      s : $+ $chanserv MODE $2 +o $4
      goto f.c
    }
  }
  if ( $3 == DEOP ) {
    if ( %tmp.registro.o < %tmp.opdeop ) || ( %tmp.registro.o < %tmp.registro.d ) { goto p.d }
    s : $+ $chanserv MODE $2 -o $4
    goto f.c
  }
  if ( $l.db(chanserv\ $+ $r.c($2),niveles,halfopdehalfop) == DIS ) { %tmp.halfopdehalfop = 500 }
  else { %tmp.halfopdehalfop = $l.db(chanserv\ $+ $r.c($2),niveles,halfopdehalfop) }
  if ( $3 == HALFOP ) {
    if ( %tmp.registro.o < %tmp.halfopdehalfop ) { goto p.d }
    if ( $l.db(chanserv\ $+ $r.c($2),configuracion,securehalfops) == on ) {
      if ( %tmp.registro.d >= %tmp.halfopdehalfop ) { s : $+ $chanserv MODE $2 +h $4 | goto f.c }
      goto p.d
    }
    else {
      if ( %tmp.registro.o < %tmp.halfopdehalfop ) { goto p.d }
      s : $+ $chanserv MODE $2 +h $4
      goto f.c
    }
  }
  if ( $3 == DEHALFOP ) {
    if ( %tmp.registro.o < %tmp.halfopdehalfop ) || ( %tmp.registro.o < %tmp.registro.d ) { goto p.d }
    s : $+ $chanserv MODE $2 -h $4
    goto f.c
  }
  if ( $l.db(chanserv\ $+ $r.c($2),niveles,voicedevoice) == DIS ) { %tmp.voicedevoice = 500 }
  else { %tmp.voicedevoice = $l.db(chanserv\ $+ $r.c($2),niveles,voicedevoice) }
  if ( $3 == VOICE ) {
    if ( %tmp.registro.o < %tmp.voicedevoice ) { goto p.d }
    s : $+ $chanserv MODE $2 +v $4
    goto f.c
  }
  if ( $3 == DEVOICE ) {
    if ( %tmp.registro.o < %tmp.voicedevoice ) || ( %tmp.registro.o < %tmp.registro.d ) { goto p.d }
    s : $+ $chanserv MODE $2 -v $4
  }
  :f.c
  chanserv.notice $2 $1 hace $upper($3) a $4 $+ .
  l.v
  :p.d
  m 4Permiso denegado.
  l.v
}

alias chanserv.invite {
  if ( $d(5) == $null ) { m Error de Sintaxis:12 INVITE <canal> | m 12/msg $chanserv AYUDA INVITE para más información. | l.v }
  if ( $ca.r($d(5)) == no ) { m El canal12 $d(5) no está registrado. | l.v }
  if ( $e.c($d(5)) == SUSPENDIDO ) { m El canal12 $d(5) está suspendido. | l.v }
  if ( $n.i($o) == no ) { m Debes identificarte antes de utilizar el comando12 INVITE. | l.v }
  if ( $l.db(nickserv\ $+ $r.c($o),ifundador,$r.c($d(5))) == $null ) && ( $l.db(chanserv\ $+ $r.c($d(5)),registros,$r.c($o)) == $null ) && ( $l.db(chanserv\ $+ $r.c($d(5)),configuracion,fundador) != $r.c($o) ) && ( $s.n($o) < 5 ) { m 4Permiso denegado. | l.v }
  if ( $l.db(nickserv\ $+ $r.c($o),ifundador,$r.c($d(5))) != $null ) || ( $l.db(chanserv\ $+ $r.c($d(5)),configuracion,fundador) == $r.c($o) ) || ( $s.n($o) >= 5 ) { %tmp.registro.o = 500 }
  else { %tmp.registro.o = $l.db(chanserv\ $+ $r.c($d(5)),registros,$r.c($o)) }
  if ( $l.db(chanserv\ $+ $r.c($d(5)),niveles,invite) == DIS ) { %tmp.invite = 500 }
  else { %tmp.invite = $l.db(chanserv\ $+ $r.c($d(5)),niveles,invite) }
  if ( %tmp.registro.o < %tmp.invite ) { m 4Permiso denegado. | l.v }
  if ( $u.c($o,$d(5)) == si ) { m Ya estás dentro del canal. | l.v }
  s : $+ $chanserv INVITE $o $d(5)
  chanserv.notice $d(5) $o se invita al canal.
  l.v
}

alias chanserv.kick {
  if ( $d(7) == $null ) { m Error de Sintaxis:12 KICK <canal> <nick> <motivo> | m 12/msg $chanserv AYUDA KICK para más información. | l.v }
  if ( $ca.r($d(5)) == no ) { m El canal12 $d(5) no está registrado. | l.v }
  if ( $e.c($d(5)) == SUSPENDIDO ) { m El canal12 $d(5) está suspendido. | l.v }
  if ( $n.i($o) == no ) { m Debes identificarte antes de utilizar el comando12 KICK. | l.v }
  if ( $l.db(nickserv\ $+ $r.c($o),ifundador,$r.c($d(5))) == $null ) && ( $l.db(chanserv\ $+ $r.c($d(5)),registros,$r.c($o)) == $null ) && ( $l.db(chanserv\ $+ $r.c($d(5)),configuracion,fundador) != $r.c($o) ) && ( $s.n($o) < 5 ) { m 4Permiso denegado. | l.v }
  if ( $n.i($d(6)) == si ) && ( $l.db(chanserv\ $+ $r.c($d(5)),registros,$r.c($d(6))) != $null ) { %tmp.registro.d = $l.db(chanserv\ $+ $r.c($d(5)),registros,$r.c($d(6))) }
  if ( $l.db(nickserv\ $+ $r.c($o),ifundador,$r.c($d(5))) != $null ) || ( $l.db(chanserv\ $+ $d(5),configuracion,fundador) == $r.c($o) ) || ( $s.n($o) >= 5 ) { %tmp.registro.o = 500 }
  else { %tmp.registro.o = $l.db(chanserv\ $+ $d(5),registros,$r.c($o)) }
  if ( $s.n($d(6)) >= 5 ) { %tmp.registro.d = 500 }
  if ($l.db(bots.db,bots,$d(6))) { %tmp.registro.d = 555 }
  if ( $l.db(chanserv\ $+ $d(5),niveles,kick) == DIS ) { %tmp.kick = 500 }
  else { %tmp.kick = $l.db(chanserv\ $+ $d(5),niveles,kick) }
  if ( %tmp.registro.o < %tmp.kick ) || ( %tmp.registro.o < %tmp.registro.d ) || ( $s.n($d(6)) >= 5 ) { m 4Permiso denegado. | l.v }
  k.c $d(5) $d(6) $o $+ > $d(7-)
  chanserv.notice $d(5) $o utiliza KICK contra $d(6) $+ .
  l.v
}

alias chanserv.unban {
  if ( $d(5) == $null ) { m Error de Sintaxis:12 UNBAN <canal> | m 12/msg $chanserv AYUDA UNBAN para más información. | l.v }
  if ( $ca.r($d(5)) == no ) { m El canal12 $d(5) no está registrado. | l.v }
  if ( $e.c($d(5)) == SUSPENDIDO ) { m El canal12 $d(5) está suspendido. | l.v }
  if ( $n.i($o) == no ) { m Debes identificarte antes de utilizar el comando12 UNBAN. | l.v }
  if ( $l.db(nickserv\ $+ $r.c($o),ifundador,$r.c($d(5))) == $null ) && ( $l.db(chanserv\ $+ $r.c($d(5)),registros,$r.c($o)) == $null ) && ( $l.db(chanserv\ $+ $r.c($d(5)),configuracion,fundador) != $r.c($o) ) && ( $s.n($o) < 5 ) { m 4Permiso denegado. | l.v }
  if ( $l.db(nickserv\ $+ $r.c($o),ifundador,$r.c($d(5))) != $null ) || ( $l.db(chanserv\ $+ $r.c($d(5)),configuracion,fundador) == $r.c($o) ) || ( $s.n($o) >= 5 ) { %tmp.registro.o = 500 }
  else { %tmp.registro.o = $l.db(chanserv\ $+ $r.c($d(5)),registros,$r.c($o)) }
  if ( $l.db(chanserv\ $+ $r.c($d(5)),niveles,unban) == DIS ) { %tmp.unban = 500 }
  else { %tmp.unban = $l.db(chanserv\ $+ $r.c($d(5)),niveles,unban) }
  if ( %tmp.registro.o < %tmp.unban ) { m 4Permiso denegado. | l.v }
  s : $+ $chanserv MODE $d(5) -b $o
  m Has sido desbaneado de12 $d(5) $+ .
  l.v
}

alias chanserv.clear {
  if ( $d(6) == $null ) { m Error de Sintaxis: 12CLEAR <canal> <opción> | m 12/msg $chanserv AYUDA CLEAR para más información. | l.v }
  if ( $ca.r($d(5)) == no ) { m El canal12 $d(5) no está registrado. | l.v }
  if ( $e.c($d(5)) == SUSPENDIDO ) { m El canal12 $d(5) está suspendido. | l.v }
  if ( $n.i($o) == no ) { m Debes identificarte antes de utilizar el comando12 CLEAR. | l.v }
  if ( $l.db(nickserv\ $+ $r.c($o),ifundador,$r.c($d(5))) == $null ) && ( $l.db(chanserv\ $+ $r.c($d(5)),registros,$r.c($o)) == $null ) && ( $l.db(chanserv\ $+ $r.c($d(5)),configuracion,fundador) != $r.c($o) ) && ( $s.n($o) < 5 ) {
    m 4Permiso denegado.
    l.v
  }
  if ( $l.db(nickserv\ $+ $r.c($o),ifundador,$r.c($d(5))) != $null ) || ( $l.db(chanserv\ $+ $r.c($d(5)),configuracion,fundador) == $r.c($o) ) || ( $s.n($o) >= 5 ) { %tmp.registro.o = 500 }
  else { %tmp.registro.o = $l.db(chanserv\ $+ $r.c($d(5)),registros,$r.c($o)) }
  if ( $l.db(chanserv\ $+ $r.c($d(5)),niveles,clear) == DIS ) { %tmp.clear = 500 }
  else { %tmp.clear = $l.db(chanserv\ $+ $r.c($d(5)),niveles,clear) }
  if ( %tmp.registro.o < %tmp.clear ) {
    m 4Permiso denegado.
    l.v
  }
  if ( $d(6) == MODES ) {
    if ( $l.db(chanserv\ $+ $r.c($d(5)),configuracion,mlock) == $null ) {
      s : $+ $chanserv MODE $d(5) -ntimlpsRMG
      m Todos los modos en canal12 $d(5) han sido borrados.
      l.v
    }
    else {
      m 4Permiso denegado.
      l.v
    }
  }
  if ( $d(6) == BANS ) {
    s : $+ $chanserv SVSMODE $d(5) b
    m Todos los bans en canal12 $d(5) han sido borrados.
    l.v
  }
  if ( $d(6) == OPS ) {
    %tipo.who = OPS
    s : $+ $chanserv WHO $d(5)
    m Modo +o de operadores han sido desactivados del canal12 $d(5) $+ .
    l.v
  }
  if ( $d(6) == HALFOPS ) {
    %tipo.who = HALFOPS
    s : $+ $chanserv WHO $d(5)
    m Modo +h de operadores han sido desactivados del canal12 $d(5) $+ .
    l.v
  }
  if ( $d(6) == VOICES ) {
    %tipo.who = VOICES
    s : $+ $chanserv WHO $d(5)
    m Modo +v de operadores han sido desactivados del canal12 $d(5) $+ .
    l.v
  }
  if ( $d(6) == USERS ) {
    %tipo.who = USERS
    %who.origen = $o
    s : $+ $chanserv WHO $d(5)
    m Todos los usuarios han sido expulsados del canal12 $d(5) $+ .
    l.v
  }
  if ( $d(6) == TOPIC ) {
    if ( $l.db(chanserv\ $+ $r.c($d(5)),configuracion,topic) != $null ) {
      %tmp.topic = $p.c($l.db(chanserv\ $+ $r.c($d(5)),configuracion,topic))
      s : $+ $chanserv TOPIC $d(5) : $+ %tmp.topic
    }
    else { s : $+ $chanserv TOPIC $d(5) : }
    m Tópico de12 $d(5) restaurado.
    l.v
  }
  m Error de Sintaxis: 12CLEAR <canal> <opción>
  m 12/msg $chanserv AYUDA CLEAR para más información.
  l.v
}

alias chanserv.identify {
  if ( $d(6) == $null ) { m Error de Sintaxis: 12IDENTIFY <canal> <contraseña> | m 12/msg $chanserv AYUDA IDENTIFY para más información. | l.v }
  if ( $ca.r($d(5)) == no ) { m El canal12 $d(5) no está registrado. | l.v }
  if ( $e.c($d(5)) == SUSPENDIDO ) { m El canal12 $d(5) está suspendido. | l.v }
  if ( $n.i($o) == no ) { m Debes identificarte antes de utilizar el comando12 IDENTIFY. | l.v }
  if ( $l.db(nickserv\ $+ $r.c($o),ifundador,$r.c($d(5))) != $null ) { m Ya estás identificado como fundador. | l.v }
  if ( $l.db(chanserv\ $+ $r.c($d(5)),configuracion,password) === $d(6) ) {
    g.db nickserv\ $+ $r.c($o) ifundador $r.c($d(5)) *
    m Contraseña aceptada, eres reconocido con nivel de fundador de12 $d(5) $+ .
    chanserv.notice $d(5) 4¡ATENCION! $o se identifica como fundador del canal.
    s : $+ $chanserv MODE $d(5) +qo $o $o
    l.v
  }
  else {
    m 4Contraseña incorrecta.
    chanserv.notice $d(5) 4¡ATENCION! Autentificación con clave incorrecta de $o $+ .
    if ( $l.db(nickserv\ $+ $r.c($o),cfundador,$d(5)) != $null ) {
      %tmp.intentos = $l.db(nickserv\ $+ $r.c($o),cfundador,$r.c($d(5)))
      inc %tmp.intentos
      if ( %tmp.intentos == 3 ) {
        k $chanserv $o Muchas contraseñas incorrectas.
        %tmp.fundador = $r.c($l.db(chanserv\ $+ $r.c($d(5)),configuracion,fundador))
        memoserv.envia %tmp.fundador $chanserv Se le informa de que el nick12 $o ha intentado 3 veces identificarse como fundador de su canal12 $d(5) con contraseña incorrecta, podría haberse tratado de un intento de robo de su canal. Recomendamos que informe a un representante de la red si esto se repite con frecuencia y cambie su contraseña para mayor seguridad mediante el comando 12/msg $chanserv SET $d(5) PASSWORD <nueva-contraseña>
        l.v
      }
      g.db nickserv\ $+ $r.c($o) cfundador $r.c($d(5)) %tmp.intentos
    }
    else { g.db nickserv\ $+ $r.c($o) cfundador $r.c($d(5)) 1 }
    l.v
  }
}

alias chanserv.access {
  if ( $d(6) == $null ) { m Error de Sintaxis: 12ACCESS <canal> $chr(123) $+ ADD $chr(124) DEL $chr(124) LIST $+ $chr(125) <nick> <nivel> | m 12/msg $chanserv AYUDA ACCESS para más información. | l.v }
  if ( $ca.r($d(5)) == no ) { m El canal12 $d(5) no está registrado. | l.v }
  if ( $e.c($d(5)) == SUSPENDIDO ) { m El canal12 $d(5) está suspendido. | l.v }
  if ( $n.i($o) == no ) { m Debes identificarte antes de utilizar el comando12 ACCESS. | l.v }
  if ( $l.db(nickserv\ $+ $r.c($o),ifundador,$r.c($d(5))) == $null ) && ( $l.db(chanserv\ $+ $r.c($d(5)),registros,$r.c($o)) == $null ) && ( $l.db(chanserv\ $+ $r.c($d(5)),configuracion,fundador) != $r.c($o) ) && ( $s.n($o) < 5 ) { goto p.d }
  if ( $l.db(nickserv\ $+ $r.c($o),ifundador,$r.c($d(5))) != $null ) || ( $l.db(chanserv\ $+ $r.c($d(5)),configuracion,fundador) == $r.c($o) ) || ( $s.n($o) >= 5 ) { %tmp.registro.o = 500 }
  else { %tmp.registro.o = $l.db(chanserv\ $+ $r.c($d(5)),registros,$r.c($o)) }
  if ( %tmp.registro.o == $null ) { %tmp.registro.o = 0 }
  if ( $l.db(chanserv\ $+ $r.c($d(5)),niveles,acc-change) == DIS ) { %tmp.acc-change = 500 }
  else { %tmp.acc-change = $l.db(chanserv\ $+ $r.c($d(5)),niveles,acc-change) }
  if ( $d(6) == ADD ) {
    if ( $d(8) == $null ) { m Error de Sintaxis: 12ACCESS <canal> ADD <nick> <nivel> | m 12/msg $chanserv AYUDA ACCESS para más información. | l.v }
    if ( %tmp.registro.o < %tmp.acc-change ) { goto p.d }
    if ( $n.r($d(7)) == no ) { m El nick12 $d(7) no está registrado. | l.v }
    if ( $d(8) !isnum ) { m El nivel del registro debe de ser un número. | l.v }
    if ( $d(8) < -1 ) || ( $d(8) > 499 ) { m El nivel de registro debe estar comprendido entre -1 y 499. | l.v }
    if ( $l.db(chanserv\ $+ $r.c($d(5)),registros,$r.c($d(7))) != $null ) {
      %tmp.registro.d = $l.db(chanserv\ $+ $r.c($d(5)),registros,$r.c($d(7)))
      if ( %tmp.registro.o < %tmp.registro.d ) || ( $d(8) >= %tmp.registro.o ) { goto p.d }
      if ( %tmp.registro.d == $d(8) ) { m El Nivel de acceso para12 $d(7) en12 $d(5) no ha cambiado de12 $d(8) $+ . | l.v }
      if ( $s.n($o) >= 5 ) {
        if ( $l.db(chanserv\ $+ $r.c($d(5)),registros,$r.c($o)) != $null ) { %tmp.registro.o2 = $l.db(chanserv\ $+ $r.c($d(5)),registros,$r.c($o)) }
        else { %tmp.registro.o2 = 0 }
        if ( %tmp.registro.o2 < %tmp.acc-change ) && ( $l.db(chanserv\ $+ $r.c($d(5)),configuracion,fundador) != $r.c($o) ) { debugc $chanserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o ha utilizado ACCESS $d(5) ADD $d(7) $d(8) 4(como OPER) }
      }
      %tmp.registro.n = $int($d(8))
      chanserv.a.a $d(5) $d(7) %tmp.registro.n
      m El Nivel de acceso para12 $d(7) en12 $d(5) ha sido cambiado a12 %tmp.registro.n $+ .
      chanserv.notice $d(5) $o cambia en $d(5) nivel de $d(7) a %tmp.registro.n
      l.v
    }
    if ( $l.db(chanserv\ $+ $r.c($d(5)),stats,numero.regs) >= 500 ) { m Superado el número máximo de registros del canal. | l.v }
    if ( $s.n($o) >= 5 ) {
      if ( $l.db(chanserv\ $+ $r.c($d(5)),registros,$r.c($o)) != $null ) { %tmp.registro.o2 = $l.db(chanserv\ $+ $r.c($d(5)),registros,$r.c($o)) }
      else { %tmp.registro.o2 = 0 }
      if ( %tmp.registro.o2 < %tmp.acc-change ) && ( $l.db(chanserv\ $+ $r.c($d(5)),configuracion,fundador) != $r.c($o) ) { debugc $chanserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o ha utilizado ACCESS $d(5) ADD $d(7) $d(8) 4(como OPER) }
    }
    %tmp.registro.n = $int($d(8))
    chanserv.a.a $d(5) $d(7) %tmp.registro.n
    m 12 $+ $d(7) agregado a lista de acceso de12 $d(5) con nivel12 %tmp.registro.n $+ .
    chanserv.notice $d(5) $o añade en $d(5) a $d(7) con nivel %tmp.registro.n
    l.v
  }
  if ( $d(6) == DEL ) {
    if ( $d(7) == $null ) { m Error de Sintaxis: 12ACCESS <canal> DEL <nick> | m 12/msg $chanserv AYUDA ACCESS para más información. | l.v }
    %tmp.registro.d = $l.db(chanserv\ $+ $r.c($d(5)),registros,$r.c($d(7)))
    if ( %tmp.registro.o < %tmp.acc-change ) || ( %tmp.registro.o < %tmp.registro.d ) { goto p.d }
    if ( $l.db(chanserv\ $+ $r.c($d(5)),registros,$r.c($d(7))) == $null ) { m 12 $+ $d(7) no fue encontrado en la lista de acceso de12 $d(5) $+ . | l.v }
    if ( $s.n($o) >= 5 ) {
      if ( $l.db(chanserv\ $+ $r.c($d(5)),registros,$r.c($o)) != $null ) { %tmp.registro.o2 = $l.db(chanserv\ $+ $r.c($d(5)),registros,$r.c($o)) }
      else { %tmp.registro.o2 = 0 }
      if ( %tmp.registro.o2 < %tmp.acc-change ) && ( $l.db(chanserv\ $+ $r.c($d(5)),configuracion,fundador) != $r.c($o) ) { debugc $chanserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o ha utilizado ACCESS $d(5) DEL $d(7) 4(como OPER) }
    }
    chanserv.b.a $d(5) $d(7)
    m 12 $+ $d(7) borrado de la lista de acceso de12 $d(5) $+ .
    chanserv.notice $d(5) $o quita de $d(5) a $d(7) $+ .
    l.v
  }
  if ( $d(6) == LIST ) {
    if ( $l.db(chanserv\ $+ $r.c($d(5)),niveles,acc-list) == DIS ) { %tmp.list = 500 }
    else { %tmp.acc-list = $l.db(chanserv\ $+ $r.c($d(5)),niveles,acc-list) }
    if ( %tmp.registro.o < %tmp.acc-list ) { goto p.d }
    m Lista de acceso de12 $d(5) $+ :
    flushini $mircdirdatabase\chanserv\ $+ $r.c($d(5))
    %tmp.ruta = $mircdirdatabase\chanserv\ $+ $r.c($d(5))
    if ( $initopic( %tmp.ruta , registros ) == 0 ) { m Lista vacia. }
    else {
      clear @registrosc
      window -hl @registrosc
      loadbuf -tregistros @registrosc $mircdirdatabase\chanserv\ $+ $r.c($d(5))
      %tmp.total = $line(@registrosc,0)
      %tmp.linea = 0
      if ( $d(7) != $null ) {
        while ( %tmp.linea < %tmp.total ) {
          inc %tmp.linea
          %tmp.l.linea = $line( @registrosc , %tmp.linea )
          if ( $d(7) iswm $gettok(%tmp.l.linea,1,61) ) {
            %tmp.rsdatos = $r.c($gettok(%tmp.l.linea,1,61))
            %tmp.rsdatos2 = $gettok(%tmp.l.linea,2,61)
            m Nick:12 %tmp.rsdatos - Nivel:12 %tmp.rsdatos2
          }
        }
      }
      else {
        while ( %tmp.linea < %tmp.total ) {
          inc %tmp.linea
          %tmp.l.linea = $line( @registrosc , %tmp.linea )
          %tmp.rsdatos = $r.c($gettok(%tmp.l.linea,1,61))
          %tmp.rsdatos2 = $gettok(%tmp.l.linea,2,61)
          m Nick:12 %tmp.rsdatos - Nivel:12 %tmp.rsdatos2
        }
      }
      :f.r
      m Fin de la lista.
    }
    l.v
  }
  if ( $d(6) == CLEAR ) {
    if ( $l.db(nickserv\ $+ $r.c($o),ifundador,$r.c($d(5))) == $null ) && ( $l.db(chanserv\ $+ $r.c($d(5)),configuracion,fundador) != $r.c($o) ) && ( $s.n($o) < 5 ) { goto p.d }
    flushini $mircdirdatabase\chanserv\ $+ $r.c($d(5))
    %tmp.ruta = $mircdirdatabase\chanserv\ $+ $r.c($d(5))
    if ( $initopic( %tmp.ruta , registros ) == 0 ) { goto f.lr }
    clear @lregistrosc
    window -hl @lregistrosc
    loadbuf -tregistros @lregistrosc $mircdirdatabase\chanserv\ $+ $r.c($d(5))
    %tmp.total = $line(@lregistrosc,0)
    %tmp.linea = 0
    while ( %tmp.linea < %tmp.total ) {
      inc %tmp.linea
      %tmp.l.linea = $line( @lregistrosc , %tmp.linea )
      %tmp.nick = $r.c($gettok(%tmp.l.linea,1,61))
      chanserv.b.a $d(5) %tmp.nick
    }
    :f.lr
    m Los registros del canal12 $d(5) han sido borrados.
    debugc $chanserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o borra todos los registros del canal12 $d(5) $+ .
    l.v
  }
  m Error de Sintaxis: 12ACCESS <canal> $chr(123) $+ ADD $chr(124) DEL $chr(124) LIST $chr(124) CLEAR $+ $chr(125) <nick> <nivel>
  m 12/msg $chanserv AYUDA ACCESS para más información.
  l.v
  :p.d
  m 4Permiso denegado.
  l.v
}

alias chanserv.delaccess {
  if ( $d(5) == $null ) { m Error de Sintaxis: 12DELACCESS <canal> | m 12/msg $chanserv AYUDA DELACCESS para más información. | l.v }
  if ( $ca.r($d(5)) == no ) { m El canal12 $d(5) no está registrado. | l.v }
  if ( $n.i($o) == no ) { m Debes identificarte antes de utilizar el comando 12DELACCESS. | l.v }
  if ( $l.db(chanserv\ $+ $r.c($d(5)),registros,$r.c($o)) == $null ) { m Tu nick no fue encontrado en la lista de acceso de12 $d(5) $+. | l.v }
  %tmp.registro = $l.db(chanserv\ $+ $r.c($d(5)),registros,$r.c($o))
  if ( %tmp.registro == -1 ) && ( $l.db(chanserv\ $+ $r.c($d(5)),configuracion,fundador) != $r.c($o) ) { m 4Permiso denegado. | l.v }
  chanserv.b.a $d(5) $o
  m Tu registro ha sido borrado del canal12 $d(5) $+ .
  chanserv.notice $d(5) $o se quita el registro en el canal.
  l.v
}

alias chanserv.akick {
  if ( $d(6) == $null ) { m Error de Sintaxis: 12AKICK <canal> $chr(123) $+ ADD $chr(124) DEL $chr(124) LIST $chr(124) ENFORCE $+ $chr(125) <nick> <motivo> | m 12/msg $chanserv AYUDA AKICK para más información. | l.v }
  if ( $ca.r($d(5)) == no ) { m El canal12 $d(5) no está registrado. | l.v }
  if ( $e.c($d(5)) == SUSPENDIDO ) { m El canal12 $d(5) está suspendido. | l.v }
  if ( $n.i($o) == no ) { m Debes identificarte antes de utilizar el comando12 AKICK. | l.v }
  if ( $l.db(nickserv\ $+ $r.c($o),ifundador,$r.c($d(5))) == $null ) && ( $l.db(chanserv\ $+ $r.c($d(5)),registros,$r.c($o)) == $null ) && ( $l.db(chanserv\ $+ $r.c($d(5)),configuracion,fundador) != $r.c($o) ) && ( $s.n($o) < 5 ) { goto p.d }
  if ( $l.db(nickserv\ $+ $r.c($o),ifundador,$r.c($d(5))) != $null ) || ( $l.db(chanserv\ $+ $r.c($d(5)),configuracion,fundador) == $r.c($o) ) || ( $s.n($o) >= 5 ) { %tmp.registro.o = 500 }
  else { %tmp.registro.o = $l.db(chanserv\ $+ $r.c($d(5)),registros,$r.c($o)) }
  if ( %tmp.registro.o == $null ) { %tmp.registro.o = 0 }
  if ( $l.db(chanserv\ $+ $r.c($d(5)),niveles,akick) == DIS ) { %tmp.akick = 500 }
  else { %tmp.akick = $l.db(chanserv\ $+ $r.c($d(5)),niveles,akick) }
  if ( $d(6) == ADD ) {
    if ( $d(7) == $null ) { m Error de Sintaxis: 12AKICK <canal> ADD <nick> <motivo> | m 12/msg $chanserv AYUDA AKICK para más información. | l.v }
    if ( %tmp.registro.o < %tmp.akick ) { goto p.d }
    if ( $n.r($d(7)) == no ) { m El nick12 $d(7) no está registrado. | l.v }
    if ( $l.db(chanserv\ $+ $r.c($d(5)),akicks,$r.c($d(7))) != $null ) { m 12 $+ $d(7) ya existe en la lista de autokicks de12 $d(5) $+ . | l.v }
    if ( $l.db(chanserv\ $+ $r.c($d(5)),stats,numero.akicks) >= 50 ) { m Superado el número máximo de akicks del canal. | l.v }
    if ( $d(8) == $null ) { %tmp.motivo = $l.conf(chanserv,makick) }
    else { %tmp.motivo = $q.c($d(8-)) }
    chanserv.a.ak $d(5) $d(7) $r.c($o) %tmp.motivo
    m 12 $+ $d(7) agregado a la lista de autokick de12 $d(5) $+ .
    l.v
  }
  if ( $d(6) == DEL ) {
    if ( $d(7) == $null ) { m Error de Sintaxis: 12AKICK <canal> DEL <nick> | m 12/msg $chanserv AYUDA AKICK para más información. | l.v }
    if ( %tmp.registro.o < %tmp.akick ) { goto p.d }
    if ( $l.db(chanserv\ $+ $r.c($d(5)),akicks,$r.c($d(7))) == $null ) { m 12 $+ $d(7) no existe en la lista de autokicks de12 $d(5) $+ . | l.v }
    chanserv.b.ak $d(5) $d(7)
    m 12 $+ $d(7) borrado de la lista de autokick de12 $d(5) $+ .
    l.v
  }
  if ( $d(6) == LIST ) {
    if ( %tmp.registro.o < %tmp.akick ) { goto p.d }
    m Lista de autokick de12 $d(5) $+ :
    flushini $mircdirdatabase\chanserv\ $+ $r.c($d(5))
    %tmp.ruta = $mircdirdatabase\chanserv\ $+ $r.c($d(5))
    if ( $initopic( %tmp.ruta , akicks ) == 0 ) { m Lista vacia. }
    else {
      clear @akicksc
      window -hl @akicksc
      loadbuf -takicks @akicksc $mircdirdatabase\chanserv\ $+ $r.c($d(5))
      %tmp.total = $line(@akicksc,0)
      %tmp.linea = 0
      if ( $d(7) != $null ) {
        while ( %tmp.linea < %tmp.total ) {
          inc %tmp.linea
          %tmp.l.linea = $line( @akicksc , %tmp.linea )
          if ( $d(7) iswm $gettok(%tmp.l.linea,1,61) ) {
            %tmp.rsdatos = $r.c($gettok(%tmp.l.linea,1,61))
            %tmp.rsdatos2 = $gettok(%tmp.l.linea,2,61)
            %tmp.rdatos3 = $r.c($gettok(%tmp.rsdatos2,1,32))
            %tmp.rdatos4 = $p.c($gettok(%tmp.rsdatos2,2-,32))
            m Nick:12 %tmp.rsdatos - Motivo:12 ( $+ %tmp.rdatos3 $+ ) -> %tmp.rdatos4
          }
        }
      }
      else {
        while ( %tmp.linea < %tmp.total ) {
          inc %tmp.linea
          %tmp.l.linea = $line( @akicksc , %tmp.linea )
          %tmp.rsdatos = $r.c($gettok(%tmp.l.linea,1,61))
          %tmp.rsdatos2 = $gettok(%tmp.l.linea,2,61)
          %tmp.rdatos3 = $r.c($gettok(%tmp.rsdatos2,1,32))
          %tmp.rdatos4 = $p.c($gettok(%tmp.rsdatos2,2-,32))
          m Nick:12 %tmp.rsdatos - Motivo:12 ( $+ %tmp.rdatos3 $+ ) -> %tmp.rdatos4
        }
      }
      :f.r
      m Fin de la lista.
    }
    l.v
  }
  if ( $d(6) == ENFORCE ) {
    if ( %tmp.registro.o < %tmp.akick ) { goto p.d }
    %tipo.who = ENFORCE
    s : $+ $chanserv WHO $d(5)
    m Han sido expulsados del canal los nicks con akick.
    l.v
  }
  m Error de Sintaxis: 12AKICK <canal> $chr(123) $+ ADD $chr(124) DEL $chr(124) LIST $chr(124) ENFORCE $+ $chr(125) <nick> <motivo>
  m 12/msg $chanserv AYUDA AKICK para más información.
  l.v
  :p.d
  m 4Permiso denegado.
  l.v
}

alias chanserv.set {
  if ( $ca.r($d(5)) == no ) { m El canal12 $d(5) no está registrado. | l.v }
  if ( $e.c($d(5)) == SUSPENDIDO ) { m El canal12 $d(5) está suspendido. | l.v }
  if ( $n.i($o) == no ) { m Debes identificarte antes de utilizar el comando12 SET. | l.v }
  if ( $l.db(nickserv\ $+ $r.c($o),ifundador,$r.c($d(5))) == $null ) && ( $l.db(chanserv\ $+ $r.c($d(5)),registros,$r.c($o)) == $null ) && ( $l.db(chanserv\ $+ $r.c($d(5)),configuracion,fundador) != $o ) && ( $s.n($o) < 5 ) { m 4Permiso denegado. | l.v }
  if ( $l.db(nickserv\ $+ $r.c($o),ifundador,$r.c($d(5))) != $null ) || ( $l.db(chanserv\ $+ $r.c($d(5)),configuracion,fundador) == $r.c($o) ) || ( $s.n($o) >= 5 ) { %tmp.registro.o = 500 }
  else { %tmp.registro.o = $l.db(chanserv\ $+ $r.c($d(5)),registros,$r.c($o)) }
  if ( $l.db(chanserv\ $+ $r.c($d(5)),niveles,set) == DIS ) { %tmp.set = 500 }
  else { %tmp.set = $l.db(chanserv\ $+ $r.c($d(5)),niveles,set) }
  if ( %tmp.registro.o < %tmp.set ) { m 4Permiso denegado. | l.v }
  if ( $d(6) == FOUNDER ) {
    if ( $d(7) == $null ) { m Error de Sintaxis: 12SET <canal> FOUNDER <nick> | m 12/msg $chanserv AYUDA SET FOUNDER para más información. | l.v }
    if ( $l.db(chanserv\ $+ $r.c($d(5)),estado,$r.c($d(5))) == OFICIAL) && ($o != %conf.root) { m 4ERROR: No se puede cambiar el fundador de los canales 12OFICIALES. | l.v }
    if ( $n.r($d(7)) == no ) { m El nick12 $d(7) no está registrado. | l.v }
    if ( $o != $l.db(chanserv\ $+ $r.c($d(5)),configuracion,fundador)) && ($s.n($o) < 5) { m 4ERROR: Solo el FOUNDER puede cambiar el fundador del canal. | l.v }
    %tmp.afundador = $l.db(chanserv\ $+ $r.c($d(5)),configuracion,fundador)
    if ( %tmp.afundador == $r.c($d(7)) ) { m 12 $+ $d(7) ya es el fundador de12 $d(5) $+ . | l.v }
    if ( $l.db(chanserv\ $+ $r.c($d(5)),configuracion,sucesor) == $r.c($d(7)) ) { m El fundador no puede ser el mismo que el sucesor. | l.v }
    chanserv.c.f $d(5) $r.c(%tmp.afundador) $d(7)
    m El Fundador de12 $d(5) cambiado a12 $d(7) $+ .
    debugc $chanserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o cambia de fundador en12 $d(5) a12 $d(7) (Antiguo fundador:12 $r.c(%tmp.afundador) $+ )
    l.v
  }
  if ( $d(6) == SUCCESSOR ) {
    if ( $o != $l.db(chanserv\ $+ $r.c($d(5)),configuracion,fundador)) && ($s.n($o) < 5) { m 4ERROR: Solo el FOUNDER puede cambiar el successor del canal. | l.v }
    if ( $d(7) == $null ) {
      if ( $l.db(chanserv\ $+ $r.c($d(5)),configuracion,sucesor) == $null ) { m El canal12 $d(5) no tiene sucesor. | l.v }
      %tmp.sucesor = $l.db(chanserv\ $+ $r.c($d(5)),configuracion,sucesor)
      b.db nickserv\ $+ %tmp.sucesor sucesor $r.c($d(5))
      b.db chanserv\ $+ $r.c($d(5)) configuracion sucesor
      m El Sucesor para el canal12 $d(5) ha sido deshabilitado.
      l.v
    }
    if ( $n.r($d(7)) == no ) { m El nick12 $d(7) no está registrado. | l.v }
    if ( $l.db(chanserv\ $+ $r.c($d(5)),configuracion,sucesor) == $r.c($d(7)) ) { m 12 $+ $d(7) ya es el sucesor de12 $d(5) $+ . | l.v }
    if ( $l.db(chanserv\ $+ $r.c($d(5)),configuracion,fundador) == $r.c($d(7)) ) { m El fundador no puede ser el mismo que el sucesor. | l.v }
    if ( $l.db(chanserv\ $+ $r.c($d(5)),configuracion,sucesor) != $null ) {
      %tmp.sucesor = $l.db(chanserv\ $+ $r.c($d(5)),configuracion,sucesor)
      b.db nickserv\ $+ %tmp.sucesor sucesor $r.c($d(5))
    }
    g.db nickserv\ $+ $r.c($d(7)) sucesor $r.c($d(5)) Sucesor
    g.db chanserv\ $+ $r.c($d(5)) configuracion sucesor $r.c($d(7))
    m El Sucesor de12 $d(5) cambiado a12 $d(7) $+ .
    l.v
  }
  if ( $d(6) == PASSWORD ) {
    if ( $d(7) == $null ) { m Error de Sintaxis: 12SET <canal> PASSWORD <contraseña> | m 12/msg $chanserv AYUDA SET PASSWORD para más información. | l.v }
    if ( $o != $l.db(chanserv\ $+ $r.c($d(5)),configuracion,fundador)) && ($s.n($o) < 5) { m 4ERROR: Solo el FOUNDER puede cambiar el password del canal. | l.v }
    g.db chanserv\ $+ $r.c($d(5)) configuracion password $d(7)
    a.t C:: $+ $d(5) $+ ::P $md5($d(7))
    m 12 $+ $d(5) contraseña cambiada a12 $d(7) $+ .
    if ( $s.n($o) >= 5 ) {
      if ( $l.db(chanserv\ $+ $r.c($d(5)),registros,$r.c($o)) != $null ) { %tmp.registro.o2 = $l.db(chanserv\ $+ $r.c($d(5)),registros,$r.c($o)) }
      else { %tmp.registro.o2 = 0 }
      if ( %tmp.registro.o2 < %tmp.set ) && ( $l.db(chanserv\ $+ $r.c($d(5)),configuracion,fundador) != $r.c($o) ) { debugc $chanserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o ha usado SET PASSWORD 4(como OPER) en el canal12 $d(5) $+ . }
    }
    l.v
  }
  if ( $d(6) == DESC ) {
    if ( $d(7) == $null ) { m Error de Sintaxis: 12SET <canal> DESC <contraseña> | m 12/msg $chanserv AYUDA SET DESC para más información. | l.v }
    g.db chanserv\ $+ $r.c($d(5)) configuracion desc $q.c($d(7-))
    m La Descripción de12 $d(5) ha sido cambiada a12 $d(7-) $+ .
    debugc $chanserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o cambia la descripción del canal12 $d(5) a12 $d(7-)
    l.v
  }
  if ( $d(6) == URL ) {
    if ( $d(7) == $null ) {
      b.db chanserv\ $+ $r.c($d(5)) configuracion url
      m URL para12 $d(5) deshabilitada.
      l.v
    }
    g.db chanserv\ $+ $r.c($d(5)) configuracion url $q.c($d(7-))
    m URL para12 $d(5) cambiada a12 $d(7) $+ .
    l.v
  }
  if ( $d(6) == EMAIL ) {
    if ( $d(7) == $null ) {
      b.db chanserv\ $+ $r.c($d(5)) configuracion email
      m Dirección de E-Mail para12 $d(5) deshabilitada.
      l.v
    }
    g.db chanserv\ $+ $r.c($d(5)) configuracion email $q.c($d(7))
    m Dirección de E-Mail para12 $d(5) cambiada a12 $d(7) $+ .
    l.v
  }
  if ( $d(6) == ENTRYMSG ) {
    if ( $d(7) == $null ) {
      b.db chanserv\ $+ $r.c($d(5)) configuracion entrymsg
      m Mensaje de entrada para12 $d(5) deshabilitado.
      l.v
    }
    g.db chanserv\ $+ $r.c($d(5)) configuracion entrymsg $q.c($d(7-))
    m Mensaje de entrada para12 $d(5) cambiado.
    l.v
  }
  if ( $d(6) == TOPIC ) {
    if ( $d(7) == $null ) {
      s : $+ $chanserv TOPIC $d(5) :
      b.db chanserv\ $+ $r.c($d(5)) configuracion topic
      b.db chanserv\ $+ $r.c($d(5)) configuracion ptopic
      l.v
    }
    s : $+ $chanserv TOPIC $d(5) : $+ $d(7-)
    g.db chanserv\ $+ $r.c($d(5)) configuracion topic $q.c($mid($d(7-),1,307))
    g.db chanserv\ $+ $r.c($d(5)) configuracion ptopic $r.c($o)
    g.db chanserv\ $+ $r.c($d(5)) configuracion ttopic $ctime
    l.v
  }
  if ( $d(6) == KEEPTOPIC ) {
    if ( $d(7) == ON ) {
      g.db chanserv\ $+ $r.c($d(5)) configuracion keeptopic on
      set %chanpillatopic. [ $+ [ $d(5) ] ] ok
      s : $+ $chanserv topic $d(5)
      m Opción de retención de tópico 12activada.
      l.v
    }
    if ( $d(7) == OFF ) {
      b.db chanserv\ $+ $r.c($d(5)) configuracion keeptopic
      m Opción de retención de tópico 12desactivada.
      if ($l.db(chanserv\ $+ $r.c($d(5)),configuracion,topiclock) == on)  { a.t C:: $+ $d(5) $+ ::T }
      l.v
    }
    m Error de Sintaxis: 12SET <canal> KEEPTOPIC $chr(123) $+ ON $chr(124) OFF $+ $chr(125)
    m 12/msg $chanserv AYUDA SET KEEPTOPIC para más información.
    l.v
  }
  if ( $d(6) == TOPICLOCK ) {
    if ( $d(7) == ON ) {
      g.db chanserv\ $+ $r.c($d(5)) configuracion topiclock on
      m Opción de candado de tópico 12activada.
      l.v
    }
    if ( $d(7) == OFF ) {
      b.db chanserv\ $+ $r.c($d(5)) configuracion topiclock
      m Opción de candado de tópico 12desactivada.
      l.v
    }
    m Error de Sintaxis: 12SET <canal> TOPICLOCK $chr(123) $+ ON $chr(124) OFF $+ $chr(125)
    m 12/msg $chanserv AYUDA SET TOPICLOCK para más información.
    l.v
  }
  if ( $d(6) == DEFTOPIC ) {
    if ( $d(7) == ON ) {
      g.db chanserv\ $+ $r.c($d(5)) configuracion deftopic on
      m Opción de tópico por defecto 12activada.
      l.v
    }
    if ( $d(7) == OFF ) {
      b.db chanserv\ $+ $r.c($d(5)) configuracion deftopic
      m Opción de tópico por defecto 12desactivada.
      l.v
    }
    m Error de Sintaxis: 12SET <canal> DEFTOPIC $chr(123) $+ ON $chr(124) OFF $+ $chr(125)
    m 12/msg $chanserv AYUDA SET DEFTOPIC para más información.
    l.v
  }
  if ( $d(6) == MLOCK ) {
    %tmp.smlock = $d(7)
    if ( + isin $d(7) ) { %tmp.smlock = $remove(%tmp.smlock,+) }
    if ( - isin $d(7) ) { %tmp.smlock = $remove(%tmp.smlock,-) }
    if ( %tmp.smlock == $null ) {
      b.db chanserv\ $+ $r.c($d(5)) configuracion mlock
      b.db chanserv\ $+ $r.c($d(5)) configuracion clave
      a.t C:: $+ $d(5) $+ ::M
      m Candado de modo de canal12 $d(5) borrado.
      l.v
    }
    %tmp.c = 0
    %tmp.unreal.m = psmntikRcaOAQSKVMGCuzNTl
    while ( %tmp.c < $len(%tmp.smlock) ) {
      inc %tmp.c
      if ( $mid(%tmp.smlock,%tmp.c,1) !isincs %tmp.unreal.m ) {
        m Modo12 $mid(%tmp.smlock,%tmp.c,1) es desconocido e ignorado.
        goto f.m
      }
      if ( $l.db(chanserv\ $+ $r.c($d(5)),mlock,$asc($mid(%tmp.smlock,%tmp.c,1))) != $null ) {
        m Modo12 $mid(%tmp.smlock,%tmp.c,1) duplicado.
        goto f.m
      }
      else { g.db chanserv\ $+ $r.c($d(5)) mlock $asc($mid(%tmp.smlock,%tmp.c,1)) * }
    }
    c.mlock $d(7)
    if ( %tmp.m.p != $null ) {
      %tmp.c = 0
      while ( %tmp.c < $len(%tmp.m.p) ) {
        inc %tmp.c
        %tmp.modos.a = $l.db(canales.db,modos.c,$r.c($d(5)))
        if ( $mid(%tmp.m.p,%tmp.c,1) !isincs %tmp.modos.a ) { g.db canales.db modos.c $r.c($d(5)) $mid(%tmp.m.p,%tmp.c,1) $+ %tmp.modos.a }
      }
    }
    if ( %tmp.m.n != $null ) {
      %tmp.c = 0
      while ( %tmp.c < $len(%tmp.m.n) ) {
        inc %tmp.c
        if ( $l.db(canales.db,modos.c,$r.c($d(5))) != $null ) {
          %tmp.modos.a = $l.db(canales.db,modos.c,$r.c($d(5)))
          if ( $mid(%tmp.m.n,%tmp.c,1) isincs %tmp.modos.a ) {
            %tmp.modos.a = $removecs(%tmp.modos.a,$mid(%tmp.m.n,%tmp.c,1))
            if ( %tmp.modos.a != $null ) { g.db canales.db modos.c $r.c($d(5)) %tmp.modos.a }
            else { b.db canales.db modos.c $r.c($d(5)) }
          }
        }
      }
    }
    if ( k isincs %tmp.m.p ) && ( l isincs %tmp.m.p ) {
      if ( $pos(%tmp.m.p,k) < $pos(%tmp.m.p,l) ) {
        if ( $d(8) == $null ) { m Debes especificar una clave para el canal. | goto f.m }
        %tmp.clavem = $d(8)
        if ( $d(9) !isnum ) { m El límite del canal debe de ser un numero. | goto f.m }
        if ( $d(9) < 1 ) { m El límite del canal debe de ser mayor que 0. | goto f.m }
        %tmp.limite = $d(9)
      }
      else {
        if ( $d(9) == $null ) { m Debes especificar una clave para el canal. | goto f.m }
        %tmp.clavem = $d(9)
        if ( $d(8) !isnum ) { m El límite del canal debe de ser un numero. | goto f.m }
        if ( $d(8) < 1 ) { m El límite del canal debe de ser mayor que 0. | goto f.m }
        %tmp.limite = $d(8)
      }
    }
    else {
      if ( k isincs %tmp.m.p ) {
        if ( $d(8) == $null ) { m Debes especificar una clave para el canal. | goto f.m }
        g.db chanserv\ $+ $r.c($d(5)) configuracion clave $q.c($d(8))
        g.db canales.db password.c $r.c($d(5)) $q.c($d(8))
      }
      if ( l isincs %tmp.m.p ) {
        if ( $d(8) !isnum ) { m El límite del canal debe de ser un numero. | goto f.m }
        if ( $d(8) < 1 ) { m El límite del canal debe de ser mayor que 0. | goto f.m }
        %tmp.limite = $d(8)
      }
    }
    if ( k isincs %tmp.m.n ) {
      if ( $l.db(canales.db,password.c,$r.c($d(5))) != $null ) {
        s : $+ $chanserv MODE $d(5) -k $p.c($l.db(canales.db,password.c,$r.c($d(5))))
        b.db canales.db password.c $r.c($d(5))
      }
      b.db chanserv\ $+ $r.c($d(5)) configuracion clave
    }
    s : $+ $chanserv MODE $d(5) $d(7-)
    if ( %tmp.m.p != $null ) && ( %tmp.m.n != $null ) { g.db chanserv\ $+ $r.c($d(5)) configuracion mlock + $+ %tmp.m.p $+ - $+ %tmp.m.n }
    else {
      if ( %tmp.m.p != $null ) { g.db chanserv\ $+ $r.c($d(5)) configuracion mlock + $+ %tmp.m.p }
      if ( %tmp.m.n != $null ) { g.db chanserv\ $+ $r.c($d(5)) configuracion mlock - $+ %tmp.m.n }
    }
    if ( %tmp.limite != $null ) {
      %tmp.lmlock = $l.db(chanserv\ $+ $r.c($d(5)),configuracion,mlock)
      g.db chanserv\ $+ $r.c($d(5)) configuracion mlock %tmp.lmlock %tmp.limite
    }
    if ( %tmp.clavem != $null ) {
      g.db chanserv\ $+ $r.c($d(5)) configuracion clave %tmp.clavem
      g.db canales.db password.c $r.c($d(5)) %tmp.clavem
    }
    %tmp.m.shadow = $l.db(canales.db,modos.c,$r.c($d(5)))
    if ( k isincs %tmp.m.shadow ) || ( i isincs %tmp.m.shadow ) || ( R isincs %tmp.m.shadow ) && ($l.db(chanserv\ $+ $r.c($d(5)),configuracion,especial) !== all || $l.db(chanserv\ $+ $r.c($d(5)),configuracion,especial) == 11) { j $shadowserv $d(5) }
    else {
      if ($l.db(chanserv\ $+ $r.c($d(5)),configuracion,especial) !== all || $l.db(chanserv\ $+ $r.c($d(5)),configuracion,especial) == 11) { p $shadowserv $d(5) }
    }
    %tmp.mlock = $l.db(chanserv\ $+ $r.c($d(5)),configuracion,mlock)
    %tmp.mlock = $gettok(%tmp.mlock,1,32)
    a.t C:: $+ $d(5) $+ ::M %tmp.mlock
    m Candado de modo de canal12 $d(5) cambiado a12 %tmp.mlock $+ .
    :f.m
    b.db chanserv\ $+ $r.c($d(5)) mlock
    l.v
  }
  if ( $d(6) == PRIVATE ) {
    if ( $d(7) == ON ) {
      g.db chanserv\ $+ $r.c($d(5)) configuracion private on
      m Opción de privacidad 12activada.
      l.v
    }
    if ( $d(7) == OFF ) {
      b.db chanserv\ $+ $r.c($d(5)) configuracion private
      m Opción de privacidad 12desactivada.
      l.v
    }
    m Error de Sintaxis: 12SET <canal> PRIVATE $chr(123) $+ ON $chr(124) OFF $+ $chr(125)
    m 12/msg $chanserv AYUDA SET PRIVATE para más información.
    l.v
  }
  if ( $d(6) == RESTRICTED ) {
    if ( $d(7) == ON ) {
      g.db chanserv\ $+ $r.c($d(5)) configuracion restricted on
      m Opción de acceso restringido 12activada.
      l.v
    }
    if ( $d(7) == OFF ) {
      b.db chanserv\ $+ $r.c($d(5)) configuracion restricted
      m Opción de acceso restringido 12desactivada.
      l.v
    }
    m Error de Sintaxis: 12SET <canal> RESTRICTED $chr(123) $+ ON $chr(124) OFF $+ $chr(125)
    m 12/msg $chanserv AYUDA SET RESTRICTED para más información.
    l.v
  }
  if ( $d(6) == SECURE ) {
    if ( $d(7) == ON ) {
      g.db chanserv\ $+ $r.c($d(5)) configuracion secure on
      m Opción Secure 12activada.
      l.v
    }
    if ( $d(7) == OFF ) {
      b.db chanserv\ $+ $r.c($d(5)) configuracion secure
      m Opción Secure 12desactivada.
      l.v
    }
    m Error de Sintaxis: 12SET <canal> SECURE $chr(123) $+ ON $chr(124) OFF $+ $chr(125)
    m 12/msg $chanserv AYUDA SET SECURE para más información.
    l.v
  }
  if ( $d(6) == SECUREOPS ) {
    if ( $d(7) == ON ) {
      g.db chanserv\ $+ $r.c($d(5)) configuracion secureops on
      m Opción de Secure Ops 12activada.
      l.v
    }
    if ( $d(7) == OFF ) {
      b.db chanserv\ $+ $r.c($d(5)) configuracion secureops
      m Opción de Secure Ops 12desactivada.
      l.v
    }
    m Error de Sintaxis: 12SET <canal> SECUREOPS $chr(123) $+ ON $chr(124) OFF $+ $chr(125)
    m 12/msg $chanserv AYUDA SET SECUREOPS para más información.
    l.v
  }
  if ( $d(6) == SECUREHALFOPS ) {
    if ( $d(7) == ON ) {
      g.db chanserv\ $+ $r.c($d(5)) configuracion securehalfops on
      m Opción de Secure HalfOps 12activada.
      l.v
    }
    if ( $d(7) == OFF ) {
      b.db chanserv\ $+ $r.c($d(5)) configuracion securehalfops
      m Opción de Secure HalfOps 12desactivada.
      l.v
    }
    m Error de Sintaxis: 12SET <canal> SECUREHALFOPS $chr(123) $+ ON $chr(124) OFF $+ $chr(125)
    m 12/msg $chanserv AYUDA SET SECUREHALFOPS para más información.
    l.v
  }
  if ( $d(6) == DEBUG ) {
    if ( $d(7) == ON ) {
      g.db chanserv\ $+ $r.c($d(5)) configuracion debug on
      chanserv.notice $d(5) $o ha activado Modo DEBUG
      m Opción de Debug 12activada.
      l.v
    }
    if ( $d(7) == OFF ) {
      chanserv.notice $d(5) $o ha desactivado Modo DEBUG
      b.db chanserv\ $+ $r.c($d(5)) configuracion debug
      m Opción de Debug 12desactivada.
      l.v
    }
    m Error de Sintaxis: 12SET <canal> DEBUG $chr(123) $+ ON $chr(124) OFF $+ $chr(125)
    m 12/msg $chanserv AYUDA SET DEBUG para más información.
    l.v
  }
  if ( $d(6) == NOEXPIRE ) {
    c.r CA
    if ( $d(7) == ON ) {
      g.db chanserv\ $+ $r.c($d(5)) configuracion noexpire on
      m El canal12 $d(5) no expirará.
      l.v
    }
    if ( $d(7) == OFF ) {
      b.db chanserv\ $+ $r.c($d(5)) configuracion noexpire
      m El canal12 $d(5) expirará si no es usado.
      l.v
    }
    m Error de Sintaxis: 12SET <canal> NOEXPIRE $chr(123) $+ ON $chr(124) OFF $+ $chr(125)
    l.v
  }
  if ( $d(6) == AUTOLIMIT ) {
    if ( $d(7) == ON ) {
      g.db chanserv\ $+ $r.c($d(5)) configuracion autolimit 1
      m El canal12 $d(5) será auto-limitado.
      chanserv.auto-limit $d(5)
      l.v
    }
    if ( $d(7) == OFF ) {
      b.db chanserv\ $+ $r.c($d(5)) configuracion autolimit 0
      m El canal12 $d(5) no será auto-limitado.
      s : $+ $chanserv mode $d(5) -l
      l.v
    }
    m Error de Sintaxis: 12SET <canal> AUTOLIMIT $chr(123) $+ ON $chr(124) OFF $+ $chr(125)
    l.v
  }
  if ($d(6) == PBANS) {
    if ($d(7)) && ($d(7) == on || $d(7) == off) {
      if ($d(7) == on) {
        if ($l.db(chanserv\ $+ $r.c($d(5)),configuracion,pmode)) {
          g.db chanserv\ $+ $r.c($d(5)) configuracion pbans 1
          a.t C:: $+ $d(5) $+ ::O *3
          m Protección de bans activada para el canal12 $d(5)
        }
        else {
          g.db chanserv\ $+ $r.c($d(5)) configuracion pbans 1
          a.t C:: $+ $d(5) $+ ::O *1
          m Protección de bans activada para el canal12 $d(5)
        }
        l.v
      }
      elseif ($d(7) == off) {
        if ($l.db(chanserv\ $+ $r.c($d(5)),configuracion,pmode)) {
          g.db chanserv\ $+ $r.c($d(5)) configuracion pbans 0
          a.t C:: $+ $d(5) $+ ::O *2
          m Protección de bans desactivada para el canal12 $d(5)
        }
        else {
          g.db chanserv\ $+ $r.c($d(5)) configuracion pbans 0
          a.t C:: $+ $d(5) $+ ::O
          m Protección de bans desactivada para el canal12 $d(5)
        }
        l.v
      }
    }
    m Error de Sintaxis: 12SET <canal> PBANS $chr(123) $+ ON $chr(124) OFF $+ $chr(125)
    l.v
  }
  if ($d(6) == PMODE) {
    if ($d(7)) && ($d(7) == on || $d(7) == off) {
      if ($d(7) == on) {
        if ($l.db(chanserv\ $+ $r.c($d(5)),configuracion,pbans)) {
          g.db chanserv\ $+ $r.c($d(5)) configuracion pmode 1
          a.t C:: $+ $d(5) $+ ::O *3
          m Protección de modos activada para el canal12 $d(5)
        }
        else {
          g.db chanserv\ $+ $r.c($d(5)) configuracion pmode 1
          a.t C:: $+ $d(5) $+ ::O *2
          m Protección de modos activada para el canal12 $d(5)
        }
        l.v
      }
      elseif ($d(7) == off) {
        if ($l.db(chanserv\ $+ $r.c($d(5)),configuracion,pbans)) {
          g.db chanserv\ $+ $r.c($d(5)) configuracion pmode 0
          a.t C:: $+ $d(5) $+ ::O *1
          m Protección de modos desactivada para el canal12 $d(5)
        }
        g.db chanserv\ $+ $r.c($d(5)) configuracion pmode 0
        a.t C:: $+ $d(5) $+ ::O
        m Protección de modos desactivada para el canal12 $d(5)
      }
      l.v
    }
    m Error de Sintaxis: 12SET <canal> PMODE $chr(123) $+ ON $chr(124) OFF $+ $chr(125)
    l.v
  }
  if ($d(6) == NAME) {
    if ($d(7) == $null) { m 4ERROR: Sintaxis12 /msg $chanserv SET #<canal> NAME <nuevo nombre> | l.v }
    if ($d(5) === $d(7)) { m ¿Tú no ves bien... no? Si quieres usar 12SET NAME tendras que cambiar alguna mayuscula o minuscula en el nombre del canal... | l.v }
    if ($d(7) === $ini(database\canales.db,canales.u,$ini(database\canales.db,canales.u,$r.c($d(7))))) { m El canal ya está como12 $d(7) | l.v }
    if ($d(5) != $d(7)) { m 4ERROR: El canal indicado12 $d(7) no es igual que el original ( $+ $d(5) $+ ). | l.v }
    j $shadowserv $d(5)
    s : $+ $shadowserv mode $d(5) +i
    %tipo.who = USERS
    %who.origen = CHaN
    .timercname1. [ $+ [ $d(7) ] ] 1 5 s : $+ $chanserv %conf.metodo $o :Inicio del cambio de nombre del canal12 $d(7)
    .timercname2. [ $+ [ $d(7) ] ] 1 6 s : $+ $chanserv WHO $d(5)
    .timercname2.1 [ $+ [ $d(7) ] ] 1 8 p $shadowserv $d(5)
    ;.timercname2.3 [ $+ [ $d(7) ] ] 1 8 j $shadowserv $d(7)
    .timercname3. [ $+ [ $d(7) ] ] 1 10 a.t C:: $+ $d(5)
    .timercname2.2 [ $+ [ $d(7) ] ] 1 10 a.t C:: $+ $d(7) $+ ::B Cambio de nombre sobre el canal.
    var %a $d(7)
    var %o
    if ($l.db(chanserv\ $+ $r.c(%a),configuracion,pmode)) { inc %o 2 }
    if ($l.db(chanserv\ $+ $r.c(%a),configuracion,pbans)) { inc %o 1 }
    .timercname5. [ $+ [ $d(7) ] ] 1 12 a.t C:: $+ %a $+ ::F $l.db(chanserv\ $+ $r.c(%a),configuracion,fundador)
    .timercname6. [ $+ [ $d(7) ] ] 1 12 a.t C:: $+ %a $+ ::P $md5($l.db(chanserv\ $+ $r.c(%a),configuracion,password))
    .timercname7. [ $+ [ $d(7) ] ] 1 12 a.t C:: $+ %a $+ ::M nt
    if (%o) { a.t C:: $+ %a $+ ::O * $+ %o }
    if ($l.db(chanserv\ $+ $r.c(%a),estado,suspendido)) { .timercname8. [ $+ [ $d(7) ] ] 1 12 a.t C:: $+ %a $+ ::S $l.db(chanserv\ $+ $r.c(%a),estado,suspend.motivo) }
    if ($l.db(chanserv\ $+ $r.c(%a),estado,forbid)) { .timercname9. [ $+ [ $d(7) ] ] 1 12 a.t C:: $+ %a $+ ::B $p.c($gettok($readini(database\canalesp.db,forbid,%a),2-,32)) }
    l.v
  }
  m Error de Sintaxis: 12SET <canal> <opcion> <parametros>
  m 12/msg $chanserv AYUDA SET para más información.
  l.v
}

alias chanserv.levels {
  if ( $d(6) != SET ) && ( $d(6) != DIS ) && ( $d(6) != LIST ) && ( $d(6) != RESET ) { m Error de Sintaxis: 12LEVELS <canal> $chr(123) $+ SET $chr(124) DIS $chr(124) LIST $chr(124) RESET $+ $chr(125) <nivel> | m 12/msg $chanserv AYUDA LEVELS para más información. | l.v }
  if ( $ca.r($d(5)) == no ) { m El canal12 $d(5) no está registrado. | l.v }
  if ( $d(6) == LIST ) {
    m  Configuración de niveles de acceso para canal12 $d(5) $+ :
    m  AUTOOP $replace($l.db(chanserv\ $+ $r.c($d(5)),niveles,autoop),DIS,(deshabilitado))
    m  AUTOHALFOP $replace($l.db(chanserv\ $+ $r.c($d(5)),niveles,autohalfop),DIS,(deshabilitado))
    m  AUTOVOICE $replace($l.db(chanserv\ $+ $r.c($d(5)),niveles,autovoice),DIS,(deshabilitado))
    m  AUTODEOP $replace($l.db(chanserv\ $+ $r.c($d(5)),niveles,autodeop),DIS,(deshabilitado))
    m  NOJOIN $replace($l.db(chanserv\ $+ $r.c($d(5)),niveles,nojoin),DIS,(deshabilitado))
    m  INVITE $replace($l.db(chanserv\ $+ $r.c($d(5)),niveles,invite),DIS,(deshabilitado))
    m  OPDEOP $replace($l.db(chanserv\ $+ $r.c($d(5)),niveles,opdeop),DIS,(deshabilitado))
    m  HALFOPDEHALFOP $replace($l.db(chanserv\ $+ $r.c($d(5)),niveles,halfopdehalfop),DIS,(deshabilitado))
    m  VOICEDEVOICE $replace($l.db(chanserv\ $+ $r.c($d(5)),niveles,voicedevoice),DIS,(deshabilitado))
    m  KICK $replace($l.db(chanserv\ $+ $r.c($d(5)),niveles,kick),DIS,(deshabilitado))
    m  UNBAN $replace($l.db(chanserv\ $+ $r.c($d(5)),niveles,unban),DIS,(deshabilitado))
    m  AKICK $replace($l.db(chanserv\ $+ $r.c($d(5)),niveles,akick),DIS,(deshabilitado))
    m  SET $replace($l.db(chanserv\ $+ $r.c($d(5)),niveles,set),DIS,(deshabilitado))
    m  CLEAR $replace($l.db(chanserv\ $+ $r.c($d(5)),niveles,clear),DIS,(deshabilitado))
    m  ACC-LIST $replace($l.db(chanserv\ $+ $r.c($d(5)),niveles,acc-list),DIS,(deshabilitado))
    m  ACC-CHANGE $replace($l.db(chanserv\ $+ $r.c($d(5)),niveles,acc-change),DIS,(deshabilitado))
    m  MEMO $replace($l.db(chanserv\ $+ $r.c($d(5)),niveles,memo),DIS,(deshabilitado))
    m  Fin de la configuración de niveles para12 $d(5) $+ .
    l.v
  }
  chanserv.sf
  if ( %tmp.registro.o < 500 ) { m 4Permiso denegado. | l.v }
  if ( $d(6) == SET ) && ( $d(7) != $null ) && ( $d(8) != $null ) && ( $d(8) isnum ) {
    if ( $d(7) != AUTOOP ) && ( $d(7) != AUTOHALFOP ) && ( $d(7) != AUTOVOICE ) && ( $d(7) != AUTODEOP ) && ( $d(7) != NOJOIN ) && ( $d(7) != INVITE ) && ( $d(7) != OPDEOP ) && ( $d(7) != HALFOPDEHALFOP ) && ( $d(7) != VOICEDEVOICE ) && ( $d(7) != KICK ) && ( $d(7) != UNBAN ) && ( $d(7) != AKICK ) && ( $d(7) != SET ) && ( $d(7) != CLEAR ) && ( $d(7) != ACC-LIST ) && ( $d(7) != ACC-CHANGE ) && ( $d(7) != MEMO ) { m Opción12 $d(7) desconocida. Escriba 12/msg $chanserv AYUDA LEVELS DESC para una lista de opciones válidas. | l.v }
    if ( $d(8) < -1 ) || ( $d(8) > 500 ) { m El Nivel debe de estar entre12 -1 y12 500 $+ . | l.v }
    %tmp.nivel = $int($d(8))
    g.db chanserv\ $+ $r.c($d(5)) niveles $lower($d(7)) %tmp.nivel
    m El nivel para12 $upper($d(7)) en canal12 $d(5) cambiado a12 %tmp.nivel $+ .
    l.v
  }
  else {
    if ( $d(6) == SET ) {
      m Error de Sintaxis: 12LEVELS <canal> SET <opcion> <nivel>
      m Escriba 12/msg $chanserv AYUDA LEVELS DESC para una lista de opciones válidas.
      l.v
    }
  }
  if ( $d(6) == DIS ) && ( $d(7) != $null ) {
    if ( $d(7) != AUTOOP ) && ( $d(7) != AUTOHALFOP ) && ( $d(7) != AUTOVOICE ) && ( $d(7) != AUTODEOP ) && ( $d(7) != NOJOIN ) && ( $d(7) != INVITE ) && ( $d(7) != OPDEOP ) && ( $d(7) != HALFOPDEHALFOP ) && ( $d(7) != VOICEDEVOICE ) && ( $d(7) != KICK ) && ( $d(7) != UNBAN ) && ( $d(7) != AKICK ) && ( $d(7) != SET ) && ( $d(7) != CLEAR ) && ( $d(7) != ACC-LIST ) && ( $d(7) != ACC-CHANGE ) && ( $d(7) != MEMO ) { m Opción12 $d(7) desconocida. Escriba 12/msg $chanserv AYUDA LEVELS DESC para una lista de opciones validas. | l.v }
    g.db chanserv\ $+ $r.c($d(5)) niveles $lower($d(7)) DIS
    m 12 $+ $upper($d(7)) deshabilitado en canal12 $d(5) $+ .
    l.v
  }
  else {
    if ( $d(6) == DIS ) {
      m Error de Sintaxis: 12LEVELS <canal> DIS <opcion>
      m Escriba 12/msg $chanserv AYUDA LEVELS DESC para una lista de opciones válidas.
      l.v
    }
  }
  if ( $d(6) == RESET ) {
    g.db chanserv\ $+ $r.c($d(5)) niveles autoop 300
    g.db chanserv\ $+ $r.c($d(5)) niveles autohalfop 200
    g.db chanserv\ $+ $r.c($d(5)) niveles autovoice 100
    g.db chanserv\ $+ $r.c($d(5)) niveles autodeop -1
    g.db chanserv\ $+ $r.c($d(5)) niveles nojoin -1
    g.db chanserv\ $+ $r.c($d(5)) niveles invite 300
    g.db chanserv\ $+ $r.c($d(5)) niveles opdeop 300
    g.db chanserv\ $+ $r.c($d(5)) niveles halfopdehalfop 200
    g.db chanserv\ $+ $r.c($d(5)) niveles voicedevoice 100
    g.db chanserv\ $+ $r.c($d(5)) niveles kick 400
    g.db chanserv\ $+ $r.c($d(5)) niveles unban 300
    g.db chanserv\ $+ $r.c($d(5)) niveles akick 450
    g.db chanserv\ $+ $r.c($d(5)) niveles set DIS
    g.db chanserv\ $+ $r.c($d(5)) niveles clear DIS
    g.db chanserv\ $+ $r.c($d(5)) niveles acc-list 0
    g.db chanserv\ $+ $r.c($d(5)) niveles acc-change 450
    g.db chanserv\ $+ $r.c($d(5)) niveles memo 450
    m Niveles de acceso de12 $d(5) configurados a niveles originales.
    l.v
  }
}

alias chanserv.migrar {
  if ($d(5)) {
    if ($ca.r($d(5)) == si) {
      if ($l.db(chanserv\ $+ $r.c($d(5)),configuracion,fundador) == $o || $s.n($o) >= 7) {
        set %migrac. [ $+ [ $d(5) ] ] $o
        s : $+ $chanserv DBQ C:: $+ $d(5)
      }
      else { m 4ERROR: No eres el fundador del canal12 $d(5) }
    }
    else { m 4ERROR: El canal12 $d(5) no está registrado... }
  }
  else { m 4Sintaxis incorrecta:12 MIGRAR #canal }
  l.v
}

alias chanserv.list {
  if ( $d(5) == $null ) { m Error de Sintaxis: 12LIST <patrón> | l.v }
  m Lista de Canales que satisfacen12 $strip($d(5)) $+ :
  var %tmp.patron $iif($d(6),$d(6))
  %tmp.cr = $findfile($mircdirdatabase\chanserv\,*,0)
  %tmp.c = 0
  %tmp.m = 0
  :c.l
  while ( %tmp.c < %tmp.cr ) {
    inc %tmp.c
    %tmp.n = $r.c($nopath($findfile($mircdirdatabase\chanserv\,*,%tmp.c)))
    if ( $d(5) iswm %tmp.n ) {
      m %tmp.n -12 $e.c(%tmp.n) 6 $+ $chr(40) $+ BDD6 $+ $chr(41)
      inc %tmp.m
      if ( %tmp.m == 50 ) { goto s.l }
    }
  }
  :s.l
  m Fin de la lista,12 %tmp.m $+ /12 $+ %tmp.cr entradas mostradas.
  l.v
}

alias chanserv.drop {
  if ( $d(5) == $null ) { m Error de Sintaxis: 12DROP <canal> | l.v }
  if ( $ca.r($d(5)) == no ) { m El canal12 $d(5) no está registrado. | l.v }
  chanserv.dropc $d(5)
  %tipo.who = APODERA
  s : $+ $chanserv WHO $d(5)
  m El canal12 $d(5) ha sido dropado.
  debugc $chanserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o borra el canal12 $d(5) $+ .
  l.v
}

alias chanserv.suspend {
  if ( $d(6) == $null ) { m Error de Sintaxis: 12SUSPEND <canal> <motivo> | l.v }
  if ( $ca.r($d(5)) == no ) { m El canal12 $d(5) no está registrado. | l.v }
  if ( $e.c($d(5)) == SUSPENDIDO ) { m El canal12 $d(5) ya está suspendido. | l.v }
  a.t C:: $+ $d(5) $+ ::S $d(6-)
  g.db chanserv\ $+ $r.c($d(5)) estado $d(5) SUSPENDIDO
  g.db chanserv\ $+ $r.c($d(5)) estado suspend.motivo $q.c($d(6-))
  g.db chanserv\ $+ $r.c($d(5)) estado suspend.origen $r.c($o)
  g.db chanserv\ $+ $r.c($d(5)) estado suspend.fecha $ctime
  g.db canalesp.db suspendidos $r.c($d(5)) *
  m El canal12 $d(5) ha sido suspendido.
  debugc $chanserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o suspende el canal12 $d(5) $+ . Motivo:12 $d(6-)
  l.v
}

alias chanserv.unsuspend {
  if ( $d(5) == $null ) { m Error de Sintaxis: 12UNSUSPEND <canal> | l.v }
  if ( $e.c($d(5)) != SUSPENDIDO ) { m El nick12 $d(5) no está suspendido. | l.v }
  %tmp.fundador = $r.c($l.db(chanserv\ $+ $r.c($d(5)),configuracion,fundador))
  a.t C:: $+ $d(5) $+ ::S
  g.db chanserv\ $+ $r.c($d(5)) estado $d(5) ACTIVO
  b.db chanserv\ $+ $r.c($d(5)) estado suspend.motivo
  b.db chanserv\ $+ $r.c($d(5)) estado suspend.origen
  b.db chanserv\ $+ $r.c($d(5)) estado suspend.fecha
  b.db canalesp.db suspendidos $r.c($d(5))
  chanserv.create $d(5)
  m El canal12 $d(5) ha sido liberado.
  debugc $chanserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o quita el suspend del canal12 $d(5) $+ .
  l.v
}

alias chanserv.listsuspend {
  if ($ini(database\canalesp.db,suspendidos,0) == 0) { m Lista vacia. }
  else {
    var %a 1
    m Listado de canales suspendidos
    while ( $ini(database\canalesp.db,suspendidos,%a) ) {
      %tmp.na = $ini(database\canalesp.db,suspendidos,%a)
      %tmp.sm = $l.db(chanserv\ $+ %tmp.na,configuracion,suspend.motivo)
      m 12 $+ %tmp.na - Motivo:12 $p.c(%tmp.sm)
      inc %a 1
    }
    m Fin de la lista de canales suspendidos.
  }
  l.v
}

alias chanserv.getpass {
  if ( $d(5) == $null ) { m Error de Sintaxis: 12GETPASS <canal> | l.v }
  if ( $ca.r($d(5)) == no ) { m El canal12 $d(5) no está registrado. | l.v }
  %tmp.getpass = $l.db(chanserv\ $+ $r.c($d(5)),configuracion,password)
  m La contraseña de12 $d(5) es12 %tmp.getpass $+ .
  debugc $chanserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o utiliza GETPASS sobre12 $d(5) $+ .
  l.v
}

alias chanserv.forbid {
  if ( $d(6) == $null ) { m Error de Sintaxis: 12FORBID <canal> <motivo> | l.v }
  if ( $l.db(canalesp.db,forbid,$r.c($d(5))) != $null ) { m El canal12 $d(5) ya está en la lista de forbid. | l.v }
  if ( $mid($d(5),1,1) != $chr(35) ) { m El canal debe comenzar por12 $chr(35) | l.v }
  if ( $ca.r($d(5)) == si ) { chanserv.dropc $d(5) }
  a.t C:: $+ $d(5) $+ ::B $d(6-)
  g.db canalesp.db forbid $r.c($d(5)) $r.c($o) $q.c($d(6-))
  m El canal12 $d(5) ha sido prohibido.
  debugc $chanserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o prohibe el canal12 $d(5) $+ . Motivo:12 $d(6-)
  l.v
}

alias chanserv.unforbid {
  if ( $d(5) == $null ) { m Error de Sintaxis: 12UNFORBID <canal> | l.v }
  if ( $l.db(canalesp.db,forbid,$r.c($d(5))) == $null ) { m El nick12 $d(5) no está en la lista de forbid. | l.v }
  b.db canalesp.db forbid $r.c($d(5))
  a.t C:: $+ $d(5) $+ ::B
  m El canal12 $d(5) ha sido liberado.
  debugc $chanserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o quita la prohibición del canal12 $d(5) $+ .
  l.v
}

alias chanserv.listforbid {
  flushini $mircdirdatabase\canalesp.db
  %tmp.ruta = $mircdirdatabase\canalesp.db
  if ( $ini( %tmp.ruta , forbid,0 ) == 0 ) {
    m Lista vacia.
  }
  else {
    m Listado de canales prohibidos -> $initopic( %tmp.ruta , forbid )
    clear @canalesp
    window -hl @canalesp
    loadbuf -tforbid @canalesp $mircdirdatabase\canalesp.db
    %tmp.total = $line(@canalesp,0)
    %tmp.linea = 0
    while ( %tmp.linea < %tmp.total ) {
      inc %tmp.linea
      %tmp.l.linea = $line( @canalesp , %tmp.linea )
      %tmp.dforbid = $gettok(%tmp.l.linea,2-,61)
      %tmp.cforbid = $gettok(%tmp.l.linea,1,61)
      %tmp.norigenf = $r.c($gettok(%tmp.dforbid,1,32))
      %tmp.mforbid = $p.c($gettok(%tmp.dforbid,2-,32))
      m $r.c(%tmp.cforbid) ( $+ $strip(%tmp.norigenf) $+ ) 12 $+ %tmp.mforbid
    }
    m Fin de la lista de canales prohibidos.
  }
  l.v
}

alias chanserv.especial {
  if ($d(5)) {
    if ( $d(6) == $null ) { 
      if ($readini(database\chanserv\ $+ $strip($d(5)),configuracion,especial)) {
        m El 12especial del canal12 $strip($d(5))  es12 $espebotnick($readini(database\chanserv\ $+ $strip($d(5)),configuracion,especial))
        l.v
      }
      m El canal12 $d(5) no tiene configurados bots de entrada al canal.
      m Para poner un especial en el canal usa: 12/msg $chanserv ESPECIAL <canal> <nº/all>
      l.v
    }
    if ( $ca.r($d(5)) == no ) { m El canal12 $d(5) no está registrado. | l.v }
    if ( $e.c($d(5)) == SUSPENDIDO ) { m El canal12 $d(5) está suspendido. | l.v }
    if ( $d(6) == ALL ) {
      g.db chanserv\ $+ $r.c($d(5)) configuracion especial ALL
      chanserv.especialj $d(5) ALL
      debugc $chanserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o introduce 4TODOS los bots al canal12 $d(5)
      m Todos los bots han entrado en12 $d(5) $+ .
      l.v
    }
    if ( $d(6) == 0 ) {
      b.db chanserv\ $+ $r.c($d(5)) configuracion especial
      chanserv.especialj $d(5) 0
      debugc $chanserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o saca 4TODOS los bots del canal12 $d(5)
      m Todos los bots han salido de12 $d(5) $+ .
      l.v
    }
    %tmp.bots = $d(6-)
    %tmp.c = 0
    :o.b
    inc %tmp.c
    %tmp.bot = $gettok(%tmp.bots,%tmp.c,32)
    if ( %tmp.bot == $null ) { goto f.cb }
    if ( %tmp.bot !isnum ) || ( %tmp.bot < 1 ) || ( %tmp.bot > 11 ) {
      m No existe ningún bot con12 %tmp.bot $+ .
      b.db chanserv\ $+ $r.c($d(5)) especial
      l.v
    }
    if ( $l.db(chanserv\ $+ $r.c($d(5)),especial,%tmp.bot) != $null ) {
      m El bot asignado con el número12 %tmp.bot ya ha sido asignado para el canal12 $d(5) $+ .
      b.db chanserv\ $+ $r.c($d(5)) especial
      l.v
    }
    g.db chanserv\ $+ $r.c($d(5)) especial %tmp.bot *
    goto o.b
    :f.cb
    b.db chanserv\ $+ $r.c($d(5)) especial
    chanserv.especialj $d(5) 0
    %tmp.c = 0
    %tmp.especialbots
    :e.b
    inc %tmp.c
    %tmp.bot = $gettok(%tmp.bots,%tmp.c,32)
    if ( %tmp.bot == $null ) { goto f.es }
    chanserv.especialj $d(5) %tmp.bot
    %tmp.especialbots = %tmp.especialbots %tmp.bot
    goto e.b
    :f.es
    g.db chanserv\ $+ $r.c($d(5)) configuracion especial %tmp.bots
    debugc $chanserv %conf.canal.admins $+ , $+ %conf.canal.opers 12 $+ $o mete los bots12 $espebotnick(%tmp.especialbots) al canal12 $d(5)
    ;m %tmp.especialbots
    m Los bots seleccionados han entrado en12 $d(5) $+ .
    l.v
  }
  else {
    m 4Sintaxis incorrecta:12 ESPECIAL #canal ALL/Nº
    l.v
  }
}

alias chanserv.bfounder {
  if ($d(5) == $null) { m 4Sintaxis incorrecta:12 BFOUNDER <canal> | l.v }
  if ( $ca.r($d(5)) == no ) { m El canal12 $d(5) no está registrado. | l.v }
  set %bfounder. [ $+ [ $d(5) ] ] $o
  s : $+ $chanserv DBQ C:: $+ $d(5) $+ ::F
  l.v
}

-------------------------

alias c.mlock {
  %tmp.c.mlock = $1
  %tmp.c.m = 0
  unset %tmp.m.p
  unset %tmp.m.n
  inc %tmp.c.m
  if ( $mid(%tmp.c.mlock,%tmp.c.m,1) == $null ) { goto f }
  if ( $mid(%tmp.c.mlock,%tmp.c.m,1) == + ) { goto p }
  if ( $mid(%tmp.c.mlock,%tmp.c.m,1) == - ) { goto n }
  :p
  inc %tmp.c.m
  if ( $mid(%tmp.c.mlock,%tmp.c.m,1) == $null ) { goto f }
  if ( $mid(%tmp.c.mlock,%tmp.c.m,1) == + ) { goto p }
  if ( $mid(%tmp.c.mlock,%tmp.c.m,1) == - ) { goto n }
  %tmp.m.p = %tmp.m.p $+ $mid(%tmp.c.mlock,%tmp.c.m,1)
  goto p
  :n
  inc %tmp.c.m
  if ( $mid(%tmp.c.mlock,%tmp.c.m,1) == $null ) { goto f }
  if ( $mid(%tmp.c.mlock,%tmp.c.m,1) == + ) { goto p }
  if ( $mid(%tmp.c.mlock,%tmp.c.m,1) == - ) { goto n }
  %tmp.m.n = %tmp.m.n $+ $mid(%tmp.c.mlock,%tmp.c.m,1)
  goto n
  :f
}

alias chanserv.c.r {
  if ( $l.db(canalesp.db,forbid,$r.c($2)) != $null ) {
    %tmp.forbid = $l.db(canalesp.db,forbid,$r.c($2))
    %tmp.motivo = $p.c($gettok(%tmp.forbid,2-,32))
    s : $+ $chanserv %conf.metodo $1 :Este canal no puede ser registrado o utilizado. Motivo:12 %tmp.motivo
    if ( $s.n($1) < 5 ) {
      s : $+ $chanserv MODE $2 +b $1
      k.c $2 $1 $l.conf(chanserv,makick)
    }
    return
  }
  if ( $gettok(%debugc,2,32) == $2 ) {
    if ( $gettok(%debugc,1,32) == on ) {
      if ( $s.n($1) < 4 ) {
        s : $+ $chanserv %conf.metodo $1 :Este canal es solo para uso de los pre-operadores y operadores de la red, usted no tiene autorización para entrar.
        s : $+ $chanserv MODE $2 +b $1
        k.c $2 $1 $l.conf(chanserv,makick)
        return
      }
    }
  }
  if ( $ca.r($2) == si ) {
    e.u.c $1 $2
    if ( $e.c($2) == SUSPENDIDO ) { return }
    if ( $2 == %conf.canal.admins ) {
      if ( $s.n($1) < 6 ) {
        s : $+ $chanserv %conf.metodo $1 :Este canal es solo para uso de los co-administradores y administradores de la red, usted no tiene autorización para entrar.
        s : $+ $chanserv MODE $2 +b $1
        k.c $2 $1 $l.conf(chanserv,makick)
        return
      }
    }
    if ( $2 == %conf.canal.opers ) {
      if ( $s.n($1) < 4 ) && (!$l.db(representantes.db,ircops,$1)) {
        s : $+ $chanserv %conf.metodo $1 :Este canal es solo para uso de los pre-operadores y operadores de la red, usted no tiene autorización para entrar.
        s : $+ $chanserv MODE $2 +b $1
        k.c $2 $1 $l.conf(chanserv,makick)
        return
      }
    }
    if ( $l.db(chanserv\ $+ $r.c($2),registros,$r.c($1)) != $null ) && ( $n.i($1) == si ) { %tmp.registro = $l.db(chanserv\ $+ $r.c($2),registros,$r.c($1)) }
    elseif ( $l.db(chanserv\ $+ $r.c($2),configuracion,fundador) == $1 ) || ( $l.db(nickserv\ $+ $r.c($2),fundador,$r.c($1)) != $null ) && ( $n.i($1) == si ) { %tmp.registro = 500 }
    else { %tmp.registro = 0 }
    if ( $l.db(chanserv\ $+ $r.c($2),configuracion,entrymsg) != $null ) {
      %tmp.entrymsg = $l.db(chanserv\ $+ $r.c($2),configuracion,entrymsg)
      s : $+ $chanserv notice $1 : $+ $replace($p.c(%tmp.entrymsg),<nick>,$1)
    }
    if ( $l.db(chanserv\ $+ $r.c($2),configuracion,autolimit) ) { chanserv.auto-limit $2 }
    memoserv.miramemos $2 $1
    if ( $l.db(chanserv\ $+ $r.c($2),akicks,$r.c($1)) != $null ) {
      if ( $n.i($1) == si ) && ( $s.n($1) < 5 ) {
        %tmp.ma = $l.db(chanserv\ $+ $r.c($2),akicks,$r.c($1))
        %tmp.mo = $r.c($gettok(%tmp.ma,1,32))
        %tmp.mm = $p.c($gettok(%tmp.ma,2-,32))
        s : $+ $chanserv MODE $2 +b $1
        k.c $2 $1 ( $+ %tmp.mo $+ ) -> %tmp.mm
        return
      }
    }
    if ( $l.db(chanserv\ $+ $r.c($2),niveles,nojoin) == DIS ) { %tmp.n.nojoin = 500 }
    else { %tmp.n.nojoin = $l.db(chanserv\ $+ $r.c($2),niveles,nojoin) }
    if ( %tmp.n.nojoin >= %tmp.registro ) && ( $s.n($1) < 5 ) {
      s : $+ $chanserv MODE $2 +b $1
      k.c $2 $1 $l.conf(chanserv,makick)
      return
    }
    if (( $l.db(chanserv\ $+ $r.c($2),configuracion,fundador) == $1 ) || ( $l.db(nickserv\ $+ $r.c($2),fundador,$r.c($1)) != $null )) && ( $n.i($1) == si ) {
      s : $+ $chanserv MODE $2 +o $1
      chanserv.a.c $2
      if ( $l.db(nickserv\ $+ $r.c($1),ifundador,$r.c($2)) != $null ) { s : $+ $chanserv MODE $2 +qo $1 $1 }
      return
    }
    if ( $l.db(chanserv\ $+ $r.c($2),configuracion,sucesor) == $r.c($1) ) && ( $n.i($1) == si ) {
      chanserv.a.c $2
      s : $+ $chanserv MODE $2 +a $1
      return
    }
    if ( $l.db(chanserv\ $+ $r.c($2),niveles,autoop) == DIS ) { %tmp.n.autoop = 500 }
    else { %tmp.n.autoop = $l.db(chanserv\ $+ $r.c($2),niveles,autoop) }
    if ( $l.db(chanserv\ $+ $r.c($2),configuracion,restricted) == on ) && ( %tmp.n.autoop > %tmp.registro ) && ( $s.n($1) < 5 ) {
      s : $+ $chanserv MODE $2 +b $1
      k.c $2 $1 $l.conf(chanserv,makick)
      return
    }
    if ( %tmp.n.autoop <= %tmp.registro ) && ( $n.i($1) == si ) {
      chanserv.a.c $2
      s : $+ $chanserv MODE $2 +o $1
      return
    }
    if ( %tmp.n.autoop == -1 ) {
      if ( $l.db(chanserv\ $+ $r.c($2),configuracion,secure) == on ) {
        if ( $n.i($1) == si ) { s : $+ $chanserv MODE $2 +o $1 }
      }
      else { s : $+ $chanserv MODE $2 +o $1 }
      return
    }
    if ( $l.db(chanserv\ $+ $r.c($2),niveles,autohalfop) == DIS ) { %tmp.n.autohalfop = 500 }
    else { %tmp.n.autohalfop = $l.db(chanserv\ $+ $r.c($2),niveles,autohalfop) }
    if ( %tmp.n.autohalfop <= %tmp.registro ) && ( $n.i($1) == si ) {
      chanserv.a.c $2
      s : $+ $chanserv MODE $2 +h $1
      return
    }
    if ( %tmp.n.autohalfop == -1 ) {
      if ( $l.db(chanserv\ $+ $r.c($2),configuracion,secure) == on ) {
        if ( $n.i($1) == si ) { s : $+ $chanserv MODE $2 +h $1 }
      }
      else { s : $+ $chanserv MODE $2 +h $1 }
      return
    }
    if ( $l.db(chanserv\ $+ $r.c($2),niveles,autovoice) == DIS ) { %tmp.n.autovoice = 500 }
    else { %tmp.n.autovoice = $l.db(chanserv\ $+ $r.c($2),niveles,autovoice) }
    if ( %tmp.n.autovoice <= %tmp.registro ) && ( $n.i($1) == si ) {
      s : $+ $chanserv MODE $2 +v $1 
      return
    }
    if ( %tmp.n.autovoice == -1 ) {
      if ( $l.db(chanserv\ $+ $r.c($2),configuracion,secure) == on ) {
        if ( $n.i($1) == si ) { s : $+ $chanserv MODE $2 +v $1 }
      }
      else { s : $+ $chanserv MODE $2 +v $1 }
      return
    }
  }
}

alias chanserv.a.c { g.db chanserv\ $+ $r.c($1) configuracion ultuso $ctime }

alias chanserv.a.a {
  if ( $l.db(chanserv\ $+ $r.c($1),registros,$r.c($2)) == $null ) {
    if ( $l.db(chanserv\ $+ $r.c($1),stats,numero.regs) != $null ) {
      %tmp.nregistros = $l.db(chanserv\ $+ $r.c($1),stats,numero.regs)
      inc %tmp.nregistros
      g.db chanserv\ $+ $r.c($1) stats numero.regs %tmp.nregistros
    }
    else { g.db chanserv\ $+ $r.c($1) stats numero.regs 1 }
  }
  g.db nickserv\ $+ $r.c($2) registros $r.c($1) $3
  g.db chanserv\ $+ $r.c($1) registros $r.c($2) $3
}

alias chanserv.b.a {
  b.db nickserv\ $+ $r.c($2) registros $r.c($1)
  b.db chanserv\ $+ $r.c($1) registros $r.c($2)
  if ( $l.db(chanserv\ $+ $r.c($1),stats,numero.regs) != $null ) {
    %tmp.nregistros = $l.db(chanserv\ $+ $r.c($1),stats,numero.regs)
    dec %tmp.nregistros
    if ( %tmp.nregistros < 1 ) { b.db chanserv\ $+ $r.c($1) stats numero.regs }
    else { g.db chanserv\ $+ $r.c($1) stats numero.regs %tmp.nregistros }
  }
}

alias chanserv.a.ak {
  if ( $l.db(chanserv\ $+ $r.c($1),stats,numero.akicks) != $null ) {
    %tmp.nakicks = $l.db(chanserv\ $+ $r.c($1),stats,numero.akicks)
    inc %tmp.nakicks
    g.db chanserv\ $+ $r.c($1) stats numero.akicks %tmp.nakicks
  }
  else { g.db chanserv\ $+ $r.c($1) stats numero.akicks 1 }
  g.db nickserv\ $+ $r.c($2) akicks $1 Akick
  g.db chanserv\ $+ $1 akicks $r.c($2) $3-
}

alias chanserv.b.ak {
  b.db nickserv\ $+ $r.c($2) akicks $1
  b.db chanserv\ $+ $r.c($1) akicks $r.c($2)
  %tmp.nakicks = $l.db(chanserv\ $+ $r.c($1),stats,numero.akicks)
  dec %tmp.nakicks
  if ( %tmp.nakicks < 1 ) { b.db chanserv\ $+ $r.c($1) stats numero.akicks }
  else { g.db chanserv\ $+ $r.c($1) stats numero.akicks %tmp.nakicks }
}

alias chanserv.c.f {
  %tmp.cfundador = $l.db(nickserv\ $+ $r.c($2),stats,fundador.c)
  if (  %tmp.cfundador != $null ) {
    dec %tmp.cfundador
    if ( %tmp.cfundador < 1 ) { b.db nickserv\ $+ $r.c($2) stats fundador.c }
    else { g.db nickserv\ $+ $r.c($2) stats fundador.c %tmp.cfundador }
  }
  b.db nickserv\ $+ $r.c($2) fundador $r.c($1)
  g.db nickserv\ $+ $r.c($3) fundador $r.c($1) Fundador
  a.t C:: $+ $1 $+ ::F $3
  g.db chanserv\ $+ $r.c($1) configuracion fundador $r.c($3)
  %tmp.cfundador = $l.db(nickserv\ $+ $r.c($3),stats,fundador.c)
  if (  %tmp.cfundador != $null ) {
    inc %tmp.cfundador
    g.db nickserv\ $+ $r.c($3) stats fundador.c %tmp.cfundador
  }
  else { g.db nickserv\ $+ $r.c($3) stats fundador.c 1 }
}

alias chanserv.p.m {
  if ( $l.db(canales.db,modos.c,$r.c($1)) != $null ) {
    %tmp.mcanal = $l.db(canales.db,modos.c,$r.c($1))
    if ( $l.db(chanserv\ $+ $r.c($1),configuracion,mlock) != $null ) { c.mlock $l.db(chanserv\ $+ $r.c($1),configuracion,mlock) }
    if ( $2 !isincs %tmp.mcanal ) && ( $2 !isincs %tmp.m.n ) { g.db canales.db modos.c $r.c($1) %tmp.mcanal $+ $2 }
  }
  else { g.db canales.db modos.c $r.c($1) $2 }
}

alias chanserv.q.m {
  if ( $l.db(canales.db,modos.c,$r.c($1)) != $null ) {
    %tmp.mcanal = $l.db(canales.db,modos.c,$r.c($1))
    if ( $l.db(chanserv\ $+ $r.c($1),configuracion,mlock) != $null ) { c.mlock $l.db(chanserv\ $+ $r.c($1),configuracion,mlock) }
    if ( $2 isincs %tmp.mcanal ) && ( $2 !isincs %tmp.m.p ) { g.db canales.db modos.c $r.c($1) $removecs(%tmp.mcanal,$2) }
  }
}

alias chanserv.create {
  if ( $ca.r($1) == si ) {
    if ( $e.c($1) == SUSPENDIDO ) { return }
    if ( $l.db(chanserv\ $+ $r.c($1),configuracion,mlock) != $null ) {
      %tmp.mlock = $l.db(chanserv\ $+ $r.c($1),configuracion,mlock)
      s : $+ $chanserv MODE $1 %tmp.mlock
      if ( $l.db(chanserv\ $+ $r.c($1),configuracion,clave) != $null ) {
        %tmp.clave = $l.db(chanserv\ $+ $r.c($1),configuracion,clave)
        s : $+ $chanserv MODE $1 +k $decode(%tmp.clave,m)
      }
      if ( $l.db(chanserv\ $+ $r.c($1),configuracion,mlock) != $null ) { c.mlock $l.db(chanserv\ $+ $r.c($1),configuracion,mlock) }
      if ( i isincs %tmp.m.p ) || ( k isincs %tmp.m.p ) || ( R isincs %tmp.m.p ) { j $shadowserv $1 }
      %tmp.c = 0
      while ( %tmp.c < $len(%tmp.m.p) ) {
        inc %tmp.c
        chanserv.p.m $1 $mid(%tmp.m.p,%tmp.c,1)
      }
    }
    if ( $l.db(chanserv\ $+ $r.c($1),configuracion,topic) != $null ) {
      %tmp.topic = $l.db(chanserv\ $+ $r.c($1),configuracion,topic)
      s : $+ $chanserv TOPIC $1 : $+ $p.c(%tmp.topic)
    }
    if ( $e.c($1) == OFICIAL ) && ($l.db(chanserv\ $+ $r.c($1),configuracion,especial) != all) && (!$istok($l.db(chanserv\ $+ $r.c($1),configuracion,especial),5,32)) { j $helpserv $1 }
    if ( $l.db(chanserv\ $+ $r.c($1),configuracion,especial) != $null ) {
      %tmp.especial = $l.db(chanserv\ $+ $r.c($1),configuracion,especial)
      %tmp.especialc = 0
      :e.b
      inc %tmp.especialc
      %tmp.especialb = $gettok(%tmp.especial,%tmp.especialc,32)
      if ( %tmp.especialb == $null ) { goto f.es }
      chanserv.especialj $1 %tmp.especialb
      goto e.b
      :f.es
    }
  }
}

alias chanserv.notice {
  if ( $l.db(chanserv\ $+ $r.c($1),configuracion,debug) == on ) && ( $ex.c($1) == si ) { s : $+ $chanserv NOTICE $1 : $+ $2- }
}

alias chanserv.sf {
  if ( $d(6) == $null ) { m Error de Sintaxis: 12 $+ $upper($d(4)) <canal> <opcion> <parametros> | m 12/msg $chanserv AYUDA SET para más información. | l.v }
  if ( $ca.r($d(5)) == no ) { m El canal12 $d(5) no está registrado. | l.v }
  if ( $e.c($d(5)) == SUSPENDIDO ) { m El canal12 $d(5) está suspendido. | l.v }
  if ( $n.i($o) == no ) { m Debes identificarte antes de utilizar el comando12 $upper($d(4)) $+ . | l.v }
  if ( $l.db(nickserv\ $+ $r.c($o),ifundador,$r.c($d(5))) == $null ) && ( $l.db(chanserv\ $+ $r.c($d(5)),registros,$r.c($o)) == $null ) && ( $l.db(chanserv\ $+ $r.c($d(5)),configuracion,fundador) != $r.c($o) ) && ( $s.n($o) < 5 ) { m 4Permiso denegado. | l.v }
  if ( $l.db(nickserv\ $+ $r.c($o),ifundador,$r.c($d(5))) != $null ) || ( $l.db(chanserv\ $+ $r.c($d(5)),configuracion,fundador) == $r.c($o) ) || ( $s.n($o) >= 5 ) { %tmp.registro.o = 500 }
  else { %tmp.registro.o = $l.db(chanserv\ $+ $r.c($d(5)),registros,$r.c($o)) }
  if ( %tmp.registro.o == $null ) { %tmp.registro.o = 0 }
}

alias espebotnick {
  var %a = 1
  var %b
  while ($gettok($1-,%a,32)) {
    if (%a == 1) {
      if ($gettok($1-,%a,32) == 1) { %b = 12 $+ $centerserv }
      if ($gettok($1-,%a,32) == 2) { %b = 12 $+ $operserv }
      if ($gettok($1-,%a,32) == 3) { %b = 12 $+ $globalserv }
      if ($gettok($1-,%a,32) == 4) { %b = 12 $+ $proxyserv }
      if ($gettok($1-,%a,32) == 5) { %b = 12 $+ $helpserv }
      if ($gettok($1-,%a,32) == 6) { %b = 12 $+ $nickserv }
      if ($gettok($1-,%a,32) == 7) { %b = 12 $+ $noticiasserv }
      if ($gettok($1-,%a,32) == 8) { %b = 12 $+ $chanserv }
      if ($gettok($1-,%a,32) == 9) { %b = 12 $+ $memoserv }
      if ($gettok($1-,%a,32) == 10) { %b = 12 $+ $cregserv }
      if ($gettok($1-,%a,32) == 11) { %b = 12 $+ $shadowserv }
      else { inc %a 1 }
    }
    elseif (%a == $numtok($1-,32)) {
      if ($gettok($1-,%a,32) == 1) { %b = %b y12 $centerserv }
      if ($gettok($1-,%a,32) == 2) { %b = %b y12 $operserv }
      if ($gettok($1-,%a,32) == 3) { %b = %b y12 $globalserv }
      if ($gettok($1-,%a,32) == 4) { %b = %b y12 $proxyserv }
      if ($gettok($1-,%a,32) == 5) { %b = %b y12 $helpserv }
      if ($gettok($1-,%a,32) == 6) { %b = %b y12 $nickserv }
      if ($gettok($1-,%a,32) == 7) { %b = %b y12 $noticiasserv }
      if ($gettok($1-,%a,32) == 8) { %b = %b y12 $chanserv }
      if ($gettok($1-,%a,32) == 9) { %b = %b y12 $memoserv }
      if ($gettok($1-,%a,32) == 10) { %b = %b y12 $cregserv }
      if ($gettok($1-,%a,32) == 11) { %b = %b y12 $shadowserv }
      else { inc %a 1 }
    }
    else {
      if ($gettok($1-,%a,32) == 1) { %b = %b $+ ,12 $centerserv }
      if ($gettok($1-,%a,32) == 2) { %b = %b $+ ,12 $operserv }
      if ($gettok($1-,%a,32) == 3) { %b = %b $+ ,12 $globalserv }
      if ($gettok($1-,%a,32) == 4) { %b = %b $+ ,12 $proxyserv }
      if ($gettok($1-,%a,32) == 5) { %b = %b $+ ,12 $helpserv }
      if ($gettok($1-,%a,32) == 6) { %b = %b $+ ,12 $nickserv }
      if ($gettok($1-,%a,32) == 7) { %b = %b $+ ,12 $noticiasserv }
      if ($gettok($1-,%a,32) == 8) { %b = %b $+ ,12 $chanserv }
      if ($gettok($1-,%a,32) == 9) { %b = %b $+ ,12 $memoserv }
      if ($gettok($1-,%a,32) == 10) { %b = %b $+ ,12 $cregserv }
      if ($gettok($1-,%a,32) == 11) { %b = %b $+ ,12 $shadowserv }
    }
    inc %a 1
  }
  return %b
}

alias chanserv.especialj {
  if ( $2 == ALL ) {
    g.db especial.db especial $r.c($1) all
    j $centerserv $1
    j $operserv $1
    j $globalserv $1
    j $proxyserv $1
    if ( $e.c($1) == OFICIAL ) { j $helpserv $1 }
    j $nickserv $1
    j $noticiasserv $1
    j $chanserv $1
    j $memoserv $1
    j $cregserv $1
    j $shadowserv $1
    j $debugserv $1
    var %a 1
    while ($read(sistema\modulos\modulos.txt,%a)) {
      var %b = $gettok($read(sistema\modulos\modulos.txt,%a),1,32)
      j $ginfo(%b,info,nick) $1
      inc %a 1
    }
  }
  if ( $2 == 0 ) {
    b.db especial.db especial $r.c($1)
    %tmp.m.shadow = $l.db(canales.db,modos.c,$r.c($1))
    if ( $1 != %conf.canal.admins ) && ( $1 != %conf.canal.opers ) { p $centerserv $1 }
    if ( $1 != %conf.canal.admins ) && ( $1 != %conf.canal.opers ) { p $operserv $1 }
    p $globalserv $1
    p $proxyserv $1
    if ( $e.c($1) != OFICIAL ) { p $helpserv $1 }
    p $nickserv $1
    p $noticiasserv $1
    p $chanserv $1
    p $memoserv $1
    p $cregserv $1
    if ( k !isincs %tmp.m.shadow ) && ( i !isincs %tmp.m.shadow ) && ( R !isincs %tmp.m.shadow ) { p $shadowserv $1 }
    p $debugserv $1
    var %a 1
    while ($read(sistema\modulos\modulos.txt,%a)) {
      p $ginfo($gettok($read(sistema\modulos\modulos.txt,%a),1,32),info,nick) $1
      inc %a 1
    }
  }
  if ( $2 == 1 ) { j $centerserv $1 }
  if ( $2 == 2 ) { j $operserv $1 }
  if ( $2 == 3 ) { j $globalserv $1 }
  if ( $2 == 4 ) { j $proxyserv $1 }
  if ( $2 == 5 ) { j $helpserv $1 }
  if ( $2 == 6 ) { j $nickserv $1 }
  if ( $2 == 7 ) { j $noticiasserv $1 }
  if ( $2 == 8 ) { j $chanserv $1 }
  if ( $2 == 9 ) { j $memoserv $1 }
  if ( $2 == 10 ) { j $cregserv $1 }
  if ( $2 == 11 ) { j $shadowserv $1 }
  if ( $2 == 12 ) { j $debugserv $1 }
}

alias chanserv.dropc {
  .signal drop canal $1
  flushini $mircdirdatabase\chanserv\ $+ $r.c($1)
  %tmp.ruta = $mircdirdatabase\chanserv\ $+ $r.c($1)
  if ( $initopic( %tmp.ruta , registros ) == 0 ) { goto f.r }
  clear @registrosu
  window -hl @registrosu
  loadbuf -tregistros @registrosu $mircdirdatabase\chanserv\ $+ $1
  %tmp.total = $line(@registrosu,0)
  %tmp.linea = 0
  while ( %tmp.linea < %tmp.total ) {
    inc %tmp.linea
    %tmp.l.linea = $line( @registrosu , %tmp.linea )
    %tmp.nicku = $gettok(%tmp.l.linea,1,61)
    chanserv.b.a $1 $r.c(%tmp.nicku)
  }
  :f.r
  flushini $mircdirdatabase\chanserv\ $+ $r.c($1)
  %tmp.ruta = $mircdirdatabase\chanserv\ $+ $r.c($1)
  if ( $initopic( %tmp.ruta , akicks ) == 0 ) { goto f.a }
  clear @akicksu
  window -hl @akicksu
  loadbuf -takicks @akicksu $mircdirdatabase\chanserv\ $+ $1
  %tmp.total = $line(@akicksu,0)
  %tmp.linea = 0
  while ( %tmp.linea < %tmp.total ) {
    inc %tmp.linea
    %tmp.l.linea = $line( @akicksu , %tmp.linea )
    %tmp.nicku = $gettok(%tmp.l.linea,1,61)
    chanserv.b.ak $1 $r.c(%tmp.nicku)
  }
  :f.a
  if ( $l.db(chanserv\ $+ $r.c($1),configuracion,sucesor) != $null ) {
    %tmp.sucesor = $l.db(chanserv\ $+ $r.c($1),configuracion,sucesor)
    b.db nickserv\ $+ %tmp.sucesor sucesor $r.c($1)
  }
  %tmp.fundador = $l.db(chanserv\ $+ $r.c($1),configuracion,fundador)
  p $shadowserv $1
  if ( $l.db(chanserv\ $+ $r.c($1),estado,$1) == OFICIAL ) { p $helpserv $1 }
  if ( $l.db(chanserv\ $+ $r.c($1),configuracion,especial) != $null ) {
    p $centerserv $1
    p $operserv $1
    p $globalserv $1
    p $proxyserv $1
    p $helpserv $1
    p $nickserv $1
    p $noticiasserv $1
    p $chanserv $1
    p $memoserv $1
    p $cregserv $1
    p $shadowserv $1
  }
  b.db nickserv\ $+ $r.c(%tmp.fundador) fundador $r.c($1)
  if ( $l.db(canales.db,canales.u,$r.c($1)) != $null ) { b.db canales.db canales.u $r.c($1) }
  if ( $l.db(canales.db,modos.c,$r.c($1)) != $null ) { b.db canales.db modos.c $r.c($1) }
  .remove $mircdirdatabase\cregserv\canales\ $+ $r.c($1)
  .remove $mircdirdatabase\chanserv\ $+ $r.c($1)
  a.t C:: $+ $1
}



alias chanserv.auto-limit {
  if ($l.db(chanserv\ $+ $r.c($1),configuracion,autolimit)) {
    var %u = $l.db(canales.db,canales.u,$r.c($1))
    var %b = $l.db(canales.db,canales.b,$r.c($1))
    .timerautolimit- [ $+ [ $1 ] ] 1 3 s : $+ $chanserv mode $1 +l $calc(%u + %b +3)
  }
}

on 1:signal:cmmodes:{
  if (*l* iswmcs $2) && ($l.db(chanserv\ $+ $1,configuracion,autolimit)) { chanserv.auto-limit $1 }
}

alias chanserv.espe.mira {
  var %a 1
  var %b = $finddir(sistema\modulos\,*,0,1)
  while (%a <= %b) {
    if ($readini(database\especial.db,modulos,$finddir(sistema\modulos\,*,%a,1))) { }
    else {
      writeini database\especial.db modulos $calc(12 + $ini(database\especial.db,modulos,0)) $nopath($finddir(sistema\modulos\,*,%a,1))
    }
    inc %a 1
  }
}
