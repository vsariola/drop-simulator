function value = nth_output(N,fcn,varargin)
  [valuecell{1:max(N)}] = fcn(varargin{:});
  value = [valuecell{N}];
end