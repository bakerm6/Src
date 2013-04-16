class testweapon extends UDKWeapon;


simulated event SetPosition(UDKPawn Holder)
{
    local vector FinalLocation;
    local vector X,Y,Z;
 
    Holder.GetAxes(Holder.Controller.Rotation,X,Y,Z);
 
    FinalLocation= Holder.GetPawnViewLocation(); //this is in world space.
    FinalLocation= FinalLocation- Y * 12 - Z * 32; // Rough position adjustment
    SetHidden(False);
    SetLocation(FinalLocation);
    SetBase(Holder);
    SetRotation(Holder.Controller.Rotation);
}

DefaultProperties
{
    Begin Object Class=SkeletalMeshComponent Name=GunMesh
        SkeletalMesh=SkeletalMesh'WP_LinkGun.Mesh.SK_WP_Linkgun_1P'
        HiddenGame=FALSE
        HiddenEditor=FALSE
    end object
    Mesh=GunMesh
    Components.Add(GunMesh)
}