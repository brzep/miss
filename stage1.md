# Symulacja dynamiki tłumów przy pomocy NetLogo
### Ewakuacja budynku D-17 WI AGH
## Ewakuacja
Plany ewakuacji budynków są kluczowe dla planowania bezpieczeństwa publicznego. Ich rzetelne przygotowanie oraz testowanie znacząco zwiększają liczbę uratowanych osób. Warunki ewakuacji regulowane są aktami prawnymi takimi jak np. Ustawa o ochronie przeciwpożarowej, Rozporządzenie Ministra Spraw Wewnętrznych i Administracji w sprawie ochrony przeciwpożarowej budynków, innych obiektów budowlanych i terenów czy Rozporządzenie Ministra Infrastruktury w sprawie warunków technicznych, jakim powinny odpowiadać budynki i ich usytuowanie. Wytyczne te nie są jednak bardzo konkretne, co pozostawia pewne pole manewru w projektowaniu planów ewakuacji. Ważną jego częścią są symulacje pozwalające na przetestowanie proponowanych rozwiązań. Modelowanie zachowania tłumu jest zagadnieniem bardzo skomplikowanym. Składa się on bowiem z wielu jednostek, których indywidualne zachowanie warunkowane jest wieloma czynnikami, w tym także interakcjami z innymi jednostkami. Z tego powodu niemożliwym jest przewidzenie zachowania tłumu w sposób inny niż symulacja. Zaplanowanie efektywnie działającego systemu ewakuacji bazującego jedynie na “stałych” wytycznych, bez przeprowadzania symulacji, jest zatem niemożliwe.

## Modelowanie zachowań tłumów
- Systemy symulacji dynamiki tłumów wykorzystują dogłębnie zbadane i opisane procesy społeczne, które można zaobserwować w zachowaniu zgromadzeń ludzi:
- Social force model [SFM] (Helbing et al., 1995): pomiary wewnętrznych motywacji jednostek do podejmowania konkretnych decyzji
    - przyspieszenie do pożądanej prędkości
    - odległość od pozostałych jednostek i ścian
    - “efekty przyciągające” – grupowanie, podążanie za innymi
- Pola potencjalne (Mabrouk, 2011): analogia do zjawiska fizycznego, łącząca przy jego pomocy zachowanie jednostek z elementami środowiska, i na jego podstawie modelująca dalsze zachowanie
- Reciprocal Velocity Obstacles [RVO] (van den Berg et al., 2008): jednostki nie porozumiewają się ze sobą, ale reagują na czynności pozostałych jednostek (założenie: wszyscy z najbliższego otoczenia przeprowadzą podobne rozumowanie dot. omijania przeszkód)

W modelowaniu zachowań tłumów wyróżnić można następujące podejścia:
- przepływowe
    - EVACNET4 (Kisko et al., 1998): modelowanie środowiska fizycznego jako grafu (węzły – przestrzenie, pojemność ograniczona powierzchnią; krawędzie – przejścia, przepływy ograniczone czasem potrzebnym na przemieszczenie się)
- automaty komórkowe
    - EGRESS (AEA Technology, 2002): dyskretyzacja przestrzeni, skupienie się na zachowaniu jednostki kosztem zachowań i procesów społecznych
- **agentowe**
    - SIMULEX (Thompson et al., 1995): jednostki to racjonalni agenci analizujący optymalną trasę ucieczki i własne możliwości pokonania znajdującej się na niej przeszkód (w tym “wyprzedzenia” innych ewakuujących się); “zindywidualizowane” zachowania grup, tj. każda jednostka decyduje o własnej prędkości niezależnie od gęstości grupy w aktualnie zajmowanej przestrzeni
- oparte o czynności
    - EXODUS (Filippidis et al., 2003): “lista zadań”, np. wracanie się po bagaż, wykonywanie poleceń instrukcji bezpieczeństwa, szukanie dziecka, komunikacja z innymi uczestnikami ewakuacji (propagacja informacji o znajdowaniu trasy)
