// Question:
/*
My friends and I have a nerd boardgame night where we play the same game every time.
The problem is, we always want to select the same player to character assignments in the same order;
 thus we end up playing the same game.”

This question is to solve that problem for us by writing a “random full game player to character assignment generator.” The rules are:
Each player must be assigned 1 and only 1 character per round
Each character may be used by up to 1 player per round
Each player must be assigned a different character each round such that they never play as the same character > 1 time
There are m players
There are n characters n => m
There are m rounds
The method to generate random valid games should return a random valid game from the full set of valid games (for given values of n and m).
*/

#include <iostream>
#include <vector>
using namespace std;

// get rand char index from set of total chars
int GetCharacter(const vector<int>& carachters, int round, int player, const vector<vector<int>>& game)
{
  auto temp = carachters;

  for(int t=0; t < temp.size(); t++) // walk throuhg all characters
  {
    for(int r=0; r < round; r++) // walk throuhg all rounds before
    {
      if(temp[t] == game[r][player])
      {
        temp.erase(temp.begin()+t); // remove character that already been plaed
      }
    }
  }
  return temp[rand() % temp.size()];
}


vector<vector<int>> GenerateGame(int playerCount, int charCount)
{
  vector<vector<int>> game; // to keep track of history

  // optimization, we can/should reserve memory in advance

  game.reserve(playerCount);

  for(int i=0; i<playerCount; i++)
  {
    vector<int> round(playerCount,0);
    game.push_back(move(round)) ;
  }

  vector<int> characters(charCount);
  //fill in characters
  for(int i=0; i<charCount; i++)
  {
    characters[i]=i;
  }

  for(int round = 0; round < playerCount; round++ )
  {
    // generate round
    for(int player = 0; player < playerCount; player++ )
    {
      int c = GetCharacter(characters, round, player, game);
      cout << c;
      game[round][player] = c;
    }
  }
  return game;
}

void PrintGame(const vector<vector<int>>& game)
{
  printf("\n");
  for (int i = 0; i < game.size(); i++)
  {
    cout << "round " << i << ":";
    for (int j = 0; j < game[i].size(); j++)
    {
      printf("(%i : %i), ", j, game[i][j]);
    }
    printf("\n");
  }

    for (int i = 0; i < game.size(); i++)
  {
    for (int j = 0; j < game[i].size(); j++)
    {
      printf("%i, ", game[i][j]);
    }
    printf("\n");
  }
}

int main()
{
  PrintGame(GenerateGame(3,4));

  //GenerateGame(3,4);
  return 0;
}



/*
Rounds/Player p1 p2 p3
1 [[1,2,0],
2  [2,0,1]
3  [0,1,2]]
*/


// a, b , c d
// per-player avail char b, c d
//1=c
// a,b,c,d - (b + c)

/*
m = 3, n = 4

p1, p2, p3
A B C D

// invalid
r1: p1=A, p2=B, p3=C
r2: p1=A, p2=B, p3=C
r3: p1=A, p2=B, p3=C

// invalid
r1: p1=A, p2=A, p3=C
r2: p1=A, p2=B, p3=C
r3: p1=A, p2=B, p3=C

// valid
r1: p1=A, p2=B, p3=C
r2: p1=C, p2=A, p3=B
r3: p1=B, p2=C, p3=A
*/
