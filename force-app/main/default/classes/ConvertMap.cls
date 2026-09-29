public class ConvertMap {
    public static Map<String, String> convertMap(Map<String, List<String>> mapOfList) {
        Map<String, String> mapOfString = new Map<String, String>();

        for (String key : mapOfList.keySet()) {
            List<String> stringList = mapOfList.get(key);
            String concatenatedString = concatenateStrings(stringList);
            mapOfString.put(key, concatenatedString);
        }

        return mapOfString;
    }

    private static String concatenateStrings(List<String> stringList) {
        if (stringList == null || stringList.isEmpty()) {
            return '';
        }

        String concatenatedString = stringList[0];
        for (Integer i = 1; i < stringList.size(); i++) {
            concatenatedString += stringList[i];
        }

        return concatenatedString;
    }
}