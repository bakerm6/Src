class GD2PlayerCamera extends GamePlayerCamera;

var Vector CamOffset;
var float CameraZOffset;
var float CameraScale, CurrentCameraScale; /** multiplier to default camera distance */
var float CameraScaleMin, CameraScaleMax;

// function UpdateViewTarget(out TViewTarget OutVT, float DeltaTime)
// {
   // local vector      HitLocation, HitNormal;
   // local CameraActor   CamActor;
   // local Pawn          TPawn;
   
   // local vector CamStart, CamDirX, CamDirY, CamDirZ, CurrentCamOffset;
   // local float DesiredCameraZOffset;

   // // Don't update outgoing viewtarget during an interpolation 
   // if( PendingViewTarget.Target != None && OutVT == ViewTarget && BlendParams.bLockOutgoing )
   // {
      // return;
   // }

   // // Default FOV on viewtarget
   // OutVT.POV.FOV = DefaultFOV;

   // // Viewing through a camera actor.
   // CamActor = CameraActor(OutVT.Target);
   // if( CamActor != None )
   // {
      // CamActor.GetCameraView(DeltaTime, OutVT.POV);

      // // Grab aspect ratio from the CameraActor.
      // bConstrainAspectRatio   = bConstrainAspectRatio || CamActor.bConstrainAspectRatio;
      // OutVT.AspectRatio      = CamActor.AspectRatio;

      // // See if the CameraActor wants to override the PostProcess settings used.
      // CamOverridePostProcessAlpha = CamActor.CamOverridePostProcessAlpha;
      // CamPostProcessSettings = CamActor.CamOverridePostProcess;
   // }
   // else
   // {
      // TPawn = Pawn(OutVT.Target);
      // // Give Pawn Viewtarget a chance to dictate the camera position.
      // // If Pawn doesn't override the camera view, then we proceed with our own defaults
      // if( TPawn == None || !TPawn.CalcCamera(DeltaTime, OutVT.POV.Location, OutVT.POV.Rotation, OutVT.POV.FOV) )
      // {   
         // /**************************************
          // * Calculate third-person perspective
          // * Borrowed from UTPawn implementation
          // **************************************/
         // OutVT.POV.Rotation = PCOwner.Rotation;                                                   
         // CamStart = TPawn.Location;
         // CurrentCamOffset = CamOffset;
         
         // DesiredCameraZOffset = 1.2 * TPawn.GetCollisionHeight() + TPawn.Mesh.Translation.Z;
         // CameraZOffset = (DeltaTime < 0.2) ? DesiredCameraZOffset * 5 * DeltaTime + (1 - 5*DeltaTime) * CameraZOffset : DesiredCameraZOffset;
         
         // CamStart.Z += CameraZOffset;
         // GetAxes(OutVT.POV.Rotation, CamDirX, CamDirY, CamDirZ);
         // CamDirX *= CurrentCameraScale;
      
         // TPawn.FindSpot(Tpawn.GetCollisionExtent(),CamStart);
         // if (CurrentCameraScale < CameraScale)
         // {
            // CurrentCameraScale = FMin(CameraScale, CurrentCameraScale + 5 * FMax(CameraScale - CurrentCameraScale, 0.3)*DeltaTime);
         // }
         // else if (CurrentCameraScale > CameraScale)
         // {
            // CurrentCameraScale = FMax(CameraScale, CurrentCameraScale - 5 * FMax(CameraScale - CurrentCameraScale, 0.3)*DeltaTime);
         // }                              
         // if (CamDirX.Z > TPawn.GetCollisionHeight())
         // {
            // CamDirX *= square(cos(OutVT.POV.Rotation.Pitch * 0.0000958738)); // 0.0000958738 = 2*PI/65536
         // }
         // OutVT.POV.Location = CamStart - CamDirX*CurrentCamOffset.X + CurrentCamOffset.Y*CamDirY + CurrentCamOffset.Z*CamDirZ;
         // if (Trace(HitLocation, HitNormal, OutVT.POV.Location, CamStart, false, vect(12,12,12)) != None)
         // {
            // OutVT.POV.Location = HitLocation;
         // }
      // }
   // }

   // // Apply camera modifiers at the end (view shakes for example)
   // ApplyCameraModifiers(DeltaTime, OutVT.POV);
// }

defaultproperties
{
   CamOffset=(X=0.0,Y=.0,Z=0.0)
   CurrentCameraScale=1.0
   CameraScale=9.0
   CameraScaleMin=3.0
   CameraScaleMax=40.0
}