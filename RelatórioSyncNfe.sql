SELECT
	clientes.cod AS 'Cod',
	clientes.nome AS 'RazaoSocial/NomeCliente',
	clientes.fantasia AS 'Fantasia/Apelido',
	IF(LENGTH(clientes.cpf) = 11, 'PF', 'PJ') AS 'TipoCliente',
	clientes.cpf AS 'CNPJ/CPF',
	clientes.rg AS 'IE/RG',
	GROUP_CONCAT(
	  	DISTINCT IF(clientes_contato.tipo = 'e', contato_cliente.contato, NULL) SEPARATOR ','
	) AS 'Email',
	GROUP_CONCAT(
	  	DISTINCT IF(clientes_contato.tipo <> 'e', contato_cliente.contato, NULL) SEPARATOR ','
	) AS 'Telefone/Celular',
	clientes.endereco_nf AS 'Logradouro',
	clientes.numero_nf AS 'Numero',
	clientes.complemento_nf AS 'Complemento',
	clientes.bairro_nf AS 'Bairro',
	cidades.codIbge AS 'CodigoIBGEMunicipio',
	cidades.uf AS 'UF',
	clientes.cep_nf AS 'CEP',
	IF(contrato_cliente.ativo = 's', '1', '0') AS 'Ativo', 
	IF(LENGTH(clientes.cgc) = 11, '03', '01') AS 'Tipo de Cliente'
FROM clientes
LEFT JOIN contato_cliente ON (contato_cliente.idcliente = clientes.id)
LEFT JOIN cidades ON (cidades.id = clientes.cidade_cob)
LEFT JOIN contrato_cliente ON (contrato_cliente.idcliente = clientes.id)
GROUP BY clientes.id
