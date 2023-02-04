alias sock {
  if ($sock(debug.server)) { sockwrite -nt debug.server $1- }
  else { sockopen debug.server $l.conf(debugserv,sip) $l.conf(debugserv,sport) }
}

on 1:sockopen:debug.server:{
  if ($sockerr > 0) {
    v.bots 4Error: No se ha podido establecer la conexión.
    v.bots Error4 $sockerr $+ : $sock($sockname).wsmsg
    return
  }
  window -ke @debug.server
  v.bots 3Correcto: Conexión de debug realizada con éxito.
  sock PROTOCTL UMODE2 NICKv2 $+(UDB,$l.conf(otras,udb),=,%conf.servidor)
  sock pass $l.conf(debugserv,spass)
  sock SERVER $l.conf(debugserv,sname) 69 : $+ $l.conf(debugserv,sdesc)
  sock : $+ $debugserv join $l.conf(debugserv,canal.debug)
  sock : $+ $debugserv mode $l.conf(debugserv,canal.debug) +qntis $debugserv
  sock : $+ $debugserv topic $l.conf(debugserv,canal.debug) Canal de debug de la red
  .timerdebug.ping 0 90 debug.ping
}

on 1:sockread:debug.server:{
  sockread %debug.server
  tokenize 32 $iif(:* iswm %debug.server,$right(%debug.server,-1),%debug.server)
  if ($1 == PING) { sock : $+ $l.conf(debugserv,sname) PONG $l.conf(debugserv,sname) $2 | return }
  elseif ($2 == PONG) { .timerdebug.ping.nr off | halt }
  elseif ($2 == away) { }
  elseif ($1 == NETINFO) { sockopen dbots %conf.ip %conf.puerto }
  elseif ($2 == DB) {
    if ($1 == %conf.servidor) && ($4 == INS || $4 == DEL) && (*::* iswm $6) && ($read(database\bdd.db,1)) { toca.bdd | halt }
  }
  else {
    echo @debug.server ( $+ $date - $time $+ ) => $1-
    .signal debug $1-
  }
  unset %debug.server
}

off 1:sockclose:debug:socklisten descucha $binfo(config,port)

