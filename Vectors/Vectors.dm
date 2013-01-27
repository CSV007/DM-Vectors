/*
	2D Vector Implementation
*/

#define vec2(x, y) list(x, y)
#define vec2p(r, t) vec2(r * cos(t), r * sin(t))

//	Common vectors
#define vec2_zero	vec2(0, 0)
#define vec2_i		vec2(1, 0)
#define vec2_j		vec2(0, 1)
#define vec2_ni		vec2(-1, 0)
#define vec2_nj		vec2(0, -1)

#ifdef VEC2_USE_DEFINES

//	#define versions of the vector functions.

	#define is_vec2(v)			(istype(v, /list) && length(v) == 2)
	#define vec2_copy(v)		vec2(v[1], v[2])
	#define vec2_cmp(v, u)		(v == u || v[1] == u[1] && v[2] == u[2])
	#define vec2_add(v, u)		vec2(v[1] + u[1], v[2] + u[2])
	#define vec2_sub(v, u)		vec2(v[1] - u[1], v[2] - u[2])
	#define vec2_to(v, u)		vec2_sub(u, v)
	#define vec2_scale(v, s)	vec2(s * v[1], s * v[2])
	#define vec2_divide(v, d)	vec2(v[1] / d, v[2] / d)
	#define vec2_neg(v)			vec2(-v[1], -v[2])
	#define vec2_dot(v, u)		(v[1] * u[1] + v[2] * u[2])
	#define vec2_mag2(v)		vec2_dot(v, v)
	#define vec2_mag(v)			sqrt(vec2_mag2(v))
	#define vec2_angle(v)		_vec2_atan2(v)
	#define vec2_unit(v)		vec2_divide(v, vec2_mag(v))
	#define vec2_iszero(v)		(!v || !v[1] && !v[2])

#else

//	proc versions of the vector functions.

proc
	is_vec2(v[]) return istype(v) && v.len == 2
	vec2_copy(v[]) return v.Copy()

	vec2_cmp(v[], u[]) return v == u || v[1] == u[1] && v[2] == u[2]

	vec2_add(v[], u[]) return vec2(v[1] + u[1], v[2] + u[2])
	vec2_sub(v[], u[]) return vec2(v[1] - u[1], v[2] - u[2])
	#define vec2_to(v, u) vec2_sub(u, v)

	vec2_scale(v[], s) return vec2(s * v[1], s * v[2])
	vec2_divide(v[], d) return vec2(v[1] / d, v[2] / d)
	vec2_neg(v[]) return vec2(-v[1], -v[2])

	#define vec2_mag2(v) vec2_dot(v, v)
	#define vec2_mag(v) sqrt(vec2_mag2(v))

	vec2_dot(v[], u[]) return v[1] * u[1] + v[2] * u[2]

	#define vec2_angle(v) _vec2_atan2(v)
	vec2_unit(v[]) return vec2_divide(v, vec2_mag(v))

	vec2_iszero(v[]) return !v || !v[1] && !v[2]


#endif

//	vec2_print isn't as customizable as a definition 
//	because they  don't have optional parameters
proc
	vec2_print(v[], separator = ",", prefix = "<", suffix = ">")
		return "[prefix][v[1]][separator] [v[2]][suffix]"

//	This procedure is... very necessary.
//	It's named this way to not conflict with other
//   math libraries or snippets you might be using. 
//	Credit to Lummox JR, by the way. 
proc
	_vec2_atan2(x, y, d)
		if(is_vec2(x))
			y = x[2]
			x = x[1]
		if(x || y)
			. = arccos(x / (d || sqrt(x * x + y * y)))
			return y >= 0 ? . : -.
		return 0

//	Aliases

	#define vec2_polar(r, t) vec2p(r, t)
	#define isvec2(v) is_vec2(v)
	#define vec2_is_zero(v) vec2_iszero(v)
	#define vec2_subtract(v, u) vec2_sub(v, u)
	#define vec2_magnitude(v) vec2_mag(v)
	#define vec2_length(v) vec2_mag(v)
	#define vec2_len(v) vec2_mag(v)
	#define vec2_multiply(v, s) vec2_scale(v, s)
	#define vec2_reverse(v) vec2_neg(v)
	#define vec2_compare(v, u) vec2_cmp(v, u)
	#define vec2_equals(v, u) vec2_cmp(v, u)

//	End of file
