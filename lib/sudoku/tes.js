function applySudokuDifficulty(grid, level) {
    const levels = {
        mudah: 25,
        sedang: 35,
        sulit: 42,
        "sangat sulit": 50,
    };

    if (!levels.hasOwnProperty(level)) {
        throw new Error("Level harus salah satu dari: 'mudah', 'sedang', 'sulit', 'sangat sulit'");
    }

    // Salin array grid agar tidak mengubah input asli
    const newGrid = grid.map(row => row.slice());

    const countToRemove = levels[level];
    const positions = [];

    // Dapatkan semua posisi sel (row, col)
    for (let r = 0; r < 9; r++) {
        for (let c = 0; c < 9; c++) {
            positions.push([r, c]);
        }
    }

    // Fungsi untuk mengambil array random sample sebanyak n elemen
    function getRandomSample(arr, n) {
        const result = [];
        const clonedArr = arr.slice();
        for (let i = 0; i < n; i++) {
            const idx = Math.floor(Math.random() * clonedArr.length);
            result.push(clonedArr[idx]);
            clonedArr.splice(idx, 1);
        }
        return result;
    }

    const toRemove = getRandomSample(positions, countToRemove);

    // Ganti angka di posisi terpilih menjadi 0
    toRemove.forEach(([r, c]) => {
        newGrid[r][c] = 0;
    });

    return newGrid;
}

// Contoh penggunaan:
const sudoku = [
    [9, 2, 1, 8, 6, 5, 4, 3, 7],
    [4, 8, 5, 3, 2, 7, 9, 1, 6],
    [6, 7, 3, 9, 1, 4, 8, 2, 5],
    [2, 4, 9, 5, 3, 1, 6, 7, 8],
    [1, 6, 7, 2, 4, 8, 3, 5, 9],
    [5, 3, 8, 6, 7, 9, 1, 4, 2],
    [7, 5, 4, 1, 9, 6, 2, 8, 3],
    [3, 1, 6, 7, 8, 2, 5, 9, 4],
    [8, 9, 2, 4, 5, 3, 7, 6, 1],
];

const result = applySudokuDifficulty(sudoku, "sedang");
console.log(result);
