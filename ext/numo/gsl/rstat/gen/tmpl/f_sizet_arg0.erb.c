/*
  @overload <%=name%>

  <%= description %>
*/
<% set n_arg:0 %>
static VALUE
<%=c_func%>(VALUE self)
{
    <%=struct%> *w;

    TypedData_Get_Struct(self, <%=struct%>, &<%=data_type_var%>, w);
    return SIZET2NUM(gsl_<%=c_func%>(w));
}