class test extends GameInfo;
event PostLogin( PlayerController NewPlayer )
{
 super.PostLogin( NewPlayer );

 NewPlayer.ClientMessage( "Welcome" $ NewPlayer.PlayerReplicationInfo.PlayerName);
}
DefaultProperties
{
    DefaultPawnClass = class'GameDev2.TestBot'
    PlayerControllerClass = class'GameDev2.testController'
    bDelayedStart = false
}
