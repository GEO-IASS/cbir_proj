function [rank, ac] = queryDatabaseGUI(img, base, rgbHiss)

ac = 0;
hitCount = 1;

qImg = quantizeRGB(img, 6);
rgbHis = computeRGBHis(qImg, 216);

distances = zeros(1000, 1);
for i = 1 : 1000
    distances(i) = 0.5 * vectorDistance(rgbHis(:, 1) + rgbHis(:, 2), rgbHiss(:, 1, i) + rgbHiss(:, 2, i))...
            + 0.5 * vectorDistance(rgbHis, rgbHiss(:, :, i));
end

[sortedResult, rank] = sort(distances);

for j = 1 : 1000
    if rank(j) >= base + 1 && rank(j) <= base + 100
        ac = ac + hitCount / j;
        hitCount = hitCount + 1;
    end
end

ac = ac / 100;