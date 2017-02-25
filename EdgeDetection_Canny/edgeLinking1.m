function bEdge = edgeLinking1(gLoc , tLow , tHigh)

    s = size(gLoc);
    bEdge = zeros(s(1) , s(2));
    sEdge = zeros(s(1) , s(2));
    wEdge = zeros(s(1) , s(2));
    stack = [];
    for r = 1 : s(1) 
        for c  = 1 : s(2) 
            if gLoc(r , c) >= tHigh
                stack = [ stack , r , c];
                bEdge(r , c) = 1;
                sEdge(r , c) = 1;
            end;
            ss = size(stack);
            while(ss(2) >= 2)     
                x = stack(ss(2) - 1);   
                y = stack(ss(2));                 
                
                stack = stack( 1 : ss(2) - 2);
                if( x > 1 && gLoc(x - 1 , y) >= tLow) 
                    bEdge(x - 1 , y) = 1;
                    if(wEdge(x - 1 , y) ~= 1 && sEdge(x - 1 , y) ~= 1)
                     wEdge(x - 1 , y) = 1;
                     stack = [ stack : x - 1 , y];
                    end;
                end;
                if(x < s(1) &&  gLoc(x + 1 , y) >= tLow)  % r
                    bEdge(x + 1 , y) = 1;
                    if(wEdge(x + 1 , y) ~= 1 && sEdge(x + 1 , y) ~= 1)
                    wEdge(x + 1 , y) = 1;
                    stack = [ stack : x + 1 , y];
                     end;
                end;
                
                if(y > 1 && gLoc(x  , y - 1) >= tLow)  % r
                    bEdge(x  , y - 1) = 1;
                    if(wEdge(x , y - 1) ~= 1 && sEdge(x , y - 1) ~= 1 )
                    wEdge(x  , y - 1) = 1;
                     stack = [ stack : x  , y - 1];
                    end;
                end;
                
                if(y < s(2) && gLoc(x  , y + 1) >= tLow)  % r
                    bEdge(x , y + 1) = 1;
                    if(wEdge(x  , y + 1) ~= 1 && sEdge(x  , y + 1) ~= 1)
                    wEdge(x , y + 1) = 1;
                     stack = [ stack : x  , y + 1];
                    end;
                end;
                
                
                 if(x > 1 && y > 1 && gLoc(x - 1  , y - 1) >= tLow)  % r
                    bEdge(x - 1 , y - 1) = 1;
                    if(wEdge(x - 1 , y - 1) ~= 1 && sEdge(x - 1 , y - 1) ~= 1)
                    wEdge(x - 1 , y - 1) = 1;
                     stack = [ stack : x  - 1, y - 1];
                    end;
                end;
                
                 if( y < s(2) && x > 1 && gLoc(x - 1  , y + 1) >= tLow)  % r
                    bEdge(x - 1 , y + 1) = 1;
                    if(wEdge(x - 1 , y + 1) ~= 1 && sEdge(x - 1 , y + 1) ~= 1)
                    wEdge(x - 1 , y + 1) = 1;
                     stack = [ stack : x  - 1, y + 1];
                    end;
                 end
                
                if(x < s(1) &&  y < s(2) &&  gLoc(x + 1  , y + 1) >= tLow)  % r
                    bEdge(x + 1 , y + 1) = 1;
                    if(wEdge(x + 1 , y + 1) ~= 1 && sEdge(x + 1 , y + 1) ~= 1)
                    wEdge(x + 1 , y + 1) = 1;
                     stack = [ stack : x  + 1, y + 1];
                    end;
                end;
                
                if(x < s(1) &&  y > 1 && gLoc(x + 1  , y - 1) >= tLow)  % r
                    bEdge(x + 1 , y - 1) = 1;
                    if(wEdge(x + 1 , y - 1) ~= 1 && sEdge(x + 1 , y - 1) ~= 1)
                    wEdge(x + 1 , y - 1) = 1;
                     stack = [ stack : x  + 1, y - 1];
                    end;
                end;
                
                 ss = size(stack);
            end;
        end;
    end;

figure; imshow(sEdge ,[]); title('Strong Edge');
figure; imshow(wEdge ,[]); title('Binary Image Highlighting Promoted Weak Edges');
end