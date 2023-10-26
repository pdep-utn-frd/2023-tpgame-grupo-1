import wollok.game.*
import Juego.*

object lanzar{
				const musica = game.sound("Pacman.mp3")
				const fantasma=new Fantasma()
				const fantasma2=new Fantasma(position=game.at(7,4),image="rival2.png")
				var property momentanea
				var pause = false
				const vidaGrafico= new Vidas(position=game.at(16,9))
				const puntaje= new Puntajes(position=game.at(16,8))
				const puntajeFinal = new Puntajes(position=game.at(9,0))
				method iniciar(){
								self.configurarInicio()
								self.agregarVisuales()
								self.programarTeclas()
								self.agregarColisiones()
								self.agregarMusica(true)
								game.start()}
				method configurarInicio(){game.width(18)
										game.height(10)
										game.cellSize(50)
										game.title("PACMAN")}
				method agregarMusica(auxiliar){ if (auxiliar == true){musica.shouldLoop(true)
																game.schedule(500, { musica.play()})}
												else {musica.stop()}}
				method agregarVisuales(){
										game.boardGround("Fondo.png")	
										game.addVisual(puntaje)
										game.addVisual(vidaGrafico)
										10.times{j=>35.times({i=>game.addVisual(new Pelotita(position =game.at(i-2,j)))})}
										4.times({i=>game.addVisual(new Muro(image="muro1.png",position=game.at(i*4,1+i)))})
										4.times({i=>game.addVisual(new Muro(image="muro2.png",position=game.at(i*4,2+i)))})
										4.times({i=>game.addVisual(new Muro(image="muro3.png",position=game.at(i*4,3+i)))})
										game.addVisualCharacter(pacman)
										game.addVisual(fantasma)
										game.addVisual(fantasma2)}
										
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
				method programarTeclas(){
										keyboard.enter().onPressDo({game.stop()})
										keyboard.space().onPressDo({self.pausa()})
										keyboard.p().onPressDo({musica.stop()})
				}
				method posicion(){return 0.randomUpTo(10)}
				method agregarColisiones(){
										//Fantasma Rojo
										game.whenCollideDo(fantasma,{personaje => personaje.chocarConRival(fantasma)
															if((pacman.vidas()==0)|| (pacman.puntos()<0)){finPorDerrota.terminar()
																					game.addVisual(finPorDerrota)
																					game.addVisual(puntajeFinal)}})
										game.onTick(1.randomUpTo(5) * 300, "movimiento1", {fantasma.acercarseA_(pacman)})
										//Fantasma Azul	
										game.whenCollideDo(fantasma2,{personaje => personaje.chocarConRival(fantasma)
															if((pacman.vidas()==0) || (pacman.puntos()<0)){finPorDerrota.terminar()
																					game.addVisual(finPorDerrota)
																					game.addVisual(puntajeFinal)}})
										game.onTick(1.randomUpTo(5) * 800, "movimiento", {fantasma2.acercarseA_(pacman)})
										//FRUTAS
											game.onTick(8000,"aparece fruta",{game.addVisual(new Fruta(position=game.at(self.posicion(),self.posicion())))})
										game.onCollideDo(pacman,{algo=>algo.desaparece()})
										
										//MUROS
										
										game.whenCollideDo(pacman,{algo=>algo.quitarpuntos()})
										
										//PARA LOS BONUS
										game.onTick(15000,"aparecen bonus",{game.addVisual(new Bonus(image="bonus.png",position=game.at(self.posicion(),self.posicion())))})
										game.onTick(30000,"aparece superBonus",{game.addVisual(new SuperBonus(image="key.png",position=game.at(self.posicion(),self.posicion())))})
										}
										}
