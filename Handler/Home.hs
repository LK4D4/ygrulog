{-# LANGUAGE TupleSections, OverloadedStrings #-}
module Handler.Home where

import Import
import Data.Time.Calendar
import Data.Time.Clock
import Data.Text as T
import Data.Maybe
import Text.Printf

getHomeR :: Handler RepHtml
getHomeR = do
    form <- liftIO logDateForm
    (formWidget, formEnctype) <- generateFormPost $ renderTable form
    defaultLayout $ do
        aDomId <- lift newIdent
        setTitle "Welcome To Yesod!"
        let attrs = [("max", "2008-07-26")]
        $(widgetFile "homepage")

gentooUrl :: Text
gentooUrl = "http://gentoo.ru/jabber/logs/gentoo@conference.gentoo.ru/"

redirectUrlTail :: (Integer, Int, Int) -> Text
redirectUrlTail (year, month, day) = T.pack $ printf "%d/%02d/%02d.html" year month day

getRedirectR :: Handler RepHtml
getRedirectR = do
    date <- toGregorian <$> fromJust <$> (runInputGet $ iopt dayField "date")
    let redirectUrl = T.append gentooUrl $ redirectUrlTail date
    redirect (redirectUrl)

getCurrentDay :: IO Day
getCurrentDay = do
    getCurrentTime >>= return . utctDay

datePickerAttrs :: Day -> [(Text, Text)]
datePickerAttrs day = 
    let textDay = T.pack $ showGregorian day
        in [ ("min", "2008-07-26")
           , ("max", textDay)]

logDateForm :: IO (AForm App App Day)
logDateForm = do
    currentDay <- getCurrentDay
    let attrs = datePickerAttrs currentDay
    let fieldSettings = FieldSettings "Дата" Nothing Nothing (Just "date") attrs
    return $ areq dayField fieldSettings (Just currentDay)
