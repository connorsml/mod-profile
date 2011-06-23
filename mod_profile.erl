%% @author Michael Connors <michael@bring42.net>
%% @copyright 2011 Michael Connors 
%% @date 2011-01-03
%% @doc Simple Profile manager module. 

%% Copyright 2011 Michael Connors
%%
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%% 
%%     http://www.apache.org/licenses/LICENSE-2.0
%% 
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.

-module(mod_profile).
-author("Michael Connors <michael@bring42.net>").

-mod_title("User Profile").
-mod_description("Implements a simple user profile manager.").

%% gen_server exports
-export([init/1]).

%% interface functions
-export([
    event/2
]).

-include_lib("zotonic.hrl").

%% @doc Handle the submit of updating details
event({submit, {updatename, _Args}, _TriggerId, _TargetId}, Context) ->
     case z_auth:is_auth(Context) of
         false ->
             Context;
         true ->
             FirstName = z_context:get_q_validated("name_first", Context),
             LastName = z_context:get_q_validated("name_surname", Context),
             Props = [
                 {name_first, FirstName},
                 {name_surname, LastName}],
             UserID = z_context:get_session(auth_user_id, Context),
             case m_rsc:update(UserID, Props, Context) of
                 {ok, RscId} -> 
                     Context3 = z_render:update("job-status-name", "Updated Successfully", Context),
                     Context3;
                 {error, _} ->
                     Context1 = z_render:update("job-status-name", "Update Failed", Context),
                     Context1
             end
     end;

event({submit, {updatepassword, _Args}, _TriggerId, _TargetId}, Context) ->
     case z_auth:is_auth(Context) of
         false ->
             Context;
         true ->
             Password = z_context:get_q_validated("password_current", Context),
             NewPassword = z_context:get_q_validated("password_new", Context),
             UserName = m_identity:get_username(Context),
             UserId = z_context:get_session(auth_user_id, Context),
             case m_identity:check_username_pw(UserName, Password, Context) of
                 {ok, RscId} -> 
                     case m_identity:set_username_pw(UserId, UserName, NewPassword, Context) of
                         ok ->
                             Context3 = z_render:update("job-status-password", "Updated Successfully", Context),
                             Context3;
                         {error, Reason} ->
                             Context3 = z_render:update("job-status-password", "Update Failed", Context),
                             Context3
                     end;
                 {error, Reason} ->
                     Context3 = z_render:update("job-status-password", "Update Failed", Context),
                     Context3
             end
     end.

init(Context) ->
    ok.

