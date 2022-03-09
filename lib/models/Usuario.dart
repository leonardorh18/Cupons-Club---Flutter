

class Usuario {

  var _id;
  var _email;
  var _nome;
  var _telefone;
  var _senha;
  
  Usuario(this._id, this._nome, this._email, this._telefone, this._senha);

  get getId => this._id;
  get getEmail => this._email;
  get getNome => this._nome;
  get getTelefone => this._telefone;
  get getSenha => this._senha;

  set setId(id) => this._id = id;
  set setEmail(email) => this._email = email;
  set setNome(nome) => this._nome = nome;
  set setTelefone(telefone) => this._telefone = telefone;
  set setSenha(senha) => this._senha = senha;

}