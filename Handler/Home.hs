{-# LANGUAGE TupleSections, OverloadedStrings #-}
module Handler.Home where

import Import
import Data.Time (Day)

instance YesodJquery App

-- This is a handler function for the GET request method on the HomeR
-- resource pattern. All of your resource patterns are defined in
-- config/routes
--
-- The majority of the code you will write in Yesod lives in these handler
-- functions. You can spread them across multiple files if you are so
-- inclined, or create a single monolithic file.
getHomeR :: Handler RepHtml
getHomeR = do
    (formWidget, formEnctype) <- generateFormPost $ renderTable sampleForm
    defaultLayout $ do
        aDomId <- lift newIdent
        setTitle "Welcome To Yesod!"
        let attrs = [("max", "2008-07-26")]
        $(widgetFile "homepage")

getRedirectR :: Handler RepHtml
getRedirectR = do
    redirect ("http://yandex.ru"::Text)

sampleForm :: AForm App App Day
sampleForm = areq (let attrs = [("max", "2008-07-26")] in dayField) "Дата" Nothing
