"""
 Copyright © 2026 James Wilcox and Hannah C. Tang.  All rights reserved.
 Permission is hereby granted to students registered for University of
 Washington CSE 344, CSE 414, and CSED 514/DATA 514 solely for purposes of
 the course.  No other use, copying, distribution, or modification is
 permitted without prior written consent. Instructors interested in reusing
 these course materials should contact the author.
"""

class Edge:
    def __init__(self, source, destination):
        self.source = source
        self.destination = destination

    def __repr__(self):
        return f"({self.source}, {self.destination})"


def sources_no_dups(edges):
    """Return a list of unique source values; ordering doesn't matter.

    This question is analogous to HW1's Q2.5.
    """
    sources = []
    #add all sources to a source list
    for i, v in enumerate(edges):
        sources.append(v.source)
    #find unique using the set function in base 
    unique = list(set(sources))
    #returns the unique source values 
    return [unique]


def edges_with_smaller_source(edges):
    """Return edges where source < destination, sorted by destination.

    This question is analogous to HW1's Q2.7.
    """
    #make everything into lists
    sources = []
    destinations = []
    slessd = []
    #get the source and destinations
    for i, v in enumerate(edges):
        sources.append(v.source)
        destinations.append(v.destination)
        if sources[i] < destinations[i]:
            toup = (sources[i], destinations[i])
            slessd.append(toup)
    #now sort it based on second item
    sorts = sorted(slessd, key=lambda x: x[1])  
    return(sorts)


if __name__ == "__main__":
    edges = [
        Edge(11, 6),
        Edge(2, 26),
        Edge(2, 4),
        Edge(5, 5),
    ]

    print(edges)
    print(sorted(sources_no_dups(edges)))
    print(edges_with_smaller_source(edges))
    print(edges)

    # Expected output:
    # [(11, 6), (2, 26), (2, 4), (5, 5)]
    # [2, 5, 11]
    # [(2, 4), (2, 26)]
    # [(11, 6), (2, 26), (2, 4), (5, 5)]