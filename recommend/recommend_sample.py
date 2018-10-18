#!/usr/bin/env python
# -*- coding: utf-8 -*-


import numpy as np
import csv
import sys


len_tmp = 1000
file_name = sys.argv[1]


def cos_sim(v1, v2):
    return np.dot(v1, v2) / (np.linalg.norm(v1) * np.linalg.norm(v2))

def favorite_genre(genre, input_wave, chart_len):
    max_value = 0
    max_genre = ""
    for k,v in genre.items():
        sim = cos_sim(input_wave[:chart_len], genre[k][:chart_len])
        if  sim > max_value:
            max_value = sim
            max_genre = k
    return max_genre

def read_input_wave(csv_file):
    f = open(csv_file)
    reader = csv.reader(f, delimiter=",")
    # header = next(reader)
    # print(header)
    chart = []
    for row in reader:
        chart.append(float(row[0]))
    return chart

def main():
    genre = {}
    genre["jazz"] = np.random.rand(len_tmp)
    genre["jpop"] = np.random.rand(len_tmp)
    genre["hiphop"] = np.random.rand(len_tmp)

    input_wave = read_input_wave(file_name)

    chart_len = min(len_tmp, len(input_wave))

    return favorite_genre(genre, input_wave, chart_len)

# def move_average(data, n):
#     return np.convolve(data, np.ones(n)/float(n), 'valid')

if __name__ == '__main__':
    #print(read_input_wave("test.csv"))

    print(main())


