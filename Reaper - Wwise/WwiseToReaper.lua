-- @description Wwise Media Pool to Reaper
-- @author BenReg
-- @version 1.0
-- @about
--   Import the sounds selected in the Wwise Media Pool in the current selected track in Reaper

if(reaper.AK_Waapi_Connect("127.0.0.1", 8080)) then

    local arg = reaper.AK_AkJson_Map()
    local options = reaper.AK_AkJson_Map()

    local result = reaper.AK_Waapi_Call("ak.wwise.ui.getSelectedFiles",
      arg, options)

    local status = reaper.AK_AkJson_GetStatus(result)

    if(status) then
      local files = reaper.AK_AkJson_Map_Get(result, "files")
      local numFiles = reaper.AK_AkJson_Array_Size(files)
      reaper.ShowConsoleMsg(numFiles .. "\n")

      for i=0, numFiles - 1 do
        local item = reaper.AK_AkJson_Array_Get(files, i)
        local pathStr = reaper.AK_AkVariant_GetString(item)
        reaper.InsertMedia(pathStr, 0)
        reaper.ShowConsoleMsg(pathStr .. "\n")
      end
    else
       reaper.ShowConsoleMsg("SOUCIS \n")
    end

    reaper.AK_AkJson_ClearAll()
    reaper.AK_Waapi_Disconnect()
  end
