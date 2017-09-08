class TaskItem {
    body: string;
    done: boolean;
}

interface ITaskScope extends ng.IScope {
    tasks: Array<TaskItem>;
    newTaskBody: string;
    addNew: typeof MainController.prototype.addNew;
    deleteTask: typeof MainController.prototype.deleteTask;
    deleteDone: typeof MainController.prototype.deleteDone;
    getDoneCount: typeof MainController.prototype.getDoneCount;
}

class MainController {
    constructor(private $scope: ITaskScope) {
        $scope.tasks = [
            {body:"do this 1", done:false},
            {body:"do this 2", done:false},
            {body:"do this 3", done:true},
            {body:"do this 4", done:false}
        ];
        
        $scope.addNew = this.addNew.bind(this);
        $scope.deleteTask = this.deleteTask.bind(this);
        $scope.deleteDone = this.deleteDone.bind(this);
        $scope.getDoneCount = this.getDoneCount.bind(this);
    }
    
    // member functions
    addNew(): void {
        this.$scope.tasks.push({body:this.$scope.newTaskBody, done:false});
        this.$scope.newTaskBody = '';
    }
    
    deleteTask(index: number): void {
        this.$scope.tasks.splice(index, 1);
    }
    
    deleteDone(): void {
        var oldTasks = this.$scope.tasks;
        this.$scope.tasks = [];
        oldTasks.forEach(task => {
            if (!task.done) {
                this.$scope.tasks.push(task);
            }
        });
    }
    
    getDoneCount(): number {
        var count = 0;
        this.$scope.tasks.forEach(task => {
            count += task.done ? 1 : 0;
        });
        return count;
    }
}