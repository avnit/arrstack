import os
import upwork

def get_job_info(job_id):
    """Retrieves information about a job on Upwork."""
    api_client_key = os.environ.get("UPWORK_API_CLIENT_KEY")
    api_client_secret = os.environ.get("UPWORK_API_CLIENT_SECRET")

    if not api_client_key or not api_client_secret:
        print("Error: Please set the UPWORK_API_CLIENT_KEY and UPWORK_API_CLIENT_SECRET environment variables.")
        return None

    try:
        client = upwork.Client(api_client_key, api_client_secret)
        job = client.job.get_job(job_id)
        return job
    except Exception as e:
        print(f"Error: {e}")
        return None

if __name__ == "__main__":
    # Example usage:
    job_id = "~0123456789abcdef"
    job_info = get_job_info(job_id)
    if job_info:
        print(job_info)