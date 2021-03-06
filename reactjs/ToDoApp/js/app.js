// parent
var TodoApp = React.createClass({
    getInitialState: function() {
        return {
          todos :
                [
                    {item:"task1", status:0},
                    {item:"task2", status:0},
                    {item:"task3", status:1},
                    {item:"task4", status:0}
                ]
        }
    },
    
    onAdd: function(newTodo){
        this.setState({
          todos : this.state.todos.concat({item:newTodo, status:0})
        });
    },
    
    onChange: function(i){
        var targetTodo = this.state.todos[i];
        var nextState = !targetTodo.status;
        targetTodo.status = nextState;
        this.setState({
          todos: this.state.todos
         });
    },

    onDelete: function(i){
        var targetTodo = this.state.todos[i];
        this.setState({
            todos: this.state.todos.filter(function(todo){
                return todo.item != targetTodo.item;
            })
        });
    },
    
    onDeleteFinished: function(){
        this.setState({
            todos: this.state.todos.filter(function(todo){
                return todo.status === 0;
            })
        });
    },
    
    render: function(){
        return (
        <div className="TodoApp">
            <TodoCounter todos={this.state.todos} />
            <TodoDeleter todos={this.state.todos} onDeleteFinished={this.onDeleteFinished}/>
            <TodoList todos={this.state.todos} onChange={this.onChange} onDelete={this.onDelete}/>
            <TodoCreator onAdd={this.onAdd}/>
        </div>
        );
    }
});

// children
var TodoCounter = React.createClass({
    render: function() {
        var finished = 0;
        this.props.todos.map(function(todo){
            if (todo.status == 1) {
                ++finished;
            }
        });
        var total = this.props.todos.length;
        
        return (
            <div className="TodoCounter">
                <p>Finished Task: {finished} / {total} </p>
            </div>
        );
    }
});

var TodoDeleter = React.createClass({
    _onDeleteFinished: function(){
        this.props.onDeleteFinished();
    },
    
    render: function(){
        return (
          <div className="TodoDeleter">
          <button onClick={this._onDeleteFinished}>Delete Finished</button>
          </div>
        );
    }
});

var TodoCreator = React.createClass({
    getInitialState: function(){
        return {
          value: ""
        }
    },

    _onAdd: function(){
        var newTodo = this.refs.inputText.getDOMNode().value;
        this.props.onAdd(newTodo);
        this.setState({value: ""}); // clear input text value
    },
    
    _onChange: function(e){
        this.setState({
            value: e.target.value
        });
    },
    
    render: function(){
        return (
          <div className="TodoCreator">
            <input type="text" value={this.state.value} ref="inputText" onChange={this._onChange}/>
            <button onClick={this._onAdd}>Add</button>
          </div>
        );
    }
});

var TodoList = React.createClass({
    _onDelete: function(i){
        this.props.onDelete(i);
    },
    _onChange: function(i){
        this.props.onChange(i);
    },

    render: function() {
      return (
        <ul>
        {
            this.props.todos.map(function(todo,i){
                var item = todo.item;
                if (todo.status == 1) {
                    item = <s>
                            <span style={{color:'gray'}}>
                                {todo.item}
                            </span>
                          </s>
                }
                return (
                    <li key={i}>
                        <input type="checkbox" checked={todo.status}
                            onChange={this._onChange.bind(this, i)}/>
                            {item}
                        <span onClick={this._onDelete.bind(this, i)}> [x] </span>
                     </li>
                 )
        },this)
        }
        </ul>
      );
    }
});

// rendering
React.render(
    <TodoApp />,
    document.getElementById('myApp')
);