const fizzBuzz = (count: number) => {
    for (let i = 1; i <= count; i++) {
        if (i % 3 === 0 && i % 5 === 0) {
            console.log("FizzBuzz");
        } else if (i % 3 === 0) {
            console.log("Fizz");
        } else if (i % 5 === 0) {
            console.log("Buzz");
        } else {
            console.log(i);
        }
    }
}

fizzBuzz(40)

console.log();
console.log("=========================================");

const palindrome = (input: string) => {
    const reverseInput = input.split("").reverse().join("")
    return reverseInput == input
}

console.log("Palindrome 'kasur rusak' :", palindrome("kasur rusak"));
console.log("Palindrome 'rumah' :", palindrome("rumah"));