on 1:sockread:dbots:{
  tokenize 32 $iif(:* iswm %datos,$right(%datos,-1),%datos)
  if ($1 == NICK) && ($4 isnum) && ($7) {
    debugc $debugserv $l.conf(debugserv,canal.debug) 3Conecta:12 NICK: $2 12IDENT: $5 12IP/HOST: $6 12REALNAME: $right($11-,-1) $+  $iif($right($9,-1),12MODOS: $9) 12SERVIDOR: $7
  }
  elseif ($2 == MODE) {
    if (#* iswm $3) {
      if (+ isin $4 || - isin $4) && ($right($4,-1)) {
        debugc $debugserv $l.conf(debugserv,canal.debug) 12 $+ $1 cambia modos de12 $3 a12 $iif($gettok($4-,$numtok($4-,32),32) isnum && . isin $1,$gettok($4-,1- $+ $calc($numtok($4-,32)-1),32),$4-)
      }
    }
    else {
      debugc $debugserv $l.conf(debugserv,canal.debug) 12 $+ $1 cambia modos a:12 $right($4-,-1)
    }
    if ($level($1) == bot) && (!$script($1 $+ .mrc)) {
      mmode $iif(:* iswm $1-,$right($1-,-1),$1-)
    }
  }
  elseif ($2 == NICK) {
    debugc $debugserv $l.conf(debugserv,canal.debug) 12 $+ $1 cambia de nick a12 $3
    if (%away. [ $+ [ $1 ] ]) {
      set %away. [ $+ [ $3 ] ] %away. [ $+ [ $1 ] ]
      set %away.c. [ $+ [ $3 ] ] %away.c. [ $+ [ $1 ] ]
    }
  }
  elseif ($2 == JOIN) {
    if ($chr(44) isin $3) {
      debugc $debugserv $l.conf(debugserv,canal.debug) 12 $+ $1 entra a los canales12 $3
    }
    else {
      debugc $debugserv $l.conf(debugserv,canal.debug) 12 $+ $1 entra al canal12 $3
    }
  }
  elseif ($2 == PART) {
    if ($chr(44) isin $3) {
      if ($4) {
        debugc $debugserv $l.conf(debugserv,canal.debug) 12 $+ $1 sale de los canales12 $3 con el mesanje: $right($4-,-1)
      }
      else {
        debugc $debugserv $l.conf(debugserv,canal.debug) 12 $+ $1 sale de los canales12 $3
      }
    }
    else {
      if ($4) {
        debugc $debugserv $l.conf(debugserv,canal.debug) 12 $+ $1 sale del canal12 $3 con el mensaje: $right($4-,-1)
      }
      else {
        debugc $debugserv $l.conf(debugserv,canal.debug) 12 $+ $1 sale del canal12 $3
      }
    }
  }
  elseif ($2 == TOPIC) {
    if ($right($6-,-1)) {
      debugc $debugserv $l.conf(debugserv,canal.debug) 12 $+ $1 cambia el topic de12 $3 por: $right($6-,-1)
    }
    else {
      debugc $debugserv $l.conf(debugserv,canal.debug) 12 $+ $1 quita el topic de12 $3 
    }
  }
  elseif ($2 == QUIT) {
    debugc $debugserv $l.conf(debugserv,canal.debug) 4Desconecta:12 NICK: $1 12( $right($3-,-1) 12)
  }
  elseif ($2 == away) {
    if ($3) {
      if (*©* iswm $3-) {
        var %a = $iif($3 == :©,$4-,$gettok($3-,$calc($findtok($3-,©,1,32) + 1) $+ -,32))
        if (%away. [ $+ [ $1 ] ]) {
          if (%a != %away. [ $+ [ $1 ] ]) {
            set %away. [ $+ [ $1 ] ] %a
            debugc $debugserv $l.conf(debugserv,canal.debug) 12 $+ $1 Cambia el mensaje de away:12 %a
          }
        }
        else {
          set %away. [ $+ [ $1 ] ] %a
          set %away.c. [ $+ [ $1 ] ] $ctime
          debugc $debugserv $l.conf(debugserv,canal.debug) 12 $+ $1 se ausenta, mensaje:12 %a
        }
      }
      else {
        if (:[*]* iswm $3-) && (min isin $3- || hr isin $3- || sec isin $3-) {
          var %a =  $gettok($3-,2-,93)
          if (%away. [ $+ [ $1 ] ]) {
            if (%a != %away. [ $+ [ $1 ] ]) {
              set %away. [ $+ [ $1 ] ] %a
              debugc $debugserv $l.conf(debugserv,canal.debug) 12 $+ $1 Cambia el mensaje de away:12 %a
            }
          }
          else {
            set %away. [ $+ [ $1 ] ] %a
            set %away.c. [ $+ [ $1 ] ] $ctime
            debugc $debugserv $l.conf(debugserv,canal.debug) 12 $+ $1 se ausenta, mensaje:12 %a
          }
        }
        else {
          if (%away. [ $+ [ $1 ] ]) {
            if ($right($3-,-1) != %away. [ $+ [ $1 ] ]) {
              set %away. [ $+ [ $1 ] ] $right($3-,-1)
              debugc $debugserv $l.conf(debugserv,canal.debug) 12 $+ $1 Cambia el mensaje de away:12 $right($3-,-1)
            }
          }
          else {
            set %away. [ $+ [ $1 ] ] $right($3-,-1)
            set %away.c. [ $+ [ $1 ] ] $ctime
            debugc $debugserv $l.conf(debugserv,canal.debug) 12 $+ $1 se ausenta, mensaje:12 $right($3-,-1)
          }
        }
      }
    }
    else {
      if (%away. [ $+ [ $1 ] ]) {
        var %a = $ctime
        var %b = %away.c. [ $+ [ $1 ] ]
        debugc $debugserv $l.conf(debugserv,canal.debug) 12 $+ $1 deja de estar ausente tras12 $replace($duration($calc($ctime - %b)),wk,$+($chr(32),semana),day,$+($chr(32),dia),hr,$+($chr(32),hora),min,$+($chr(32),minuto),sec,$+($chr(32),segundo)) $+ .
        unset %away. [ $+ [ $1 ] ]
        unset %away.c. [ $+ [ $1 ] ]
      }
    }
  }
  elseif ($2 == help) {
    if ($3 == USERCMDS || $3 == OPERCMDS || $3 == SVSCMDS || $3 == UMODES || $3 == SNOMASKS || $3 == CHMODES || $3 == OFLAGS) {
      s : $+ $helpserv %conf.metodo $1 :He visto que pides ayuda sobre el tema12 $3 $+ , para ver la ayuda has de poner 4? delante:
      s : $+ $helpserv %conf.metodo $1 :/helpop 4?12 $+ $3
    }
    elseif ($istok(ADMIN.LICENSE.PART.USERHOST.AWAY.LINKS.PING.USERIP.CREDITS.LIST.PONG.VERSION.CYCLE.LUSERS.PRIVMSG.VHOST.DALINFO.MAP.QUIT.WATCH.DCCALLOW.MODE.RULES.WHO.INVITE.MODULE.SETNAME.WHOIS.ISON.MOTD.SILENCE.WHOWAS.JOIN.NAMES.STATS.KICK.NICK.TIME.KNOCK.NOTICE.TOPIC,$3,46)) {
      s : $+ $helpserv %conf.metodo $1 :He visto que pides ayuda sobre el tema12 $3 $+ , para ver la ayuda has de poner 4? delante:
      s : $+ $helpserv %conf.metodo $1 :/helpop 4?12 $+ $3
    }
    elseif ($istok(ADCHAT.DNS.NACHAT.SETIDENT.ADDMOTD.GLINE.OPER.SHUN.ADDOMOTD.GLOBOPS.OPERMOTD.SPAMFILTER.CHATOPS.GZLINE.REHASH.SQUIT.CHGHOST.HTM.RESTART.TEMPSHUN.CHGIDENT.KILL.RPING.TRACE.CHGNAME.KLINE.SAJOIN.TSCTL.CLOSE.LAG.SAMODE.UNDCCDENY.CONNECT.LOCOPS.SAPART.WALLOPS.DCCDENY.MKPASSWD.SDESC.ZLINE,$3,46)) {
      s : $+ $helpserv %conf.metodo $1 :He visto que pides ayuda sobre el tema12 $3 $+ , para ver la ayuda has de poner 4? delante:
      s : $+ $helpserv %conf.metodo $1 :/helpop 4?12 $+ $3
    }
    elseif ($istok(SQLINE.SVSKILL.SVSNLINE.SVSSILENCE.SVS2MODE.SVSLUSERS.SVSNOLAG.SVSSNO.SVS2SNO.SVSMODE.SVSNOOP.SVSWATCH.SVSFLINE.SVSMOTD.SVSO.SWHOIS.SVSJOIN.SVSNICK.SVSPART.UNSQLINE,$3,46)) {
      s : $+ $helpserv %conf.metodo $1 :He visto que pides ayuda sobre el tema12 $3 $+ , para ver la ayuda has de poner 4? delante:
      s : $+ $helpserv %conf.metodo $1 :/helpop 4?12 $+ $3
    }
    else {
      s : $+ $helpserv NOTICE @#opers_help :12 $+ $1 necesita ayuda sobre:12 $3-
      s : $+ $helpserv privmsg conf.canal.opers :12 $+  $1 está buscando ayuda sobre12 $3- 6( /helpop $3- 6)
    }
  }
  elseif ($1 == SERVER) {
    debugc $debugserv $l.conf(debugserv,canal.debug) Servidor12 $2 6( $+ $5- $+ 6) entra en la red.
  }
  elseif ($2 == SERVER) {
    debugc $debugserv $l.conf(debugserv,canal.debug) Servidor12 $3 6( $+ $right($5-,-1) $+ 6) entra en la red.
  }
  elseif ($2 == SETHOST) {
    debugc $debugserv $l.conf(debugserv,canal.debug) Cambio de 12VHOST sobre12 $1 $+ : $3
  }
  elseif ($1 == TOPIC) {
    debugc $debugserv $l.conf(debugserv,canal.debug) 12TOPIC del canal12 $2 $+ : $right($5-,-1)
  }
  elseif ($2 == KICK) {
    debugc $debugserv $l.conf(debugserv,canal.debug) 12 $+ $1 expulsa a12 $4 del canal12 $3 $+ , motivo: $right($5-,-1)
  }
  elseif ($1 == SQUIT) {
    debugc $debugserv $l.conf(debugserv,canal.debug) Servidor12 $2 sale de la red: $right($3-,-1)
  }
  elseif ($2 == KILL) {
    if (*(?)* iswm $1-) { }
    else { debugc $debugserv $l.conf(debugserv,canal.debug) 12 $+ $1 4KILLea a12 $3 $+ : $remove($5-,$chr(40),$chr(41)) }
  }
  elseif ($2 == SETNAME) {
    debugc $debugserv $l.conf(debugserv,canal.debug) 12 $+ $1 usa12 SETNAME: $right($3-,-1)
  }
  elseif ($2 == CHGHOST) {
    debugc $debugserv $l.conf(debugserv,canal.debug) 12 $+ $1 usa 12CHGHOST sobre12 $3 $+ : $4
  }
  elseif ($2 == CHGIDENT) {
    debugc $debugserv $l.conf(debugserv,canal.debug) 12 $+ $1 usa 12CHGIDENT sobre12 $3 $+ : $4
  }
  elseif ($2 == CHGNAME) {
    debugc $debugserv $l.conf(debugserv,canal.debug) 12 $+ $1 usa 12CHGNAME sobre12 $3 $+ : $right($4-,-1)
  }
  elseif ($2 == SWHOIS) {
    debugc $debugserv $l.conf(debugserv,canal.debug) 12 $+ $1 $iif($right($4-,-1),pone un,4quita el) 12SWHOIS a12 $3 $+ $iif($right($4-,-1),: $right($4-,-1))
  }
  elseif ($2 == CHATOPS) {
    debugc $debugserv $l.conf(debugserv,canal.debug) 12 $+ $1 envia un CHATOPS 6(Mensaje a todos los OPERs6) con el mensaje: $right($3-,-1)
  }
  elseif ($2 = ADCHAT) {
    debugc $debugserv $l.conf(debugserv,canal.debug) 12 $+ $1 envia un ADCHAT 6(Mensaje a todos los ADMINs6) con el mensaje: $right($3-,-1)
  }
  elseif ($2 == NACHAT) {
    debugc $debugserv $l.conf(debugserv,canal.debug) 12 $+ $1 envia un NACHAT 6(Mensaje a todos los NET-ADMINs6) con el mensaje: $right($3-,-1)
  }
  elseif ($2 == UMODE2) {
    debugc $debugserv $l.conf(debugserv,canal.debug) 12 $+ $1 cambia modos a12 $3-
    if ($1 == bidle) && ($3 == +r) {
      s SVS2MODE $1 +kB
    }
  }
  elseif ($2 == SVS2MODE) {
    debugc $debugserv $l.conf(debugserv,canal.debug) 4Modos forzados en12 $3 $+ :12 $4-
  }
  elseif ($1 == SWHOIS) {
    debugc $debugserv $l.conf(debugserv,canal.debug) 12 $+ $1 añadido a12 $2 $+ : $right($3-,-1)
  }
  elseif ($2 == privmsg) { }
  elseif ($2 == notice) { }
  elseif ($1 == PING || $2 == PING) { }
  elseif ($2 == WHOIS) { }
  elseif ($1 == PROTOCTL) { }
  elseif ($2 == ADMIN) { }
  elseif ($2 == INFO) { }
  elseif ($2 == VERSION) { }
  elseif ($1 == PASS) { }
  elseif ($2 == SMO) { }
  elseif ($2 == EOS) { }
  elseif ($2 == TKL) { }
  elseif ($2 == GLOBOPS) { }
  elseif ($2 == DBQ) { }
  elseif ($2 == DB) { }
  elseif ($1 == NETINFO) { }
  elseif ($2 == sendsno) {
    if ($3 === G) && (añadido isin $4-) {
      debugc $debugserv $l.conf(debugserv,canal.debug) 4TEMPSHUN puesto en12 $8 por12 $11 $+ : $12-
    }
    elseif ($3 === G) && (quita isin $4-) { 
      debugc $debugserv $l.conf(debugserv,canal.debug) Elimitando4 TEMPSHUN puesto a12 $9 por3 $12
    }
    elseif ($3 === o) {
      if ($4 == :intento) {
        debugc $debugserv $l.conf(debugserv,canal.debug) 4 $+ $8 intentó identificarse como IRCop...
      }
      else {
        debugc $debugserv $l.conf(debugserv,canal.debug) 12 $+ $right($4,-1) es ahora12 $replace($9-,$chr(40), $+ $chr(40) $+ 4,$chr(41), $+ $chr(41))
      }
    }
    elseif ($3 === e) {
      debugc $debugserv $l.conf(debugserv,canal.debug) 4 $+ $5 de12 $7 $+ : $9-
    }
    elseif ($3 === S) {
      sock : $+ $operserv privmsg %conf.canal.opers :4SPAM detectado desde12 $gettok($5,1,33) $+ : $replace($gettok($10-,2,39),$gettok($8,1,39),4 $+ $gettok($8,1,39) $+ )
    }
    else {
      debugc $debugserv $l.conf(debugserv,canal.debug) 12 $+ $right($4,-1)  $+ $7-
    }
  }
  elseif ($2 isnum) { }
  else {
    if ($1) { debugc $debugserv $l.conf(debugserv,canal.debug) <><><> $1- }
  }
}

alias debug.ping {
  sock PING $l.db(servidores.db,servidor,hub)
  .timerdebug.ping.nr 1 60 debug.ping.nr
}

alias debug.ping.nr {
  .timer* off
  sock : $+ $l.conf(debugserv,sname) SQUIT %conf.servidor :Sin respuesta de $l.db(servidores.db,servidor,hub) $+ 
  .sockclose dbots
  sock : $+ $l.conf(debugserv,sname) SQUIT $l.conf(debugserv,sname) :Sin respuesta de $l.db(servidores.db,servidor,hub) $+ 
  .sockclose debug
  window -c @bots
  window -c @debug
  window -c @debug.server
  .timerdebug.ping.cb 1 5 conectar
}

on 1:input:@debug.server:sock : $+ $1-
