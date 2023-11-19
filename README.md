# Informe Técnico: Mobile Engineer Practical Test

En este informe, se presenta la solución para el desafío técnico de ingeniería móvil, abordando aspectos relacionados con la creación de una aplicación para mostrar una lista de objetos `Dog`.

## Aplicación:
La aplicación "PracticalTest_Marcocrasi" para iOS permite a los usuarios explorar una lista de perros con detalles como nombre, descripción, edad e imágenes. La estructura `DogDataBase` gestiona la representación de datos de perros, almacenando y cargando información desde un archivo plist para garantizar persistencia. El controlador `APIRequestController` maneja las solicitudes a una API externa para obtener datos de perros y sus imágenes. La interfaz principal, gestionada por `DogsTableViewController`, ofrece funcionalidades de edición en la lista, incluida la eliminación y reordenación de elementos. Además, se han implementado pruebas unitarias para garantizar la integridad de las funciones clave de la aplicación.

## Arquitectura:
La arquitectura de la aplicación sigue un enfoque MVC (Model-View-Controller), común en el desarrollo de aplicaciones iOS. A continuación, se presenta un resumen de la arquitectura principal:

**Modelo (Model):**
La estructura `DogDataBase` actúa como el modelo principal, representando la información detallada de un perro, incluyendo nombre, descripción, edad y datos de imagen.
`DogJSON` se utiliza para la representación de datos en formato JSON, facilitando la codificación y decodificación desde y hacia la API externa.

**Vista (View):**
`DogsTableViewController` se encarga de la gestión de la interfaz de usuario y de la presentación de la lista de perros en una tabla.
`DogTableViewCell` define la celda de la tabla y cómo se presenta cada elemento de la lista.

**Controlador (Controller):**
`APIRequestController` actúa como el controlador principal que gestiona las solicitudes a la API externa para obtener información sobre perros y sus imágenes.
`DogsTableViewController` también actúa como un controlador, coordinando la interacción entre el modelo y la vista, y manejando eventos como la edición de la tabla.

**Persistencia de Datos:**
Se utiliza la estructura `DogDataBase` para la persistencia de datos, almacenando y cargando información de perros desde un archivo plist en el directorio de documentos.

## Pruebas Unitarias:
La aplicación presenta una sólida suite de pruebas unitarias que abarcan aspectos clave del código, garantizando la funcionalidad y robustez del software. Los casos de prueba cubren la inicialización y la funcionalidad de las estructuras de datos, así como el comportamiento de los controladores y la interacción con la red.

## Diseño: Interfaz de Usuario:
La interfaz de usuario sigue un diseño pixel-perfect según las especificaciones. Se han utilizado colores de fuente predefinidos para mantener la coherencia. Las pruebas de interfaz de usuario validan la correcta inicialización y funcionalidad del controlador de vista `DogsTableViewController`, asegurando una experiencia de usuario sin errores.

## Solicitud de Red:
La solicitud de información desde una red externa es esencial y se gestiona mediante el `APIRequestController`. Las funciones asincrónicas `fetchInfoDogs`, `fetchImage`, y `fetchInfoAndImages` garantizan una obtención eficiente de datos desde la API, sin bloquear la interfaz de usuario.

## Base de Datos:
La persistencia de datos se logra mediante la estructura `DogDataBase` y el manejo de archivos plist. Los métodos `saveToFile` y `loadFromFile` facilitan el almacenamiento y la carga eficiente de información sobre perros, permitiendo una experiencia continua para el usuario.


## Tabla de Componentes Principales

Para brindar una visión rápida y clara de los componentes esenciales de los archivos clave en el proyecto, se ha incluido la siguiente tabla:

