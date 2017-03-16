/*
  <%= file_name %>
  Ruby/Numo::GSL - GSL wrapper for Ruby/Numo::NArray

  created on: 2017-03-11
  Copyright (C) 2017 Masahiro Tanaka
*/

#include <ruby.h>
#include "numo/narray.h"
#include "numo/template.h"
<% include_files.each do |f| %>
#include <<%=f%>>
<% end %>

#if SIZEOF_INT == 4
#define cInt numo_cInt32
#define cUInt numo_cUInt32
#elif SIZEOF_INT == 8
#define cInt numo_cInt64
#define cUInt numo_cUInt64
#endif

static VALUE <%=ns_var%>;

struct opt_d_u {double d; unsigned int u;};

<% id_decl.each do |x| %>
<%= x %><% end %>

<% children.each do |c|%>
<%= c.result %>

<% end %>

void
Init_<%=lib_name%>(void)
{
    VALUE mN;
    mN = rb_define_module("Numo");
    <%=ns_var%> = rb_define_module_under(mN, "GSL");

    <% id_assign.each do |x| %>
    <%= x %><% end %>

    <% children.each do |c| %>
    <%= c.call_init %><% end %>
}