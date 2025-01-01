const person = {
    name: 'John',
    age: 30,
    city: 'New York'
};

const greetings = ["hello", "how are you"]

const [greeting_one, greeting_two] = greetings
const {name: neme, age, city} = person

console.log(greeting_one, greeting_two)