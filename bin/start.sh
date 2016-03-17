#!/bin/bash

erl  -pa ../ebin  -pa ../deps/*/ebin  -eval "packvs:start()"