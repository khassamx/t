import ffmpeg
import os

class VideoCutter:
    def __init__(self, input_file):
        self.input_file = input_file

    def get_duration(self):
        try:
            probe = ffmpeg.probe(self.input_file)
            duration = float(probe['format']['duration'])
            return duration
        except ffmpeg.Error as e:
            print(f'Error getting duration: {e}')
            return None

    def cut(self, start_time, end_time, output_file):
        try:
            ffmpeg.input(self.input_file, ss=start_time, t=end_time - start_time).output(output_file).run()
        except ffmpeg.Error as e:
            print(f'Error cutting video: {e}')

    def segment(self, segment_length):
        duration = self.get_duration()
        if duration is None:
            return
        segments = []
        for start_time in range(0, int(duration), segment_length):
            end_time = min(start_time + segment_length, duration)
            segment_file = f'segment_{start_time}_{end_time}.mp4'
            self.cut(start_time, end_time, segment_file)
            segments.append(segment_file)
        return segments

if __name__ == '__main__':
    cutter = VideoCutter('input_video.mp4')
    cutter.segment(60)  # Segment into 1-minute parts