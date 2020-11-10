import wollok.game.*
import plantas.*
import toni.*
import pachamama.*
import mercados.*

const mercadoCentral = new Mercado(oro=1000,position=game.at(13,7),image="mercado.png") 
const mercadoChino = new Mercado(oro=500,position=game.at(1,7),image="mercado_chino_opt.png")		
		

object juego {
	
	method configurarTeclado() {
/* 		Acciones de la Pachamama */
		keyboard.f().onPressDo({ pachamama.fumigar() })
		keyboard.l().onPressDo({ pachamama.llover() })		


/*		Acciones de Toni */		
		keyboard.m().onPressDo({ toni.sembrarPlanta(new Maiz(position=toni.position())) })
		keyboard.t().onPressDo({ toni.sembrarPlanta(new Trigo(position=toni.position())) })
		keyboard.o().onPressDo({ toni.sembrarPlanta(new Tomaco(position=toni.position())) })
		keyboard.c().onPressDo({ toni.cosecharPlanta() })
		keyboard.x().onPressDo({ toni.cosecharTodo() })
		keyboard.r().onPressDo({ toni.regarPlanta() })
		keyboard.a().onPressDo({ toni.regarLasPlantas() })
		keyboard.v().onPressDo({ toni.venderEnMercado() })
		keyboard.space().onPressDo({
			game.say(toni,"Tengo " + toni.oroObtenido().toString() + " de oro " + 
			" y quedan " + toni.plantasCosechadas().size().toString() + " plantas por vender")
		})
		keyboard.control().onPressDo({ game.say(toni,"Valor de mi cosecha: " + toni.valorCosecha().toString() ) } )
	
/*		Movimientos de Toni  */  		
		keyboard.up().onPressDo({toni.moverseHaciaArriba()})
		keyboard.down().onPressDo({toni.moverseHaciaAbajo()})
		keyboard.left().onPressDo({toni.moverseHaciaLaIzquierda()})
		keyboard.right().onPressDo({toni.moverseHaciaLaDerecha()})
		
	}
	
	
	method configurarPersonajes(){

		game.addVisual(toni)
		game.addVisual(pachamama)
		game.addVisual(mercadoCentral)
		game.addVisual(mercadoChino)
	}	
	
	
}
