 // SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract projectVotes is Ownable,AccessControl {
    bytes32 public constant ROLE_VOLTANTE = keccak256("ROLE_VOLTANTE"); // 0x226c4972ab1f314d4ad7ff65fbbf70e5647a0620354d97bff1b978c4cf385edf
    bytes32 public constant ROLE_ADMIN = keccak256("ROLE_ADMIN"); // 0x2172861495e7b85edac73e3cd5fbb42dd675baadf627720e687bcfdaca025096
    
    // Variables del Votante.
    uint totalVotos = 0;
    string public votoBueno = "Se Voto!";
    string public votoMalo = "No Voto!";

    constructor() {
        _setupRole(DEFAULT_ADMIN_ROLE,msg.sender);
        _setupRole(ROLE_VOLTANTE, msg.sender);
        _setRoleAdmin(ROLE_ADMIN,ROLE_ADMIN);
    }

    function voto() public view returns(bool) {
        //solamente los votantes puenden votar
        //solamente un votante por voto
        require(hasRole(ROLE_VOLTANTE, msg.sender), "Tu puedes voto");
        return true;
    }

    struct Votante{
        bool voto; // si es verdadero, la persona ya voto
        bool puedeVotar; // derecho al voto
        uint256 votos;
        uint256 tiempoVoto; // tiempo para votar
    }
    mapping (address => Votante) votantes;

    struct Candidato{
        uint id;
        address addressCandidato;
        string nombre;
        uint256 contadorVotos;
    }
    
    // 1. registro de candidatos (proyectos) con sus datos de identificación (nombre projecto)
    
    Candidato public candidato1 = Candidato({
        id: 1,
        nombre: "Travelandian",
        contadorVotos: 0,
        addressCandidato: 0x1234567890123456789100000000000000000000
    }); 

    Candidato public candidato2 = Candidato({
        id: 2,
        nombre: "Edulandian",
        contadorVotos: 0,
        addressCandidato: 0x1234567890123456789200000000000000000000
    }); 

    Candidato public candidato3 = Candidato({
        id: 3,
        nombre: "Ecolandian2",
        contadorVotos: 0,
        addressCandidato: 0x1234567890123456789300000000000000000000
    }); 

   /* 
    la idea es agregar a candidatos, hay que construir una funcion. 
    function registroCandidatos(string memory _nombre) public {
        candidato.push(candidato(_nombre),0);
    }*/

    // 2. derecho al voto a los votantes por el dueño del contrato

    function normalCosa() public {
        // cosa todos puede probar
    }

    function duenoChecar() public onlyOwner {
        // solamente para dueno

    }
    
    function permisoVotar() public view returns(bool) {
        require(hasRole(ROLE_VOLTANTE, msg.sender), "No Voto!");
        return true;
    }

    function derechoVoto() public view returns(string memory){
        require(hasRole(ROLE_VOLTANTE, msg.sender), "Solo las voltante puede darte derecho al Voto.");
        return "El votante ya voto.";
    } 
    



















    // 3. Votos de votantes == > falta solo 1 vez
    
    function votar (uint _candidato) public {
        require(votantes[msg.sender].puedeVotar, "No puedes votar");
        votantes[msg.sender].voto = true;
        
        // hay que poner la funcion del tiempo 

       

        if (_candidato == 1){
            // votas por Travelandian
            candidato1.contadorVotos += 1;
            
        }
        if (_candidato == 2){ 
            // votas por Edulandian
            candidato2.contadorVotos += 1;
          
        }
        if (_candidato == 3){
            // votas por Ecolandian
            candidato3.contadorVotos += 1;
        }

    } 

    /*
    function Votar(uint _candidato) public {
        Votante storage sender = votantes[msg.sender];
        require(sender.puedeVotar, "No tiene derecho a votar");
        require(!sender.voto, "Ud ya voto");
        sender.voto = true;
        sender.votos = _candidato;
        // If `proposal` is out of the range of the array,
        // this will throw automatically and revert all
        // changes.
        Candidato[_candidato].contadorVotos += sender.puedeVotar;
    }
    */

    // 4. La votación debe terminar después de un tiempo determinado
    function tiempoInicio() public pure returns (uint256){
         uint256 duracion = 60; //segundos

         return duracion;
    }



    
    // 5. Mostrar Ganador y mostrar la dirección del contrato inteligente.
    function candidatoGanador() public view returns (uint candidatoGanador_)
    {
        /*
        uint conteovotosGanadores = 0;
        for (uint p = 1; p < candidato[p].length; p++) {
            if (candidato[p].contadorVotos > conteovotosGanadores) {
                conteovotosGanadores = candidato[p].contadorVotos;
                candidatoGanador_ = p;
            }
        }*/
        
        uint conteovotosGanadores = 0;
        for (uint p = 0; p <= 3; p++) {
        if (candidato1.contadorVotos > candidato2.contadorVotos && candidato1.contadorVotos > candidato3.contadorVotos){
            conteovotosGanadores = candidato1.contadorVotos;
            candidatoGanador_ = 1;  
        }
        if (candidato2.contadorVotos > candidato1.contadorVotos && candidato2.contadorVotos > candidato3.contadorVotos){
            conteovotosGanadores = candidato2.contadorVotos;
            candidatoGanador_ = 2;
        }
        if (candidato3.contadorVotos > candidato1.contadorVotos && candidato3.contadorVotos > candidato2.contadorVotos){
            conteovotosGanadores = candidato3.contadorVotos;
            candidatoGanador_ = 3;
        }
    
        }

    }


    function nombreGanador() external view
            returns (string memory nombreGanador_)
    { 
       // nombreGanador_ = candidato[candidatoGanador()].nombre;
         
        if (candidatoGanador() == 1){
            nombreGanador_ = candidato1.nombre; 
        }
        if (candidatoGanador() == 2){
            nombreGanador_ = candidato2.nombre; 
        }
        if (candidatoGanador() == 3){
            nombreGanador_ = candidato3.nombre; 
        }

    } 

     function addressGanador() external view returns (address addressGanador_){ 
        
        if (candidatoGanador() == 1){
            addressGanador_ = candidato1.addressCandidato; 
        }
        if (candidatoGanador() == 2){
            addressGanador_ = candidato2.addressCandidato; 
        }
        if (candidatoGanador() == 3){
            addressGanador_ = candidato3.addressCandidato; 
        }

    } 

}