% x is a vector of positions of the queens ( each queen has only one
% position), the position represnts the column index of the queen in the
% chess board to assure that each queen is alone on line and column
function [err, sol]=nQueen(x)

    n=numel(x);
    
    % Z contains the indices of the queens after sorting
    [~, Z]=sort(x);
    Y=1:n;
    
    % create chessBoard martix with no queen
    Hit=zeros(n,n);
    
    err=0;
    for i=1:n-1
        for j=i+1:n
            % if the queen is not alone on diagonals, then increment the
            % number of error
            if abs(Z(i)-Z(j))==abs(Y(i)-Y(j))
                Hit(i,j)=1;
                Hit(j,i)=1;
                err=err+1;
            end
        end
    end
    
    sol.Z=Z;
    sol.Y=Y;
    sol.Hit=Hit;
    sol.err=err;

end