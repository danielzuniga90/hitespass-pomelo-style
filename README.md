# hitespass-pomelo-style

Estilos de la tarjeta para el iframe de datos seguros de Pomelo.

Pomelo recibe la URL de `styles.css` como parametro `styles`, descarga su
contenido y lo pega dentro de su propia pagina. Por eso las rutas dentro del CSS
tienen que ser absolutas, y por eso conviene que las imagenes vayan incrustadas:
sin eso el navegador necesita un segundo viaje y la tarjeta aparece por partes.

## Como editar

Se edita `styles.src.css` y se corre:

```bash
./build.sh
```

Eso genera `styles.css` con las cuatro imagenes incrustadas en base64.
`styles.css` no se edita a mano.

## Archivos

| Archivo | Que es |
|---|---|
| `styles.src.css` | fuente, se edita |
| `build.sh` | incrusta las imagenes y genera el final |
| `styles.css` | generado, es lo que Pomelo descarga |
| `card_background.webp` | fondo de la tarjeta, 2x |
| `card_brand.webp` | sello Premiere, 2x |
| `card_wordmark.svg` | marca hites VISA |
| `copy_all.svg` | icono de copiar |

Las imagenes salen de la libreria `hites-pass-ui`, sin modificar.
