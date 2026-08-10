# This is how Y coordinate is transformed

Local Space (Y+ "Down")
    │ Model Matrix
    ▼
World Space (Y+ "Down")
    │ View Matrix
    ▼
View (Camera) Space (Y+ "Down")
    │ Projection Matrix (FLIPS Y+ by doing Y Scale = -1)
    ▼
Clip Space (Y+ "Up")
    │ Perspective Divide (GPU)
    ▼
Normalized Device Coordinates (NDC) (Y+ "Up")
    │ Viewport Transform (GPU) [For D3D11 an internal Y coordinate flip happens]
    ▼
Screen Space (Pixels) (Y+ "Down")
