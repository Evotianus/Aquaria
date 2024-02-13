<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\task>
 */
class TaskFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        $urgency = array('Critical', 'High', 'Medium', 'Low', 'Very Low');

        return [
            'user_id' => mt_rand(1, 5),
            'title' => fake()->sentence(3),
            'urgency' => $urgency[mt_rand(0, 4)],
            'due' => fake()->dateTime(),
            'isFinished' => 0,
        ];
    }
}
