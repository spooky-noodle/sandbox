from course import Course

class Courselist:
    """
    Linked list representing all of the courses for 1 student at a university

    Attributes: 
        head(Course): the first course of the list, completely empty except for the next pointer
        n(Course): the current index of the list, used for __next__() calls
    """
    def __init__(self):
        self.head = Course()
        pass

    def insert(self, course_to_insert: Course = None):
        """insert the specified course_to_insert in Course Number ascending order"""
        pass

    def remove(self, number: int): 
        """remove the first occurrence of the specified Course"""
        pass

    def remove_all(self, number: int):
        """removes ALL occurrences of the specified Course"""
        pass

    def find(self, number: int):
        """find the first occurrance of the specified course in the list or return -1"""
        pass

    def size(self):
        """return the number of items in the list"""
        curr = self.head
        size = 0
        while curr.next != None:
            size += 1
            curr = curr.next
        return size

    def calculate_gpa(self):
        """return the GPA using all courses in the list"""
        pass

    def is_sorted(self):
        """return True if the list is sorted by Course Number, False otherwise"""
        curr = self.head.next
        while curr.next != None:
            if curr.number < curr.prev.number:
                return False
            else:
                curr = curr.next
        return True

    def __str__(self):
        """returns a string with each Course’s data on a separate line"""
        list_str = f"Current List: ({self.size()})"
        curr = self.head.next
        while curr.next != None:
            list_str += f"\n{curr.__str__()}"
        return list_str

    def __iter__(self):
        self.n = self.head
        return self

    def __next__(self):
        if self.n.next == None:
            raise StopIteration
        else:
            self.n = self.n.next
            return self.n.prev