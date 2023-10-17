import wollok.game.*
import Juego.*

object lanzar{
				method iniciar(){
								self.configurarInicio()
								self.agregarVisuales()
								self.programarTeclas()
								self.agregarColisiones()
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
				method programarTeclas() {
										keyboard.enter().onPressDo({game.stop()})
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
//	game.onCollideDo(Fruta ,{
//		personaje => personaje.chocarConRival(fantasma)
//		if(pacman.vidas() == 0){
//			finDeJuego.terminar()
//			game.addVisual(finDeJuego)
//			game.addVisual(puntajeFinal)
//		}
//	})
	//
						
