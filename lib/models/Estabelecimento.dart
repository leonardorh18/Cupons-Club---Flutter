


class Estabelecimento {

 var id;
 var email;
 var telefone;
 var nome;
 var rua;
 var numero;
 var bairro;
 var cidade;
 var estado;
 var cep;


Estabelecimento({this.bairro, this.cep, this.cidade, 
   this.estado, this.id, this.nome,
  this.numero, this.rua, this.telefone, this.email,});

 
get getId => this.id;

 set setId(var id) => this.id = id;

  get getEmail => this.email;

 set setEmail( email) => this.email = email;

  get getTelefone => this.telefone;

 set setTelefone( telefone) => this.telefone = telefone;

  get getNome => this.nome;

 set setNome( nome) => this.nome = nome;

  get getRua => this.rua;

 set setRua( rua) => this.rua = rua;

  get getNumero => this.numero;

 set setNumero( numero) => this.numero = numero;

  get getBairro => this.bairro;

 set setBairro( bairro) => this.bairro = bairro;

  get getCidade => this.cidade;

 set setCidade( cidade) => this.cidade = cidade;

  get getEstado => this.estado;

 set setEstado( estado) => this.estado = estado;

  get getCep => this.cep;

 set setCep( cep) => this.cep = cep;


}