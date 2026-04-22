#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS

do
  if [[ $YEAR != 'year' ]]
  then
    # check if winner exists, if not insert it
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    if [[ -z $WINNER_ID ]]
    then
      $($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
    fi

    # get new winner_id
      WINNER_ID=$($PSQL "select team_id from teams where name='$WINNER'")

    # check if opponent exists, if not insert it
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
    if [[ -z $OPPONENT_ID ]]
    then
      $($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
    fi

    # get new opponent_id
      OPPONENT_ID=$($PSQL "select team_id from teams where name='$OPPONENT'")

    # check if the game exists, if not insert it
    GAME_ID=$($PSQL "SELECT game_id FROM games WHERE year=$YEAR AND round='$ROUND' AND winner_id=$WINNER_ID AND opponent_id=$OPPONENT_ID")
    if [[ -z $GAME_ID ]]
    then
      $($PSQL "INSERT INTO games(year,round,winner_id,winner_goals,opponent_goals,opponent_id) VALUES($YEAR,'$ROUND',$WINNER_ID,$WINNER_GOALS,$OPPONENT_GOALS,$OPPONENT_ID)")
    fi
    GAME_ID=$($PSQL "SELECT game_id FROM games WHERE year=$YEAR AND round='$ROUND' AND winner_id=$WINNER_ID AND opponent_id=$OPPONENT_ID")
  fi
done
