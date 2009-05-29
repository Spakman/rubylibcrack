#include <ruby.h>
#include <crack.h>
#include "dictconfig.h"

/*
 * Runs FascistCheck and returns if the password is regarded as weak or not.
 * If it is, the class variable @message is set to the value of the error message.
 */
static VALUE t_weak(VALUE self) {
        char *failure_message;
        failure_message = (char *)FascistCheck(STR2CSTR(self), DICTPATH);
        if(failure_message) {
                rb_iv_set(self, "@message", rb_str_new2(failure_message));
                return Qtrue;
        }
        else {
                return Qfalse;
        }
}

/*
 * Runs FascistCheck and returns if the password is regarded as strong or not.
 * If it isn't, the class variable @message is set to the value of the error message.
 */
static VALUE t_strong(VALUE self) {
        VALUE weak;
        weak = t_weak(self);
        if(weak == Qtrue) {
                return Qfalse;
        }
        else {
                return Qtrue;
        }
}

VALUE cPassword;

void Init_rubylibcrack() {
        cPassword = rb_define_class("Password", rb_cString);
        rb_define_attr(cPassword, "message", 1, 0);
        rb_define_method(cPassword, "weak?", t_weak, 0);
        rb_define_method(cPassword, "strong?", t_strong, 0);
}
