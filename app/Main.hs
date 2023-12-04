{-# LANGUAGE OverloadedStrings #-}
module Main (main) where

import Web.Scotty (scotty, html, post, request, status)
import Debug.Trace (trace)
import Control.Monad.IO.Class (MonadIO(liftIO))
import Network.HTTP.Types (ok200, status400)
import Network.Wai (Request(requestBody))
import System.Random (randomRIO)

main :: IO ()
main = scotty 3001 $ do
    post "/" $ do
        r <- request
        b <- liftIO $ requestBody r
        c <- liftIO $ randomRIO (1 :: Int, 2) 
        liftIO $ putStrLn ("count: " ++ show c)
        trace ("Received request" ++ show b) $
            if even c
            then status ok200
            else status status400
