# Symulacja dynamiki tłumów przy pomocy NetLogo
### Ewakuacja budynku D-17 WI AGH

## Modele ewakuacji w NetLogo
- [Sala wykładowa](https://ccl.northwestern.edu/netlogo/models/community/Evacuation%20of%20a%20lecture%20hall)
    - bardzo uproszczony przykład, zasady postępowania opierają się na odgórnie zdefiniowanych wartościach koordynatów (odpowiadających np. dotarciu do ściany sali), po osiągnięciu których agenci zmieniają kierunek ruchu
- [Klasa](https://urbanspatialanalysis.com/netlogo-simulating-classroom-evacuation/)
    - również uproszczony przykład, agenci podejmują decyzje o ruchu bazując na odległości od wyjść i estymowanym czasie potrzebnym im na ewakuację
    - “What is the probability that an alternate route might get me out quicker even if I accrue more distance in the process?”
- [Pojedyncze kwadratowe pomieszczenie bez przeszkód](https://ieeexplore.ieee.org/document/6263226)
    - losowe rozmieszczenie homogenicznych agentów
    - agenci zawsze kierują się do najbliższego wyjścia, a w razie niemożliwości wykonania ruchu po prostu czekają na swoją kolej
    - tak proste zasady są wystarczające do zamodelowania typowych zachowań tłumów obserwowanych w rzeczywistości (blokowanie wyjść, ustawianie się “w łuki” przy wyjściach)
- [Budynek wielopiętrowy](https://iopscience.iop.org/article/10.1088/1757-899X/854/1/012060) 
    - użyto środowiska NetLogo3D do zamodelowania budynku z faktycznym rozmieszczeniem pięter i łączących je klatek schodowych w przestrzeni
    - agenci mogą zmienić kierunek, by podążyć za tłumem
- [The Float (Singapur scena)](https://github.com/shingkid/crowd-evacuation-simulation) 
    - tylko 1 poziom
    - agenci niehomogeniczni (szybkość poruszania zależna od płci, wieku, wagi, ograniczeń widoczności; prócz tego, parametry takie jak poziom paniki, zdrowie i siła)
    - 2 strategie: “smart” udająca się do najbliższego niezablokowanego wyjścia, “follow” podążająca za innym agentem
    - śmierć agentów od kontaktu z ogniem oraz nadmiernego nacisku
- [FEUP_PRODEI_SSASC_2019](https://github.com/hsouporto/FEUP_PRODEI_SSASC_2019)
    - Rozbudowanie poprzedniej symulacji, m.in. o dodatkowe strategie agentów

## Analiza budynku D17
- 4 piętra
- 2 oddzielne skrzydła budynku, po 2 klatki schodowe w każdym

### Analiza w kontekście ewakuacji
- wszystkie drogi ewakuacyjne z pięter prowadzą przez klatki schodowe. Liczby osób w poszczególnych z nich kształtują się następująco:

| piętro     | skrzydło turing |               | skrzydło shannon |               |
|------------|-----------------|---------------|------------------|---------------|
|            | klatka główna   | klatka boczna | klatka główna    | klatka boczna |
| I piętro   | 126             | 118           | 54               | 39            |
| II piętro  | 182             | 63            | 40               | 54            |
| III piętro | 141             | 52            | 39               | 54            |

- każda z klatek schodowych posiada bezpośrednie wyjście ewakuacyjne
    - przez wyjścia ewakuacyjne z klatek głównej skrzydła turing i bocznej skrzydła shannon ewakuuje się dodatkowo odpowiednio po 110 i 13 osób z sal na parterze
- pozostałe sale na parterze posiadają bezpośrednie wyjścia ewakuacyjne bądź są one zlokalizowane w bezpośredniej okolicy na korytarzu/w przyległej sali
- biorąc pod uwagę układ budynku, w ewakuacji kluczowe jest utrzymanie jak największej przepustowości na klatkach schodowych

### Analiza w kontekście symulacji w netlogo
- poszczególne piętra można zamodelować jako plansze 2D
- jedyne punkty styku między piętrami to klatki schodowe, jest ich cztery
- *jeśli założyć przebieg ewakuacji zgodny z wytycznymi z planu ewakuacji*, model pięter można sprowadzić do czterech segmentów, każdy związany stricte z wybraną klatką + pojedyncze grupy sal na parterze - **niestety takie założenie jest jednak dalekie od prawdopodobnego realnego przebiegu ewakuacji, stąd jest ono błędne**
- cały układ (w szczególności punkty wspólne między piętrami) można zamodelować na dwa sposoby:
    - **model 3D** - bardziej intuicyjne, potencjalne problemy z wydajnością czy niechcianymi interakcjami aktorów między piętrami
    - **model 2D** - mniej intuicyjne, konieczność korzystania z “teleportacji”, potencjalne problemy z wykrywaniem zagrożeń przez “portale teleportacji”
