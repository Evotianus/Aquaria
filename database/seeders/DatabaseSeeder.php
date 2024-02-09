<?php

namespace Database\Seeders;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\User;
use App\Models\Fish;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {

        $fishArray = [
            [
                'name' => 'Stingray',
                'description' => 'Just a stingray',
                'image' => 'stingray',
            ],
            [
                'name' => 'Pufferfish',
                'description' => 'Just a pufferfish',
                'image' => 'pufferfish',
            ],
            [
                'name' => 'Clown fish',
                'description' => 'Just a clown fish',
                'image' => 'clownfish',
            ],
            [
                'name' => 'Salmon',
                'description' => 'Just a salmon',
                'image' => 'salmon',
            ],
        ];

        $userArray = [
            [
                'username' => 'Evo',
                'email' => 'evo@gmail.com',
                'password' => 'evo',
            ],
        ];

        foreach ($fishArray as $fish) {
            Fish::create($fish);
        }

        foreach ($userArray as $user) {
            User::create($user);
        }
    }
}
