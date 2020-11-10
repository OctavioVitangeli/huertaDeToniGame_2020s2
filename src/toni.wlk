import wollok.game.*
import plantas.*
import pachamama.*
import mercados.*
import visualYMovimientos.*

object toni {
	var property image = "toni.png"
	var property position = game.at(3, 3)
	var property plantasSembradas = []
	var property plantasCosechadas = []
	var property oroObtenido = 0
	var property gastoDiario = 200

		
	// Pegar acá todo lo que tenían de Toni en la etapa 1
	
	method sembrarPlanta(planta) {
		if (not self.listaDePosicionesSembradas().contains(self.position()) ) {
			plantasSembradas.add(planta)
			game.addVisual(plantasSembradas.last())	
		}
		else self.error("Ya hay siembra")
	}	
	

	method regarLasPlantas() {
		plantasSembradas.forEach( { p=>p.regar() } )
	}
	
	method regarPlanta () { 
		game.colliders(self).forEach ( { planta => planta.regar() } )
	}
	
	
	method plantasListasParaCosechar() {
		return plantasSembradas.filter( { p=>p.listaParaCosechar() } )
	}

	method cosecharPlanta() {
//		**** Agrego validacion de que hay planta para cosechar ******
		if (self.estaEnPlantaCosechable()) {
			const planta = game.uniqueCollider(self)
			game.removeVisual(planta) 
			plantasCosechadas.add(planta)
			plantasSembradas.remove(planta)						
		}
		else if (self.estaEnPlantaSembrada()) { self.error("No está lista para cosechar") }
		else { self.error("Acá NO hay planta") }		
	}

//		*** Métodos para validar que está en planta cosechable ************	
	method estaEnPlantaCosechable() { return self.listaDePosicionesCosechables().contains(self.position()) }
	method listaDePosicionesCosechables() { return self.plantasListasParaCosechar().map( { p=>p.position() } ) }
	method estaEnPlantaSembrada() { return self.listaDePosicionesSembradas().contains(self.position()) }
	method listaDePosicionesSembradas() { return self.plantasSembradas().map( { p=>p.position() } ) }

//		***********************************************************************

	method cosecharTodo() {
		self.plantasListasParaCosechar().forEach( { p=>p.cosechate() } )
		game.say(self,"Total " + plantasCosechadas.size().toString() + " plantas cosechadas")
	}

	method valorCosecha() {
		return plantasCosechadas.sum( { p=>p.cuantoOroDa() } )
	}
	
	method venderCosecha() {
		oroObtenido += self.valorCosecha()
		plantasCosechadas.clear()
	}
	
	method  paraCuantosDiasLeAlcanza() {
		return (oroObtenido + self.valorCosecha()) / gastoDiario
	}
	
	method cuantoHayParaCeliacos() {
		return self.plantasListasParaCosechar().count( { p=>p.esAptoCeliaco() } )
	}
	
	method convieneRegar() {
		return self.plantasSembradas().any( { p=> not p.listaParaCosechar() } )
	}
	
	method hacerOfrenda(pacha) { 
		pacha.rotarPosicion()
//		******* Agrego validación que haya al menos 1 planta para ofrendar *********
		if (plantasSembradas != []) { plantasSembradas.anyOne().serOfrenda() }		
		if (not pacha.estaAgradecida()) { pacha.nivelAgradecimiento(10) }	
		else {pacha.llover() self.regarLasPlantas()}					
	}
	
	method venderEnMercado() {
		if (self.valorCosecha() == 0) { self.error("Nada para Vender") }
			else if(position == mercadoCentral.position() ) { mercadoCentral.aceptarCompra() }
			else if (position == mercadoChino.position()) { mercadoChino.aceptarCompra() }
			else { self.error("no hay ningun mercado") }
	}
		
method moverseHaciaArriba() {
		if(self.position().y() != game.height() - 1) {
				self.position(self.position().up(1))
			}
			else { self.position( new Position(x=self.position().x(),y=0) ) }
	}
	method moverseHaciaAbajo() {
		if(self.position().y() != 0){
				self.position(self.position().down(1))
			}
			else { self.position( new Position(x=self.position().x(),y=game.height() - 1) ) }
	}
	method moverseHaciaLaIzquierda() {
		self.image("toni_izq.png")
			if(self.position().x() != 0){
				self.position(self.position().left(1))
			}
			else { self.position( new Position(x=game.width() - 1,y=self.position().y())) } 
	}
	method moverseHaciaLaDerecha() {
		self.image("toni.png")
			if(self.position().x() != game.width() - 1){
				self.position(self.position().right(1))
			}
			else { self.position( new Position(x=0,y=self.position().y())) }
	}	
	
}