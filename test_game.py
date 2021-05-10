from unittest import TestCase, mock

import game

class GameTest(TestCase):
    
    def test_join(self):
        """Players may join a game"""

        pig = game.Pig('PlayerA', 'PlayerB', 'PlayerC')

        self.assertEqual(pig.get_players(), ('PlayerA', 'PlayerB', 'PlayerC'))


    def test_roll(self):
        """A roll of the die results in an integer between 1 and 6"""

        pig = game.Pig('PlayerA', 'PlayerB')

        for i in range(500):
            r = pig.roll()
            self.assertIsInstance(r, int)
            self.assertTrue(1 <= r <= 6)
    

    def test_scores(self):
        """Player scores can be retrieved"""

        pig = game.Pig('PlayerA', 'PlayerB', 'PlayerC')
        self.assertEqual(
            pig.get_score(),
            {
                'PlayerA': 0,
                'PlayerB': 0,
                'PlayerC': 0
            }
        )


    def test_get_player_names(self):
        """Players can enter their names"""

        fake_input = mock.Mock(side_effect=['A', 'M', 'Z', ''])
    
        with mock.patch('builtins.input', fake_input):
            names = game.get_player_names()

        self.assertEqual(names, ['A', 'M', 'Z'])
