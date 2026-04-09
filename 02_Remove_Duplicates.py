def remove_duplicates(input_string):
    result = ""

    for char in input_string:
        if char not in result:
            result += char

    return result


while True:
    user_input = input("Enter a string: ")

    if user_input == "":
        print("Please enter a string.")
        continue

    print(f"Original : {user_input}")
    print(f"Unique   : {remove_duplicates(user_input)}")