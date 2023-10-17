import wollok.game.*
import Juego.*

object lanzar{	
				const musica = game.sound("Pacman.mp3")
				var property momentanea
				var pause= false
				method iniciar(){
								self.configurarInicio()
								self.agregarVisuales()
								self.programarTeclas()
								self.agregarColisiones()
								self.agregarMusica()
								game.start()}
				method configurarInicio(){game.width(18)
										game.height(10)
										game.cellSize(50)
										game.title("PACMAN")}
				method agregarVisuales(){
										game.boardGround("fondo.jpg")	
										game.addVisualCharacter(pacman)
										game.addVisual(fantasma)
										game.addVisual(fantasma2)
										game.addVisual(puntaje)
										game.addVisual(vidaGrafico)}
				method pausa(){if (pause == false){game.removeTickEvent("aparece fruta")
													game.removeTickEvent("movimiento1")
													game.removeTickEvent("movimiento")
													momentanea= pacman.position()
													game.removeVisual(pacman)
													game.addVisual(similarPacman)
													similarPacman.position(momentanea)
													pause = true} 
													else{
													game.onTick(6000,"aparece fruta",{game.addVisual
													(new Fruta(position=game.at(0.randomUpTo(game.width()).truncate(0),
													0.randomUpTo(game.height()).truncate(0))))})
													game.onTick(1.randomUpTo(5) * 800, "movimiento", {fantasma2.acercarseA_(pacman)})
													game.onTick(1.randomUpTo(5) * 300, "movimiento1", {fantasma.acercarseA_(pacman)})
													pause = false
													game.removeVisual(similarPacman)
													game.addVisual(pacman)
													pacman.position(momentanea)}}
				method programarTeclas() {
										keyboard.enter().onPressDo({game.stop()})
										keyboard.space().onPressDo({self.pausa()})
										keyboard.p().onPressDo({musica.stop()})
				}
				method agregarColisiones(){
										game.whenCollideDo(fantasma,{personaje => personaje.chocarConRival(fantasma)
															if(pacman.vidas() == 0){finDeJuego.terminar()
																					game.addVisual(finDeJuego)
																					game.addVisual(puntajeFinal)}})
										game.onTick(1.randomUpTo(5) * 300, "movimiento1", {fantasma.acercarseA_(pacman)})
										//Fantasma Azul	
										game.whenCollideDo(fantasma2,{personaje => personaje.chocarConRival(fantasma)
															if(pacman.vidas() == 0){finDeJuego.terminar()
																					game.addVisual(finDeJuego)
																					game.addVisual(puntajeFinal)}})
										game.onTick(1.randomUpTo(5) * 800, "movimiento", {fantasma2.acercarseA_(pacman)})
										game.onTick(6000,"aparece fruta",{game.addVisual
											(new Fruta(position=game.at(0.randomUpTo(game.width()).truncate(0),
											0.randomUpTo(game.height()).truncate(0))))})}
											}
object finalDeJuego{						
				method finJuego(){
								game.removeVisual(pacman)
								game.removeVisual(fantasma)
								game.removeVisual(fantasma2)
								game.removeVisual(puntaje)
								game.removeVisual(vidaGrafico)
								game.addVisual(tableroFinal)
								game.removeTickEvent("aparece fruta")
								game.removeTickEvent("movimiento1")
								game.removeTickEvent("movimiento")}
}
//	game.onCollideDo(Fruta ,{
//		personaje => personaje.chocarConRival(fantasma)
//		if(pacman.vidas() == 0){
//			finDeJuego.terminar()
//			game.addVisual(finDeJuego)
//			game.addVisual(puntajeFinal)
//		}
//	})
	//
						
