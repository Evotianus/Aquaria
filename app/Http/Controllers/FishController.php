<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;
use App\Models\Fish;
use App\Models\Timer;
use App\Models\User;

class FishController extends Controller
{
    
    public function fishcollection(Request $request)
    {
        
        $timer_fishid = Timer::select('fish_id')->where('user_id',$request->userId)->distinct()->get();
        
        $fish = DB::table('timers')
                    ->join('fish', 'timers.fish_id', '=', 'fish.id')
                    ->select('fish.id', 'fish.name', 'fish.description', 'fish.image', 'timers.created_at')
                    ->whereIn('fish.id', $timer_fishid)
                    // ->orderby('timers.created_at','ASC')
                    ->groupBy('fish.id')
                    ->get();
        // $created_atTimer = Timer::selectRaw('DATE(created_at) as created_at')->whereIn('fish_id',$timer_fishid)->orderby('created_at','ASC')->distinct()->get();
        

        // return response()->json(array('fish' => $fish,'created_atTimer' => $created_atTimer),200);
        return response()->json($fish,200);
        // return $fish;
    }

}
