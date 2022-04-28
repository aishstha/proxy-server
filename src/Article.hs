{-# LANGUAGE OverloadedStrings #-}
module Article where
import Data.Text.Lazy
import Data.Text.Lazy.Encoding
import Data.Aeson
import Control.Applicative

-- Define the Article constructor
-- e.g. Article 12 "some title" "some body text"
data Article = Article Integer Text Text -- id title bodyText
     deriving (Show)


-- Tell Aeson how to create an Article object from JSON string.
instance FromJSON Article where
     parseJSON (Object v) = Article <$>
                            v .:? "id" .!= 0 <*> -- the field "id" is optional
                            v .:  "title"    <*>
                            v .:  "bodyText"


-- Tell Aeson how to convert an Article object to a JSON string.
instance ToJSON Article where
     toJSON (Article id title bodyText) =
         object ["id" .= id,
                 "title" .= title,
                 "bodyText" .= bodyText]


-- {-# LANGUAGE OverloadedStrings #-}
-- {-# LANGUAGE DeriveGeneric #-}
-- {-# LANGUAGE DeriveDataTypeable #-}

-- import qualified Data.ByteString.Lazy as B
-- import GHC.Generics
-- import Web.Scotty
-- import Network.HTTP.Types
-- import Control.Monad.Trans (liftIO)
-- import Article 
-- import Data.Maybe


-- main = scotty 3000 myApp

-- myApp = do
--     get "/" $ do
--       text "This is GET REQUEST"
--     delete "/" $ do
--       html "This is DELETE REQUEST"
--     post "/" $ do
--       text "This is post request"
--     put "/" $ do 
--       text "This is put request"
--     post "/set-headers" $ do
--       status status302
--       setHeader "Location" "http://www.google.com"
--     get "/askfor/:word" $ do
--       w <- param "word"
--       html $ mconcat ["<h1> you asked for", w, ", you got it </h1>"]
--     post "/submit" $ do
--       name <- param "name"
--       text name
--     matchAny "/all" $ do
--       text "matches all method"
--     -- get article (json)
--     get "/article" $ do
--       json $ Article 13 "caption" "content" -- Call Article constructor and encode the result as JSON
--     -- post article (json)
--     post "/article" $ do
--       article <- jsonData :: ActionM Article -- Decode body of the POST request as an Article object
--       liftIO $ print article
--       json article                           -- Send the encoded object back as JSON
--     notFound $ do
--       text "not found such route"

    

     