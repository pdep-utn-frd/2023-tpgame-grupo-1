import wollok.game.*

object pacman {

	var property image = "pacman.png"
	var property position = game.origin()
	var property vidas = 2
	var property puntos = 0
	
	method perderVida(){
		vidas = vidas - 1
		position = game.origin()
	}
	
	method chocarConRival(rival){
		self.perderVida()
		rival.position(game.at(5,5))
	}
	
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
	var property imagen = "cherry.png"
	var property position=game.origin()
	var property x=0
	
	method desaparecer(){
		game.removeVisual(self)
	}
	method image(){
		x = 1.randomUpTo(3).roundUp()
		if (x==1){
			 return "cherry.png"
		}else if(x==2){
			return "banana.png"
		}else{
			return "sandia.png"
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

//class Muro{
//			method image()="muro.jpg"
//			method position(x,y)= game.at(x,y)
//			
//}

