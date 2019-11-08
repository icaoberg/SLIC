function answer = ml_createfile_excl( filefullpath ) 

% STATUS = ML_CREATEFILE_EXCL( FILEFULLPATH)
%
% Create the file FILEFULLPATH only if it does not already exist.
% Return value is 0 if file was successfully created, or 1 if it
% already exists or 2 if it could not be created for some other
% reason (such as non-existent directory or not enough permission).

% Copyright (C) 2006-2015 Murphy Lab
% Carnegie Mellon University
%
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published
% by the Free Software Foundation; either version 2 of the License,
% or (at your option) any later version.
%
% This program is distributed in the hope that it will be useful, but
% WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
% General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
% 02110-1301, USA.
%
% For additional information visit http://murphylab.web.cmu.edu or
% send email to murphy@cmu.edu

% Meel Velliste 5/20/02
% Modified 3/03 EJSR
%     binpath
% Modified 7/05 T. Zhao
%     bincmd
% Modified 1/05/2015 I. Cao-Berg
% Updated method to move away from using mex file

answer = false;
if ~isunix() && ~ismac()
	warning('This function will only work in *nix and MacOSX');
	return
end

if ~isa( filefullpath, 'char' )
	warning('Input argument must be a character' );
end

if ~exist( filefullpath, 'file' )
	try
		[status, message] = system(['touch ' filefullpath]);
		answer = true;
	catch err
		disp('Unable to make temporary file' );
		getReport( err )
	end
else
	warning('File exists on disk');
end
