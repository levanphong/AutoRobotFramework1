class TokenHelper:
    def get_token_orient_event(self, env_type):
        environment = {
            'Olivia': 'Basic NzQyOTkzODY0MEtFQUVNR1Y4Q1NaMTRCOVlMWlo1SDE6SDNFTEQwN1cwQTRHSjc4RElKTDdVT1g0UDNYNlgzOUg0VExVUTVERDRBUEtOMFlYSUtONExXTkdDVENSQkw5Rg==',
            'STG': 'Basic NTE4NDAzOTdOV0lFR0RaQkhQQ0tBU1VBTU0yM0pYNlc6S0EzS0M3VTk0SEg0WFJJQzZNMk5TRkZTUUdBVFk4WFM5QldSU1RHNEZDS1MxNlFMS01XMkQ0MlJTSkJDU1lMSw=='
        }
        return environment.get(env_type, "Invalid environment")
