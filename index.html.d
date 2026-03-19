<!doctype html>
<html lang="pt" class="h-full">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Awards Futebol | Pinto Basto</title>
    <script src="https://cdn.tailwindcss.com/3.4.17"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        * { font-family: 'Plus Jakarta Sans', sans-serif; }
        body { background-color: #050a18; color: #e2e8f0; }
        .gradient-bg { background: radial-gradient(circle at top right, #1e3a8a, #050a18); }
        .premium-card { background: rgba(15, 23, 42, 0.6); backdrop-filter: blur(12px); border: 1px solid rgba(255,255,255,0.05); }
        .btn-primary { background: linear-gradient(135deg, #2563eb, #1d4ed8); transition: all 0.3s ease; }
        .btn-primary:hover:not(:disabled) { transform: translateY(-2px); box-shadow: 0 10px 20px -5px rgba(37, 99, 235, 0.4); }
        .rating-btn.active { background-color: #2563eb; color: white; border-color: #3b82f6; box-shadow: 0 0 15px rgba(37, 99, 235, 0.5); }
        .podium-1 { border: 4px solid #fbbf24; box-shadow: 0 0 40px rgba(251, 191, 36, 0.2); }
        .modal-backdrop { background-color: rgba(2, 6, 23, 0.95); backdrop-filter: blur(8px); }
        ::-webkit-scrollbar { width: 6px; }
        ::-webkit-scrollbar-thumb { background: #1e293b; border-radius: 10px; }
    </style>
</head>
<body class="h-full overflow-auto gradient-bg">

    <!-- ECRÃ DE CARREGAMENTO -->
    <div id="loading-screen" class="fixed inset-0 z-[100] bg-[#050a18] flex flex-col items-center justify-center transition-opacity duration-500">
        <div class="text-center animate-pulse">
            <h2 class="text-white text-2xl font-black tracking-widest uppercase italic">AWARDS FUTEBOL</h2>
            <p class="text-blue-500 text-[10px] font-bold mt-2 tracking-[0.5em]">LIGANDO À NUVEM...</p>
        </div>
    </div>

    <div id="app" class="min-h-full w-full hidden">
        
        <!-- LOGIN -->
        <div id="login-screen" class="min-h-full flex items-center justify-center p-4">
            <div class="max-w-md w-full bg-[#0f172a] rounded-[3rem] shadow-2xl border border-white/5 p-10 text-center">
                <div class="mb-10">
                    <h1 class="text-3xl font-extrabold text-white italic tracking-tighter">Pinto Basto</h1>
                    <p class="text-blue-400 font-bold tracking-[0.3em] uppercase text-[10px] mt-2">Awards Futebol</p>
                </div>
                
                <div class="space-y-6">
                    <div class="text-left">
                        <label class="block text-[10px] font-black uppercase tracking-widest text-slate-500 mb-2 ml-1 italic">Acesso Atleta</label>
                        <select id="player-select" class="w-full px-6 py-4 bg-[#1e293b] border border-white/5 rounded-2xl text-white outline-none mb-4 cursor-pointer">
                            <option value="">Carregando atletas...</option>
                        </select>
                        <button onclick="loginAsPlayer()" class="w-full btn-primary text-white font-black py-4 rounded-2xl shadow-lg uppercase tracking-wider italic">Entrar no Balneário</button>
                    </div>

                    <button onclick="viewAsGuest()" class="w-full bg-white/5 hover:bg-white/10 text-white font-bold py-4 rounded-2xl border border-white/10 text-[10px] uppercase tracking-widest">📊 Ver Ranking Geral</button>

                    <div class="relative py-4">
                        <div class="absolute inset-0 flex items-center"><div class="w-full border-t border-white/5"></div></div>
                        <div class="relative flex justify-center text-[9px] uppercase font-black text-slate-600"><span class="px-4 bg-[#0f172a]">Área Técnica</span></div>
                    </div>

                    <input id="admin-password" type="password" placeholder="Chave Mestra" class="w-full px-6 py-4 bg-[#1e293b] border border-white/5 rounded-2xl outline-none text-white text-sm">
                    <button onclick="loginAsAdmin()" class="w-full bg-white/5 text-slate-400 py-3 rounded-xl text-[9px] uppercase tracking-widest">Acesso Direção</button>
                </div>
            </div>
        </div>

        <!-- APP PRINCIPAL -->
        <div id="main-app" class="hidden min-h-full flex flex-col">
            <header class="bg-[#050a18]/80 backdrop-blur-xl border-b border-white/5 sticky top-0 z-40 px-6 py-4 flex justify-between items-center">
                <div class="flex items-center gap-3">
                    <div class="w-8 h-8 bg-blue-600 rounded-lg flex items-center justify-center font-black italic text-xs">PB</div>
                    <h1 class="text-xs font-black uppercase italic tracking-widest">Awards <span class="text-blue-500">Futebol</span></h1>
                </div>
                <button onclick="logout()" class="text-[9px] font-black uppercase bg-red-500/10 text-red-500 px-4 py-2 rounded-lg border border-red-500/20">Sair</button>
            </header>

            <main class="flex-1 max-w-7xl w-full mx-auto px-4 py-8">
                <!-- RANKING -->
                <section id="ranking-section" class="mb-12">
                    <div id="podium-container" class="flex flex-col md:flex-row justify-center items-end gap-8 py-10"></div>
                    <div class="bg-[#0f172a] rounded-[2rem] border border-white/5 overflow-hidden">
                        <table class="w-full text-left">
                            <thead class="text-[10px] font-black text-slate-500 uppercase border-b border-white/5">
                                <tr>
                                    <th class="px-6 py-4">Pos</th>
                                    <th class="px-6 py-4">Atleta</th>
                                    <th class="px-6 py-4 text-right italic">Total PTS</th>
                                </tr>
                            </thead>
                            <tbody id="ranking-table-body" class="divide-y divide-white/5 italic"></tbody>
                        </table>
                    </div>
                </section>

                <!-- ADMIN -->
                <section id="admin-dashboard" class="hidden space-y-8">
                    <div class="grid grid-cols-2 gap-4">
                        <button onclick="openPlayerModal()" class="bg-blue-600 p-6 rounded-3xl font-black uppercase text-[10px] tracking-widest italic text-white">Novo Jogador</button>
                        <button onclick="openGameModal()" class="bg-green-600 p-6 rounded-3xl font-black uppercase text-[10px] tracking-widest italic text-white">Criar Jogo</button>
                    </div>
                    <div id="admin-lists" class="grid md:grid-cols-2 gap-6">
                        <div class="bg-[#0f172a] rounded-3xl p-6 border border-white/5">
                            <h3 class="text-[10px] font-black uppercase text-slate-500 mb-4">Plantel</h3>
                            <div id="players-list" class="space-y-2"></div>
                        </div>
                        <div class="bg-[#0f172a] rounded-3xl p-6 border border-white/5">
                            <h3 class="text-[10px] font-black uppercase text-slate-500 mb-4">Histórico de Jogos</h3>
                            <div id="games-list" class="space-y-2"></div>
                        </div>
                    </div>
                </section>

                <!-- JOGADOR -->
                <section id="player-dashboard" class="hidden space-y-6">
                    <div id="player-welcome" class="bg-blue-600/10 p-8 rounded-[2.5rem] border border-blue-500/20 text-center">
                        <h2 class="text-2xl font-black italic">Olá, <span id="welcome-name" class="text-blue-500">Atleta</span>!</h2>
                        <p class="text-[10px] font-bold uppercase tracking-widest text-slate-400 mt-2">Vota nos teus colegas abaixo</p>
                    </div>
                    <div id="voting-list" class="grid gap-4"></div>
                </section>
            </main>
        </div>
    </div>

    <!-- MODALS -->
    <div id="player-modal" class="hidden fixed inset-0 modal-backdrop flex items-center justify-center p-4 z-50">
        <div class="bg-[#0f172a] rounded-[2.5rem] w-full max-w-md p-8 border border-white/10 space-y-4">
            <h3 class="font-black text-white text-center uppercase italic">Perfil do Atleta</h3>
            <input id="new-player-name" type="text" placeholder="Nome Completo" class="w-full px-6 py-4 bg-[#1e293b] border border-white/5 rounded-xl text-white outline-none">
            <select id="new-player-pos" class="w-full px-6 py-4 bg-[#1e293b] border border-white/5 rounded-xl text-white outline-none">
                <option value="Guarda-redes">Guarda-redes</option>
                <option value="Defesa">Defesa</option>
                <option value="Médio">Médio</option>
                <option value="Avançado">Avançado</option>
            </select>
            <div class="flex gap-2">
                <button onclick="closeModal('player-modal')" class="flex-1 py-4 bg-white/5 text-slate-500 font-bold rounded-xl uppercase text-[10px]">Cancelar</button>
                <button onclick="savePlayer()" class="flex-1 py-4 bg-blue-600 text-white font-black rounded-xl uppercase text-[10px] italic">Gravar</button>
            </div>
        </div>
    </div>

    <div id="game-modal" class="hidden fixed inset-0 modal-backdrop flex items-center justify-center p-4 z-50">
        <div class="bg-[#0f172a] rounded-[2.5rem] w-full max-w-lg p-8 border border-white/10 space-y-6">
            <h3 class="font-black text-white text-center uppercase italic">Novo Jogo</h3>
            <input id="game-title" type="text" placeholder="Ex: Jornada 1" class="w-full px-6 py-4 bg-[#1e293b] border border-white/5 rounded-xl text-white outline-none">
            <input id="game-date" type="date" class="w-full px-6 py-4 bg-[#1e293b] border border-white/5 rounded-xl text-white outline-none">
            <div id="call-up-selection" class="max-h-48 overflow-y-auto grid grid-cols-2 gap-2 p-2 bg-black/20 rounded-xl"></div>
            <button onclick="saveGame()" class="w-full py-4 bg-green-600 text-white font-black rounded-xl uppercase text-[10px] italic">Publicar Evento</button>
        </div>
    </div>

    <div id="voting-modal" class="hidden fixed inset-0 modal-backdrop flex items-center justify-center p-4 z-50">
        <div class="bg-[#0f172a] rounded-[2.5rem] w-full max-w-2xl max-h-[90%] flex flex-col border border-white/10 overflow-hidden">
            <div class="p-6 border-b border-white/5 flex justify-between items-center bg-blue-600/5">
                <h3 class="font-black text-white uppercase italic">Boletim de Voto</h3>
                <button onclick="closeModal('voting-modal')" class="bg-blue-600 px-6 py-2 rounded-lg text-white font-black text-[9px] uppercase italic">Concluir</button>
            </div>
            <div id="voting-content" class="p-6 overflow-y-auto space-y-8"></div>
        </div>
    </div>

    <script type="module">
        import { initializeApp } from "https://www.gstatic.com/firebasejs/11.6.1/firebase-app.js";
        import { getAuth, signInAnonymously, onAuthStateChanged, signInWithCustomToken } from "https://www.gstatic.com/firebasejs/11.6.1/firebase-auth.js";
        import { getFirestore, doc, setDoc, getDoc, collection, onSnapshot, addDoc, updateDoc, deleteDoc } from "https://www.gstatic.com/firebasejs/11.6.1/firebase-firestore.js";

        // CONFIGURAÇÕES (Injetadas pelo ambiente)
        const firebaseConfig = JSON.parse(__firebase_config);
        const app = initializeApp(firebaseConfig);
        const auth = getAuth(app);
        const db = getFirestore(app);
        const appId = typeof __app_id !== 'undefined' ? __app_id : 'pinto-basto-v1';

        // ESTADO
        let players = [];
        let games = [];
        let votes = [];
        let currentUser = null;
        const ADMIN_PASS = "admin123";

        // CATEGORIAS
        const CATS = [
            { id: 'perf', name: 'Melhor Desempenho', icon: '⭐' },
            { id: 'def', name: 'Muralha Defensiva', icon: '🛡️' },
            { id: 'gol', name: 'Instinto Goleador', icon: '⚔️' },
            { id: 'bat', name: 'Batoteiro', icon: '⚠️', neg: true }
        ];

        async function init() {
            try {
                if (typeof __initial_auth_token !== 'undefined' && __initial_auth_token) {
                    await signInWithCustomToken(auth, __initial_auth_token);
                } else {
                    await signInAnonymously(auth);
                }
            } catch (e) { console.error("Erro Auth", e); }

            onAuthStateChanged(auth, (user) => {
                if (user) setupListeners();
            });
        }

        function setupListeners() {
            // Ouvir Jogadores
            onSnapshot(collection(db, 'artifacts', appId, 'public', 'data', 'players'), (snap) => {
                players = snap.docs.map(d => ({ id: d.id, ...d.data() }));
                refreshUI();
                document.getElementById('loading-screen').classList.add('opacity-0');
                setTimeout(() => {
                    document.getElementById('loading-screen').style.display = 'none';
                    document.getElementById('app').classList.remove('hidden');
                }, 500);
            });

            // Ouvir Jogos
            onSnapshot(collection(db, 'artifacts', appId, 'public', 'data', 'games'), (snap) => {
                games = snap.docs.map(d => ({ id: d.id, ...d.data() }));
                refreshUI();
            });

            // Ouvir Votos
            onSnapshot(collection(db, 'artifacts', appId, 'public', 'data', 'votes'), (snap) => {
                votes = snap.docs.map(d => ({ id: d.id, ...d.data() }));
                refreshUI();
            });
        }

        function refreshUI() {
            renderLoginSelect();
            if (currentUser === 'admin') renderAdmin();
            if (currentUser && currentUser !== 'admin' && currentUser !== 'guest') renderPlayer();
            renderRanking();
        }

        // --- LÓGICA DE LOGIN ---
        window.loginAsPlayer = () => {
            const id = document.getElementById('player-select').value;
            if(!id) return;
            currentUser = players.find(p => p.id === id);
            document.getElementById('login-screen').classList.add('hidden');
            document.getElementById('main-app').classList.remove('hidden');
            document.getElementById('player-dashboard').classList.remove('hidden');
            document.getElementById('welcome-name').textContent = currentUser.name.split(' ')[0];
            refreshUI();
        };

        window.loginAsAdmin = () => {
            if(document.getElementById('admin-password').value === ADMIN_PASS) {
                currentUser = 'admin';
                document.getElementById('login-screen').classList.add('hidden');
                document.getElementById('main-app').classList.remove('hidden');
                document.getElementById('admin-dashboard').classList.remove('hidden');
                refreshUI();
            } else { alert("Pass errada"); }
        };

        window.viewAsGuest = () => {
            currentUser = 'guest';
            document.getElementById('login-screen').classList.add('hidden');
            document.getElementById('main-app').classList.remove('hidden');
            refreshUI();
        };

        window.logout = () => { location.reload(); };

        // --- RENDERS ---
        function renderLoginSelect() {
            const s = document.getElementById('player-select');
            const val = s.value;
            s.innerHTML = '<option value="">Seleciona o teu nome...</option>';
            players.forEach(p => s.innerHTML += `<option value="${p.id}">${p.name}</option>`);
            s.value = val;
        }

        function renderAdmin() {
            const pList = document.getElementById('players-list');
            pList.innerHTML = players.map(p => `
                <div class="flex justify-between items-center bg-white/5 p-3 rounded-xl border border-white/5">
                    <span class="text-xs font-bold">${p.name}</span>
                    <button onclick="window.deletePlayer('${p.id}')" class="text-red-500 text-[10px] font-black">X</button>
                </div>
            `).join('');

            const gList = document.getElementById('games-list');
            gList.innerHTML = games.map(g => `
                <div class="flex justify-between items-center bg-white/5 p-3 rounded-xl border border-white/5">
                    <div>
                        <p class="text-xs font-bold uppercase">${g.title}</p>
                        <p class="text-[8px] text-slate-500">${g.date}</p>
                    </div>
                    <button onclick="window.deleteGame('${g.id}')" class="text-red-500 text-[10px] font-black">X</button>
                </div>
            `).join('');
        }

        function renderPlayer() {
            const list = document.getElementById('voting-list');
            const myGames = games.filter(g => g.playerIds.includes(currentUser.id));
            
            if(myGames.length === 0) {
                list.innerHTML = '<p class="text-center text-slate-500 text-[10px] uppercase py-10">Nenhum jogo convocado.</p>';
                return;
            }

            list.innerHTML = myGames.map(g => {
                const totalVotos = votes.filter(v => v.gameId === g.id && v.voterId === currentUser.id).length;
                const totalNecessario = (g.playerIds.length - 1) * CATS.length;
                const concluido = totalVotos >= totalNecessario && totalNecessario > 0;

                return `
                    <div class="bg-[#0f172a] p-6 rounded-[2rem] border border-white/5 flex justify-between items-center">
                        <div>
                            <h4 class="font-black text-white italic uppercase text-sm">${g.title}</h4>
                            <p class="text-[9px] text-slate-500 uppercase font-bold">${g.date}</p>
                        </div>
                        ${concluido ? 
                            '<span class="text-green-500 text-[9px] font-black uppercase">✓ Votado</span>' : 
                            `<button onclick="window.openVoting('${g.id}')" class="bg-blue-600 px-6 py-3 rounded-xl text-white font-black text-[9px] uppercase italic">Votar</button>`
                        }
                    </div>
                `;
            }).join('');
        }

        function renderRanking() {
            const stats = players.map(p => {
                const pVotes = votes.filter(v => v.targetId === p.id);
                const pos = pVotes.filter(v => !CATS.find(c => c.id === v.category).neg).reduce((a,b) => a + b.score, 0);
                const neg = pVotes.filter(v => CATS.find(c => c.id === v.category).neg).reduce((a,b) => a + b.score, 0);
                return { ...p, total: pos - neg };
            }).sort((a,b) => b.total - a.total);

            document.getElementById('ranking-table-body').innerHTML = stats.map((p, i) => `
                <tr>
                    <td class="px-6 py-4"><span class="w-6 h-6 rounded bg-white/5 flex items-center justify-center text-[10px]">${i+1}</span></td>
                    <td class="px-6 py-4 font-bold text-sm">${p.name}</td>
                    <td class="px-6 py-4 text-right font-black text-blue-500">${p.total}</td>
                </tr>
            `).join('');

            // Podium
            const pod = document.getElementById('podium-container');
            if(stats.length > 0) {
                const top = stats.slice(0, 3);
                pod.innerHTML = top.map((p, i) => `
                    <div class="flex flex-col items-center gap-2 ${i === 0 ? 'order-2 scale-110 mb-6' : (i === 1 ? 'order-1' : 'order-3')}">
                        <div class="w-20 h-20 rounded-3xl bg-[#0f172a] border-2 ${i === 0 ? 'border-yellow-500 shadow-xl' : 'border-white/10'} flex items-center justify-center text-2xl">
                            ${i === 0 ? '🥇' : (i === 1 ? '🥈' : '🥉')}
                        </div>
                        <p class="text-[10px] font-black uppercase">${p.name.split(' ')[0]}</p>
                        <p class="text-[9px] font-black text-blue-500">${p.total} PTS</p>
                    </div>
                `).join('');
            }
        }

        // --- ACÇÕES CLOUD ---
        window.savePlayer = async () => {
            const name = document.getElementById('new-player-name').value;
            const pos = document.getElementById('new-player-pos').value;
            if(!name) return;
            await addDoc(collection(db, 'artifacts', appId, 'public', 'data', 'players'), { name, position: pos });
            closeModal('player-modal');
        };

        window.deletePlayer = async (id) => {
            if(confirm("Apagar?")) await deleteDoc(doc(db, 'artifacts', appId, 'public', 'data', 'players', id));
        };

        window.saveGame = async () => {
            const title = document.getElementById('game-title').value;
            const date = document.getElementById('game-date').value;
            const pIds = Array.from(document.querySelectorAll('.p-check:checked')).map(i => i.value);
            if(!title || pIds.length === 0) return;
            await addDoc(collection(db, 'artifacts', appId, 'public', 'data', 'games'), { title, date, playerIds: pIds });
            closeModal('game-modal');
        };

        window.deleteGame = async (id) => {
            if(confirm("Apagar?")) await deleteDoc(doc(db, 'artifacts', appId, 'public', 'data', 'games', id));
        };

        window.openVoting = (gameId) => {
            const game = games.find(g => g.id === gameId);
            const others = players.filter(p => p.id !== currentUser.id && game.playerIds.includes(p.id));
            const cont = document.getElementById('voting-content');
            
            cont.innerHTML = others.map(p => `
                <div class="bg-white/5 p-6 rounded-3xl space-y-4">
                    <p class="font-black uppercase text-xs text-blue-500">${p.name}</p>
                    <div class="space-y-6">
                        ${CATS.map(cat => {
                            const v = votes.find(x => x.gameId === gameId && x.voterId === currentUser.id && x.targetId === p.id && x.category === cat.id);
                            const score = v ? v.score : -1;
                            return `
                                <div>
                                    <p class="text-[9px] font-bold uppercase text-slate-500 mb-2">${cat.icon} ${cat.name}</p>
                                    <div class="flex gap-1">
                                        ${[0,1,2,3,4,5].map(n => `
                                            <button onclick="window.submitVote('${gameId}', '${p.id}', '${cat.id}', ${n}, this)" 
                                                class="rating-btn w-8 h-8 rounded-lg text-[10px] font-bold border border-white/10 ${score === n ? 'active' : 'bg-black/20'}">
                                                ${n}
                                            </button>
                                        `).join('')}
                                    </div>
                                </div>
                            `;
                        }).join('')}
                    </div>
                </div>
            `).join('');
            openModal('voting-modal');
        };

        window.submitVote = async (gId, tId, catId, score, btn) => {
            const existing = votes.find(v => v.gameId === gId && v.voterId === currentUser.id && v.targetId === tId && v.category === catId);
            if(existing) {
                await updateDoc(doc(db, 'artifacts', appId, 'public', 'data', 'votes', existing.id), { score });
            } else {
                await addDoc(collection(db, 'artifacts', appId, 'public', 'data', 'votes'), {
                    gameId: gId, voterId: currentUser.id, targetId: tId, category: catId, score: score
                });
            }
            btn.parentElement.querySelectorAll('button').forEach(b => b.classList.remove('active'));
            btn.classList.add('active');
        };

        // --- UTILS ---
        window.openPlayerModal = () => openModal('player-modal');
        window.openGameModal = () => {
            document.getElementById('call-up-selection').innerHTML = players.map(p => `
                <label class="flex items-center gap-2 p-2 text-[10px] font-bold uppercase">
                    <input type="checkbox" value="${p.id}" class="p-check"> ${p.name.split(' ')[0]}
                </label>
            `).join('');
            openModal('game-modal');
        };
        window.openModal = (id) => document.getElementById(id).classList.remove('hidden');
        window.closeModal = (id) => document.getElementById(id).classList.add('hidden');

        init();
    </script>
</body>
</html>
