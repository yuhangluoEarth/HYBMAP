function cellwt = GetAreaWeight(varargin)
if nargin == 1
    deg = varargin{1};
    rows=180/deg;
    cols=360/deg;
    halfSize = deg/2;
    tmp = ones(rows,cols,'single');
    R = makerefmat(-180+halfSize, 90-halfSize, deg, -deg);
    EP = almanac('earth','wgs84','kilometers');
    [~,wt] = areamat((tmp>-1),R,EP);
    cellwt = repmat(wt,[1 cols]);
elseif nargin == 2
    rows=varargin{1};
    cols=varargin{2};
    tmp = ones(rows,cols,'single');
    R = makerefmat(-180+(360/cols)/2, 90-(180/rows)/2, 360/cols, -180/rows);
    EP = almanac('earth','wgs84','kilometers');
    [~,wt] = areamat((tmp>-1),R,EP);
    cellwt = repmat(wt,[1 cols]);
else
    error('not support!');
end
end