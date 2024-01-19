**Trabajo personal probando CoreML**

En esta app estoy probando el potencial de ML para el reconocimiento de fotos. Al hacer una foto, te dice que tipo de planta es.

![FlowerMTL](https://github.com/agavgar/FlowerMTL/assets/98350985/1fd53dcd-8d61-46d1-b1ce-a03e6363fd35)
![FlowerMTL_2](https://github.com/agavgar/FlowerMTL/assets/98350985/16f8ccd5-c386-42d8-9035-81e5f6200645)
![FlowerMTL3](https://github.com/agavgar/FlowerMTL/assets/98350985/d52106fa-3308-4851-ad0f-53bea81b8de3)
![FlowerMTL4](https://github.com/agavgar/FlowerMTL/assets/98350985/ef1e7d3c-9259-407d-8233-a6f3bf231a0b)

**Breve descripción**

La app lo que hace lo primero darte a elegir si quieres analizar una foto realizada o hacer una nueva con la cámara del iphone. Una vez realizada, el titulo se cambia por el titulo que da el modelo al analizar la foto, después consumimos la API de wikipedia para conseguir por un lado la foto y por otro le descripción de Wikipedia. Todo ello usando CocoaPods, AlamoFire, SwiftyJSON, SDWebImage para el correcto funcionamiento de todo.

**Guía de instalación**

En este caso la instalación es más compleja ya que no he incluido el modelo por tema de tamaño. Habría que descargarsde le proyecto, incluir el modelo que analiza las flores o crear uno nuevo (Mi siguiente paso será ese) y ya debería estar (comprobar el metodo para llamar al modelo). SE REQUIERE DISPOSITIVO FISICO

**Experiencia**

Este proyecto ha sido uno de curioseo, como me gusta llamarlo a mí. En mi sed de conocimientos, querñia saber como incluir una IA en una app o en este caso poder utilizar Modelos de Entrenamiento para conseguir un resultado. En este caso, Apple tiene su propio framework y aunque no es tan poderoso como un IA de lenguaje natural, es una herramienta muy interesante para trabajar con ella. Lo siguiente ha sido investigar como usarla y aprovechar para añadirle pequeñas mejoras para que pueda ser una herramienta decente. Muy interesante y muy contento del resultado que aunque sea muy secillo y SPOLER: no funciona perfectamente, me ha abierto las miras sobre la implentación de una IA en una app.
