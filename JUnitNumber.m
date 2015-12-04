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
    methods(Static)
        function r = ZeroDim()
            r = int8(zeros(1,8));
        end
    end
    methods
        function obj = JUnitNumber(arg)
            if nargin == 1,
                if isnumeric(arg),
                    obj.Value = arg;
                    obj.Dim = obj.ZeroDim;
                elseif isstr(arg),
                    obj.Value = 1;
                    obj.Dim = obj.ZeroDim;
                    switch arg,
                        case 'm',
                            obj.Dim(1) = 1;
                        case 'kg',
                            obj.Dim(2) = 1;
                        case 's',
                            obj.Dim(3) = 1;
                        case 'A',
                            obj.Dim(4) = 1;
                        case 'K',
                            obj.Dim(5) = 1;
                        case 'rad',
                            obj.Dim(8) = 1;
                        otherwise,
                            error('Argument must be a valid string');
                    end
                else
                    error('Argument must be numeric or string');
                end
            end
        end
        function st = isDimless(obj)
            if obj.Dim == ZeroDim,
                st = logical(1);
            else
                st = logical(0);
            end
        end
        function r = plus(o1,o2)
            is1 = isa(o1,'JUnitNumber');
            is2 = isa(o2,'JUnitNumber');
            if o1 && o2,
                if o1.Dim == o2.Dim,
                    r = JUnitNumber([o1.Value] + [o2.Value]);
                    r.Dim = o1.Dim;
                else
                    error('Dimension mismatch');
                end
            else
                error('Dimension mismatch');
            end
        end
        function r = uplus(obj)
            r = obj;
        end
        function r = minus(o1,o2)
            is1 = isa(o1,'JUnitNumber');
            is2 = isa(o2,'JUnitNumber');
            if o1 && o2,
                if o1.Dim == o2.Dim,
                    r = JUnitNumber([o1.Value] - [o2.Value]);
                    r.Dim = o1.Dim;
                else
                    error('Dimension mismatch');
                end
            else
                error('Dimension mismatch');
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
            if ~is2,
                r = JUnitNumber([o1.Value] .* [o2]);
                r.Dim = o1.Dim;
            else
                if is2.isDimless,
                    r = JUnitNumber([o1.Value] .* [o2.Value]);
                    r.Dim = o1.Dim;
                else
                    error('Dimension mismatch');
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
            
            if r.Dim == o1.ZeroDim,
                r = r.Value;
            end
        end
    end
end

