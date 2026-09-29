public class LanguageController {
    public Boolean englishChecked {get; set;}
    public Boolean japaneseChecked {get; set;}

    public PageReference goToLanguagePage() {
        if(englishChecked) {
            return Page.EnglishPage;
        } else if(japaneseChecked) {
            return Page.JapanesePage;
        } else {
            return null;
        }
    }
}