import mariano.*

/*
 * Los sabores
 */
object frutilla { }
object chocolate { }
object vainilla { }
object naranja { }
object limon { }


/*
 * Golosinas
 */
 
class Golosina {
	var peso = 0
	var precio = 0
	var sabor = null
	
	method precio() = precio
	method sabor() = sabor
	method peso() = peso
} 
 
class Bombon inherits Golosina{
	
	override method precio() = 5
	method mordisco() { peso = peso * 0.8 - 1 }
	override method sabor() = frutilla
	method libreGluten() { return true }
}


class Alfajor inherits Golosina{

	override method precio() = 12
	method mordisco() { peso = peso * 0.8 }
	override method sabor() = chocolate
	method libreGluten() { return false }
}

class Caramelo inherits Golosina{

	override method precio() = 12
	method mordisco() { peso = 0.max(peso-1) }
	method libreGluten() { return true }
}


class Chupetin inherits Golosina{

	override method precio() = 2
	method mordisco() { 
		if (peso >= 2) {
			peso = peso * 0.9
		}
	}
	override method sabor() = naranja
	method libreGluten() { return true }
}

class Oblea inherits Golosina{

	override method precio() = 5
	method mordisco() {
		if (peso >= 70) {
			// el peso pasa a ser la mitad
			peso = peso * 0.5
		} else { 
			// pierde el 25% del peso
			peso = peso - (peso * 0.25)
		}
	}	
	override method sabor() = vainilla
	method libreGluten() { return false }
}

class Chocolatin inherits Golosina{
	// hay que acordarse de *dos* cosas, el peso inicial y el peso actual
	// el precio se calcula a partir del precio inicial
	// el mordisco afecta al peso actual
	var pesoInicial
	var consumido = 0
	
	method pesoInicial(unPeso) { pesoInicial = unPeso }
	override method precio() { return pesoInicial * 0.50 }
	override method peso() { return (pesoInicial - consumido).max(0) }
	method mordisco() { consumido = consumido + 2 }
	override method sabor() = chocolate
	method libreGluten() { return false }

}

class ChocolatinVIP inherits Chocolatin{
	var humedad 
	
	method humedad() = humedad
	
	override method peso() = super()*(1+self.humedad())
}

class ChocolatinPremium inherits ChocolatinVIP{
	override method humedad() = super()/2
}


class GolosinaBaniada inherits Golosina{
	var golosinaInterior
	var pesoBanio = 4
	
	method golosinaInterior(unaGolosina) { golosinaInterior = unaGolosina }
	override method precio() { return golosinaInterior.precio() + 2 }
	override method peso() { return golosinaInterior.peso() + pesoBanio }
	method mordisco() {
		golosinaInterior.mordisco()
		pesoBanio = (pesoBanio - 2).max(0) 
	}	
	override method sabor() { return golosinaInterior.sabor() }
	method libreGluten() { return golosinaInterior.libreGluten() }	
}


class Tuttifrutti inherits Golosina{
	var libreDeGluten
	const sabores = [frutilla, chocolate, naranja]
	var saborActual = 0
	
	method mordisco() { saborActual += 1 }	
	override method sabor() { return sabores.get(saborActual % 3) }	

	override method precio() { return (if(self.libreGluten()) 7 else 10) }
	override method peso() = 5
	method libreGluten() { return libreDeGluten }	
	method libreGluten(valor) { libreDeGluten = valor }
}


class BombonDuro inherits Bombon{
	
	override method mordisco(){
		peso = 0.max(peso-1)
	}
	method gradoDeDureza(){
		if ( peso >= 12){
			return 3
		}
		else if (peso.between(8,12)){
			return 2
		}
		else{
			return 1
		}
	}
}

class CarameloRelleno inherits Caramelo{
		
	override method mordisco(){
		super()
		sabor = chocolate
	}
	override method precio() = super() + 1
}

class ObleaCrujiente inherits Oblea{
	var cantMordiscos = 0
	
	override method mordisco(){
		super()
		cantMordiscos += 1
		if (cantMordiscos.between(1,3)) {0.max(peso-3)}
	}
	method estaDebil() = cantMordiscos > 3	
}

