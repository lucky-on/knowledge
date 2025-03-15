import matplotlib.pyplot as plt
import matplotlib.patches as mpatches
import numpy as np

# Define character colors
character_colors = {
    'Мурзавецкая': 'red',
    'Павлин': 'blue',
    'Мурзавецкий': 'green',
    'Глафира': 'purple',
    'Купавина': 'orange',
    'Чугунов': 'cyan',
    'Лыняев': 'magenta',
    'Анфуса': 'yellow'
}

# Define scenes with character appearances, start and end positions, and word counts
scenes = {
    'Явление первое': {
        'Павлин': {'start': 0, 'end': 50, 'words': 50},
        'Мурзавецкая': {'start': 10, 'end': 30, 'words': 20},
        'Глафира': {'start': 10, 'end': 30, 'words': 1},
        'Мурзавецкий': {'start': 20, 'end': 50, 'words': 30}
    },
    'Явление второе': {
        'Мурзавецкий': {'start': 0, 'end': 100, 'words': 100},
        'Глафира': {'start': 0, 'end': 50, 'words': 30},
        'Павлин': {'start': 50, 'end': 100, 'words': 20}
    },
    'Явление третье': {
        'Мурзавецкий': {'start': 0, 'end': 80, 'words': 80},
        'Мурзавецкая': {'start': 20, 'end': 80, 'words': 60},
        'Павлин': {'start': 0, 'end': 20, 'words': 10}
    },
    'Явление четвертое': {
        'Мурзавецкий': {'start': 0, 'end': 50, 'words': 50},
        'Глафира': {'start': 10, 'end': 50, 'words': 40}
    },
    'Явление пятое': {
        'Мурзавецкая': {'start': 0, 'end': 100, 'words': 100},
        'Чугунов': {'start': 20, 'end': 80, 'words': 60}
    },
    'Явление шестое': {
        'Лыняев': {'start': 0, 'end': 70, 'words': 70},
        'Мурзавецкая': {'start': 10, 'end': 60, 'words': 50},
        'Анфуса': {'start': 20, 'end': 40, 'words': 20}
    },
    'Явление седьмое': {
        'Купавина': {'start': 0, 'end': 60, 'words': 60},
        'Мурзавецкая': {'start': 10, 'end': 50, 'words': 40}
    },
    'Явление восьмое': {
        'Мурзавецкая': {'start': 0, 'end': 80, 'words': 80},
        'Павлин': {'start': 10, 'end': 50, 'words': 40},
        'Глафира': {'start': 20, 'end': 40, 'words': 20}
    },
    'Явление девятое': {
        'Купавина': {'start': 0, 'end': 90, 'words': 90},
        'Чугунов': {'start': 20, 'end': 70, 'words': 50}
    },
    'Явление десятое': {
        'Лыняев': {'start': 0, 'end': 100, 'words': 100},
        'Купавина': {'start': 20, 'end': 90, 'words': 70}
    },
    'Явление одиннадцатое': {
        'Мурзавецкий': {'start': 0, 'end': 50, 'words': 50},
        'Мурзавецкая': {'start': 10, 'end': 50, 'words': 40},
        'Купавина': {'start': 20, 'end': 50, 'words': 30},
        'Глафира': {'start': 30, 'end': 50, 'words': 20}
    },
    'Явление двенадцатое': {
        'Мурзавецкая': {'start': 0, 'end': 50, 'words': 50},
        'Мурзавецкий': {'start': 20, 'end': 50, 'words': 30}
    },
    'Явление тринадцатое': {
        'Купавина': {'start': 0, 'end': 200, 'words': 200},
        'Глафира': {'start': 20, 'end': 200, 'words': 180}
    },
    '': {
        'Купавина': {'start': 0, 'end': 0, 'words': 0},
        'Глафира': {'start': 0, 'end': 0, 'words': 0}
    }
}

# Define the plot
fig, ax = plt.subplots(figsize=(15, 8))

# Set y positions for each character in each scene
y_positions = {character: i for i, character in enumerate(character_colors.keys())}
y_labels = list(character_colors.keys())

# Plot each scene
for i, (scene, characters) in enumerate(scenes.items()):
    for character, data in characters.items():
        y_pos = y_positions[character]
        color = character_colors[character]
        start_pos = i * 100 + data['start']
        end_pos = i * 100 + data['end']
        width = (data['words'] / max([data['words'] for characters in scenes.values() for data in characters.values()])) * 2  # Normalizing width
        rect = mpatches.Rectangle((start_pos, y_pos - width / 2), end_pos - start_pos, width, color=color)
        ax.add_patch(rect)

# Set labels and title
ax.set_yticks(list(y_positions.values()))
ax.set_yticklabels(y_labels)
ax.set_xticks([i * 100 for i in range(len(scenes))])
ax.set_xticklabels(list(scenes.keys()), rotation=45, ha='right')
ax.set_xlabel('Явления')
ax.set_ylabel('Персонажи')
ax.set_title('Появление и реплики персонажей в каждом явлении')

# Show the plot
plt.grid(True)
plt.show()
