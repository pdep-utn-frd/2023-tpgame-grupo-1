import wollok.game.*
import general.*

//// Objetos juegos General

object pacman {
	var property ganador = 5000
	var property image = "pacman.png"
	var property position = game.origin()
	var property vidas = 3
	var property puntos = 0
	
	method perderVida(){
		vidas = vidas - 1
		position = game.origin()
	}
	method ganaVida(){vidas=vidas+1}
	method ganapuntos(p){
		puntos=puntos+p
		if (puntos > 5000){finalDeJuego.finJuego()}
		}
	method chocarConRival(rival){
		self.perderVida()
		rival.position(game.at(5,5))
	}
	method pierdepuntos(){ 
		puntos=puntos-50
		position=game.at(0,0)}
	
	method desaparece(){}
	method mostrarPuntos(){return puntos}
}

object similarPacman{var property image = "pacman.png"
					var property position = pacman.position()
					method chocarConRival(rival){}
					method vidas(){}
					method desaparece(){}
					method quitarpuntos(){}
}

class Fantasma{
	var property image = "rival1.png"
	var property position = game.at(5,2)
	
	method acercarseA_(personaje){
		var posicionPacman = personaje.position()
		var newX = position.x() + if(posicionPacman.x() > position.x()) {1} else {-1}
		var newY = position.y() + if(posicionPacman.y() > position.y()) {1} else {-1}
		
		position = game.at(newX, newY)
	}
	method chocarConRival(rival){}
	method vidas(){}
	method desaparece(){}
	method quitarpuntos(){}
}

class Fruta{ 
	const cherry = "cherry.png"
	const banana = "banana.png"
	const sandia = "sandia.png"
	var property position 
	var property x=0
	var property image= self.imagen()
	
	method desaparece(){
		game.removeVisual(self)
		pacman.ganapuntos(50)
	}
	method imagen(){
		x = 0.randomUpTo(3).roundUp()
		if (x==1){
			 return cherry
		}else if(x==2){
			return banana
		}else{
			return sandia
		}	
	}
	method chocarConRival(rival){}
	method quitarpuntos(){}
}

class Pelotita{ 
	var property image="pelita.png"
	 var property position = game.origin()
	method desaparece() {
		game.removeVisual(self)
		pacman.ganapuntos(20)
	}
	method chocarConRival(rival){}	
	method quitarpuntos(){}
	
}
class Bonus inherits Pelotita { 
	override method desaparece(){
		super()
		pacman.ganaVida()}}

class Muro{ 
	var property image=" "
	var property position = 0
	method quitarpuntos () { 
		pacman.pierdepuntos()
		
	}
	method chocarConRival(rival){}
	method desaparece(){}
}
class SuperBonus inherits Pelotita {

	override method desaparece(){
		game.say(pacman,"¡¡+3000!!!")
		game.removeVisual(self)
		pacman.ganapuntos(3000)
	}
}

////////VISUALES:
object paleta { const property blanco="FFFFFF"}

class Vidas{
				const property blanco="FFFFFF"
				var property position
				method text()= "VIDAS:" + pacman.vidas()
				method textColor()=paleta.blanco()
				method acercarseA_(personaje){}
				method chocarConRival(rival){}
				method desaparece(){}	
				method quitarpuntos(){}	
}
class Puntajes inherits Vidas{
				override method text()="PUNTOS:" + pacman.puntos()
}

object tableroFinal{
	var property position = game.at(2,1)
	var property image = "pantallaganador2.jpeg"
	method desaparece(){}
}

///// Finalizar Juego		
object finalDeJuego{
				const musicaGanador =game.sound("PacmanVictoria.mp3")					
				method finJuego(){
								game.clear()
								game.addVisual(tableroFinal)
								lanzar.agregarMusica(false)
								game.schedule(500, {musicaGanador.play()})
								keyboard.enter().onPressDo({game.stop()})}
								
}

object finPorDerrota{

				  const musicaPerdedor =game.sound("PacmanDerrota.mp3")
				  method terminar(){
				  					game.clear()
				  					lanzar.agregarMusica(false)
									game.schedule(500, {musicaPerdedor.play()})
									keyboard.enter().onPressDo({game.stop()})
									
				  }
				  method image()= "gamerOver.jpeg"
				  method position()= game.at(3,1)
}
