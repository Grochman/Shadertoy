# Shadertoy
Minimalistic environment using OpenGL, GLEW, and GLFW for GLSL shader art development. 

### Features
- #include directive support for glsl files
- texture support
- micro-librarys for: shapes, fractal coloring, random number generation, color conversion (quite inefficient)

### Shaders
- Mandelbrot set
- Julia set 
- sphere
- loading screen
- halftone in grayscale with horizontal and vertical dot travel
- halftone in color (rgb) with dot travel and angle offset
- kuwahara filter with color
- palette quantization to specified color palette
- luminance quantization with color preservation using value from hsv mapped colors 

![mandelbrot](https://github.com/user-attachments/assets/9f58bc47-538f-48c8-a990-7119ee25a30d)
![julia](https://github.com/user-attachments/assets/e5fd438e-c57c-4e6b-b7c9-a354e8373af6)
![sphere](https://github.com/user-attachments/assets/91d3806f-290a-4193-9f2e-9b59d3e0dc57)
![loading](https://github.com/user-attachments/assets/0b413afd-b213-4e69-badd-ff6eb75ab772)
![halftone_monochrome_move](https://github.com/user-attachments/assets/fe810575-05b0-46ed-903b-92b53c9257b1)
![halftone_color_move](https://github.com/user-attachments/assets/8cf08786-b37f-4591-aeac-c031bea55ef7)
![kuwahara_color](https://github.com/user-attachments/assets/b9a510e0-03b6-4eb0-9748-d12c288a0a84)
![palette_quantization](https://github.com/user-attachments/assets/edfd189c-cfcd-48ec-810f-331298062bdf)
![luminance_quantization](https://github.com/user-attachments/assets/72e95f74-0e93-45ac-885f-7e4ae86aa74c)



### Resources
- Basic framework based on https://www.youtube.com/@TheCherno
- GLSL The Book of Shaders https://thebookofshaders.com/
- Shaping functions visualization https://graphtoy.com/
- Color palette generator https://coolors.co/
