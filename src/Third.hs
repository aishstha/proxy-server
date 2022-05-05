{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DeriveDataTypeable #-}
-- This is phase 1 
module Third where
 
import qualified Data.ByteString.Lazy as B
import GHC.Generics
import Web.Scotty
import Network.HTTP.Types
import Control.Monad.Trans (liftIO)
import Article 
import Data.Maybe

import Data.Monoid ((<>))
import Data.Aeson (FromJSON, ToJSON)
import Control.Applicative
import Matheg

fu = do
      article <- jsonData :: ActionM Article -- Decode body of the POST request as an Article object
      liftIO $ print article
      json article                           -- Send the encoded object back as JSON

greet m = (show.name) m ++" was born in the year "++ (show.born) m

main = scotty 3000 myApp

myApp = do
    get "/" $ do
      text "This is GET REQUEST"
    delete "/" $ do
      html "This is DELETE REQUEST"
    post "/" $ do
      text "This is post request"
    put "/" $ do 
      text "This is put request"
    post "/set-headers" $ do
      status status302
      setHeader "Location" "http://www.google.com"
    get "/askfor/:word" $ do
      w <- param "word"
      html $ mconcat ["<h1> you asked for", w, ", you got it </h1>"]
    post "/submit" $ do
      name <- param "name"
      text name
    matchAny "/all" $ do
      text "matches all method"
    -- get article (json)
    get "/article" $ do
      json $ Article 13 "caption" "content" -- Call Article constructor and encode the result as JSON
    -- post article (json)
    post "/article" fu
    notFound $ do
      text "not found such route"

    

     