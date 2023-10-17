import wollok.game.*
import general.*
object pacman {
	var property ganador = 20
	var property image = "pacman.png"
	var property position = game.origin()
	var property vidas = 2
	var property puntos = 0
	
	method perderVida(){
		vidas = vidas - 1
		position = game.origin()
	}
	method ganapuntos(p){
		puntos=puntos+p
		finalDeJuego.finJuego()}
	method chocarConRival(rival){
		self.perderVida()
		rival.position(game.at(5,5))
	}
	
}

object similarPacman{var property image = "pacman.png"
					var property position = pacman.position()
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
}
object puntaje{
				const property blanco="FFFFFF"
				method textColor()=paleta.blanco()
				method text()="PUNTOS:" + pacman.puntos()
				method position() = game.at(16,8)
				method acercarseA_(personaje){}
				method chocarConRival(rival){}				
}
object puntajeFinal{
				const property blanco="FFFFFF"
				method textColor()=paleta.blanco()
				method text()="PUNTOS:" + pacman.puntos()
				method position() = game.at(9,0)
				method acercarseA_(personaje){}
				method chocarConRival(rival){}				
}
//Visual para terminar el juego 

object finDeJuego{
				  method terminar(){
				  					game.removeVisual(fantasma)
				  					game.removeVisual(fantasma2)
				  					game.removeVisual(pacman)
				  					game.removeVisual(puntaje)
				  					game.removeVisual(vidaGrafico)
				  }
				  method image()= "gameOver.png"
				  method position()= game.at(1,0)
}

class Fruta{ 
	const cherry = "cherry.png"
	const banana = "banana.png"
	const sandia = "sandia.png"
	var property position=game.origin()
	var property x=0
	var property image= self.imagen()
	
	method desaparecer(){
		game.removeVisual(self)
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
	
}

class Pelota{ 
	var property image ="pelotitas.png"
	var property position= game.origin()
	
	const x=0.randomUpTo(18)
	const y=0.randomUptTo(10)
	method desaparecer() {
		game.removeVisual(self)
	}
	method aparecer(){
		20.times(game.addVisual(new Pelota(position=game.at(x,y))))
	}
}


object tableroFinal{
	var property position = game.at(0,0)
	var property image = "PantallaFinal.png"
}


