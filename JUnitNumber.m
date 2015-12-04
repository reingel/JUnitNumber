%
% Unit Class
%
% Created by Soonkyu Jeong
% Creation Date : 2015.11.19
% Last Modified : 2015.11.19
%

% base units
% Length Mass Time ElectricCurrent ThermodynamicTemperature
% m      kg   s    A               K

classdef JUnitNumber
    properties
        Value
    end
    properties (SetAccess = private)
        Dim % 7 orders of base units and 1 order of angularity
    end
    properties (Constant, Hidden)
        nBasDim = 8;
        ZeroDim = int8(zeros(1,8));
    end
    methods
        function obj = JUnitNumber(arg)
            if nargin == 1,
                if isnumeric(arg),
                    obj.Value = arg;
                    obj.Dim = JUnitNumber.ZeroDim;
                elseif isstr(arg),
                    obj.Value = 1;
                    obj.Dim = JUnitNumber.ZeroDim;
                    switch arg,
                        case 'm',
                            obj.Dim(1) = int8(1);
                        case 'kg',
                            obj.Dim(2) = int8(1);
                        case 's',
                            obj.Dim(3) = int8(1);
                        case 'A',
                            obj.Dim(4) = int8(1);
                        case 'K',
                            obj.Dim(5) = int8(1);
                        case 'rad',
                            obj.Dim(8) = int8(1);
                        otherwise,
                            error('Argument must be a valid string');
                    end
                else
                    error('Argument must be numeric or string');
                end
            end
        end
        function st = isDimless(obj)
            if sum(obj.Dim == JUnitNumber.ZeroDim) == JUnitNumber.nBasDim,
                st = logical(1);
            else
                st = logical(0);
            end
        end
        function r = plus(o1,o2)
            is1 = isa(o1,'JUnitNumber');
            is2 = isa(o2,'JUnitNumber');
            if is1 && is2,
                if o1.Dim == o2.Dim,
                    r = JUnitNumber([o1.Value] + [o2.Value]);
                    r.Dim = o1.Dim;
                else
                    error('JUnitNumber::plus dimension mismatch');
                end
            else
                error('JUnitNumber::plus dimension mismatch');
            end
        end
        function r = uplus(obj)
            r = obj;
        end
        function r = minus(o1,o2)
            is1 = isa(o1,'JUnitNumber');
            is2 = isa(o2,'JUnitNumber');
            if is1 && is2,
                if o1.Dim == o2.Dim,
                    r = JUnitNumber([o1.Value] - [o2.Value]);
                    r.Dim = o1.Dim;
                else
                    error('JUnitNumber::minus dimension mismatch');
                end
            else
                error('JUnitNumber::minus dimension mismatch');
            end
        end
        function r = uminus(obj)
            r = JUnitNumber(-obj.Value);
            r.Dim = obj.Dim;
        end
        function r = mtimes(o1,o2)
            is1 = isa(o1,'JUnitNumber');
            is2 = isa(o2,'JUnitNumber');
            if ~is1 && is2,
                r = JUnitNumber([o1] * [o2.Value]);
                r.Dim = o2.Dim;
            elseif is1 && ~is2,
                r = JUnitNumber([o1.Value] * [o2]);
                r.Dim = o1.Dim;
            elseif is1 && is2,
                r = JUnitNumber([o1.Value] * [o2.Value]);
                r.Dim = o1.Dim + o2.Dim;
            end
        end
        function r = times(o1,o2)
            is1 = isa(o1,'JUnitNumber');
            is2 = isa(o2,'JUnitNumber');
            if ~is1 && is2,
                r = JUnitNumber([o1] .* [o2.Value]);
                r.Dim = o2.Dim;
            elseif is1 && ~is2,
                r = JUnitNumber([o1.Value] .* [o2]);
                r.Dim = o1.Dim;
            elseif is1 && is2,
                r = JUnitNumber([o1.Value] .* [o2.Value]);
                r.Dim = o1.Dim + o2.Dim;
            end
        end
        function r = mpower(o1,o2)
            is1 = isa(o1,'JUnitNumber');
            is2 = isa(o2,'JUnitNumber');
            if ~is2, % number
                if o2 == floor(o2),
                    r = JUnitNumber([o1.Value] ^ [o2]);
                    r.Dim = [o1.Dim] * [o2];
                else
                    error('JUnitNumber::mpower power value must be an integer');
                end
            else
                if is2.isDimless,
                    if o2.Value == floor(o2.Value),
                        r = JUnitNumber([o1.Value] ^ [o2.Value]);
                        if is1,
                            r.Dim = [o1.Dim] * [o2.Value];
                        else
                            r.Dim = JUnitNumber.ZeroDim;
                        end
                    end
                else
                    error('JUnitNumber::mpower dimension mismatch');
                end
            end
        end
        function r = power(o1,o2)
            is1 = isa(o1,'JUnitNumber');
            is2 = isa(o2,'JUnitNumber');
            if ~is2, % number
                if o2 == floor(o2),
                    r = JUnitNumber([o1.Value] .^ [o2]);
                    r.Dim = [o1.Dim] * [o2];
                else
                    error('JUnitNumber::power power value must be an integer');
                end
            else
                if is2.isDimless,
                    if o2.Value == floor(o2.Value),
                        r = JUnitNumber([o1.Value] .^ [o2.Value]);
                        if is1,
                            r.Dim = [o1.Dim] * [o2.Value];
                        else
                            r.Dim = JUnitNumber.ZeroDim;
                        end
                    end
                else
                    error('JUnitNumber::power dimension mismatch');
                end
            end
        end
        function r = mldivide(o1,o2)
            is1 = isa(o1,'JUnitNumber');
            is2 = isa(o2,'JUnitNumber');
            if ~is1 && is2,
                r = JUnitNumber([o1] \ [o2.Value]);
                r.Dim = -o2.Dim;
            elseif is1 && ~is2,
                r = JUnitNumber([o1.Value] \ [o2]);
                r.Dim = o1.Dim;
            elseif is1 && is2,
                r = JUnitNumber([o1.Value] \ [o2.Value]);
                r.Dim = o1.Dim - o2.Dim;
            end
            
            if r.isDimless, % return a number, not a class
                r = r.Value;
            end
        end
        function r = mrdivide(o1,o2)
            is1 = isa(o1,'JUnitNumber');
            is2 = isa(o2,'JUnitNumber');
            if ~is1 && is2,
                r = JUnitNumber([o1] / [o2.Value]);
                r.Dim = -o2.Dim;
            elseif is1 && ~is2,
                r = JUnitNumber([o1.Value] / [o2]);
                r.Dim = o1.Dim;
            elseif is1 && is2,
                r = JUnitNumber([o1.Value] / [o2.Value]);
                r.Dim = o1.Dim - o2.Dim;
            end
            
            if r.isDimless, % return a number, not a class
                r = r.Value;
            end
        end
        function r = ldivide(o1,o2)
            is1 = isa(o1,'JUnitNumber');
            is2 = isa(o2,'JUnitNumber');
            if ~is1 && is2,
                r = JUnitNumber([o1] .\ [o2.Value]);
                r.Dim = -o2.Dim;
            elseif is1 && ~is2,
                r = JUnitNumber([o1.Value] .\ [o2]);
                r.Dim = o1.Dim;
            elseif is1 && is2,
                r = JUnitNumber([o1.Value] .\ [o2.Value]);
                r.Dim = o1.Dim - o2.Dim;
            end
            
            if r.isDimless, % return a number, not a class
                r = r.Value;
            end
        end
        function r = rdivide(o1,o2)
            is1 = isa(o1,'JUnitNumber');
            is2 = isa(o2,'JUnitNumber');
            if ~is1 && is2,
                r = JUnitNumber([o1] ./ [o2.Value]);
                r.Dim = -o2.Dim;
            elseif is1 && ~is2,
                r = JUnitNumber([o1.Value] ./ [o2]);
                r.Dim = o1.Dim;
            elseif is1 && is2,
                r = JUnitNumber([o1.Value] ./ [o2.Value]);
                r.Dim = o1.Dim - o2.Dim;
            end
            
            if r.isDimless, % return a number, not a class
                r = r.Value;
            end
        end
        function r = eq(o1,o2)
            is1 = isa(o1,'JUnitNumber');
            is2 = isa(o2,'JUnitNumber');
            
            if ~isDimEqual(o1,o2),
                error('Dimension mismatch');
            end
            
            if ~is1 && is2,
                r = [o1] == [o2.Value];
            elseif is1 && ~is2,
                r = [o1.Value] == [o2];
            elseif is1 && is2,
                r = [o1.Value] == [o2.Value];
            end
        end
        function r = ne(o1,o2)
            is1 = isa(o1,'JUnitNumber');
            is2 = isa(o2,'JUnitNumber');
            
            if ~isDimEqual(o1,o2),
                error('Dimension mismatch');
            end
            
            if ~is1 && is2,
                r = [o1] ~= [o2.Value];
            elseif is1 && ~is2,
                r = [o1.Value] ~= [o2];
            elseif is1 && is2,
                r = [o1.Value] ~= [o2.Value];
            end
        end
        function r = lt(o1,o2)
            is1 = isa(o1,'JUnitNumber');
            is2 = isa(o2,'JUnitNumber');
            
            if ~isDimEqual(o1,o2),
                error('Dimension mismatch');
            end
            
            if ~is1 && is2,
                r = [o1] < [o2.Value];
            elseif is1 && ~is2,
                r = [o1.Value] < [o2];
            elseif is1 && is2,
                r = [o1.Value] < [o2.Value];
            end
        end
        function r = gt(o1,o2)
            is1 = isa(o1,'JUnitNumber');
            is2 = isa(o2,'JUnitNumber');
            
            if ~isDimEqual(o1,o2),
                error('Dimension mismatch');
            end
            
            if ~is1 && is2,
                r = [o1] > [o2.Value];
            elseif is1 && ~is2,
                r = [o1.Value] > [o2];
            elseif is1 && is2,
                r = [o1.Value] > [o2.Value];
            end
        end
        function r = le(o1,o2)
            is1 = isa(o1,'JUnitNumber');
            is2 = isa(o2,'JUnitNumber');
            
            if ~isDimEqual(o1,o2),
                error('Dimension mismatch');
            end
            
            if ~is1 && is2,
                r = [o1] <= [o2.Value];
            elseif is1 && ~is2,
                r = [o1.Value] <= [o2];
            elseif is1 && is2,
                r = [o1.Value] <= [o2.Value];
            end
        end
        function r = ge(o1,o2)
            is1 = isa(o1,'JUnitNumber');
            is2 = isa(o2,'JUnitNumber');
            
            if ~isDimEqual(o1,o2),
                error('Dimension mismatch');
            end
            
            if ~is1 && is2,
                r = [o1] >= [o2.Value];
            elseif is1 && ~is2,
                r = [o1.Value] >= [o2];
            elseif is1 && is2,
                r = [o1.Value] >= [o2.Value];
            end
        end
    end
    methods (Access = private)
        function st = isDimEqual(o1,o2)
            is1 = isa(o1,'JUnitNumber');
            is2 = isa(o2,'JUnitNumber');
            if ~is1 && is2,
                st = o2.isDimless;
            elseif is1 && ~is2,
                st = o1.isDimless;
            elseif is1 && is2,
                st = sum(o1.Dim == o2.Dim) == JUnitNumber.nBasDim;
            end
        end
    end
end

