# Y coordinate transformation convention used by this game's renderer

Local Space (Y+ "Down")
    │ Model Matrix
    ▼
World Space (Y+ "Down")
    │ View Matrix
    ▼
View (Camera) Space (Y+ "Down")
    │ Projection Matrix (FLIPS Y+ "Down" to Y+ "Up" by doing Y Scale = -1)
    ▼
Clip Space (Y+ "Up")
    │ Perspective Divide (GPU)
    ▼
Normalized Device Coordinates (NDC) (Y+ "Up")
    │ Viewport Transform (GPU) [For D3D11 an internal Y coordinate flip happens]
    ▼
Screen Space (Pixels) (Y+ "Down")
