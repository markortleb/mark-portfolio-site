const defaultWidth = 100;
const defaultHeight = 70;

let width = defaultWidth;
let height = defaultHeight;
let mouseDown;
let brushName = 'brush-0';


function eraseBoard(){
    const chalkBoard = document.querySelector('.chalkboard');
    chalkBoard.innerHTML = '';
}


function initBoard(){
    const chalkBoard = document.querySelector('.chalkboard');

    for (let i = 0; i < height; i++){
        let row = document.createElement('div');
        row.classList.add('row');
        for (let j = 0; j < width; j++){
            let block = document.createElement('div');
            block.classList.add('block');

            block.addEventListener('mouseover', e => {
                if (mouseDown){
                    block.classList.add(brushName);
                }
            });
            row.appendChild(block);

        }
        chalkBoard.appendChild(row);
    }

    chalkBoard.addEventListener('mousedown', e => {
        // We are randomizing color, by making new brush each time
        const style = document.createElement('style');
        let newBrushName = brushName.split('-')[0] + '-'
            + (parseInt(brushName.split('-')[1]) + 1).toString();

        let randomColor = Math.floor(Math.random()*16777215).toString(16);
        style.innerHTML = `.${newBrushName} { background-color: #${randomColor}; }`;
        console.log(style.innerHTML);
        document.getElementsByTagName('body')[0].appendChild(style);
        brushName = newBrushName;

        // Use this to prevent mouse attempting to drag element
        e.preventDefault();

        mouseDown = true;
    });

    chalkBoard.addEventListener('mouseup', e => {
        mouseDown = false;
    });

}


function initSizeForm(){
    const submitButton = document.querySelector('.submit-button');

    submitButton.addEventListener('click', e => {
        const widthInput = document.querySelector('#width');
        const heightInput = document.querySelector('#height');

        let maxWidth = 300;
        let maxHeight = 110;

        let newWidth = parseInt(widthInput.value);
        let newHeight = parseInt(heightInput.value);

        if (newWidth > 0 && newHeight > 0){
            if (newHeight > maxHeight){
                height = maxHeight;
            } else{
                height = newHeight;
            }
            if (newWidth > maxWidth){
                width = maxWidth;
            } else{
                width = newWidth;
            }
        } else{
            width = defaultWidth;
            height = defaultHeight;
        }
        widthInput.value = '';
        heightInput.value = '';

        eraseBoard();
        initBoard();
    });
}


function initEraseButton(){
    const eraseButton = document.querySelector('.erase-button');
    eraseButton.addEventListener('click', e => {
        eraseBoard();
        initBoard();
    });
}


initBoard();
initSizeForm();
initEraseButton()
