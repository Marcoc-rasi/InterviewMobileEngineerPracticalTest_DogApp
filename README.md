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
| `PracticalTest_Marcocrasi` | Aplicación principal para iOS que permite la exploración de una lista de perros.               |
| `DogDataBase`              | Estructura encargada de gestionar la persistencia de datos, almacenando y cargando información. |
| `APIRequestController`     | Controlador principal que maneja las solicitudes a una API externa para obtener datos de perros. |
| `DogsTableViewController`  | Controlador de vista que gestiona la interfaz de usuario y presenta la lista de perros en una tabla. |
| `DogTableViewCell`         | Define la celda de la tabla y especifica cómo se presenta cada elemento de la lista.            |

Esta tabla ofrece una descripción rápida y clara de los roles y funciones de los archivos más relevantes en el proyecto.


## Comentarios Finales:
Este desafío fue una experiencia enriquecedora que disfruté enormemente. Considero que abordé el problema con elegancia y añadí funciones adicionales para destacar la persistencia de datos. Estoy muy satisfecho con el resultado obtenido. Es relevante señalar que, aunque la interfaz de usuario no se ajusta exactamente a las especificaciones solicitadas, cumple eficazmente su función y es completamente adaptable a cualquier tamaño de pantalla.

## Conclusión:
Agradezco la oportunidad de enfrentar este desafío técnico y me encuentro disponible para cualquier pregunta o aclaración adicional. Confío en que la solución propuesta cumple con los estándares de rendimiento y calidad requeridos.

