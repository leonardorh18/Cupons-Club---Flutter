


class Tarefa {


  var _id;
  var _descricao;
  var _cupom_id;

  Tarefa(this._descricao, this._id);

  get getId => this._id;

 set setId( id) => this._id = id;

  get getDescricao => this._descricao;

 set setDescricao( descricao) => this._descricao = descricao;

  get cupomid => this._cupom_id;

 set cupomid( value) => this._cupom_id = value;



}