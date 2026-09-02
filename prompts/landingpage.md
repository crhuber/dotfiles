### Opus Model 1:

```
I want you to build me a landing page for my productivity app.

Follow this procedure:

Generate a long, random alphanumeric string using a shell script.

Define the creative direction (color scheme, layout, typography, etc.) based on the string. Look beyond the surface for subpatterns, special numbers, anything that inspires you.

Use your judgment to bring this direction to life and make it look great.

Don’t reveal the string in the design. It’s only for your inspiration.
```

### Deep Think Model (Fable 5):

```
I want you to improve this design. To figure out what to focus on, use a Fable 5 subagent as a design critic.

Follow this procedure at each iteration:

Capture a screenshot of the current design

Invoke the critic in a fresh context, with just the screenshot, not the code, implementation details, or earlier iterations/critiques

Ask it to evaluate the aesthetic that the design is going for, imagine how a top design studio would execute this aesthetic, then outline the biggest gaps

Lastly, it should provide a score out of 10 indicating how close the current design is to that studio-level quality bar

Provide this guidance to the critic in its prompt:

It should think high-level about the overall structure and composition as well as look at the fine details

It should watch out for patterns that feel overdone, excessive, or otherwise obviously AI-generated, and penalize them

It should provide tight, specific feedback, not vague prose

It should be bold and opinionated, not rely on what’s safe or easy

Your work is only complete when the critic independently deems it 9/10 or higher. Do not put that criterion in the critic prompt; keep it objective in its scoring. Use the same critic prompt each time.
```


###  For more advanced motion, use video generation (OPus 5)

```
The design is pretty plain. Add more personality using image generation. Consider shaders or 3D effects in combination with images to create more interesting visuals.

For image generation, use this environment variable OPENROUTER_API_KEY key (only use it locally, do not store it in the code or product):

Verify that your work looks right frame-by-frame in the browser.
```

### Animated Graphics

```
Can you replace the image on this page with a looping video clip that does something more interesting? Have the crystal splinter apart and slowly spin around. It should have awesome glassy effects that refract the page background and cast shadows and light around it.

To get convincing glass refraction effects, render the video of the glass over the page background colors first (so it bakes in the refraction effects), then remove the background with a video matting model.

Use this fal.ai API key: sk-a1b2c3d4…

Find appropriate recent models for video generation and background removal.
```

### Transitions

```
Build a demo page for a suitcase that uses a video model to create interactive transitions between a couple of screens. Each screen should show the suitcase in a different state, with vertical motion that feels appropriate for scrolling:

Initially, have the suitcase floating high up in the air

Then have it land on the floor and pop open

Finally, have its contents neatly land into it from the top

Generate the initial frame using your image generation skill. Then, generate a video clip that starts from that frame and animates to the next state. Use the final frame of that video to seed the next transition so that it continues seamlessly. Scrub through the transitions one by one as the user scrolls.

Use this fal.ai API key:

Use a video model with strong physics and consistency, like Seedance 2.5.
```

### Simplify

```
Simplify the layout into ___

Get rid of gradients, glows, and unnecessary containers

Aim for a truly minimalist aesthetic that feels Apple-native
```
