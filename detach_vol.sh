#!/bin/bash
[ $# -ne 1 ] && { echo -e "Incorrect number of arguments.\nUsage: ${0} <instnance_id>"; exit 1; }
instance_id="$1"

for volume_id in $(aws ec2 describe-instances --instance-id ${instance_id} --region us-east-2 --query 'Reservations[*].[Instances[*].BlockDeviceMappings[?DeviceName!=`/dev/xvda` && DeviceName!=`/dev/sda1`].[Ebs.VolumeId]]' --output text); do echo "Detaching volume ${volume_id} from ${instance_id}"; aws ec2 detach-volume --volume-id ${volume_id} --region us-east-2; done

