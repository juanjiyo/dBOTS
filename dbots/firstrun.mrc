on 1:start:{
  .timerfirstrun1 1 1 firstrun
}

alias firstrun {
  window -ak @Inicio
  < Est� es la primera vez que ejecutar los dBoTs043
  <
  < Con lo cual, para que sepas como poder configurarlos y usarlos del modo correcto, te voy a echar una mano...
  <
  < Lo primero que vamos a hacer es abrir el panel de configuraci�n, y as� podr�s configurar los bots...
  < Para ello, haz doble click12 AQUI y se abrira el panel...
  < Si tienes dudas de alguna de las opciones, veras un bot�n 4? que te dar� informaci�n y ayuda de que hacer...
  <
  < Una vez configurados los bots, deber�s crear dos links en el unrealircd.conf
  < Uno para debug.server (Para ver las opciones deberas abrir el archivo dbots.conf y ojear abajo del todo del nombre del servidor, password, y de m�s... y si quieres modificar algo, pues ese es el momento)
  < Y el otro, l�gicamente, para los bots...
  <
  < Cabe destacar que desde la versi�n4 3.5 de los dBoTs, debug ya no es un m�dulo, si no que es un bot mas, y muy importante a la hora de que las BDDs est�n correctamente.
  < Con lo cual, el primer servidor en conectar es el de debug y luego, cuando este haya conectado, conectaran los bots...
  <
  < Tambi�n tendr�s que a�adirlos como U:Lines, ya que si no lo haces, no funcionaran bien algunas funciones de los bots...
  <
  < Por ultimo dir� que si cambias algo estando los bots conectados, para que los cambios surjan efecto deber�s reiniciar los bots...
  < L�gicamente dir� que es preferible y 4ACONSEJABLE que no se cambien cosas de la configuraci�n de los bots estando estos conectados...
  <
  < Sin mas, os doy las gracias por apoyarme en este trabajo, que en un principio fue mi ilusi�n para usar Unreal IRCd + UDB, ya que sin vosotros, seguramente no me abr�a esforzado tanto en estos services...
  <
  <
  < Agradecimientos:
  <
  < - 12Davidlig: Por todo el trabajo que hiciste desde que empezaste los dBoTs para Unreal IRCd, por que si tu no hubieras hecho esto, yo no lo abr�a seguido... Gracias, de verdad...
  <
  < - 12Eric: Por estar siempre ah�, al pie del ca��n... y por dejarme bots que hab�as creado para ponerlos como m�dulos de los dbots.
  <
  < - 12JcRs: Por todas las sugerencias que me has dado.
  <
  < - 12Masterix: Por estar en mi red, a pesar de poder estar en otras de mejor calidad...
  <
  < - 12rubenwilson: Por tus aportaciones, tus ideas y sugerencias... 
  <
  < - 12^_Dream_^: Por todos esos bus y errores reportados, y sobre todo por esas dos shells que, junto con MaSTeRiX, ten�is pensando poner para esta red.
  < 
  < - 12JimeMC: Por tus sugerencias y ayudas! Que siempre que tenia alguna cosa que me fastidiaba me echabas un cable...
  <
  < - A todos los que entr�is en la red, ya sea por el inter�s en los dbots... por la compa��a o los amigos, o simplemente porque os gusta estar aqu�.
  <
  < - Y como no, un especial agradecimiento a todos los que me hab�is comunicado errores, bugs, erratas... o cualquier otra cosa que haya ayudado a mejorar los dBoTs...
  <
}

alias < echo @inicio $iif($1,$1-,)

on ^1:HOTLINK:aqu�:*:return
on 1:hotlink:aqu�:*:if ($active == @inicio) { conf }

menu @inicio {
  C E R R A R:firstrunend
}

alias firstrunend {
  window -c @inicio
  .unload -rs $script
}
