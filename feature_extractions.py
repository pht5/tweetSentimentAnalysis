def load_data(filename):
    import pickle

    with open(filename, 'rb') as f:
        data = pickle.load(f)

    return data

def make_labels(data):
    # The data we have decided on is going to be stored as a list of
    # dictionaries, where inside the dictionaries are our handlabled data
    return


if __name__ == "__main__":
    data = load_data('ben_labels.pckl')
    print(len(data))
    
