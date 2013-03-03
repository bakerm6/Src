class SeqAct_GD2FlashlightSequence extends SequenceAction;

 var vector rotationVector;
 var vector locationVector;

 // Events
 //================================================== ==

 event Activated()
 {
 local SeqVar_Object ObjVar;
 local Rotator viewRotation;
 local pawn player;

 foreach LinkedVariables(class'SeqVar_Object', ObjVar, "Target")
 {
 player = Pawn(ObjVar.GetObjectValue());

 viewRotation = player.GetViewRotation();
 locationVector = player.GetPawnViewLocation();

 rotationVector.X = viewRotation.Pitch;
 rotationVector.Y = viewRotation.Yaw;
 rotationVector.Z = viewRotation.Roll;
 }
 }

 //================================================== ==

 DefaultProperties
 {
 bCallHandler=false

 ObjName="Get Player Rotation and Location"
 ObjCategory="Player"
 //VariableLinks.Empty
 VariableLinks(1)=(ExpectedType=class'SeqVar_Vector',LinkDesc="Rotation Vector",bWriteable=true,PropertyName=rotationVector)
 VariableLinks(2)=(ExpectedType=class'SeqVar_Vector',LinkDesc="Location Vector",bWriteable=true,PropertyName=locationVector)
 }