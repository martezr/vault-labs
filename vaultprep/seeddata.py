import os
import urllib3
import hvac
from base64 import b64encode
from os import urandom

urllib3.disable_warnings()
client = hvac.Client(url='http://localhost:8200', token=os.environ['VAULT_TOKEN'], verify=False)

def generaterandom():
    random_bytes = urandom(32)
    token = b64encode(random_bytes).decode('utf-8')
    return token

def seed_kvv1_data(mount_point, num):
    for x in range(num):
        randomstring = generaterandom()
        hvac_secret = {
            'password': randomstring,
        }
        client.kv.v1.create_or_update_secret(path='/secret' + str(x), secret=hvac_secret, mount_point=mount_point)

def seed_kvv2_data(mount_point, num):
    for x in range(num):
        randomstring = generaterandom()
        hvac_secret = {
            'password': randomstring,
        }
        client.kv.v2.create_or_update_secret(path='/secret' + str(x), secret=hvac_secret, mount_point=mount_point)

seed_kvv1_data('secret',600)
seed_kvv2_data('kv2secret',450)

