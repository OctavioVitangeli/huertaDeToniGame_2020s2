import plantas.*
import toni.*
import wollok.game.*
object mercado{
	const property image = "mercado.png"
	var property position = game.at(5,13)
	var property mercaderia = []
	var property oro = 200
	
	method venderMercaderia(){ 
		oro -= toni.valorCosecha()
		mercaderia.add(toni.plantasCosechadas())
	}


}

