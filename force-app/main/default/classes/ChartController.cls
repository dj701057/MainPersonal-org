public class ChartController {
    public String dynamicUrl { get; set; }

    public ChartController() {
        // Query the Account data
        List<Account> accounts = [SELECT Name, AnnualRevenue FROM Account WHERE AnnualRevenue != null  LIMIT 4        ];

        // Create lists to store the account names and spend data
        List<String> accountNames = new List<String>();
        List<String> accountSpends = new List<String>();
        for (Account acc : accounts) {
            accountNames.add('"' + acc.Name + '"');
            accountSpends.add(String.valueOf(acc.AnnualRevenue));
        }

        // Set up chart config and replace the data with dynamic values.
        String config = '{'
            + '    "type": "bar",'
            + '    "data": {'
            + '        "labels": [' + String.join(accountNames, ',') + '],'
            + '        "datasets": [{'
            + '            "label": "AnnualRevenue",'
            + '            "data": [' + String.join(accountSpends, ',') + '],'
            + '            "backgroundColor": "rgba(0,123,255,0.5)",'
            + '            "borderColor": "rgba(0,123,255,1)",'
            + '            "borderWidth": 1'
            + '        }]'
            + '    },'
            + '    "options": {'
            + '        "scales": {'
            + '            "yAxes": [{'
            + '                "ticks": {'
            + '                    "beginAtZero": true'
            + '                }'
            + '            }]'
            + '        },'
            + '        "plugins": {'
            + '            "datalabels": {'
            + '                "color": "#000",'
            + '                "anchor": "end",'
            + '                "align": "top",'
            + '                "formatter": function(value, context) {'
            + '                    return value;'
            + '                }'
            + '            }'
            + '        }'
            + '    }'
            + '}';

        // Construct the URL
        String encodedConfig = EncodingUtil.urlEncode(config, 'UTF-8');
        dynamicUrl = 'https://quickchart.io/chart?c=' + encodedConfig;
    }
}