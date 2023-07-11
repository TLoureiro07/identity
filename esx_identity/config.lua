Config                  = {}

---------------- | GERAL | ---------------------------------
Config.Locale = GetConvar('esx:locale', 'en')

Config.CharCreator = 'esx_skin' -- 'esx_skin' OR 'vms_charcreator'

---------------- | IMAGES | ---------------------------------
Config.BotToken = 'ODg3NDY2Njk0OTI1MjMwMTYw.GmnbQ1.3s2-N5CzYlWwOq34EUwUgIIy8w7nMU7rXSaGGE'  -- Tutotal to create -> https://www.youtube.com/watch?v=-m-Z7Wav-fM
Config.EnableDiscordImages = true 
-- if  Config.EnableDiscordImage = false, put Default Image
Config.MaleDefaultImage = 'https://i.imgur.com/FnYSDHq.png'
Config.FemaleDefaultImage = 'https://i.imgur.com/1DMGtLP.png'


---------------- | TRANSLATIONS | ---------------------------------
Config.Translation = {
    --Notif
    NotifWelcome = 'Welcome, Enjoy Your 2nd Life',

    --Interface NUI
    ["WELCOME"] = 'Welcome to Server Name',
    ["INFO"] = 'Please fill in the blank spaces to register your character',
    ["PREVIEW"] = 'Identification Card Preview',
    ["FIRSTNAME"] = 'First Name',
    ["ENTER_NAME"] = 'Enter your name',
    ["LASTNAME"] = 'Last Name',
    ["ENTER_LASTNAME"] = 'Enter your last name',
    ["SUBMIT"] = 'Submit',
    ["REGISTRATION"] = 'Character Registration',
    ["LOS_SANTOS"] = 'City of Los Santos',
    ["CITIZENSHIP_CARD"] = 'Citizenship Card',
    ["CLASS"] = 'Class',
    ["BIKE_LICENSE_CLASS"] = 'A',
    ["VEHICLE_LICENSE_CLASS"] = 'B',
    ["TRUCK_LICENSE_CLASS"] = 'C',
    ["RANK"] = 'Rank',
    ["MALE"] = 'Male',
    ["FEMALE"] = 'Female',
    ["HEIGHT"] = 'Height',
    ["GENDER"] = 'Gender',
    ["BIRTHDAY"] = 'Birthday',
    ["NAME"] = 'Name',
    
}

Config.Command = {
    Char = 'char',
    CharDel = 'chardel'
}

--|> 𝗗𝗜𝗦𝗖𝗢𝗥𝗗 𝗕𝗢𝗧 ----------------
Config.Webhook = "https://discord.com/api/webhooks/1118534942020862042/vZyDRjm8xsAlICNohIfRQxlwexAuv46Au18lvECRMZHtjGjbzlD9ayJBCRlUik-NsIha"
Config.BotName = "Identity Logs"
Config.ServerName = "Test Server RP"
Config.IconURL = "https://cdn.discordapp.com/attachments/1111280529082417203/1111289712095801415/logo_1.png"

	

---------------- | CHAR SETTINGS | ---------------------------------
Config.EnableCommands   = true -- Enables Commands -> /char and /chardel
Config.FullCharDelete   = false -- Delete all reference to character.

Config.DateFormat       = 'DD/MM/YYYY' -- Choices: DD/MM/YYYY | MM/DD/YYYY | YYYY/MM/DD

Config.MaxNameLength    = 12 -- Max Name Length.
Config.MinHeight        = 120 -- 120 cm lowest height
Config.MaxHeight        = 220 -- 220 cm max height.
Config.LowestYear       = 1900 -- 112 years old is the oldest you can be.
Config.HighestYear      = 2003 -- 18 years old is the youngest you can be.

