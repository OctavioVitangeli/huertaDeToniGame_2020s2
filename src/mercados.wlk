import wollok.game.*
import toni.*


class Mercado {
	var property image
	var property position
	var property oro
	var property mercaderia = []
		
	method aceptarCompra(){ 
		if(oro >= toni.valorCosecha()) {
		oro -= toni.valorCosecha()
		game.say(self,"Compra realizada valor " + toni.valorCosecha().toString())
		mercaderia.addAll(toni.plantasCosechadas())
		toni.venderCosecha()
	}
	else { self.error("no puedo cubrir esa venta") }
	}
}	
	
