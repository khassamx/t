class Contact:
    def __init__(self, name, email, phone):
        self.name = name
        self.email = email
        self.phone = phone

class ContactManager:
    def __init__(self):
        self.contacts = []

    def add_contact(self, contact):
        self.contacts.append(contact)

    def search_contact(self, name=None, email=None):
        results = []
        for contact in self.contacts:
            if (name and name.lower() in contact.name.lower()) or 
               (email and email.lower() in contact.email.lower()):
                results.append(contact)
        return results

    def filter_contacts(self, criteria):
        return [contact for contact in self.contacts if criteria(contact)]

    def export_contacts(self, filename):
        with open(filename, 'w') as f:
            for contact in self.contacts:
                f.write(f'{contact.name},{contact.email},{contact.phone}\n')

# Example Usage
if __name__ == '__main__':
    manager = ContactManager()
    manager.add_contact(Contact('John Doe', 'john@example.com', '123-456-7890'))
    manager.add_contact(Contact('Jane Smith', 'jane@example.com', '098-765-4321'))
    search_results = manager.search_contact(name='Jane')
    for contact in search_results:
        print(contact.name, contact.email)
    manager.export_contacts('contacts.csv')
