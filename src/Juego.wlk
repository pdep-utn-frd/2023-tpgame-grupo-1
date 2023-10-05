import wollok.game.*

object messi {
				var puntaje = 0
  				var property position = game.at(8,8)
  				method image() = "messi.png"
  				method centrar() {position = game.center()}
				method ganar(puntos){ puntaje = puntaje + puntos }
				method puntaje() = puntaje
				method perder(puntos) {puntaje = puntaje - puntos}
}
object mbappe{
				const puntos = -200
				var property position = game.at(6,6)
				method aparecer(){game.addVisual(self)}
				method image()="Mbappe.png"
				method movete(){
							  messi.ganar(puntos)
							  self.desaparecer()
				}
				method desaparecer(){
										game.removeVisual(self)
				}
}
object invisible{
					method position() = game.at(5,5)
					method aparece(){game.removeVisual(self) mbappe.aparecer()}
					method movete(){}
}

object paleta { const property blanco="FFFFFF"}
object tablero{ 
				method text() =  "PUNTOS:" + messi.puntaje()
				method textColor()=paleta.blanco()
				method position() = game.at(9,game.height()-10)
				method movete() {}
				method desaparece(){}
				
			
			}				
object copa{ 
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
class Segundos{ 
						var property position = game.origin()
						var puntos = 10
						method image() = "bobo.png"
						method movete() {}
						method desaparece() {
							game.removeVisual(self)
							messi.perder(puntos)
						}
    						 
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
											game.onTick(6000, "aparecen segundos", {game.addVisual(new Segundos(position=game.at(0.randomUpTo(game.width()).truncate(0),0.randomUpTo(game.height()).truncate(0))))})
											}
				method programarTeclas() {
											//TODO: Código autogenerado }
											}
				method definirColisiones() {
					game.onCollideDo(messi,{pelotasdefutbol=> pelotasdefutbol.movete()})
					game.onCollideDo(messi,{algo=>algo.desaparece()})}
					game.onCollideDo(messi, {invisible =>  game.schedule(3000, { invisible.aparece()}) })
				}	
}
