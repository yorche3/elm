port module HelloUser exposing (main)

import Platform
import Greeting exposing (greet)


-- Puertos para comunicarse con Node.js
port sendGreeting : String -> Cmd msg
port receiveName : (String -> msg) -> Sub msg


-- Modelo
type alias Model =
    { name : Maybe String
    , greeting : Maybe String
    }


-- Mensajes
type Msg
    = NameReceived String
    | SendGreeting


-- Inicialización
init : () -> ( Model, Cmd Msg )
init _ =
    ( { name = Nothing, greeting = Nothing }
    , Cmd.none
    )


-- Actualización
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NameReceived name ->
            ( { model | name = Just name }
            , sendGreeting (greet name)
            )

        SendGreeting ->
            case model.name of
                Just name ->
                    ( model, sendGreeting (greet name) )

                Nothing ->
                    ( model, Cmd.none )


-- Suscripciones (escucha el puerto de entrada)
subscriptions : Model -> Sub Msg
subscriptions _ =
    receiveName NameReceived


-- Programa principal
main : Program () Model Msg
main =
    Platform.worker
        { init = init
        , update = update
        , subscriptions = subscriptions
        }