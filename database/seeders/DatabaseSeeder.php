<?php

namespace Database\Seeders;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\User;
use App\Models\Task;
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
                'description' => 'Even though its body is large and flat, this fish is capable of beautiful movements and sometimes jumps from the surface of the water in a very graceful style. The speed and flexibility of stingrays make them difficult for their natural predators to catch.',
                'image' => 'stingray',
            ],
            [
                'name' => 'Pufferfish',
                'description' => 'The normal appearance of a pufferfish is long and tapered, like a football, and they have notably rounded heads. All pufferfish have a beak-like cluster of four fused teeth at the forefront of their mouths which they use to crack open some of their favorite foods.',
                'image' => 'pufferfish',
            ],
            [
                'name' => 'Clown fish',
                'description' => 'Clownfish are small, brightly colored fish found in warm waters of the Indian and Pacific Oceans. These fish are notable for their unique mating habits and social structures within their colonies.',
                'image' => 'clownfish',
            ],
            [
                'name' => 'Salmon',
                'description' => 'The mature salmon has shimmer with shades of silvery blue, blending into the aquatic world. When its time to lay eggs, their bodies undergo metamorphosis and turn bright red, while their heads turn a striking green.',
                'image' => 'salmon',
            ],
            [
                'name' => 'Swordfish',
                'description' => 'Female swordfish has a larger size than male swordfish. However, only male swordfish have a sword on the underside of their tail. Swordfish have a very fast reproductive ability. This fish can reproduce in just 28 days and can produce up to 50 young per parent.',
                'image' => 'swordfish',
            ],
            [
                'name' => 'Masked Butterflyfish',
                'description' => 'Also known as the Bluecheek Butterflyfish, is one of the few species of fish known to have a long-term mates. With their fun and unique coloration, they look like theyre going to a fancy masquerade ball! ',
                'image' => 'maskedbutterfly',
            ],
            [
                'name' => 'Threadfin butterflyfish',
                'description' => 'This fish is peaceful and mostly ignores other fishes in the aquarium. However, this fish can show aggression to the same kind. This fish species is active in the day and sleeps in hiding spots like crevices at night.',
                'image' => 'threadfinbutterflyfish',
            ],
            [
                'name' => 'Goldfish',
                'description' => 'Goldfish don’t have stomachs and should therefore be fed easily digestible food in lots of small feeding sessions. This is also why goldfish produce so much waste and why you need a filter to keep their water clean.',
                'image' => 'goldfish',
            ],
            [
                'name' => 'Shark',
                'description' => 'Sharks are predators that are famous for their sharp canine teeth. However, shark teeth actually fall out quite often. Shark teeth can fall out easily because they do not have tooth roots. Even so, sharks are not worried about their teeth, because within 24 hours new teeth will grow.',
                'image' => 'shark',
            ],
            [
                'name' => 'Red snapper fish',
                'description' => 'Red snapper can grow to about 40 inches, weigh up to 50 pounds and live more than 50 years. Red snapper begin to reproduce when they are about two years old, spawning from May to October along rocky ledges or coral reefs.',
                'image' => 'redsnapperfish',
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

        User::factory(5)->create();
        Task::factory(200)->create();
    }
}
