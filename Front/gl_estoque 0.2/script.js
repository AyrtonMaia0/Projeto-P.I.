let btnAdd = document.querySelector('button');
let table = document.querySelector('table');
let nomeInput = document.querySelector('#nome');
let codigoInput = document.querySelector('#codigo');
let codBarraInput = document.querySelector('#codBarra');
let precoInput = document.querySelector('#preco');
let setorInput = document.querySelector('#setor');
let quantidadeInput = document.querySelector('#quantidade');

btnAdd.addEventListener('click', () => {
    let nome = nomeInput.value;
    let codigo = codigoInput.value;
    let codBarra = codBarraInput.value;
    let quantidade = quantidadeInput.value;
    let preco = precoInput.value;
    let setor = setorInput.value;
   
    var date = new Date();
	var current_date = date.getDate() + "/" + (date.getMonth()+1) + "/" + date.getFullYear();
    var current_time = date.getHours()+":"+ date.getMinutes()+":"+ date.getSeconds();

    var current_datetime = current_time + "<br>" + current_date;
    
    if(nome == "" || nome == null){
        nome = "---";
    } 

    if(codigo == "" || codigo == null){
        codigo = "---";
    } 

    if(codBarra == "" || codBarra == null){
        codBarra = "---";
    } 

    if(quantidade == "" || quantidade == null){
        quantidade = 0;
    } 

    let template = `
                <tr>
                    <td>${nome}</td>
                    <td>${codigo}</td>       
                    <td>${codBarra}</td>             
                    <td>${'R$ ' + preco}</td>
                    <td>${setor}</td>                 
                    <td>${quantidade}</td>
                    <td>${current_datetime}</td>
                </tr>`;
    table.innerHTML += template;
});