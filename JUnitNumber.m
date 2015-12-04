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
        Dim % 7 orders of base units and 1 order of angularity
    end
    properties (Constant)
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
            if obj.Dim == JUnitNumber.ZeroDim,
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
    end
end

