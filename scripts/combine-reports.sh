#!/bin/bash

kube_bench_reports=($1)
kube_hunter_reports=($2)
output_report=$3

echo "# Combined Security Scan Report" > $output_report
echo "" >> $output_report

echo "## kube-bench Reports" >> $output_report
for report in ${kube_bench_reports[@]}; do
  echo '```json' >> $output_report
  cat $report >> $output_report
  echo '```' >> $output_report
  echo "" >> $output_report
done

echo "## kube-hunter Reports" >> $output_report
for report in ${kube_hunter_reports[@]}; do
  echo '```json' >> $output_report
  cat $report >> $output_report
  echo '```' >> $output_report
  echo "" >> $output_report
done

echo "Report generated on $(date)" >> $output_report