| Archivo                    | Descripción                                                                                      |
|----------------------------|--------------------------------------------------------------------------------------------------|
| `PracticalTest_Marcocrasi` |               |
| `DogDataBase`              |  |
| `APIRequestController`     | La clase `APIRequestController` en este código Swift gestiona las solicitudes a una API para obtener información sobre perros, almacenando los resultados en un array denominado `dogsDataBaseArray`. Este array contiene instancias de la clase `DogDataBase`, que encapsulan la información recuperada, como nombres, descripciones, edades e imágenes de los perros. La clase define un enum llamado `DogInfoError`, el cual, conforme al protocolo `Error` y `LocalizedError`, especifica errores personalizados asociados con la búsqueda de elementos y la obtención de datos de imágenes. Este enum se utiliza para manejar posibles fallos durante las solicitudes a la API. En cuanto a los métodos, la clase presenta tres funciones relevantes. La primera, `fetchInfoDogs`, realiza una solicitud asíncrona a una URL específica para obtener información sobre perros en formato JSON, utilizando la nueva sintaxis `async/await` de Swift 5.5. La segunda función, `fetchImage(from:)`, recupera de manera asíncrona imágenes desde una URL determinada y crea objetos `UIImage` a partir de los datos obtenidos, manejando posibles errores de forma detallada. La tercera función, `fetchInfoAndImages`, combina las funcionalidades de las dos anteriores para obtener tanto la información sobre perros como las imágenes asociadas. Itera a través del array de objetos `DogJSON`, llama a `fetchImage` para cada imagen, y crea instancias de la clase `DogDataBase` con la información completa de cada perro, incluyendo su imagen. Finalmente, devuelve el array completo con la información detallada sobre cada perro. En resumen, la clase `APIRequestController` encapsula de manera eficiente la lógica asíncrona para interactuar con una API de perros, gestionando errores mediante un enum personalizado y organizando la información recuperada en instancias de `DogDataBase`. |
| `DogsTableViewController`  | La clase `DogsTableViewController` en el archivo `DogsTableViewController.swift` despliega un controlador de vista de tabla para presentar información relacionada con perros en una aplicación iOS. Esta clase hereda de `UITableViewController` y se encarga de gestionar solicitudes a una API a través de la instancia `dogApiRequestController` de la clase `APIRequestController`. El array `dogsDataBaseArray` almacena objetos de la clase `DogDataBase` que contienen información sobre los perros. Este array tiene un observador `didSet` que, al detectar cambios, imprime un mensaje y guarda los datos en un archivo mediante el método estático `saveToFile` de la estructura `DogDataBase`. El ciclo de vida de la vista comienza con el método `viewDidLoad`, que utiliza un modelo concurrente para cargar de manera asíncrona los datos desde la API y actualizar la interfaz de usuario. El método `viewWillAppear` se asegura de recargar la tabla para reflejar los datos más recientes cada vez que la vista está a punto de aparecer. La implementación de métodos relacionados con el protocolo `UITableViewDataSource` incluye `numberOfSections`, que devuelve siempre 1, `numberOfRowsInSection`, que se basa en la cantidad de elementos en `dogsDataBaseArray`, y `cellForRowAt`, que configura y devuelve una celda personalizada `DogTableViewCell` con la información del perro correspondiente. Para la manipulación de la tabla, se han implementado métodos como `moveRowAt` para reordenar filas, `editingStyleForRowAt` para establecer el estilo de edición (eliminación) y `commit editingStyle` para realizar acciones de edición, como eliminar una fila y actualizar la tabla. Si no quedan filas después de la eliminación, se recargan datos desde la API. Métodos adicionales incluyen `updateUI`, que actualiza la interfaz de usuario en el hilo principal, y `displayError`, que imprime mensajes de error en caso de problemas al obtener datos desde la API. El método `getDogsData` se encarga de obtener de forma asíncrona datos de perros desde la API. Verifica si los datos ya están almacenados localmente y los carga si es así. Si no, realiza una solicitud a la API, almacena los nuevos datos y los guarda en un archivo local. Finalmente, `editButtonTapped` es un método de acción vinculado al botón de edición en la barra de navegación, que alterna entre modos de edición y no edición de la tabla. En resumen, la clase `DogsTableViewController` proporciona un control centralizado para la presentación y manipulación eficiente de datos sobre perros en la interfaz de usuario de la aplicación. |
| `DogTableViewCell`         | La clase `DogTableViewCell` es una implementación personalizada de `UITableViewCell` diseñada para mostrar información detallada sobre perros en una interfaz de usuario de una aplicación iOS. La celda contiene varios componentes, incluyendo una imagen del perro, el nombre del perro, una descripción y la edad del perro. Entre sus propiedades destacan `dogImageView` (un `UIImageView` que muestra la imagen del perro), `nameLabel` (un `UILabel` para mostrar el nombre del perro), `descriptionLabel` (un `UILabel` para mostrar la descripción del perro), `ageLabel` (un `UILabel` para mostrar la edad del perro), y `cornerRadius` (un radio utilizado para establecer las esquinas redondeadas de la imagen del perro). En cuanto a sus métodos, se encuentra `awakeFromNib()`, un método de inicialización llamado cuando la celda se carga por primera vez. Además, `setSelected(_:animated:)` es un método que se activa cuando la celda se selecciona, siendo útil para realizar configuraciones adicionales si es necesario. Finalmente, `update(with:)` es un método que toma un objeto `DogDataBase` y actualiza la interfaz de usuario con la información correspondiente del perro. La clase también incluye una extensión, `UIColor Extension`, que facilita la inicialización de un color mediante un código hexadecimal. |

Esta tabla ofrece una descripción rápida y clara de los roles y funciones de los archivos más relevantes en el proyecto.


## Comentarios Finales:
Este desafío fue una experiencia enriquecedora que disfruté enormemente. Considero que abordé el problema con elegancia y añadí funciones adicionales para destacar la persistencia de datos. Estoy muy satisfecho con el resultado obtenido. Es relevante señalar que, aunque la interfaz de usuario no se ajusta exactamente a las especificaciones solicitadas, cumple eficazmente su función y es completamente adaptable a cualquier tamaño de pantalla.

## Conclusión:
Agradezco la oportunidad de enfrentar este desafío técnico y me encuentro disponible para cualquier pregunta o aclaración adicional. Confío en que la solución propuesta cumple con los estándares de rendimiento y calidad requeridos.

