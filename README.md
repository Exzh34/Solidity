# Solidity
<h3>Notes and simple code made while learning solidity</h3>
<p> Moralis begginer stuff is based on https://www.youtube.com/channel/UCgWS9Q3P5AxCWyQLT2kQhBw/playlists </p>
<p>Zombie stuff based on learning guide @ https://cryptozombies.io/</p>
<p> <h4>Address:</h4> Every account and smart contract has an address. It is used to send and receive Ether from one account to another. Basically your public identity on the blockchain</p>
<p> <h4>Mapping:</h4> Data type used to store associations. Similar to a list but it holds 2 values, and allows to quickcly get the value corresponding to the key </p>
<p> <h4>Event:</h4> When called, it causes the arguments to be stored in the transaction´s logs </p>
<p> <h4>Emit:</h4> Keyword that is used to call events </p>
<p> <h4>Constructor:</h4> Function that is runned directly when the contract is created, this functions runs only once</p>
<p> <h4>Msg:</h4> Keyword that allows us to access some special variables that are available for us from the blockchain </p>
<p> <h4>Require:</h4> Convenience function in solidity. It guarantees validity of conditions that cannot be detected before execution </p>
<p> <h4>Constant:</h4> Keyword added to a variable that tells solidity it cannot be changed </p>
<p> <h4>Struct:</h4> Struct types are used to represent a record. Allow to create our own data type </p>
<p> <h4>Enum:</h4> Enums restrict variables to have one of the only few predefined values. The values in this enumerated list are called enums. </p>
<p> <h4>Arrays:</h4> "Player[] public players;" creates and array called players of the struct Player.</p>
<p> <h4>Modifier:</h4> Can be used to change the behaviour of functions in a declarative way, for example you can use a modifier to automatically check a condition prior to executing the function, it is also inheritable between contracts.</p>
