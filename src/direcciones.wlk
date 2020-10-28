import wollok.game.*

object este {
	method siguientePosicion(position){
		return if(position.x() == game.width() -1 ) { position } 
		else { position.right(1) }	
 }
}

object oeste{
	method siguientePosicion(position){
		return if(position.x() == 0){ position } 
		else {position.left(1) }
		
 }
}

object norte{ 
	method siguientePosicion(position){
		return if(position.y() == game.height() - 1){ position }
		else{ position.up(1) }
 }
}

object sur{
	method siguientePosicion(position){
		return if(position.y()== 0 ){ position }
		else { position.down(1) }	
 }
}
