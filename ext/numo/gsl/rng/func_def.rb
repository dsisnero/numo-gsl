[{:func_name=>"gsl_rng_alloc",
  :func_type=>"gsl_rng *",
  :args=>[["const gsl_rng_type *", "T"]],
  :desc=>
   "This function returns a pointer to a newly-created\n" +
   "instance of a random number generator of type T.\n" +
   "For example, the following code creates an instance of the Tausworthe\n" +
   "generator,\n" +
   "\n" +
   "gsl_rng * r = gsl_rng_alloc (gsl_rng_taus);\n" +
   "\n" +
   "If there is insufficient memory to create the generator then the\n" +
   "function returns a null pointer and the error handler is invoked with an\n" +
   "error code of GSL_ENOMEM.\n" +
   "\n" +
   "The generator is automatically initialized with the default seed,\n" +
   "gsl_rng_default_seed.  This is zero by default but can be changed\n" +
   "either directly or by using the environment variable GSL_RNG_SEED\n" +
   "(Random number environment variables).\n" +
   "\n" +
   "The details of the available generator types are\n" +
   "described later in this chapter."},
 {:func_name=>"gsl_rng_clone",
  :func_type=>"gsl_rng *",
  :args=>[["const gsl_rng *", "r"]],
  :desc=>
   "This function returns a pointer to a newly created generator which is an\n" +
   "exact copy of the generator r."},
 {:func_name=>"gsl_rng_env_setup",
  :func_type=>"const gsl_rng_type *",
  :args=>[["", "void"]],
  :desc=>
   "This function reads the environment variables GSL_RNG_TYPE and\n" +
   "GSL_RNG_SEED and uses their values to set the corresponding\n" +
   "library variables gsl_rng_default and\n" +
   "gsl_rng_default_seed.  These global variables are defined as\n" +
   "follows,\n" +
   "\n" +
   "extern const gsl_rng_type *gsl_rng_default\n" +
   "extern unsigned long int gsl_rng_default_seed\n" +
   "\n" +
   "The environment variable GSL_RNG_TYPE should be the name of a\n" +
   "generator, such as taus or mt19937.  The environment\n" +
   "variable GSL_RNG_SEED should contain the desired seed value.  It\n" +
   "is converted to an unsigned long int using the C library function\n" +
   "strtoul.\n" +
   "\n" +
   "If you don't specify a generator for GSL_RNG_TYPE then\n" +
   "gsl_rng_mt19937 is used as the default.  The initial value of\n" +
   "gsl_rng_default_seed is zero.\n"},
 {:func_name=>"gsl_rng_fread",
  :func_type=>"int",
  :args=>[["FILE *", "stream"], ["gsl_rng *", "r"]],
  :desc=>
   "This function reads the random number state into the random number\n" +
   "generator r from the open stream stream in binary format.\n" +
   "The random number generator r must be preinitialized with the\n" +
   "correct random number generator type since type information is not\n" +
   "saved.  The return value is 0 for success and GSL_EFAILED if\n" +
   "there was a problem reading from the file.  The data is assumed to\n" +
   "have been written in the native binary format on the same\n" +
   "architecture."},
 {:func_name=>"gsl_rng_free",
  :func_type=>"void",
  :args=>[["gsl_rng *", "r"]],
  :desc=>
   "This function frees all the memory associated with the generator\n" +
   "r."},
 {:func_name=>"gsl_rng_fwrite",
  :func_type=>"int",
  :args=>[["FILE *", "stream"], ["const gsl_rng *", "r"]],
  :desc=>
   "This function writes the random number state of the random number\n" +
   "generator r to the stream stream in binary format.  The\n" +
   "return value is 0 for success and GSL_EFAILED if there was a\n" +
   "problem writing to the file.  Since the data is written in the native\n" +
   "binary format it may not be portable between different architectures."},
 {:func_name=>"gsl_rng_get",
  :func_type=>"unsigned long int",
  :args=>[["const gsl_rng *", "r"]],
  :desc=>
   "This function returns a random integer from the generator r.  The\n" +
   "minimum and maximum values depend on the algorithm used, but all\n" +
   "integers in the range [min,max] are equally likely.  The\n" +
   "values of min and max can be determined using the auxiliary\n" +
   "functions gsl_rng_max (r) and gsl_rng_min (r)."},
 {:func_name=>"gsl_rng_max",
  :func_type=>"unsigned long int",
  :args=>[["const gsl_rng *", "r"]],
  :desc=>
   "gsl_rng_max returns the largest value that gsl_rng_get\n" + "can return."},
 {:func_name=>"gsl_rng_memcpy",
  :func_type=>"int",
  :args=>[["gsl_rng *", "dest"], ["const gsl_rng *", "src"]],
  :desc=>
   "This function copies the random number generator src into the\n" +
   "pre-existing generator dest, making dest into an exact copy\n" +
   "of src.  The two generators must be of the same type."},
 {:func_name=>"gsl_rng_min",
  :func_type=>"unsigned long int",
  :args=>[["const gsl_rng *", "r"]],
  :desc=>
   "gsl_rng_min returns the smallest value that gsl_rng_get\n" +
   "can return.  Usually this value is zero.  There are some generators with\n" +
   "algorithms that cannot return zero, and for these generators the minimum\n" +
   "value is 1."},
 {:func_name=>"gsl_rng_name",
  :func_type=>"const char *",
  :args=>[["const gsl_rng *", "r"]],
  :desc=>
   "This function returns a pointer to the name of the generator.\n" +
   "For example,\n" +
   "\n" +
   "printf (\"r is a '%s' generator\\n\", \n" +
   "        gsl_rng_name (r));\n" +
   "\n" +
   "would print something like r is a 'taus' generator."},
 {:func_name=>"gsl_rng_set",
  :func_type=>"void",
  :args=>[["const gsl_rng *", "r"], ["unsigned long int", "s"]],
  :desc=>
   "This function initializes (or `seeds') the random number generator.  If\n" +
   "the generator is seeded with the same value of s on two different\n" +
   "runs, the same stream of random numbers will be generated by successive\n" +
   "calls to the routines below.  If different values of $s \\geq 1$\n" +
   "s >= 1 are supplied, then the generated streams of random\n" +
   "numbers should be completely different.  If the seed s is zero\n" +
   "then the standard seed from the original implementation is used\n" +
   "instead.  For example, the original Fortran source code for the\n" +
   "ranlux generator used a seed of 314159265, and so choosing\n" +
   "s equal to zero reproduces this when using\n" +
   "gsl_rng_ranlux.  \n" +
   "\n" +
   "When using multiple seeds with the same generator, choose seed values\n" +
   "greater than zero to avoid collisions with the default setting.  \n" +
   "\n" +
   "Note that the most generators only accept 32-bit seeds, with higher\n" +
   "values being reduced modulo $2^{32}$ \n" +
   "2^32.  For generators\n" +
   "with smaller ranges the maximum seed value will typically be lower."},
 {:func_name=>"gsl_rng_size",
  :func_type=>"size_t",
  :args=>[["const gsl_rng *", "r"]],
  :desc=>
   "These functions return a pointer to the state of generator r and\n" +
   "its size.  You can use this information to access the state directly.  For\n" +
   "example, the following code will write the state of a generator to a\n" +
   "stream,\n" +
   "\n" +
   "void * state = gsl_rng_state (r);\n" +
   "size_t n = gsl_rng_size (r);\n" +
   "fwrite (state, n, 1, stream);"},
 {:func_name=>"gsl_rng_state",
  :func_type=>"void *",
  :args=>[["const gsl_rng *", "r"]],
  :desc=>
   "These functions return a pointer to the state of generator r and\n" +
   "its size.  You can use this information to access the state directly.  For\n" +
   "example, the following code will write the state of a generator to a\n" +
   "stream,\n" +
   "\n" +
   "void * state = gsl_rng_state (r);\n" +
   "size_t n = gsl_rng_size (r);\n" +
   "fwrite (state, n, 1, stream);"},
 {:func_name=>"gsl_rng_types_setup",
  :func_type=>"const gsl_rng_type **",
  :args=>[["", "void"]],
  :desc=>
   "This function returns a pointer to an array of all the available\n" +
   "generator types, terminated by a null pointer. The function should be\n" +
   "called once at the start of the program, if needed.  The following code\n" +
   "fragment shows how to iterate over the array of generator types to print\n" +
   "the names of the available algorithms,\n" +
   "\n" +
   "const gsl_rng_type **t, **t0;\n" +
   "\n" +
   "t0 = gsl_rng_types_setup ();\n" +
   "\n" +
   "printf (\"Available generators:\\n\");\n" +
   "\n" +
   "for (t = t0; *t != 0; t++)\n" +
   "  @{\n" +
   "    printf (\"%s\\n\", (*t)->name);\n" +
   "  @}"},
 {:func_name=>"gsl_rng_uniform",
  :func_type=>"double",
  :args=>[["const gsl_rng *", "r"]],
  :desc=>
   "This function returns a double precision floating point number uniformly\n" +
   "distributed in the range [0,1).  The range includes 0.0 but excludes 1.0.\n" +
   "The value is typically obtained by dividing the result of\n" +
   "gsl_rng_get(r) by gsl_rng_max(r) + 1.0 in double\n" +
   "precision.  Some generators compute this ratio internally so that they\n" +
   "can provide floating point numbers with more than 32 bits of randomness\n" +
   "(the maximum number of bits that can be portably represented in a single\n" +
   "unsigned long int)."},
 {:func_name=>"gsl_rng_uniform_int",
  :func_type=>"unsigned long int",
  :args=>[["const gsl_rng *", "r"], ["unsigned long int", "n"]],
  :desc=>
   "This function returns a random integer from 0 to n-1 inclusive\n" +
   "by scaling down and/or discarding samples from the generator r.\n" +
   "All integers in the range [0,n-1] are produced with equal\n" +
   "probability.  For generators with a non-zero minimum value an offset\n" +
   "is applied so that zero is returned with the correct probability.\n" +
   "\n" +
   "Note that this function is designed for sampling from ranges smaller\n" +
   "than the range of the underlying generator.  The parameter n\n" +
   "must be less than or equal to the range of the generator r.\n" +
   "If n is larger than the range of the generator then the function\n" +
   "calls the error handler with an error code of GSL_EINVAL and\n" +
   "returns zero.\n" +
   "\n" +
   "In particular, this function is not intended for generating the full range of\n" +
   "unsigned integer values $[0,2^{32}-1]$ \n" +
   "[0,2^32-1]. Instead\n" +
   "choose a generator with the maximal integer range and zero minimum\n" +
   "value, such as gsl_rng_ranlxd1, gsl_rng_mt19937 or\n" +
   "gsl_rng_taus, and sample it directly using\n" +
   "gsl_rng_get.  The range of each generator can be found using\n" +
   "the auxiliary functions described in the next section."},
 {:func_name=>"gsl_rng_uniform_pos",
  :func_type=>"double",
  :args=>[["const gsl_rng *", "r"]],
  :desc=>
   "This function returns a positive double precision floating point number\n" +
   "uniformly distributed in the range (0,1), excluding both 0.0 and 1.0.\n" +
   "The number is obtained by sampling the generator with the algorithm of\n" +
   "gsl_rng_uniform until a non-zero value is obtained.  You can use\n" +
   "this function if you need to avoid a singularity at 0.0."}]
