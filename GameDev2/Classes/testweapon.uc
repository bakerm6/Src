class testweapon extends UDKWeapon;
var bool check;

simulated event SetPosition(UDKPawn Holder)
{
    local vector FinalLocation;
    local vector X,Y,Z;
    //local rotator c;
    Holder.GetAxes(Holder.Controller.Rotation,X,Y,Z);
    FinalLocation= Holder.GetPawnViewLocation(); //this is in world space.
    FinalLocation= FinalLocation-Y*9-Z*20; // Rough position adjustment
    //FinalLocation= FinalLocation- Y * -12 - Z * -32;
    SetHidden(False);
    SetLocation(FinalLocation);
    SetBase(Holder);
    SetRotation(Holder.Controller.Rotation);
    //c.yaw = c.yaw - 15000;
    //SetRotation(c);
}

DefaultProperties
{
    Begin Object Class=StaticMeshComponent Name=GunMesh
        StaticMesh=StaticMesh'FP_arms_test.FParms_test2'
        Rotation=(Yaw=-15000)
        HiddenGame=FALSE
        HiddenEditor=FALSE
        CastShadow = False
    end object
    /*Begin Object class=SkeletalMeshComponent Name=MySkeletalMeshComponent
    SkeletalMesh=SkeletalMesh'test_anim.monster_test'
    AnimtreeTemplate= AnimTree'test_anim.walk_tree_test'
    AnimSets(0)=AnimSet'test_anim.walk_test'
    Translation=(Z=0.0)
    End Object*/
    Mesh=GunMesh
    //bCastShadows = false
    Components.Add(GunMesh)
    check = false
   //SpawnRotation=(yaw=6000)
}