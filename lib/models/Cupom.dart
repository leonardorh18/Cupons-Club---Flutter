class Cupom {

  var _id ;
  var _data_criacao;
  var _data_termino;
  var _descricao;
  var _porc_desconto ;
  var _preco ;
  var _nome_produto ;
  var _contagem_cupons ;
  var _estabelecimento_id ;
  var _estabelecimento;
  var _link_imagem;
  

    
  Cupom(this._id ,this._data_criacao, this._contagem_cupons, this._data_termino, 
  this._descricao, this._estabelecimento_id,  this._estabelecimento,
        this._nome_produto, this._porc_desconto, this._preco, this._link_imagem);

 getNome(){
  return this._nome_produto;
}
 get link_imagem => this._link_imagem;

 set link_imagem(var value) => this._link_imagem = value;

get getEstabelecimento => this._estabelecimento;

 set setEstabelecimento( estabelecimento) => this._estabelecimento = estabelecimento;

  get id => this._id;

 set id( value) => this._id = value;

  get data_criacao => this._data_criacao;

 set data_criacao( value) => this._data_criacao = value;

  get data_termino => this._data_termino;

 set data_termino( value) => this._data_termino = value;

  get descricao => this._descricao;

 set descricao( value) => this._descricao = value;

  get porc_desconto => this._porc_desconto;

 set porc_desconto( value) => this._porc_desconto = value;

  get preco => this._preco;

 set preco( value) => this._preco = value;

  get nome_produto => this._nome_produto;

 set nome_produto( value) => this._nome_produto = value;

  get contagem_cupons => this._contagem_cupons;

 set contagem_cupons( value) => this._contagem_cupons = value;

  get estabelecimento_id => this._estabelecimento_id;

 set estabelecimento_id( value) => this._estabelecimento_id = value;

  

 
}