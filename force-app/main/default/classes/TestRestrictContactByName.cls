@isTest
private class TestRestrictContactByName {

    @isTest static void testInvalidLastName() {
        // 1. Criar o dado de teste com o nome proibido
        Contact c = new Contact(LastName = 'INVALIDNAME');
        
        // 2. Executar o teste
        Test.startTest();
        // Usamos o parâmetro 'false' no Database.insert para permitir que o teste continue 
        // mesmo após a falha do trigger, para podermos validar o erro.
        Database.SaveResult result = Database.insert(c, false);
        Test.stopTest();
        
        // 3. Verificar (Assert)
        // O sucesso deve ser falso
        System.assert(!result.isSuccess());
        // A mensagem de erro deve ser exatamente a que está no trigger
        System.assertEquals('The Last Name "INVALIDNAME" is not allowed for DML', 
                             result.getErrors()[0].getMessage());
    }
}