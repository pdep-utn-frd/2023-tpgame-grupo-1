import wollok.game.*

object messi {
				var puntaje = 0
  				var property position = game.origin()
  				method image() = "messi.png"
  				method centrar() {position = game.center()}
				method ganar(puntos){ puntaje = puntaje + puntos }
				method puntaje() = puntaje
				method perder(puntos) {puntaje = puntaje - puntos}
}

object paleta { const property blanco="FFFFFF"}
object tablero{ 
				method text() =  "PUNTOS:" + messi.puntaje()
				method textColor()=paleta.blanco()
				method position() = game.at(9,game.height()-10)
				method movete() {}
				method desaparece(){}
				
			
			}				
object pelotasdefutbol{ 
						var property position = game.center()
						var puntos = 10
						method image() = "copa.png"
						method movete() {
    						const x = 0.randomUpTo(game.width()).truncate(0)
    						const y = 0.randomUpTo(game.height()).truncate(0)
  							  position = game.at(x,y) 
  							  messi.ganar(puntos)
    }
 }
object bobo{ 
						var property position = game.origin()
						var puntos = 10
						method image() = "bobo.png"
						method movete() {
    						const x = 0.randomUpTo(game.width()).truncate(0)
    						const y = 0.randomUpTo(game.height()).truncate(0)
  							  position = game.at(x,y) 
    }
 }
object pantalla{
				method iniciar() {
				self.configurarInicio()
				self.agregarVisuales()
				self.programarTeclas()
				self.definirColisiones()}
				method configurarInicio() {
											game.height(10)
											game.width(20)
											game.title("juego MESIAS")
											game.boardGround("cancha.jpeg")}
				method agregarVisuales() {
											game.addVisualCharacter(messi)
											game.addVisual(pelotasdefutbol)
											game.addVisual(bobo)
											game.addVisual(tablero)
											game.say(messi, "Anda pa alla bobo")
											game.onTick(2000, "movimiento", { bobo.movete() })
											}
				method programarTeclas() {
											//TODO: Código autogenerado }
											}
				method definirColisiones() {
					game.onCollideDo(messi,{pelotasdefutbol=> pelotasdefutbol.movete()})
				}	
}
