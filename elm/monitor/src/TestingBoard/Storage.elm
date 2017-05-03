port module TestingBoard.Storage exposing (..)

import TestingBoard.Types as Types

-- port for sending records to js land.
port send : List Types.RecordType -> Cmd msg
