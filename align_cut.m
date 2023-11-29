function [ax,ay] = align_cut(x,y)
%ALIGN_CUT input two of correlated Data BUT not aligned,
%Return the aligned data, and abandon the left data. 

% USAGE：
% [ AlignData1, AlignData2 ] = align_cut( Ori_Data1, Ori_Data2 )
% The two original data should have SAME SAMPLE RATE.
%
[cor,~] = xcov(x,y);

[~, index] = max(cor);

len = max(length(x),length(y));
if index <= len                   %align the start point first
    ay = y(len-index+1:end);
    ax = x;
else
    ax = x(index-len+1:end);
    ay = y;
end

if length(ax)>length(ay)         %cut the unaligned end points
    ax = ax(1:length(ay));
%     ay = ay;
else
%     ax = ax;
    ay = ay(1:length(ax));
end

