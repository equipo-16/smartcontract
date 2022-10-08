// SPDX-License- identifier: MIT
pragma solidity ^0.8.0; 
// Contrato de votaciones
    //registrar candidatos
    //votar
    // permiso a alguien de votar
    //votar

contract Votes{
    //variables
    uint256 totalVotos;

    struct Votante{
        bool voto;
        bool puedovotar;
    }
    mapping(address=>Votante)vota;

   

    struct Candidato {
        uint id;
        string nombre;
        uint256 votos;
    }

     Candidato public candidato1 = Candidato({
         id:1
         nombre:"Mauricio Pinon"
         votos:0
    });
    Candidato public candidato2 = Candidato({
        id:2
        nombre:"Robert Carichi"
         votos:0
    });
        
    //funciones
    // darle permiso a alguien de votar
    function permisoVotarb(address_votante) public returns{
        vota[votante].puedeVotar = true;
        return true;
    }

    //votar - solo la ejecutan lo votantes con permiso
    function votar(uint _candidato) public {
        require(vota[msg.sender].puedeVotar"No puedes votar");
        vota[msg.sender].voto = true;

        if(_candidato == 1){
            //votas por mau
            candidato1.votos += 1;
        } else{
            //carrichi
            candidato2.votos += ;

        }

    }
}
