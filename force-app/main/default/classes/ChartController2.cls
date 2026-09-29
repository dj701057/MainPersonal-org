public class ChartController2 {
    public List<Account> accountList { get; set; }

    public ChartController2() {
        accountList = [SELECT Name, AnnualRevenue FROM Account];
    }

    public String getChartData() {
        List<String> labels = new List<String>();
        List<Decimal> data = new List<Decimal>();

        for (Account acc : accountList) {
            labels.add(acc.Name);
            data.add(acc.AnnualRevenue);
        }

        Map<String, Object> chartData = new Map<String, Object>{
            'type' => 'bar',
            'data' => new Map<String, Object>{
                'labels' => labels,
                'datasets' => new List<Map<String, Object>>{
                    new Map<String, Object>{
                        'label' => 'Annual Revenue',
                        'data' => data
                    }
                }
            }
        };

        return JSON.serialize(chartData);
    }
}