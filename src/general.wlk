import wollok.game.*
import Juego.*

object nivel1{
				
				const musica = game.sound("Pacman.mp3")
				const fantasma=new Fantasma()
				const fantasma2=new Fantasma(position=game.at(7,4),image="rival2.png")
				
				var property momentanea
				var pause = false
				const vidaGrafico= new Vidas(position=game.at(16,9))
				const puntaje= new Puntajes(position=game.at(16,8))
				const puntajeFinal = new Puntajes(position=game.at(9,0))
				method iniciar(){
								self.configurarInicio1()
								self.agregarVisuales1()
								self.programarTeclas1()
								self.agregarColisiones1()
								self.agregarMusica(true)
								game.start()}
				method configurarInicio1(){game.width(18)
										game.height(10)
										game.cellSize(50)
										game.title("PACMAN")}
				method agregarMusica(auxiliar){ if (auxiliar){musica.shouldLoop(true)
																game.schedule(500, { musica.play()})}
												else {musica.stop()}}
				method agregarVisuales1(){
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
										
				method pausa(){if (!pause){game.removeTickEvent("aparece fruta")
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
													game.onTick(1.randomUpTo(5) * 800, "movimiento", {fantasma2.acercarseA()})
													game.onTick(1.randomUpTo(5) * 300, "movimiento1", {fantasma.acercarseA()})
													pause = false
													game.removeVisual(similarPacman)
													game.addVisual(pacman)
													pacman.position(momentanea)}}
				method programarTeclas1(){
										keyboard.enter().onPressDo({game.stop()})
										keyboard.space().onPressDo({self.pausa()})
										keyboard.p().onPressDo({musica.stop()})
				}
				method posicion(){return 0.randomUpTo(10)}
				method agregarColisiones1(){
										//Fantasma Rojo
										game.whenCollideDo(fantasma,{personaje => personaje.chocarConRival(fantasma)
														
																				})
										game.onTick(1.randomUpTo(5) * 300, "movimiento1", {fantasma.acercarseA()})
										//Fantasma Azul	
										game.whenCollideDo(fantasma2,{personaje => personaje.chocarConRival(fantasma2)
														})
										game.onTick(1.randomUpTo(5) * 800, "movimiento", {fantasma2.acercarseA()})
										//FRUTAS
											game.onTick(8000,"aparece fruta",{game.addVisual(new Fruta(position=game.at(self.posicion(),self.posicion())))})
										game.onCollideDo(pacman,{algo=>algo.desaparece()})
										
										//MUROS
										
										game.whenCollideDo(pacman,{algo=>algo.quitarpuntos()})
										
										//PARA LOS BONUS
										game.onTick(15000,"aparecen bonus",{game.addVisual(new Bonus(image="bonus.png",position=game.at(self.posicion(),self.posicion())))})
										game.onTick(30000,"aparece superBonus",{game.addVisual(new SuperBonus(image="key.png",position=game.at(self.posicion(),self.posicion())))})
										}}
										
										
object nivel2{
				const fantasmanivel2=new Fantasma(image="enemigo1.jpg")
				const fantasma2nivel2=new Fantasma(image="enemigo1.jpg")
				const vidaGrafico= new Vidas(position=game.at(16,9))
				const puntaje= new Puntajes(position=game.at(16,8))
				//const puntajeFinal = new Puntajes(position=game.at(9,0))

				
	method arranque(){self.eliminarPantalla() 
						self.agregarMensajeNivel2()
						keyboard.any().onPressDo({self.iniciar()})
						}
	method iniciar(){ 
						
						game.removeVisual(tableroNivel2)
						nivel1.configurarInicio1()
						self.agregarVisuales2()
						nivel1.programarTeclas1()
						self.agregarColisiones2()
						nivel1.agregarMusica(true)
						
						}
						
				method agregarColisiones2(){
											game.onCollideDo(pacman,{enemigo=>enemigo.pierdeVida()})
											game.onCollideDo(pacman,{algo=>algo.desaparece()})
										
											game.whenCollideDo(pacman,{algo=>algo.quitarpuntos()})
											
											//game.onTick(11000,"aparece hongo ",{game.addVisual(new Bonus(image="hongo.png",position=game.at()})
										////	//aca podemos agregar o colisiones  y onticks nuevos y distintos, ademas de eliminar los del nivel anterior 
											
				}
				method agregarVisuales2(){
										game.boardGround("level2.png")
										game.addVisual(puntaje)
										game.addVisual(vidaGrafico)
										game.addVisual(enemigoNivel2)
										//10.times{j=>15.times({i=>game.addVisual(new Muro(image="muro1level2.png",position=game.at(i+1,j*2)))})}
										pacman.image("pacmanNivel2.png")
										game.addVisualCharacter(pacman)
										
										
								
				}	
				
				method aparecenMonedas(){
				10.times{j=>20.times({i=>game.addVisual(new Pelotita(image="moneda .png",position =game.at(i,j)))})}
				}
				method agregarMensajeNivel2(){
					nivel1.agregarMusica(false)
					game.addVisual(tableroNivel2)
					game.boardGround("Fondo.png")	
					
				}
				
				
				
						
				method eliminarPantalla(){
				  					game.clear()
				  }		
				}
				
object nivel3{ 
		const vidaGrafico= new Vidas(position=game.at(7,0))
		const puntaje= new Puntajes(position=game.at(15,0))
	method arranque(){nivel2.eliminarPantalla() 
					self.agregarMensajeNivel3()
					keyboard.any().onPressDo({self.iniciar()})
					
	}
	method iniciar(){ 
						game.removeVisual(tableroNivel3)
						nivel1.configurarInicio1()
						self.agregarVisuales3()
						nivel1.programarTeclas1()
						self.agregarColisiones3()
						nivel1.agregarMusica(true)}
		
						
	method agregarVisuales3(){ 
		game.addVisual(puntaje)
		game.addVisual(vidaGrafico)
		game.addVisualCharacter(pacman)
		game.schedule(8000,game.addVisual(enemigoNivel3))
		
		
	}
						
						
	
}

				

				