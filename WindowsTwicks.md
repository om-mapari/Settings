1) Activate Battery Icon:
https://github.com/thebookisclosed/ViVe
vivetool /enable /id:56328729,48433719

2) how to get rid of the "ENG US" keyboard
Settings > Time & Language > Typing > Advanced keyboard settings > check the "Use desktop language bar when it's available".

3) Clear Icon Cache - Sometimes Windows keeps the old icon.
cmd → Run as Admin
Enter these commands one-by-one: This restarts Explorer & refreshes icon cache.
taskkill /IM explorer.exe /F
DEL /A /Q "%localappdata%\IconCache.db"
start explorer.exe


