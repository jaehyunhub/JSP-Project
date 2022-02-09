function validateNotNull(event) {
	let list = document.getElementsByTagName('li'); // <li> 요소들을 선택
	for(let i=0;i<list.length;i++) {
		let inputs = list[i].querySelectorAll('input:not([type=button]),textarea'); // <li> 요소 하위 요소 중 button이 아닌 <input> 요소나 <textarea> 요소 선택
		for(input of inputs) {
			input.value = input.value.trim(); // 문자열 양끝 공백 제거
			if(!input.value && input.name!='email') { // 아무것도 입력하지 않은 경우; email은 NULL 허용하므로 제외
				let word = list[i].querySelector('label').textContent; // <label> 요소 사이의 문자열 추출
				let post = (word.charCodeAt(word.length-1) - '가'.charCodeAt(0)) % 28 > 0 ? '을' : '를'; // 마지막 글자의 받침 유무에 따라 적절한 조사 선택
				alert(word + post + ' 입력하세요!');
				input.focus();
				event.preventDefault(); // submit의 기본 이벤트 제거
				return false; // for문의 반복을 멈추고 함수 실행 종료
			}
		}
	}
	return true;
}

function validateSubmit(id) {
	document.getElementById(id).addEventListener('submit', validateNotNull, false);
}
// 사용 예제: <form> 요소의 id를 인자로 전달
// validateSubmit('register_form');

function getBytesLength(str) {
    let bytes = 0;
    for(let i=0;i<str.length;i++) {
        let unicode = str.charCodeAt(i);
        bytes += unicode >> 11 ? 3 : (unicode >> 7 ? 2 : 1); // 2^11=2048로 나누었을 때 몫이 있으면 3bytes, 그보다 작은 수이면서 2^7=128로 나누었을 때 몫이 있으면 2bytes, 그 외에는 1byte
    }
    return bytes;
}

function validateBytesLength(obj) {
	for(let key in obj) {
		document.getElementById(key).addEventListener('keyup', function() {
			while(getBytesLength(this.value)>obj[key]) {
				this.value = this.value.slice(0, -1);
			}
		}, false);
	}
}
// 사용 예제: 길이 제한이 필요한 <input> 요소의 id와 바이트 길이를 객체 형식 인자로 전달
// validateBytesLength({title:150,name:30,passwd:12});