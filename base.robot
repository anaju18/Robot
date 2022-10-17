Documentation     Arquvo simples para realizar requsisões HTTP em APIs
Library           RequestsLibrary
Resource          ./rotas/usuarios_keywords.robot
Resource          ./rotas/produtos_keywords.robot
Resource          ./rotas/login_keywords.robot
Resource          ./rotas/carrinho.keywords.robot

*** Variables ***
${URL} =     http://localhost:3000
&{login}=    exemplo=fulano@qa.com    password=0123456      
${response}
${user_id}  

*** Test Cases ***
Cenario: Geral Rota Login
    [Tags]    GET
    Criar Sessão
    POST Login User Invalido 401                     ##Documentação não fala sobre status code 401
    POST Login User Sem Senha 400
    POST Login User Sem Email 400
    POST Login Usuario Valido 200
    Validar Ter Logado

Cenario: Geral Rota Usuarios
    [Tags]    ROTAS
    Criar Sessão
    GET Endpoint /Usuarios
    POST Usuarios User Cadastrado 400 
    POST Usuarios User Sem Email 400
    POST Usuarios User Sem Senha 400
    POST Usuarios User Valido 201                     #Tem que retornar 201 e criar um novo usuário com sucesso
    GET Usuario por ID 200                            #Tem que retornar o json do usuario criado
    DELETE Endpoint /usuarios Ultimo ID               #Deletar usuario Criado
    GET Usuario por ID 400                            #Tem que retornar 400, usuario foi deletado

Cenario: GET Todos os Usuarios 200
    [Tags]    GET
    Criar Sessão
    GET Endpoint /Usuarios
    Validar Status Code "200"

Cenario: GET Todos produtos 200
    [Tags]    GET
    Criar Sessão
    GET Endpoint /produtos

Cenario: GET produto por Id 200
    [Tags]    GET
    Criar Sessão
    GET Endpoint /produtos/"BeeJh5lz3k6kSIzA"
    Validar Status Code "200"

Cenario: POST Cadastrar Usuario 201
    [Tags]    POST
    Criar Sessão
    POST Endpoint /Usuarios
    Validar Status Code "201"
    Validar Se Mensagem Contém "sucesso"

Cenario: PUT Editar Usuario Criado 200
    [Tags]    PUT
    Criar Sessão
    PUT Endpoint /Usuarios
    Validar Status Code "200"
    
Cenario: DELETE Usuario Editado 200
    [Tags]    DELETE
    Criar Sessão
    DELETE Endpoint /usuarios Ultimo ID
    Validar Status Code "200"

Cenario: POST Realizar Login 200
    [tags]    POSTLOGIN
    Criar Sessão
    POST Endpoint /login
    Validar Status Code "200"

Cenario: POST Criar Produto 201
    [Tags]    POSTPRODUTO
    Criar Sessão
    Fazer Login e Armazenar Token
    POST Endpoint /produtos
    Validar Status Code "201"

Cenario: DELETE Excluir Produto 200
    [Tags]    DELETE_PRODUTO
    Criar Sessão
    Fazer Login e Armazenar Token
    Criar Produto e Armazenar ID
    DELETE Endpoint /produtos
    Validar Status Code "200"

Cenario: POST Criar Usuario De Massa Estatica 201
    [Tags]    POST_USUARIO_ESTATICO
    Criar Sessão
    Criar Usuario Estatico Valido
    POST Endpoint /Usuarios
    Validar Status Code "201"

*** Keywords ***
Criar Sessão         
    Create Session              serverest    ${URL}
Validar Quantidade "${qnt}"
    Should Be Equal            ${response.json()["quantidade"]}    ${qnt}
Validar Se Mensagem Contem "${palavra}"
    Should Contain             ${response.json()["message"]}    ${palavra}