{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Matheg where
import Data.Aeson
import qualified Data.ByteString.Lazy as B
import GHC.Generics

data Mathematician = Mathematician { name :: String
                                   , nationality :: String
                                   , born :: Int
                                   , died :: Maybe Int
                                   } deriving Generic

instance FromJSON Mathematician

matheg = do
  input <- B.readFile "input.json"
  let mm = decode input :: Maybe Mathematician
  case mm of
    Nothing -> print "error parsing JSON"
    Just m -> (putStrLn.greet) m
    
greet m = (show.name) m ++" was born in the year "++ (show.born) m