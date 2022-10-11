// SPDX-License-Identifier: MIT 

pragma solidity ^0.8.0; 

//import "@openzeppelin/contracts/access/Ownable.sol"; 
//import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/contracts/security/Pausable.sol";

contract projectVotos {


    uint totalVotos = 0;
    uint256 tiempoVoto; // tiempo para votar
    //string _votoBueno = "Se Voto!";
   // string _votoMalo = "No Voto!";

    address public duenoContrato; // dueno del contrato
   // bytes32 constant RolVotante = keccak256("RolVotante");

   constructor() public {
        //_setupRole(RolVotante, msg.sender);
        duenoContrato = msg.sender;
    }

    // Variables del Votante.
    struct Votante{
        bool voto; // si es verdadero, la persona ya voto
        bool puedeVotar; // derecho al voto
        string nombre; // nombre del votante
    }
    mapping (address => Votante) listaVotantes;

    // Variables del Candidato.
    struct Candidato{
        //address direccion;
        string nombre; // nombre del candidato
        string proyecto; // nombre del proyecto
        uint256 contadorVotos; // votos acumulados
    }

    // Una matriz dinámica de estructuras de datos de tipo `Candidatos`
    mapping (address => Candidato) listaCandidatos;
    address[] addressCandidato;

    

    // 1. registro de Votantes con sus datos de identificación (nombre y address)
    function AddVotante(string memory nombre, address direccionVotante) public {
        listaVotantes[direccionVotante].puedeVotar = true;
        listaVotantes[direccionVotante].voto = false;
        listaVotantes[direccionVotante].nombre = nombre;
    }

    // registro de Candidatos/Proyectos con sus datos de identificación (nombre, proyecto y address)
    function AddCandidato(string memory nombre,string memory proyecto, address direccionCandidato) public{
        duenoContrato = msg.sender;
        listaCandidatos[direccionCandidato].nombre = nombre;
        listaCandidatos[direccionCandidato].proyecto = proyecto;
        addressCandidato.push(direccionCandidato);
    }

    // 2. derecho al voto a los votantes por el dueño del contrato


    function permisoVotar(address _votante) public returns(bool) {
        listaVotantes[_votante].puedeVotar = true;
        return true;
    }

    /*function normalCosa() public {
        // cosa todos puede probar
    }

    function duenoChecar() public onlyOwner {
        // solamente para dueno
    }*/

    // 3. Votos de votantes solo 1 vez por votante

    function votar (address candidatoDireccion) public {
        require(listaVotantes[msg.sender].puedeVotar, "No puedes votar");
        require(!listaVotantes[msg.sender].voto, "Ya votaste, no puedes votar nuevamente");
        listaVotantes[msg.sender].voto = true;
        listaCandidatos[candidatoDireccion].contadorVotos = listaCandidatos[candidatoDireccion].contadorVotos +1;
        totalVotos = totalVotos + 1;
    }

    // 4. La votación debe terminar después de un tiempo determinado

    

    // 5. Totalizar Votos y mostrar Candidato/Poryecto Ganador y la dirección del contrato inteligente.

    function candidatoGanador() public view returns (address candidatoGanador_){
        uint conteovotosGanadores = 0;
        for (uint p = 0; p < addressCandidato.length; p++) {
            if (listaCandidatos[addressCandidato[p]].contadorVotos > conteovotosGanadores) {
                conteovotosGanadores = listaCandidatos[addressCandidato[p]].contadorVotos;
                candidatoGanador_ = addressCandidato[p];
            }
        }

        return candidatoGanador_;
    }

    function nombreGanador() public view returns (string memory nombreGanador_) {
        nombreGanador_ = listaCandidatos[candidatoGanador()].nombre;
    }
} 
