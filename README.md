# MercadoLibre
Prueba técnica Mercado Libre

## Features
- Buscador
- Filtrar búsqueda por relevancia, menos precio y mayor precio
- Lista de productos encontrados
- Paginación o infinite scroll
- Detalle de producto

## Estructura del proyecto
El proyecto se trabajó con el patrón arquitectónico *VIPER* debido a que se pensó para trabajar en un equipo grande y con multiples features.
Todos los módulos cuentan con la siguiente estructura:

![VIPER](https://user-images.githubusercontent.com/36196045/175325902-d629b375-e123-4df5-ac83-b681610f11a2.png)

#### View
Contiene la vista y el controlador del módulo.

#### Interactor
Es el encargado de traer la información, ya sea por medio de servicios web o información almacenada en el dispositivo (La información la retorna al *Presenter*).

#### Presenter 
Es el orquestador del  módulo, es el encargado de recibir las acciones de la vista y llamar al router para navegación, el interactor para hacer llamados a red y/o traer información y la vista para ejecutar alguna acción.

#### Entity
Modelos usados para la presentación de la información en el módulo.

#### Router
Construye el módulo y es el manejador de la navegación del módulo.

## Unit tests
Los unit test que se probaron para el ejercicio son los *Presenter* e *Interactor* de cada módulo.
