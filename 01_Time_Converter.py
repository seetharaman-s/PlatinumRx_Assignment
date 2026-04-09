def convert_minutes(total_minutes):
    hours   = total_minutes // 60
    minutes = total_minutes  % 60

    hr_label  = "hr"  if hours   == 1 else "hrs"
    min_label = "minute" if minutes == 1 else "minutes"

    return f"{hours} {hr_label} {minutes} {min_label}"


while True:
    user_input = input("Enter number of minutes: ")

    try:
        print(f"Result: {convert_minutes(int(user_input))}")
    except ValueError:
        print("Invalid input. Please enter a whole number.")