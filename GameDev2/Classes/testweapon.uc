class testweapon extends UDKWeapon;


simulated event SetPosition(UDKPawn Holder)
{
    local vector FinalLocation;
    local vector X,Y,Z;
 
    Holder.GetAxes(Holder.Controller.Rotation,X,Y,Z);
 
    FinalLocation= Holder.GetPawnViewLocation(); //this is in world space.
    FinalLocation= FinalLocation -Y * 12 -Z * 32; // Rough position adjustment
    //FinalLocation= FinalLocation- Y * -12 - Z * -32;
    SetHidden(False);
    SetLocation(FinalLocation);
    SetBase(Holder);
    SetRotation(Holder.Controller.Rotation);
}

DefaultProperties
{
    Begin Object Class=StaticMeshComponent Name=GunMesh
        StaticMesh=StaticMesh'FP_arms_test.FParms_test_mesh'
        HiddenGame=FALSE
        HiddenEditor=FALSE
    end object
    Mesh=GunMesh
    Components.Add(GunMesh)
}