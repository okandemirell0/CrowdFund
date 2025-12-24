// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract CrowdFund {
    // 1. GÖREV: Event Tanımlama
    // Frontend (Web sitesi) bu olayı dinleyecek
    event YeniBagis(address indexed bagisci, string isim, uint256 miktar);

    struct Bagiscilar {
        address cuzdanAdresi;
        string isim;
        uint256 miktar;
    }
    Bagiscilar[] public bagisciListesi;

    address public owner;
    uint256 public hedefMiktar;
    uint256 public KilitAcilmaSuresi;
    uint256 public toplamToplanan;
    mapping(address => uint256) public bagislar;

    constructor(uint256 _hedef, uint256 _sureSaniye) {
        owner = msg.sender;
        hedefMiktar = _hedef;
        KilitAcilmaSuresi = block.timestamp + _sureSaniye;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Yetki yok");
        _;
    }
    function deposit(string memory _isim) public payable {
        require(block.timestamp < KilitAcilmaSuresi, "Sure bitti.");
        require(msg.value > 0, "Bagis 0 olamaz.");

        bagislar[msg.sender] += msg.value;
        toplamToplanan += msg.value;
        bagisciListesi.push(Bagiscilar(msg.sender, _isim, msg.value));

        
        emit YeniBagis(msg.sender, _isim, msg.value);
    }

    function withdraw() public onlyOwner {
        require(toplamToplanan >= hedefMiktar, "Hedefe daha var.");
        require(block.timestamp >= KilitAcilmaSuresi, "Sure dolmadi.");
        payable(owner).transfer(address(this).balance);
    }

    function refund() public {
        require(block.timestamp >= KilitAcilmaSuresi, "Sure henuz dolmadi.");
        require(toplamToplanan < hedefMiktar, "Hedef basarildi, iade yok.");
        
        uint256 miktar = bagislar[msg.sender];
        require(miktar > 0, "Iade alacak paraniz yok.");

        bagislar[msg.sender] = 0;
        payable(msg.sender).transfer(miktar);
    }
}
