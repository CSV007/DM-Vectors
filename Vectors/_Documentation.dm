#if 0
/*
--- Table of Contents
	A.	Version History
	B.	Introduction
	1.	Common Vectors (zero, i, j)
	2.	Vector Properties (accessing components, getting magnitude and direction)
	3.	Vector Functions (add, subtract, multiply, divide, reverse, unit, dot, copy, compare, type-check)
	4.	!!! Note for Advanced Users !!!


-A- Version History
	# (MM/DD/YYYY)

	1 (01/27/2013)
		Project creation.


-B- Introduction

	2D Vectors in DM, by Kaiochao

		Internally, my 2-dimensional vectors are simply lists of length 2.
		So, you'd access them with the list index operators (see Vector Properties below).
		Unfortunately, this means you can't use operators like +, -, *, or / on them, or else bad things will happen.

	Notes
	1.	Some have aliases (different names, same function) and may be listed together.
	2.	Although they are conceptually different, Coordinates and Vectors are treated the same.
		 That is, this documentation may use both for clarity, but you will only actually be using vector objects.
	3.	I'll also try to write how functions are written on paper.


-1- Common Vectors
		vec2_zero
			The zero vector, <0, 0>.
			It's safe to initialize your vectors with this instead of leave them as null and try to operate with it.
			e.g.
*/

				var velocity[] = vec2_zero

				//  Later on in your code...
					velocity = vec2_add(velocity, acceleration)

				//  If you didn't initialize velocity as a vector, you'd get a run-time error here.

/*
		vec2_i
			The unit vector along the x-axis, <1, 0>.
			I doubt anyone would use this, but whatever.

		vec2_j
			The unit vector along the y-axis, <0, 1>.

		vec2_ni
			-i
			<-1, 0>

		vec2_nj
			-j
			<0, -1>


-2- Vector Properties
		Vector components are accessed with the list index operators.
		e.g.
*/
			x-component of vector v = v[1]
			y-component of vector v = v[2]
/*
		This is because vectors in DM are actually lists!

	-	vec2_mag(vector v)
		vec2_magnitude(...)
		vec2_length(...)
		vec2_len(...)
			|v|
			Returns the magnitude of a vector.

	-	vec2_angle(vector v)
			Returns the angle of a vector.

	-	vec2_print(vector v, [text separator = ",", text prefix = "<", text suffix = ">"])
			Returns a text representation of 'v'.
			By default, it's <x, y>, but you can provide your own formatting.

-3- Vector Functions

	-	vec2(num x, num y)
			<x, y>
			Return a new vector object with given x and y components.

	-	vec2p(num r, angle t)
		vec2_polar(...)
			Return a new vector object with given length and angle.
			A vector from the given polar coordinates (r, theta)

	-	is_vec2(vector v)
		isvec2(...)
			Returns true if v is a vector.
			A recognized vector is a /list of length 2.

	-	vec2_iszero(vector v)
		vec2_is_zero(...)
			Returns true if v is equivalent to the zero vector. 
			Also returns true if v evaluates to false. 

	-	vec2_cmp(vector v, vector u)
		vec2_compare(...)
		vec2_equals(...)
			Returns true if v and u are equivalent vectors:
			- Their x and y components are equal.
			- They have the same magnitude and direction.

	-	vec2_add(vector v, vector u)
			v + u, "v plus u"
			Returns a new vector object with components of v and u added together.

	-	vec2_sub(vector v, vector u)
		vec2_subtract(...)
			v - u, "v minus u"
			Returns a new vector object with components of v and u subtracted.

	-	vec2_to(coordinate a, coordinate b)
			Returns a new vector object that can be added to 'a' to get to 'b'.

	-	vec2_scale(vector v, num s)
		vec2_multiply(...)
			v * s, "v times s"
			Returns a new vector object with v's components multiplied by 's'.

	-	vec2_divide(vector v, num d)
			v / d, "v divided by d"
			Returns a new vector object with v's components divided by 'd'.

	-	vec2_neg(vector v)
		vec2_reverse(...)
			-v, "negative v"
			Returns a new vector object in the opposite direction of 'v'.

	-	vec2_dot(vector v, vector u)
			v . u, "v dot u" (the dot is centered vertically when written, though)
			Returns the dot product, or scalar product, of 'v' and 'u'.

	-	vec2_unit(vector v)
			v / |v|, v^ "unit vector of v, v-hat" (the ^ is on top of the v, not next to it)


-4- Note for Advanced Users
	By default, this library runs using mainly procs.
	However, it may be more efficient when running with definitions instead.
	So, this library contains both versions, but only uses one at a time.
	To use definitions mode, define VEC2_USE_DEFINES in your .dme before the BEGIN_INCLUDE line.
	e.g.
*/
		// END_PREFERENCES

		#define VEC2_USE_DEFINES

		// BEGIN_INCLUDE
		#include <kaiochao\vectors\Vectors.dme>
/*
	tl; dr: Defines mode is faster but forces you to split up operations (see code example at the bottom)

	The reasoning behind this is that the act of calling a proc takes a tiny bit of CPU by itself.
	Using preprocessor definitions, you pretty much won't be calling any non-built-in procedures.
	The only downside to this comes when you're doing multiple operations at once.
	e.g.
*/

		//	written 5 * (<1, 2> + <3, 4>)
		var c[] = vec2_scale(vec2_add(vec2(1, 2), vec2(3, 4)), 5)

/*
	After the functions have been replaced through the preprocessors, that line looks like this:
*/

		var c[] = vec2(5 * vec2(vec2(1, 2)[1] + vec2(3, 4)[2], vec2(1, 2)[2] + vec2(3, 4)[2])[1], 5 * vec2(vec2(1, 2)[1] + vec2(3, 4)[2], vec2(1, 2)[2] + vec2(3, 4)[2])[2])

/*
	I can make it look nicer by adding line breaks and comments:
*/

		var c[] = vec2(
			//	x-component of c is 5 times the x-component of the sum
			5 * vec2(
				//	get the sum of the two vectors
				vec2(1, 2)[1] + vec2(3, 4)[1],
				vec2(1, 2)[2] + vec2(3, 4)[2])[1], //  the [1] at the end gets the x-component of the sum

			//	y-component of c is 5 times the y-component of the sum
			5 * vec2(
				vec2(1, 2)[1] + vec2(3, 4)[1],
				vec2(1, 2)[2] + vec2(3, 4)[2])[2])

/*
	That's 11 list() objects being made in one line, with only one being used in the end.
	So, you'll have to split things up to be more efficient.
	Fortunately, making variables isn't as hard on the CPU as calling a proc, so this mode is still pretty beneficial.
	Also, it makes your code cleaner, in a way.
	e.g.
*/

		var a[] = vec2(1, 2)
		var b[] = vec2(3, 4)
		var sum[] = vec2_add(a, b)
		var c[] = vec2_scale(sum, 5)

/*

	That's it for the documentation. Thanks for downloading my vector library!
		- Kaiochao

*/

#endif
