# Simulation of Solar System in Augmented Reality

[![WWDC](https://img.shields.io/badge/WWDC%20Scholarship-Winner-4099FF.svg)](https://developer.apple.com/wwdc)

<img width="700" alt="first" src="https://user-images.githubusercontent.com/43496238/50532140-f8712f80-0b4f-11e9-91cf-03d3c77f2cd9.png">

## About 🔭:
---
Astronomy is the core of physics and science. And, with better understanding of science, people would eventually debunk the mentality of ‘learning science is just for exams’ when they get to see how science relates back to their everyday lives.

This is especially important for people in Southeast Asia which is where I am originated from, as they tend to lack the curiosity and drive to learn science, which is all that crucial in building a more sustainable economy to eradicate poverty and thus improving the quality of life.

### Author:
[Steven Tan](https://github.com/StevenTan)

### Target Audience:

* Primary school children or younger
* Users with no programming background

---
## Design Objectives 📌:

**1. Getting kids into Coding**

<img width="700" alt="variable" src="https://user-images.githubusercontent.com/43496238/50532190-d926d200-0b50-11e9-9c10-cccb32035bb9.png">

We allow the kids to explore the Solar System by tweaking the codebase, making mistakes and eventually learning from them. In this particular playground, users/kids are able to code and manipulate:

 * The size of each individual planet
 * The planet rotation speed around its centre of mass
 * The planet rotation speed around Sun as the centre of rotation  
 * The distance between planets in the solar system
  
Children learn about the concepts of rotational motion and how it’s being affected by its distance from its centre of rotation. So instead of ‘teaching’ these abstract concepts, we allow the kids to interact with them and let them to do the learning.

Children would also notice that the planets start the rotation on the same line (x-axis), that's by design to demonstrate the concept of orbital speed. Given enough time, it would evolve gradually to simulate an actual solar system.

Children are encouraged to explore by walking to the furthest planets and back, all in the comfort of their own rooms. Natural satellites of Earth and Mars have also been included.

 ---
**2. Instilling A Love Of Science In Children**

 <img width="690" alt="changevariable" src="https://user-images.githubusercontent.com/43496238/50532156-23f41a00-0b50-11e9-9d3c-02873372b66a.png">

Once the kids have gotten the solar system set up, in most cases they should immediately notice that the natural satellite of earth, which is Moon would collide with neighbouring planets as the initial distance between them might be just too close. 

Through trial and errors of setting the distance by tweaking the codebase, they learn. And we learn best from experience.

Kids/users learn about concepts of rotational speed/velocity and how it’s being affected by its distance from the centre of rotation. So instead of ‘teaching’ these abstract concepts, we allow the kids to interact with them and let the learning to happen naturally.

---

👻 _Making learning fun and interactive. Look at Earth!_

![EarthRotation](https://user-images.githubusercontent.com/43496238/50532311-9a921700-0b52-11e9-87c5-5072859f95c9.gif)

Notice how the planets start the rotation on the same line? That's by design to demonstrate the concept of orbital speed. Given enough time, it would evolve gradually to simulate an actual solar system.





---
### Design Rationale ✏️:

The framework used was adapted from the AR-module of iOS project.  SceneKit was mostly used for the modelling of planets but I wish to place more emphasis on the central role of ARKit in this Playground.

Knowing the importance of developing an interest in science in children, Augmented Reality in particular was chosen in this project as it woudld help to set the perfect stage for a more immersive learning experience of abstract concepts through real-world interaction.

---
### Test Environment ⚙️:

This playground was tested to run successfully on:

* Device Model: iPad 5th-Gen (A1822)
* iOS version: 11.3
* Playground Version: 2.0
* Test Date: April 1, 2018.

---

_This document was last modified on April 2, 2018._



