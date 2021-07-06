# spl_bug

This repo is made to show problems of current scrollable_positioned_list package.
Main view has 2 obvious buttons leading to two corresponding views of reversed and not lists. 

The main problem is bounce effect that occurs when you `jumpTo` to item in the bottom, in the middle, etc.
That happens because of desirable alignment: for example, when alignment is 0.0 and you `jumpTo` last item in direct (not reversed) list, the code tries to position this target item at desirable alignment, thus causing leading (previous) items of target go above the visible part, viewport. And then the correction that utilizes bounceEffect happens.

# My small workaround
So I made a small workaround for bounce effect that you can see at `scrollable_positioned_list\lib\src\viewport.dart` lines 251-264, just uncomment them. 
What it does is clamp the viewport particular, restrict its values so no overscroll is available. BTW it's good when you use `ClampingScrollPhysics` but not good for `BouncingScrollPhysics`.

To be honest it doesn't work in a good way but that helped me see one strange thing that causes glitch effect: 
1. Place breakpoint at line 248 for example
2. Using button in `appBar` change target item to the topmost one
3. Then change target item to the bottommost one
4. The very first frame catched at the breakpoint shows that `leadingOffset` and `trailingOffset` have incorrect values, for me they = 0.0, but pretty obviously they cannot be zero, at least `leadingNegativeChild's` height cannot.

# Summary
So what I tried to point is that maybe someone can see further and understand what causes the problem with glitch or even maybe fix the whole bounce effect issue.
