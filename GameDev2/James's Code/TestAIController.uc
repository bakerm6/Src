class TestAIController extends AIController;

var Actor Target;
var float x;
var vector destination;
var SoundCue scream;
var bool temp;
event Possess(Pawn inPawn, bool bVehicleTransition)
{
    super.Possess(inPawn, bVehicleTransition);
    Pawn.SetMovementPhysics();
    temp = true;
}
auto state Idle
{
Begin:
    Target = GetALocalPlayerController().Pawn;
    x = VSize(Target.Location - Pawn.Location);
    if(x <0)
        x*=-1;
    if (x < 500)
    {
        if(temp!= false)
            PlaySound( scream );
        MoveToward(Target, Target, 128);
        temp = false;
    }
    else
    {
    destination.X = 500;
    destination.Y = 500;
    destination.Z = 150;
    MoveTo(destination);
    temp = true;
    }
    Sleep(0);
    goto 'Begin';
}


DefaultProperties
{
    scream = SoundCue'MyPackage.mstwoc'
}