<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Fish;
use App\Models\Timer;
use App\Models\User;

class FishController extends Controller
{
    
    public function fishcollection(Request $request)
    {
        
        $timer_fishid = Timer::select('fish_id')->where('user_id',$request->userId)->distinct()->get();
        
        $fish = Fish::select('id', 'name', 'description', 'image', 'created_at')->whereIn('id', $timer_fishid)->get();

        return response()->json($fish, 200);
        // return $fish;
    }

}
