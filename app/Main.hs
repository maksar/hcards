{-# LANGUAGE OverloadedStrings #-}
module Main where

import Database.ODBC
main :: IO ()
main = do
  conn <-
    connect
      "DRIVER=DRIVER;Server=HOST;Port=1433;Uid=UID;Pwd=PASS;Database=DB"
  rows <- query conn "select [COLUMN] from TABLE" :: IO [[Text]]
  print rows
  close conn