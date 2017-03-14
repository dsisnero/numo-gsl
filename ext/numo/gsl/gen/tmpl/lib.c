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

struct opt_d_u {double d; unsigned int u;};

<% id_decl.each do |x| %>
<%= x %><% end %>

<% children.each do |c|%>
<%= c.result %>

<% end %>

void
Init_<%=lib_name%>(void)
{
    VALUE mNumo, mG;

    mNumo = rb_define_module("Numo");
    mG = rb_define_module_under(mNumo, "GSL");
    <% set namespace_var:"mG" %>

    <% id_assign.each do |x| %>
    <%= x %><% end %>

    <% children.each do |c| %>
    <%= c.call_init %><% end %>
}
