def calculate_rectangle_area(length, width):
    """
    Calculate the area of a rectangle.

    Args:
    - length (float): Length of the rectangle.
    - width (float): Width of the rectangle.

    Returns:
    - float: The calculated area of the rectangle.
    """
    area = length * width
    return area

def main():
    # Define length and width of the rectangle
    length = 5.0
    width = 3.0

    # Calculate the area of the rectangle
    area = calculate_rectangle_area(length, width)

    # Display the result
    print("The area of the rectangle is:", area)

if __name__ == "__main__":
    main()
