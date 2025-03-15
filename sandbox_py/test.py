states_visited = {
  'Eric' : ['A','B','C'],
  'Isaac': ['D', 'E', 'F']
}

print(states_visited.items())


str = "Hello World"

for cc in str:
    print(f"{cc}")

for states, name  in states_visited.items():
    print(name)
    print(states)
    print(f"{name} has visited:")
    for state in states:
        print(f"\t{state}")
