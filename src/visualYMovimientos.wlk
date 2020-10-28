import wollok.game.*
import plantas.*
import direcciones.*
import toni.*
import pachamama.*

object juego {
	var property personajeActual = toni
	
	method configurarTeclado() {
		
		// acciones de la pachamama
		keyboard.f().onPressDo({ pachamama.fumigar() })
		keyboard.l().onPressDo({ pachamama.llover() })
		
			
		// acciones de toni 
		keyboard.m().onPressDo({ toni.sembrarMaiz() })
		keyboard.t().onPressDo({ toni.sembrarTrigo() })
		keyboard.o().onPressDo({ toni.sembrarTomaco() })
		keyboard.c().onPressDo({ toni.cosecharPlanta() })
		keyboard.x().onPressDo({ toni.cosecharTodo() })
		keyboard.r().onPressDo({ toni.regarPlanta() })
		keyboard.a().onPressDo({ toni.regarLasPlantas() })
		keyboard.v().onPressDo({ toni.venderCosecha() })
		keyboard.space().onPressDo({
			game.say(toni,"tengo" + toni.oroObtenido() + " de oro obtenido" + 
			"y me quedan" + toni.plantasCosechadas().size() + "para vender")
		})
		self.configurarMovimiento()
		
	}
	
	method configurarMovimiento(){
		keyboard.up().onPressDo({
			if(personajeActual.position().y() < game.height() - 1){
				personajeActual.position(personajeActual.position().up(1))
			}
		})
		keyboard.down().onPressDo({
			if(personajeActual.position().y() > 0){
				personajeActual.position(personajeActual.position().down(1))
			}
		})
		keyboard.left().onPressDo({
			if(personajeActual.position().x() > 0){
				personajeActual.position(personajeActual.position().left(1))
			}
		})
		keyboard.right().onPressDo({
			if(personajeActual.position().x() < game.width() - 1){
				personajeActual.position(personajeActual.position().right(1))
			}
		})
	}
	method configurarPersonajes(){
		game.addVisual(toni)
	}	
}
