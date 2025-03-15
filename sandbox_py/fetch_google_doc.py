import requests
from bs4 import BeautifulSoup


def fetch_and_print_grid(doc_url):
    # 1. Download the HTML of the published Google Doc
    response = requests.get(doc_url)
    response.raise_for_status()

    # 2. Parse the HTML with BeautifulSoup
    soup = BeautifulSoup(response.text, 'html.parser')

    # 3. Locate the table and extract rows
    #    Look for <table> then <tr> elements
    table = soup.find('table')
    if not table:
        raise ValueError("No table found in the provided URL or the table could not be parsed.")

    rows = table.find_all('tr')

    # 4. Parse each row to get (x, char, y)
    #    Skip a header row
    coords = []  # will hold (x, char, y) tuples

    for row_index, tr in enumerate(rows):
        # Extract all cells <td> in this row
        cells = tr.find_all(['td', 'th'])

        # Read the columns (assuming x-coord, character, y-coord)
        # Parse x and y as integers
        try:
            x_str = cells[0].get_text(strip=True)
            character_str = cells[1].get_text(strip=True)
            y_str = cells[2].get_text(strip=True)

            x = int(x_str)
            y = int(y_str)

            # Append the triple to the list
            coords.append((x, character_str, y))
        except ValueError:
            continue

    # 5. Determine the bounding rectangle of the grid
    max_x = max(item[0] for item in coords)
    max_y = max(item[2] for item in coords)

    # 6. Build a lookup dict for quick character access by (x, y)
    #    Key: (x, y), Value: the character string
    char_map = {}
    for (x, char, y) in coords:
        char_map[(x, y)] = char

    # 7. Print the grid.
    #    (0,0) is bottom-left, so print from top row down to y=0
    for y in range(max_y, -1, -1):
        row_chars = []
        for x in range(max_x + 1):
            row_chars.append(char_map.get((x, y), ' '))
        # Join the row of characters into a single string
        print("".join(row_chars))


doc_url = "https://docs.google.com/document/d/e/2PACX-1vQGUck9HIFCyezsrBSnmENk5ieJuYwpt7YHYEzeNJkIb9OSDdx-ov2nRNReKQyey-cwJOoEKUhLmN9z/pub"
fetch_and_print_grid(doc_url)