<?php

namespace App\Http\Controllers;

use App\Models\Task;
use Illuminate\Http\Request;
use Symfony\Component\Console\Output\ConsoleOutput;

class TaskController extends Controller
{
    //
    public function addTask(Request $request) {
        $task = new Task;
        $task->user_id = $request->user_id;
        $task->title = $request->title;
        $task->urgency = $request->urgency;
        $task->due = $request->due;
        $task->isFinished = $request->isFinished;

        $task->save();
        return response()->json($task, 200);
    }

    public function deleteTask(Request $request) {
        $deletedTask = Task::where('user_id', $request->user_id )
        ->where('id', $request->id)
        ->delete();

        return response()->json(["isDeleted" => $deletedTask], 200);
    }

    public function updateTask(Request $request) {
        $updatedTask = Task::where('user_id', $request->user_id)
        ->where('id', $request->id)
        ->update([
            'title' => $request->title,
            'urgency' => $request->urgency,
            'due' => $request->due
        ]);

        return response()->json(["changed_row" => $updatedTask], 200);
    }

    public function showAllTask(Request $request) {
        $tasks = Task::where('user_id', $request->id)->get()    ;

        return response()->json($tasks, 200);
    }

    public function checkTask(Request $request) {

        if($request->isFinished == 0) {
            $updatedTask = Task::where('user_id', $request->user_id)
            ->where('id', $request->id)
            ->update([
                'isFinished' => 1,
            ]);
        } else {
            $updatedTask = Task::where('user_id', $request->user_id)
            ->where('id', $request->id)
            ->update([
                'isFinished' => 0,
            ]);
        }
        return response()->json(["isChecked" => true], 200);
    }

    public function findTask(Request $request) {
        $task = Task::where('user_id', $request->user_id )
        ->where('id', $request->id)
        ->first();

        return $task[0];
    }
}
