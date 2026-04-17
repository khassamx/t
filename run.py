from flask import Flask, request, jsonify
from flask_cors import CORS
import logging
import queue
import threading
import time

app = Flask(__name__)
CORS(app)

# Configure logging
logging.basicConfig(level=logging.INFO)

# Task queue for processing videos
video_queue = queue.Queue()

# Worker thread to process videos from the queue
def video_worker():
    while True:
        video_task = video_queue.get()
        logging.info(f'Processing video: {video_task}')
        try:
            # Simulate video processing time
            time.sleep(5)  # Simulating processing delay
            logging.info(f'Finished processing video: {video_task}')
        except Exception as e:
            logging.error(f'Error processing video {video_task}: {str(e)}')
        finally:
            video_queue.task_done()

# Start a thread for processing videos in the background
threading.Thread(target=video_worker, daemon=True).start()

@app.route('/upload', methods=['POST'])
def upload_video():
    file = request.files['file']
    if not file:
        logging.error('No file part')
        return jsonify({'error': 'No file provided'}), 400
    video_task = file.filename
    video_queue.put(video_task)
    logging.info(f'Video {video_task} queued for processing.')
    return jsonify({'message': 'Video uploaded successfully'}), 200

@app.errorhandler(500)
def internal_error(error):
    logging.error(f'Internal Server Error: {error}')
    return jsonify({'error': 'Internal Server Error'}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=False)