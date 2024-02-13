<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\UserController;
use App\Http\Controllers\FishController;
use App\Http\Controllers\TimerController;
use App\Http\Controllers\TaskController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

// Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
//     return $request->user();
// });

Route::post('/create-user', [UserController::class, 'register']);
Route::post('/verify-user', [UserController::class, 'login']);
Route::post('/delete-user', [UserController::class, 'deleteUser']);
Route::post('/change-username', [UserController::class, 'changeUsername']);
Route::post('/change-email', [UserController::class, 'changeEmail']);
Route::post('/change-password', [UserController::class, 'changePassword']);

Route::post('/create-timer', [TimerController::class, 'timerFinished']);
Route::post('/get-timer-by-user', [TimerController::class, 'getTotalTimerByUserId']);
// Route::get('', [FishController])

Route::post('/add-task', [TaskController::class, 'addTask']);
Route::post('/delete-task', [TaskController::class, 'deleteTask']);
Route::post('/update-task', [TaskController::class, 'updateTask']);
Route::post('/show-task', [TaskController::class, 'showAllTask']);
Route::post('/find-task', [TaskController::class, 'findTask']);
Route::post('/check-task', [TaskController::class, 'checkTask']);
