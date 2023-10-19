import wollok.game.*
import general.*

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
}

object similarPacman{var property image = "pacman.png"
					var property position = pacman.position()
					method chocarConRival(rival){}
					method vidas(){}
					method desaparece(){}
					method quitarpuntos(){}
}

object fantasma{
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
	method desaparecer(){}
	method quitarpuntos(){}
}
object fantasma2{
	var property image = "rival2.png"
	var property position = game.at(7,4)
	
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

//Visual para puntaje 

object paleta { const property blanco="FFFFFF"}
object vidaGrafico{
				const property blanco="FFFFFF"
				method textColor()=paleta.blanco()
				method text()="VIDAS:" + pacman.vidas()
				method position() = game.at(16,9)
				method acercarseA_(personaje){}
				method chocarConRival(rival){}
				method desaparece(){}	
				method quitarpuntos(){}	
}
object puntaje{
				const property blanco="FFFFFF"
				method textColor()=paleta.blanco()
				method text()="PUNTOS:" + pacman.puntos()
				method position() = game.at(16,8)
				method acercarseA_(personaje){}
				method chocarConRival(rival){}	
				method desaparece(){}
				method quitarpuntos(){}	
}
object puntajeFinal{
				const property blanco="FFFFFF"
				method textColor()=paleta.blanco()
				method text()="PUNTOS:" + pacman.puntos()
				method position() = game.at(9,0)
				method acercarseA_(personaje){}
				method chocarConRival(rival){}
				method desaparece(){}					
}

class Fruta{ 
	const cherry = "cherry.png"
	const banana = "banana.png"
	const sandia = "sandia.png"
	var property position=game.origin()
	var property x=0
	var property image= self.imagen()
	
	method desaparece(){
		game.removeVisual(self)
		pacman.ganapuntos(20)
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
		pacman.ganapuntos(10)
	}
	method chocarConRival(rival){}	
	method quitarpuntos(){}
	
}
class Bonus inherits Pelotita { 
	override method desaparece(){
		super()
		pacman.ganaVida()}}
	

object tableroFinal{
	var property position = game.at(2,1)
	var property image = "pantallaganador2.jpeg"
	method desaparece(){}
}
class Muro{ 

	
	var property image=" "
	var property position = 0
	method quitarpuntos () { 
		pacman.pierdepuntos()
		
	}
	method chocarConRival(rival){}
	method desaparece(){}
}
object superBonus {
	const x= 0.randomUpTo(5).roundUp()
	const y=0.randomUpTo(10).roundUp()
	var property image= "key.png"
	var property position=game.at(x,y)
	method desaparece(){
		game.say(pacman,"¡¡+3000!!!")
		game.removeVisual(self)
		pacman.ganapuntos(3000)
	}
	method chocarConRival(rival){}
	method vidas(){}
	
	method quitarpuntos(){}
}
