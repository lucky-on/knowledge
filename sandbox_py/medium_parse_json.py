import json

def solution(postContentString):
    postContent = json.loads(postContentString)
    # Type your solution here

    sections = list(postContent["sections"])
    paragraphs = list(postContent["paragraphs"])

    section_ids = []
    for s in sections:
        if s["startIndex"] != 0:
            section_ids.append(s["startIndex"])

    # make sure all section ids are in order
    section_ids.sort()

    # make sure there are no duplicates (there is at least one paragraph between sections)
    previous_id = -1
    for id in section_ids:
        if id == previous_id:
            section_ids.remove(id)
            #raise Exception("section ids must have a gap for paragraph(s)")

    section_index=0 # index to track internal index in list of sections
    index=0 # common index for paragraphs and sections

    post_string = "" # post string we return

    # idea is to go over all paragraphs (assuming they are in the right order)
    # and add it to the output string, but if index is equal to section index
    # then add "-\n" in front of it
    for p in paragraphs:
        if len(section_ids) > section_index and section_ids[section_index] == index:
            post_string += "-\n"
            section_index += 1
        post_string += p["text"]
        index += 1
        if(index < len(paragraphs)):
             post_string += "\n"

    return post_string

str = "{\"paragraphs\": [{\"id\" : \"aaa\", \"text\": \"aaa\"}, {\"id\": \"bbb\", \"text\": \"bbb\"}, {\"id\": \"ccc\", \"text\": \"ccc\"}, {\"id\": \"ddd\", \"text\": \"ddd\"}, {\"id\": \"eee\", \"text\": \"eee\"}, {\"id\": \"fff\", \"text\": \"fff\"}], \"sections\" : [{\"id\": \"s0\", \"startIndex\": 0}, {\"id\": \"s1\", \"startIndex\": 2}, {\"id\": \"s2\", \"startIndex\": 4}]}"

print(solution(str))
