def add_to_pickl_file(fname, new_data):
    # Given a pickle filename, append to it the new data (in our case, a list of dicts)
    import pickle
    import sys

    with open(fname, 'rb') as f:
        data = pickle.load(f)

    if not data:
        data = []

    data.append(new_data)

    with open(fname, 'wb') as f:
        print(data)
        pickle.dump(data, f)

def pickl_init(fname):
    with open(fname, 'rb'):
