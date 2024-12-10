%% Brainf interpreter in Erlang.
-module(bf).

-export([interpret/4, main/1]).

-author("arnu515").
-license("MIT").

interpret(_S, _P, done, _) -> 
	%io:format(standard_error, "~w~n", [{S, P}]),
	ok;
interpret(State, Popped, Op, Next) ->
	{OpN, NextN} = case Next of
		[] -> {done, []}; [OpNext|NextNext] -> {OpNext, NextNext}
	end,
	[Curr|Rest] = State,
	{StateN, PoppedN} = case Op of
		$+ -> {[Curr+1|Rest], Popped};
		$- -> {[Curr-1|Rest], Popped};
		$. -> 
			io:put_chars([Curr]),
			{State, Popped};
		$, -> 
			case io:get_chars([], 1) of
				[T] -> {[T|Rest], Popped};
				eof -> {[0|Rest], Popped}
			end;
		$> ->
			case Popped of
				[] -> {[0|State], Popped};
				[H|T] -> {[H|State], T}
			end;
		$< -> {Rest, [Curr|Popped]};
		_ -> {State, Popped}
	end,
	interpret(StateN, PoppedN, OpN, NextN).

interpret_all_files([]) -> ok;
interpret_all_files([File|Files]) ->
	case file:read_file(File) of
		{ok, <<First, Contents/binary>>} -> interpret([0], [], First, bitstring_to_list(Contents));
		{error, Reason} -> throw(Reason);
		_ -> throw('Empty file')
	end,
	interpret_all_files(Files).

main([]) -> io:put_chars(standard_error, "ERROR: No files specified."), exit(1);
main(Files) ->
	interpret_all_files(Files).

