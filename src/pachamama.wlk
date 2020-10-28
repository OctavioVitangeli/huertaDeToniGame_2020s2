import toni.*
import wollok.game.*

object pachamama {
	var property nivelDeAgradecimiento = 10
	var property position = game.at(0,13)
	
	method image() = if (self.estaAgradecida()){	"pachamama-agradecida.png"}
					else{ "pacha_enojada.png"}
	
	method llover(){ nivelDeAgradecimiento += 5} 
	
	method fumigar(){ nivelDeAgradecimiento = 0}
	
	method estaAgradecida() = nivelDeAgradecimiento >= 10
	
}
