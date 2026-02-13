public class RandomContactFactory {

    public static List<Contact> generateRandomContacts(Integer numContacts, String lastName) {
        List<Contact> contacts = new List<Contact>();
        
        for(Integer i = 0; i < numContacts; i++) {
            // O primeiro nome deve ser "Test" seguido do número da iteração
            Contact c = new Contact(FirstName = 'Test ' + i, LastName = lastName);
            contacts.add(c);
        }
        
        // Retorna a lista sem realizar o "insert"
        return contacts;
    }
}