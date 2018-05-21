import numpy as np
from scipy.io import wavfile
from scipy import interpolate
import sys

NEW_SAMPLERATE = 16000

old_samplerate, old_audio = wavfile.read(sys.argv[1])

if old_samplerate != NEW_SAMPLERATE:
    duration = old_audio.shape[0] / old_samplerate

    time_old  = np.linspace(0, duration, old_audio.shape[0])
    time_new  = np.linspace(0, duration, int(old_audio.shape[0] * NEW_SAMPLERATE / old_samplerate))

    interpolator = interpolate.interp1d(time_old, old_audio.T)
    new_audio = interpolator(time_new).T

    wavfile.write("downsampled.wav", NEW_SAMPLERATE, np.round(new_audio).astype(old_audio.dtype))