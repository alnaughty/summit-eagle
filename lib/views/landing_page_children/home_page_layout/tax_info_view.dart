import 'package:flutter/material.dart';
import 'package:summiteagle/globals/app.dart';

class TaxInfoView extends StatelessWidget with AppConfig {
  TaxInfoView({Key? key}) : super(key: key);
  static final List<Map> _taxForms = [
    {
      "name": "PT",
      "data": [
        {
          "title": "2551Q",
          "description": "Percentage Trax Quarterly",
        },
      ]
    },
    {
      "name": "VT",
      "data": [
        {
          "title": "2550M",
          "description": "VAT Monthly",
        },
        {
          "title": "2550Q",
          "description": "VAT Quarterly",
        },
        {
          "title": "VAT RELIEF",
          "description": "Attachment to Vat Quarterly",
        },
      ]
    },
    {
      "name": "IT",
      "data": [
        {
          "title": "1701",
          "description": "Mixed income Earners",
        },
        {
          "title": "1701A",
          "description": "Solely Professionals/ Business Owners",
        },
      ]
    },
    {
      "name": "IQ",
      "data": [
        {
          "title": "1701Q",
          "description": "Quarterly Tax",
        },
      ]
    },
    {
      "name": "WH",
      "data": [
        {
          "title": "0619E",
          "description": "Monthly Withholding Rent",
        },
        {
          "title": "1601EQ",
          "description": "Quarterly Withholding Rent",
        },
        {
          "title": "QAP Alphalist",
          "description": "Attachment to Quarterly Withholding Rent",
        },
        {
          "title": "1604E",
          "description": "Annual Withholding Rent",
        },
      ]
    },
    {
      "name": "WC",
      "data": [
        {
          "title": "1601C",
          "description": "Monthly Witholding Compensation",
        },
      ]
    },
  ];
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, c) {
        final double w = c.maxWidth;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              "Tax forms information",
              style: TextStyle(
                color: black,
                fontSize: 25,
                height: 1,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ..._taxForms.map(
              (e) => ListTile(
                title: Text(
                  e['name'],
                  style: TextStyle(
                    color: orange,
                    fontSize: 20,
                    height: 1,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                subtitle: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (_, index) => ListTile(
                    title: Text(
                      e['data'][index]['title'],
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(e['data'][index]['description'],
                        style: TextStyle(
                          color: black.withOpacity(.5),
                        )),
                  ),
                  separatorBuilder: (_, index) => const Divider(),
                  itemCount: e['data'].length,
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
