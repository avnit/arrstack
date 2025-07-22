#     pip install python-upwork
import upwork as upwork

api_client_key = 'YOUR_API_KEY'
api_client_secret = 'YOUR_API_SECRET'

def get_job_info(job_id, api_client_key=api_client_key, api_client_secret=api_client_secret):
    client = upwork.Client(api_client_key, api_client_secret)
    job = client.job.get_job(job_id)
    return job
