from flask import Flask, jsonify
from get_info_job_info import search_jobs

app = Flask(__name__)

@app.route("/jobs")
def get_jobs():
    jobs = search_jobs("Google Cloud Platform")
    return jsonify(jobs)

if __name__ == "__main__":
    app.run(debug=True)