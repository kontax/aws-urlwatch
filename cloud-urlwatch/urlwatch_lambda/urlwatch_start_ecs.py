import json
import os

from aws import start_ecs_task
from common import return_code

ECS_CLUSTER = os.environ.get('ECS_CLUSTER')
TASK_DEFN = os.environ.get('TASK_DEFN')
SUBNETS = os.environ.get('SUBNETS')
SECURITY_GROUPS = os.environ.get('SECURITY_GROUPS')


def handler(event, context):
    print(json.dumps(event))
    subnets = SUBNETS.split(',')
    security_groups = SECURITY_GROUPS.split(',')
    print(subnets)
    print(security_groups)
    start_ecs_task(ECS_CLUSTER, TASK_DEFN, subnets, security_groups)
    return return_code(200, {'status': 'ECS task starting'})

