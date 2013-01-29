/*
	2D Vector Implementation
*/

//	Constructors
#ifndef VEC2_USE_DATUMS
	#define vec2(x, y) list(x, y)
	#define vec2 list
#endif

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

#elif defined(VEC2_USE_DATUMS)
//	These require v and u to be vec2 variables.
	#define vec2_copy(v)		v.Copy()
	#define vec2_cmp(v, u)		v.Equals(u)
	#define vec2_add(v, u)		v.Add(u)
	#define vec2_sub(v, u)		v.Subtract(u)
	#define vec2_to(v, u)		u.Subtract(v)
	#define vec2_scale(v, s)	v.Scale(s)
	#define vec2_divide(v, d)	v.Divide(s)
	#define vec2_neg(v)			v.Negate()
	#define vec2_dot(v, u)		v.Dot()
	#define vec2_mag2(v)		v.Magnitude2()
	#define vec2_mag(v)			v.Magnitude()
	#define vec2_angle(v)		v.Angle()
	#define vec2_unit(v)		v.Unit()
	#define vec2_iszero(v)		v.IsZero()

proc
	vec2(x, y) return new /vec2 (x, y)
	is_vec2(vec2/v) return istype(v)

vec2
	var x = 0, y = 0

	New(x, y)
		if(x) src.x = x
		if(y) src.y = y

	proc
		Copy() return vec2(x, y)
		Equals(vec2/v) return src == v || x == v.x && y == v.y

		Add(vec2/v)
			if(args.len == 1) return vec2(x + v.x, y + v.y)
			else
				var vec2/r = Copy()
				for(v in args) { r.x += v.x; r.y += v.y}
				return r

		Subtract(vec2/v)
			if(args.len == 1) return vec2(x - v.x, y - v.y)
			else
				var vec2/r = Copy()
				for(v in args) { r.x -= v.x; r.y -= v.y }
				return r

		Scale(s) return vec2(x * s, y * s)
		Divide(d) return vec2(x / d, y / d)
		Negate() return vec2(-x, -y)

		Dot(vec2/v) return x * v.x + y * v.y

		Magnitude() return sqrt(Magnitude2())
		Magnitude2() return Dot(src)

		Angle() return _vec2_atan2(x, y)

		Unit() return Divide(Magnitude())

		NonZero() return x || y
		IsZero() return !NonZero()

#else
//	proc versions of the vector functions.
proc
	is_vec2(v[])			return istype(v) && v.len == 2
	vec2_copy(v[])			return v.Copy()
	vec2_cmp(v[], u[])		return v == u || v[1] == u[1] && v[2] == u[2]
	vec2_add(v[], u[])		return vec2(v[1] + u[1], v[2] + u[2])
	vec2_sub(v[], u[])		return vec2(v[1] - u[1], v[2] - u[2])
	#define vec2_to(v, u)	vec2_sub(u, v)
	vec2_scale(v[], s)		return vec2(s * v[1], s * v[2])
	vec2_divide(v[], d)		return vec2(v[1] / d, v[2] / d)
	vec2_neg(v[])			return vec2(-v[1], -v[2])
	#define vec2_mag2(v)	vec2_dot(v, v)
	#define vec2_mag(v)		sqrt(vec2_mag2(v))
	vec2_dot(v[], u[])		return v[1] * u[1] + v[2] * u[2]
	#define vec2_angle(v)	_vec2_atan2(v)
	vec2_unit(v[])			return vec2_divide(v, vec2_mag(v))
	vec2_iszero(v[])		return !v || !v[1] && !v[2]
#endif

//	Some functions are better off in non-definitions mode.
proc
	/**
	 * Because definitions can't support optional parameters,
	 * and this is pretty customizable.
	 *
	 * @param	v to be converted to formatted text
	 * @param	separator goes between the components, followed by a space
	 * @param	prefix goes before the sequence of components
	 * @param	suffix goes after the sequence of components
	 * @return	the vector converted to a nice string
	 * 			e.g.	vec2_print(vec2(1, 2))
	 * 					=> "<1, 2>"
	 * 					vec2_print(vec2(3, 4), "{", "}")
	 * 					=> "{1, 2}"
	 */
	vec2_print(v[], prefix = "<", suffix = ">", separator = ",")
		return "[prefix][v[1]][separator] [v[2]][suffix]"

	/**
	 * @param	x the x-component of a vector with magnitude
	 * 			The vector itself can also be given.
	 * @param	y if a vector wasn't passed to x, this is the y-component
	 * @param	d a length can be supplied for optimization purposes
	 * 			if it has already been given
	 * @return	the angle of the vector given as x or described by x and y
	*/
	_vec2_atan2(x, y, d)
		if(is_vec2(x))
			y = x[2]
			x = x[1]
		if(d && (x || y))
			. = arccos(x / (d || sqrt(x * x + y * y)))
			return y >= 0 ? . : -.
		return 0

	#ifndef VEC2_USE_DATUMS
	pos2_dist(a[], b[])
		return vec2_mag(vec2_to(a, b))
	#else
	pos2_dist(vec2/a, vec2/b)
		var vec2/r = b.Subtract(a)
		return r.Magnitude()
	#endif

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