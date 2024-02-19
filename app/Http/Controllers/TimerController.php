<?php

namespace App\Http\Controllers;

use Carbon\Carbon;
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
            "user_id" => $request->userId,
            "fish_id" => $fish->id,
        ]);

        return response()->json($fish, 200);
    }

    public function getTotalTimerByUserId(Request $request) {
        $timersByWeek = Timer::where('user_id', $request->userId)->whereBetween('created_at', [Carbon::now()->startOfWeek(), Carbon::now()->endOfWeek()])->selectRaw('SUM(minutes) as daily_focus_time, DAYNAME(created_at) as dayname')->groupBy('dayname')->get();
        $timersByMonth = Timer::where('user_id', $request->userId)->whereBetween('created_at', [Carbon::now()->startOfMonth(), Carbon::now()->endOfMonth()])->selectRaw('SUM(minutes) as daily_focus_time, DAYOFMONTH(created_at) as date')->groupBy('date')->get();
        $recentCatch = Timer::where('user_id', $request->userId)->orderBy('created_at', 'DESC')->limit(3)->get();
        $daysInMonth = Timer::selectRaw('DAY(LAST_DAY(created_at)) as days_in_month')->first();

        // return response()->json(['timersByWeek' => $timersByWeek, 'timersByMonth'], 200, $headers);
        return response()->json(['timers_by_week' => $timersByWeek, 'timers_by_month' => $timersByMonth, 'recent_catch' => $recentCatch, 'days_in_month' => $daysInMonth], 200);
    }
}
