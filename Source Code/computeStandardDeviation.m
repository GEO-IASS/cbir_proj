function sd = computeStandardDeviation(v)

m = sum(v) / size(v, 1);

for i = 1 : size(v, 1)
    v(i, :) = (v(i, :) - m).^2;
end

sd = sqrt(sum(v) / size(v, 1));