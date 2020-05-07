:- module(game_interact,[]).

/** <module> handle interactions from the game web page to the server via pengine
 *
 * this module gets imported into the sandbox
 */

:- use_module(library(pengines)).
:- use_module(library(http/http_session)).
:- use_module(library(hostname)).

:- use_module(larkc_client).

%% :- use_module(larkc_helper).
%% :- use_module(larkc_hold).

:- use_module(util).

:- dynamic current_process/4, current_location/3.

:- multifile sandbox:safe_primitive/1.

