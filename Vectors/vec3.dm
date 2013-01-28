/*

	3D Vector Implementation

*/

#define vec3(x, y, z)		list(x, y, z)

//	Common vectors
#define vec3_zero			vec3(0, 0, 0)
#define vec3_i				vec3(1, 0, 0)
#define vec3_j				vec3(0, 1, 0)
#define vec3_k				vec3(0, 0, 1)
#define vec3_ni				vec3(-1, 0, 0)
#define vec3_nj				vec3(0, -1, 0)
#define vec3_nk				vec3(0, 0, -1)

#ifdef VEC3_USE_DEFINES
//	#define versions of the vector functions.

#define is_vec3(v)			(istype(v, /list) && length(v) == 3)
#define vec3_copy(v)		vec3(v[1], v[2], v[3])
#define vec3_cmp(v, u)		(v == u || v[1] == u[1] && v[2] == u[2] && v[3] == u[3])
#define vec3_add(v, u)		vec3(v[1] + u[1], v[2] + u[2], v[3] + u[3])
#define vec3_sub(v, u)		vec3(v[1] - u[1], v[2] - u[2], v[3] - u[3])
#define vec3_to(v, u)		vec3_sub(u, v)
#define vec3_scale(v, s)	vec3(s * v[1], s * v[2], s * v[3])
#define vec3_divide(v, d)	vec3(v[1] / d, v[2] / d, v[3] / d)
#define vec3_neg(v)			vec3(-v[1], -v[2], -v[3])
#define vec3_dot(v, u)		(v[1] * u[1] + v[2] * u[2] + v[3] * u[3])
#define vec3_mag2(v)		vec3_dot(v, v)
#define vec3_mag(v)			sqrt(vec3_mag2(v))
#define vec3_unit(v)		vec3_divide(v, vec3_mag(v))
#define vec3_iszero(v)		(!v || !v[1] && !v[2] && !v[3])
#define vec3_cross(v, u)	vec3(v[2] * u[3] - v[3] * u[2], v[3] * u[1] - v[1] * u[3], v[1] * u[2] - v[2] * u[1])

#else
//	proc versions of the vector functions.

proc
	is_vec3(v[])			return istype(v) && v.len == 3
	vec3_copy(v[])			return v.Copy()
	vec3_cmp(v[], u[])		return v == u || v[1] == u[1] && v[2] == u[2] && v[3] == u[3]
	vec3_add(v[], u[])		return vec3(v[1] + u[1], v[2] + u[2], v[3] + u[3])
	vec3_sub(v[], u[])		return vec3(v[1] - u[1], v[2] - u[2], v[3] - u[3])
	#define vec3_to(v, u)	vec3_sub(u, v)
	vec3_scale(v[], s)		return vec3(s * v[1], s * v[2], s * v[3])
	vec3_divide(v[], d)		return vec3(v[1] / d, v[2] / d, v[3] / d)
	vec3_neg(v[])			return vec3(-v[1], -v[2], -v[3])
	#define vec3_mag2(v)	vec3_dot(v, v)
	#define vec3_mag(v)		sqrt(vec3_mag2(v))
	vec3_dot(v[], u[])		return v[1] * u[1] + v[2] * u[2] + v[3] * u[3]
	vec3_unit(v[])			return vec3_divide(v, vec3_mag(v))
	vec3_iszero(v[])		return !v || !v[1] && !v[2] && !v[3]
	vec3_cross(v[], u[])	return vec3(v[2] * u[3] - v[3] * u[2], v[3] * u[1] - v[1] * u[3], v[1] * u[2] - v[2] * u[1])

#endif

proc/vec3_print(v[], separator = ",", prefix = "<", suffix = ">")
	return "[prefix][v[1]][separator] [v[2]][separator] [v[3]][suffix]"

//	Aliases

#define isvec3(v)			is_vec3(v)
#define vec3_is_zero(v)		vec3_iszero(v)
#define vec3_subtract(v, u)	vec3_sub(v, u)
#define vec3_magnitude(v)	vec3_mag(v)
#define vec3_length(v)		vec3_mag(v)
#define vec3_len(v)			vec3_mag(v)
#define vec3_multiply(v, s)	vec3_scale(v, s)
#define vec3_reverse(v)		vec3_neg(v)
#define vec3_compare(v, u)	vec3_cmp(v, u)
#define vec3_equals(v, u)	vec3_cmp(v, u)

//	End of file