- hybrydowe (np. z dodatkiem uczenia maszynowego)
    - Yan et al., 2024: użycie DNN do symulowania zachowań i trajektorii grup jako wsparcie dla ulepszonego SFM

## Budynek
D-17 jest budynkiem Wydziału Informatyki AGH w Krakowie. Budynek został oddany do użytku w 2012 roku. Podzielony jest on na dwa skrzydła, w jednym z nich rezydują osoby pracujące na Wydziale, w drugim natomiast odbywają się zajęcia dydaktyczne. Budynek posiada cztery kondygnacje oraz parking podziemny. W skrzydle pracowniczym na parterze znajdują się dwie sale konferencyjne, mieszczące do 160 osób oraz pokoje pracownicze. Na wyższych piętrach miejsce mają mniejsze sale konferencyjne, pokoje pracownicze oraz socjalne. W drugim ze skrzydeł wyróżnić można bufet, dwie sale wykładowe, kolejno na 253 i 157 osób, sale zajęciowe oraz inne pokoje, o pojemności do 40 osób.
Do D-17 dostać można się przez dwa wejścia główne usytuowane w łączniku między skrzydłami. Budynek wyposażony jest w 12 wyjść ewakuacyjnych. Teren dookoła budynku jest ogrodzony, posiada dwie otwarte oraz jedną zamkniętą bramę. Miejsce zbiórki po ewakuacji znajduje się na pobliskim skwerze.
W budynku w każdym dniu roboczym przebywają osoby pracujące oraz studiujące, łącznie ok.  osób. Liczba ta znacząco zwiększa się, gdy odbywają się w nim wydarzenia takie jak np. konferencje czy targi. Osoby zebrane są wtedy zazwyczaj na parterze, w obydwu skrzydłach.

### Istniejące projekty symulacji
#### [shingkid/crowd-evacuation-simulation](https://github.com/shingkid/crowd-evacuation-simulation)
- School of Information Systems, Singapore Management University
- ewakuacja trybuny największej położonej na wodzie sceny na świecie oraz największego w Singapurze stadionu
- dobrze opisane założenia:
    -   30 tys. osób
        - uwzględniono:
        - strukturę wiekową i płciową mieszkańców Singapuru
        - szybkość poruszania się osób
        - wizję
        - poziom paniki (zależny od obecności ognia w polu widzenia)
        - masę osób
- strategie
    - “smart” - agenci są świadomi gdzie znajdują się wyjścia ewakuacyjne, jeśli są zablokowane, poszukują kolejnych najbliższe
    - “follow” - agenci śledzą dokładnie jednego innego agenta, w odległości jednostkowej, jeśli widzą ogień uciekają w przeciwną stronę, jeśli widzą wyjście, idą bezpośrednio do niego
- śmierć agenta
- agent umiera w kontakcie z ogniem bądź od nacisku (obliczanego na podstawie masy i szybkości innych agentów) przekraczającego poziom (uzależniony od parametrów agenta)

#### [hsouporto/FEUP_PRODEI_SSASC_2019](https://github.com/hsouporto/FEUP_PRODEI_SSASC_2019) 
- opiera się na powyższym i rozbudowuje go o kolejne parametry takie jak np.
    - szybkość rozchodzenia się ognia
    - liczbę źródeł ognia
    - dodatkowe strategie



### Bibliografia
- https://journals.aps.org/pre/abstract/10.1103/PhysRevE.51.4282
- https://gamma.cs.unc.edu/RVO/  	
- https://www.mdpi.com/2071-1050/13/18/10277
- https://www.sciencedirect.com/science/article/pii/S2095263515000710
- https://www.mdpi.com/2079-9292/13/5/934
- https://udspace.udel.edu/items/ef332e58-0898-44eb-8817-712b919536df 
