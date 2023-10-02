import wollok.game.*

object messi {
				var puntaje = 0
  				var property position = game.origin()
  				method image() = "messi.png"
  				method centrar() {position = game.center()}
				method ganar(puntos){ puntaje = puntaje + puntos }
				method puntaje() = puntaje
}

object tablero{ 
				method text() =  "Puntos:" + messi.puntaje()
				method position() = game.at(10,game.height()-1)
}
class Pelotasdefutbol{  
						var position
						var puntos = 1 
						method position() = position 
						method image() = "pelota.jpg"
						method desaparecer(){ 
							game.removeVisual(self)
							messi.ganar(puntos)}
 }

object pantalla{
				var cantAutos = 10
				method iniciar() {
				self.configurarInicio()
				self.agregarVisuales()
				self.programarTeclas()
				self.definirColisiones()}
				method configurarInicio() {
											game.height(10)
											game.width(23)
											game.title("juego MESIAS")}
				method agregarVisuales() {
											game.addVisualCharacter(messi)
											cantAutos.times({
											i => game.addVisual(new Pelotasdefutbol(position = game.at(i+3,10)))})
											game.addVisual(tablero)}
				method programarTeclas() {
											//TODO: Código autogenerado }
											}
				method definirColisiones() {game.onCollideDo(messi,{algo => algo.desaparecer() }) }	
}
