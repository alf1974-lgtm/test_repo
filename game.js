/**
 * Tic Tac Toe — two players, one browser
 * Player X always goes first; players alternate after each move.
 */

'use strict';

// ── Winning combinations (indices into the 9-cell board) ──────────────────
const WIN_COMBOS = [
  [0, 1, 2], // top row
  [3, 4, 5], // middle row
  [6, 7, 8], // bottom row
  [0, 3, 6], // left col
  [1, 4, 7], // middle col
  [2, 5, 8], // right col
  [0, 4, 8], // diagonal ↘
  [2, 4, 6], // diagonal ↙
];

// ── DOM references ─────────────────────────────────────────────────────────
const cells         = Array.from(document.querySelectorAll('.cell'));
const statusBanner  = document.getElementById('status-banner');
const currentPlayer = document.getElementById('current-player');
const winsXEl       = document.getElementById('wins-x');
const winsOEl       = document.getElementById('wins-o');
const drawsEl       = document.getElementById('draws');
const restartBtn    = document.getElementById('restart-btn');
const resetScoreBtn = document.getElementById('reset-score-btn');
const overlay       = document.getElementById('overlay');
const overlayIcon   = document.getElementById('overlay-icon');
const overlayMsg    = document.getElementById('overlay-message');
const overlayBtn    = document.getElementById('overlay-btn');

// ── Game state ─────────────────────────────────────────────────────────────
let board        = Array(9).fill(null); // null | 'X' | 'O'
let activePlayer = 'X';                 // whose turn it is
let gameOver     = false;

const score = { X: 0, O: 0, draws: 0 };

// ── Core logic ─────────────────────────────────────────────────────────────

/** Check whether `player` has won. Returns the winning combo or null. */
function checkWin(player) {
  return WIN_COMBOS.find(combo =>
    combo.every(idx => board[idx] === player)
  ) ?? null;
}

/** Returns true when all cells are filled. */
function isBoardFull() {
  return board.every(cell => cell !== null);
}

/** Handle a cell click. */
function handleCellClick(event) {
  const cell  = event.currentTarget;
  const index = Number(cell.dataset.index);

  // Ignore clicks on filled cells or after game ends
  if (board[index] !== null || gameOver) return;

  // Place the mark
  board[index] = activePlayer;
  cell.textContent   = activePlayer;
  cell.dataset.mark  = activePlayer;
  cell.disabled      = true;

  // Check result
  const winCombo = checkWin(activePlayer);

  if (winCombo) {
    // ── Win ──────────────────────────────────────────────────────────────
    gameOver = true;
    score[activePlayer]++;
    updateScoreboard();

    // Highlight winning cells
    winCombo.forEach(idx => cells[idx].classList.add('winning'));

    // Update banner
    statusBanner.textContent = `Player ${activePlayer} wins! 🎉`;
    statusBanner.className   = 'status-banner winner';

    // Show overlay after a short delay so the winning animation is visible
    setTimeout(() => showOverlay('win', activePlayer), 600);

  } else if (isBoardFull()) {
    // ── Draw ─────────────────────────────────────────────────────────────
    gameOver = true;
    score.draws++;
    updateScoreboard();

    statusBanner.textContent = "It's a draw! 🤝";
    statusBanner.className   = 'status-banner draw';

    setTimeout(() => showOverlay('draw', null), 600);

  } else {
    // ── Next turn ─────────────────────────────────────────────────────────
    activePlayer = activePlayer === 'X' ? 'O' : 'X';
    updateStatusBanner();
  }
}

/** Reset the board for a new game (scores are preserved). */
function newGame() {
  board        = Array(9).fill(null);
  activePlayer = 'X';
  gameOver     = false;

  cells.forEach(cell => {
    cell.textContent  = '';
    cell.disabled     = false;
    cell.removeAttribute('data-mark');
    cell.classList.remove('winning');
  });

  updateStatusBanner();
  hideOverlay();
}

/** Reset scores and start a new game. */
function resetScores() {
  score.X = 0;
  score.O = 0;
  score.draws = 0;
  updateScoreboard();
  newGame();
}

// ── UI helpers ─────────────────────────────────────────────────────────────

function updateStatusBanner() {
  currentPlayer.textContent = activePlayer;
  statusBanner.className    = `status-banner ${activePlayer === 'X' ? 'x-turn' : 'o-turn'}`;
  // Rebuild the full text so the <span> stays inside
  statusBanner.innerHTML    =
    `Player <span id="current-player">${activePlayer}</span>'s turn`;
}

function updateScoreboard() {
  winsXEl.textContent = score.X;
  winsOEl.textContent = score.O;
  drawsEl.textContent = score.draws;
}

function showOverlay(type, player) {
  overlay.classList.remove('hidden');

  if (type === 'win') {
    const isX = player === 'X';
    overlayIcon.textContent = isX ? '❌' : '⭕';
    overlayMsg.textContent  = `Player ${player} wins!`;
    overlayMsg.style.color  = isX ? '#e94560' : '#4fc3f7';
  } else {
    overlayIcon.textContent = '🤝';
    overlayMsg.textContent  = "It's a draw!";
    overlayMsg.style.color  = '#ffd740';
  }
}

function hideOverlay() {
  overlay.classList.add('hidden');
}

// ── Event listeners ────────────────────────────────────────────────────────

cells.forEach(cell => cell.addEventListener('click', handleCellClick));
restartBtn.addEventListener('click', newGame);
resetScoreBtn.addEventListener('click', resetScores);
overlayBtn.addEventListener('click', newGame);

// ── Initialise ─────────────────────────────────────────────────────────────
updateStatusBanner();
updateScoreboard();
