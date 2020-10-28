import wollok.game.*
import plantas.*
import pachamama.*
import mercados.*

object toni {
	const property image = "toni.png"
	var property position = game.at(3, 3)
	var property plantasSembradas = []
	var property plantasCosechadas = []
	var property oroObtenido = 0
	var property gastoDiario = 200
	
	// Pegar acá todo lo que tenían de Toni en la etapa 1
	
	method sembrarMaiz() {
			plantasSembradas.add(new Maiz(position=self.position()))
			game.addVisual(plantasSembradas.last())		
	}		

	
	method sembrarTrigo() {
			plantasSembradas.add(new Trigo(position=self.position()))
			game.addVisual(plantasSembradas.last())		
	}		


	method sembrarTomaco() {
			plantasSembradas.add(new Tomaco(position=self.position()))
			game.addVisual(plantasSembradas.last())		
	}		


	method regarLasPlantas() {
		plantasSembradas.forEach( { p=>p.regar() } )
	}
	
	method regarPlanta () {
		game.colliders(self).forEach ( { planta => planta.regar() } )
	}
	
	method plantasListasParaCosechar() {
		return plantasSembradas.filter( { p=>p.listaParaCosechar() } ).asSet()
	}

	method cosecharPlanta() {
		game.colliders(self).forEach( {planta =>
			if (planta.listaParaCosechar()) {
				game.removeVisual(planta) 
				plantasCosechadas.add(planta)
				plantasSembradas.remove(planta) } } )
	}
	
	method cosecharTodo() {
		self.plantasListasParaCosechar().forEach( { p=>p.cosechate() } )
		plantasCosechadas.addAll(self.plantasListasParaCosechar())
		plantasSembradas.removeAll(self.plantasListasParaCosechar())
	}
	
	method valorCosecha() {
		return plantasCosechadas.sum( { p=>p.cuantoOroDa() } )
	}
	//falta asignar la tecla
	method venderCosechas(){ 
	return if(game.colliders(self) and (mercado.oro() >= self.valorCosecha()))
	{ self.venderTodo()  mercado.venderMercaderia()}
	else{ self.error("no hay ningun mercado")}
	}
	method venderTodo(){
		oroObtenido += self.valorCosecha()
		plantasCosechadas.clear() }	
	// estos 2 metodos vender cosecchas y vender todo son para probar si funciona
	// en caso de funcionar BORRAR metodo vender cosecha 
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
	
	method hacerUnaOfrendad() = 
	game.whenCollideDo(pachamama,( {plantas => plantasSembradas.last().cosechate() } ) ) 
	and if(not pachamama.estaAgradecida()){ pachamama.nivelDeAgradecimiento()+10}	
		else{pachamama.llover() self.regarLasPlantas()}							
								
	
}