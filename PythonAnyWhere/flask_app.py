
#utulizar o flask e algumas outras bibliotecas que serao necessarias
from flask import Flask, render_template, request, Response
from flask_sqlalchemy import SQLAlchemy

#============================================================================================================================

app = Flask(__name__, template_folder='templates')
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = True
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://azsolutions:***********@azsolutions.mysql.pythonanywhere-services.com/azsolutions$testeGL'                #mysql://usuario:senha@provedor/nomedobanco
db = SQLAlchemy(app)

class Produto(db.Model):
    codProduto = db.Column(db.Integer, primary_key=True, autoincrement=True)                            #id do produto
    nomeProduto = db.Column(db.String(120))                                                             #nome do produto
    marca = db.Column(db.String(45))
    preco = db.Column(db.String(45))

    def to_json(self):
        return {"codProduto":self.codProduto, "nomeProduto":self.nomeProduto, "marca":self.marca, "preco":self.preco}
#from flask_app import db
#db.create_all()




#============================================================================================================================
@app.route('/')
def login():
    return render_template('login.html')


@app.route('/estoque')
def estoque():
    return render_template('estoque.html')


@app.route('/esqsenha')
def esqsenha():
    return render_template('esqsenha.html')

@app.route('/cadastro')
def cadastro():
    return render_template('cadastro.html')



#============================================================================================================================
#Selecionar Tudo
@app.route('/produtos', methods=["GET"])
def selecionaProdutos():
    produtos_objetos = Produto.query.all()
    produtos_json = [produto.to_json for produto in produtos_objetos]
    print(produtos_json)
    return gera_response(200, "produtos", produtos_json, "ok")




#Selecionar Individual
@app.route('/produto/<codProduto>', methods=["GET"])
def selecionaProduto(codProduto):
    produto_objeto = Produto.query.filter_by(codProduto=codProduto).first()                                                 #pegar produto
    produto_json = produto_objeto.to_json()
    return gera_response(200, "produto", produto_json)




#Cadastrar
@app.route('/produto', methods=["POST"])
def criaProduto():
    body = request.get_json()

    try:
        produto = Produto(nomeProduto=body["nomeProduto"], marca=body["marca"], preco=body["preco"])                         #criacao de um usuario (a partir da classe)
        db.session.add(produto)                                                                                              #foi aberta uma sessao e colocada a classe anterior
        db.session.commit()
        return gera_response(201, "produto", produto.to_json(), "Criado com Sucesso!!")
    except Exception as e:
        print('Erro', e)
        return gera_response(400, "produto", {}, "Erro ao Cadastrar")




#Atualizar
@app.route('/produto/<codProduto>', methods=["PUT"])
def atualizaProduto(codProduto):
    #pegar produto
    produto_objeto = Produto.query.filter_by(codProduto=codProduto).first()
    #pegar modificacoes
    body = request.get_json()

    try:
        if('nomeProduto' in body):
            produto_objeto.nome = body['nomeProduto']
        if('marca' in body):
            produto_objeto.marca = body['marca']
        if('preco' in body):
            produto_objeto.preco = body['preco']

        db.session.add(produto_objeto)
        db.session.commit()
        return gera_response(200, "produto", produto_objeto.to_json(), "Atualizado com Sucesso!!")
    except Exception as e:
        print('Erro', e)
        return gera_response(400, "produto", {}, "Erro ao Atualizar")





#Deletar
@app.route('/produto/<codProduto>', methods=["DELETE"])
def deletaProduto(codProduto):
    produto_objeto = Produto.query.filter_by(codProduto=codProduto).first()                                                #pegar produto

    try:
        db.session.delete(produto_objeto)
        db.session.commit()
        return gera_response(200, "produto", produto_objeto.to_json(), "Deletado com Sucesso!!")
    except Exception as e:
        print('Erro', e)
        return gera_response(400, "produto", {}, "Erro ao Deletar")





def gera_response(status, nomeConteudo, conteudo, mensagem=False):
    body = {}
    body [nomeConteudo] = conteudo

    if(mensagem):
        body["mensagem"] = mensagem

    return Response(json.dumps(body), status=status, mimetype= "application/json")

