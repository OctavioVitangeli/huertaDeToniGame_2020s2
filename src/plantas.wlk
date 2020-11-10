import wollok.game.*
import pachamama.*
import toni.*

class Plantas {
	var property position
	
	method serOfrenda() {
		game.removeVisual(self) 
		toni.plantasSembradas().remove(self)
	}
	
	method cosechate() { 
		toni.position(self.position())
		game.removeVisual(self) 
		toni.plantasCosechadas().add(self) 
		toni.plantasSembradas().remove(self)
	}
	
	method esAptoCeliaco() = true
}


class Maiz inherits Plantas {
	var property esAdulta = false
	
	method image() {
		return if (esAdulta and pachamama.estaAgradecida()) { "maiz_gigante_opt.png" } 
		else if (esAdulta) { "maiz_adulto.png" }
		else { "maiz_bebe.png" }
			
	}
	
	method cuantoOroDa() { return if(pachamama.estaAgradecida()) { 180 }
								  else { 150 }
	}
		
	method regar() {
		if (not esAdulta) {esAdulta=true}
	}
	
	method listaParaCosechar() { return esAdulta }
	

}

class Trigo inherits Plantas {
	var property etapa = 0
	
	override method esAptoCeliaco() = false
	
	method image() {
	
	if (etapa == 0) { return "trigo_0.png" }
	else if (etapa == 1) { return "trigo_1.png"  }
	else if (etapa == 2) { return "trigo_2.png"  }
	else { return "trigo_3.png"  }
	
	}
	
	method cuantoOroDa(){ return if(etapa == 2) { 100}
		else { 200 }
		// este método será llamado solo sobre la colección de plantas cosechadas, por esa razón no se contemplan las
		// etapas 0 y 1
	}
	
	method regar() {
		if (pachamama.estaAgradecida()) { etapa = (etapa + 2).rem(4) }
		else { etapa = (etapa + 1).rem(4) }	
	}
	
	method listaParaCosechar() { return etapa >= 2 }
	
	
}

class Tomaco inherits Plantas {
	
	method image() { 
		return if (pachamama.estaAgradecida()) { "tomaco_podrido.png" }
		else { "tomaco_ok.png" }			
	}
	
	method cuantoOroDa(){ return 80 }
	method regar() { }
	method listaParaCosechar() { return not pachamama.estaAgradecida() }
}

