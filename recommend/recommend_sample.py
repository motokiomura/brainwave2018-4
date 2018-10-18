import numpy as np

def cos_sim(v1, v2):
    return np.dot(v1, v2) / (np.linalg.norm(v1) * np.linalg.norm(v2))

def favorite_genre(genre, input_wave):
    max_value = 0
    max_genre = ""
    for k,v in genre.items():
        sim = cos_sim(input_wave, genre[k])
        if  sim > max_value:
            max_value = sim
            max_genre = k
    return max_genre

def main():
    genre = {}

    genre["jazz"] = np.random.rand(100)

    genre["jpop"] = np.random.rand(100)

    input_wave = np.random.rand(100)

    return favorite_genre(genre, input_wave)

if __name__ == '__main__':
    print(main())


