<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Timer;
use App\Models\Fish;

class TimerController extends Controller
{
    function fishStrike() {
        $fishCount = Fish::count();

        return rand(1, $fishCount);
    }

    public function timerFinished(Request $request) {
        $fish_id = $this->fishStrike();
        $fish = Fish::where('id', $fish_id)->get()->first();

        $timer = Timer::create([
            "minutes" => $request->minutes,
            "user_id" => $request->user_id,
            "fish_id" => $fish->id,
        ]);

        return response()->json($fish, 200);
    }

}
