import re

# ORM tools
import web2py
import SQLObject
import SQLAlchemy

def validate_input(input_string):
    pattern = r'^[a-zA-Z0-9]+$'
    if re.match(pattern, input_string):
        return True
    else:
        return False
