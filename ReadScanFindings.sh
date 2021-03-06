#!/usr/bin/env bash
  set -e
#aws ecr wait image-scan-complete --repository-name centos --image-id imageTag=25
#if [ $(echo $?) -eq 0 ]; then
  SCAN_FINDINGS=$(aws ecr describe-image-scan-findings --repository-name centos --image-id imageTag=${BUILD_NUMBER} | jq '.imageScanFindings.findingSeverityCounts')
  CRITICAL=$(echo $SCAN_FINDINGS | jq '.CRITICAL')
  HIGH=$(echo $SCAN_FINDINGS | jq '.HIGH')
  MEDIUM=$(echo $SCAN_FINDINGS | jq '.MEDIUM')
  LOW=$(echo $SCAN_FINDINGS | jq '.LOW')
  INFORMATIONAL=$(echo $SCAN_FINDINGS | jq '.INFORMATIONAL')
  UNDEFINED=$(echo $SCAN_FINDINGS | jq '.UNDEFINED')
  if [ $CRITICAL != null ] || [ $HIGH != null ]; then
    echo Docker image contains vulnerabilities at CRITICAL or HIGH level
    aws ecr batch-delete-image --repository-name centos --image-ids imageTag=${BUILD_NUMBER}  #delete pushed image from container registry
    exit 0  #exit execution due to docker image vulnerabilities
  fi
#fi
