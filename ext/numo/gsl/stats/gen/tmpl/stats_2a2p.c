static void
<%=c_iter%>(na_loop_t *const lp)
{
    size_t   n;
    char    *p1, *p2, *p3;
    ssize_t  s1, s2;
    double  *opt = (double*)(lp->opt_ptr);

    INIT_COUNTER(lp, n);
    INIT_PTR(lp, 0, p1, s1);
    INIT_PTR(lp, 1, p2, s2);
    p3 = lp->args[2].ptr + lp->args[2].iter[0].pos;

    *(double*)p3 = <%=c_method%>((double*)p1,s1/sizeof(double),
                                 (double*)p2,s2/sizeof(double),n,opt[0],opt[1]);
}

/*
  <%=desc%>
  @overload <%=method%>(<%=method_args%>,[axis0,axis1,..])
  <% desc_param.each do |x|%>
  <%=x%><% end %>
*/
static VALUE
<%=c_func%>(int argc, VALUE *argv, VALUE mod)
{
    VALUE v, reduce;
    double opt[2];
    ndfunc_arg_in_t ain[3] = {{cDF,0},{cDF,0},{sym_reduce,0}};
    ndfunc_arg_out_t aout[1] = {{cDF,0}};
    ndfunc_t ndf = { <%=c_iter%>, STRIDE_LOOP_NIP|NDF_FLAT_REDUCE, 3, 1, ain, aout };

    if (argc<4) {
        rb_raise(rb_eArgError,"wrong number of argument (%d for >=4)",argc);
    }

    opt[0] = NUM2DBL(argv[2]);
    opt[1] = NUM2DBL(argv[3]);

    reduce = na_reduce_dimension(argc-4, argv+4, 2, argv);
    v =  na_ndloop3(&ndf, opt, 2, *argv, reduce);
    return rb_funcall(v,rb_intern("extract"),0);
}