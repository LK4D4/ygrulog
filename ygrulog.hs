{-# LANGUAGE TypeFamilies, QuasiQuotes, MultiParamTypeClasses, TemplateHaskell, OverloadedStrings #-}
import Yesod
import Data.Text

data YgruLog = YgruLog

mkYesod "YgruLog" [parseRoutes|
/ HomeR GET
/log RedirectToLogR GET
|]

instance Yesod YgruLog

getHomeR :: Handler RepHtml
getHomeR = defaultLayout [whamlet|<form .well action=@{RedirectToLogR}>
     Дата: <input type="date" name="bday" min="2008.07.26"/>
     <button .btn type=submit name=watch>Посмотреть
     |]

getRedirectToLogR :: Handler RepHtml
getRedirectToLogR = do
    redirect ("http://yandex.ru"::Text)

main :: IO ()
main = warpDebug 3000 YgruLog
