public class EmailValue {
       
    public static void fetchValue(){      
       /* List<String> stringValue = new List<String>();
        List<EmailTemplate> emailsValue = [select id ,name ,htmlValue,body from EmailTemplate order by lastModifiedDate desc limit 1];
        System.debug('emailsValue:: '+ emailsValue);
        
        for(EmailTemplate e : emailsValue){
            if(e != null){
                String s1 = e.htmlValue;
                System.debug('s1:: '+ s1);
                String s2 = s1.stripHtmlTags();
				System.debug('s2:: '+ s2);
                stringValue.add(s2); 
            }

        }
    } */   
        	EmailTemplate emailsValue = [select id ,name ,htmlValue,body from EmailTemplate order by lastModifiedDate desc limit 1];
        		
            String myHTML = '';
                                 
            String htmlPattern = '<(?i).*?>';
          	String breakPattern = '(?i).*?>';  // matches <br>, <BR>, <br/>, <br />, <br   />, etc.
            String whitespacePattern = '\\s+' ;
            
            String workingText ;
            String plainText ;
            
            // replace all HTML break tags with the newLine character
            pattern lineBreaks = pattern.compile(breakPattern);
            matcher matchedLineBreaks = lineBreaks.matcher(myHTML);
            workingText = matchedLineBreaks.replaceAll('\n');
            
            // take what's left and remove all HTML tags, replacing them with a single space  
            pattern htmlTags = pattern.compile(htmlPattern);
            matcher matchedHTML = htmlTags.matcher(workingText);
            workingText = matchedHTML.replaceAll(' ');
            
            // replace all whitespace with single spaces, and we're all done!
            pattern whitespace = pattern.compile(whitespacePattern);
            matcher matchedWhitespace = whitespace.matcher(workingText);
            plainText = matchedWhitespace.replaceAll(' ');  
	}
}