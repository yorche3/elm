module HelloWorld exposing (main)

import Platform
import Debug

main : Program () () ()
main =
    let
        _ = Debug.log "Hello, World! from Elm" ()
    in
    Platform.worker
        { init = \() -> ( (), Cmd.none )
        , update = \_ _ -> ( (), Cmd.none )
        , subscriptions = \_ -> Sub.none
        }