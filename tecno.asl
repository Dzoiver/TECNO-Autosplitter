state("data.bin") // v3 by Seifer and C0yotl
{
    string100 fileToLoad : "data.bin", 0xEE2908, 0x810;
}    
start
{
	if (current.fileToLoad.Contains("INTRO_MOVIE.MPG"))
    {
        vars.timerStop = false;
        return true;
    }
}

isLoading
{
    if (!settings["loadremover"])
        return false;
    
    if (current.fileToLoad.Contains(".DAT") && !old.fileToLoad.Contains(".DAT"))
        vars.timerStop = true;

    if (current.fileToLoad.Contains("GENCOMMENT") && !old.fileToLoad.Contains("GENCOMMENT"))
        vars.timerStop = false;

    return vars.timerStop;
}
split
{
    try // Ignores the error if the key doesn't exist in the settings
    {
        if (!settings[vars.SplitNames[vars.counter]]) // Skips unwanted splits
        {
        vars.counter++;
        }
    }
    catch
    {
        
    }

    if (current.fileToLoad.Contains(vars.SplitNames[vars.counter])) 
    {
        vars.counter++;
        return true;
    }
}
onStart
{
    vars.counter = 0;
}
startup 
{
    settings.Add("loadremover", true, "Loadremover");
    settings.Add("splitLevels", true, "Split on levels");
    //settings.Add("splitCutscene", false, "Split on cutscenes");
    //settings.Add("AY 04.OGG", true, "Питание катсцена", "splitCutscene");
    //settings.Add("G_LIGHT.TGA", true, "Зелёная карта катсцена", "splitCutscene");
    settings.Add("LEVELBD_GENCOMMENT", true, "LEVELBD (Chapter 2 and 8)", "splitLevels");
    settings.Add("LEVELC1_GENCOMMENT", true, "LEVELC1 (Chapter 3 and 7)", "splitLevels");
    settings.Add("LEVELC2_GENCOMMENT", true, "LEVELC2 (Chapter 4 and 6)", "splitLevels");
    settings.Add("LEVELE_GENCOMMENT", true, "LEVELE (Chapter 5)", "splitLevels");
    settings.Add("LEVELF_GENCOMMENT", true, "LEVELF (Chapter 9)", "splitLevels");
    settings.Add("ENDING_MOVIE.MPG", true, "Ending Cutscene");
    vars.counter = 0;
    vars.timerStop = false;
    
    vars.SplitNames = new List<string>() // For every name there also must be an option in the settings, otherwise it won't work
	{
		//"0020.PNG", // Предохранитель
        //"0298.PNG", // Карта
        //"AY 04.OGG", // Питание катсцена
        //"ITE_041.3DS", // Disc
        //"G_LIGHT.TGA", // Green card cutscene
        //"ANICO 16_C.OGG", // Антиматерия катсцена
        // "LADO.OGG", // Чаттинг с Мика
        // "LEVELA_CUTS_END.3DS", // Последняя катсцена Алексии
        "LEVELBD_GENCOMMENT", // Мика
        // "LEVELA_INTRO_NOISE"
        // "LEVELB_CORRE_CUTS", // Запуск таймера Мика
        "LEVELC1_GENCOMMENT", // Уровень C Мика Chapter3
        // "ANICO 32.OGG", // 3 Ящика в огонь
        "LEVELC2_GENCOMMENT", // С2 Мика Chapter4
        "LEVELE_GENCOMMENT", // Tank level Chapter5
        "LEVELC2_GENCOMMENT", // С2 Мика (2) Chapter6
        "LEVELC1_GENCOMMENT", // С1 Мика (2) Chapter7
        "LEVELBD_GENCOMMENT", // B Мика (2) Chapter8
        "LEVELF_GENCOMMENT", // Chapter9
        "ENDING_MOVIE.MPG", // Ending
	};
    
}
