public class RemoveDuplicate {
   public static void getTemplate() {       
        list<string> str = new list<string>();
        str.add('a');
        str.add('b');
        str.add('a');
        str.add('v');
        str.add('x');
        str.add('x');
        str.add('y');
        str.add('c');
        str.add('q');
        set<string>strSet = new set<string>(str);  // creating a set and assigning the list as value of set
        // set is having a by default property of keeping only unique values in it.
        system.debug('content is'+strset);
    }

}