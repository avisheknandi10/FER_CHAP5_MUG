function tss = tringle_side_signature(pts)
    len = length(pts);
    tss = zeros(nchoosek(len,3),1);
    
    m = 1;
    for i = 1:len
        for j = i+1:len
            for k = j+1:len
                x = pts(i,:);
                y = pts(j,:);
                z = pts(k,:);
                
                a = sum(sqrt((x - y).^2));
                b = sum(sqrt((y - z).^2));
                c = sum(sqrt((z - x).^2));
                      
                tss(m) = (max([a,b,c])-min([a,b,c]))/(a+b+c);
                m = m + 1;
                
            end
        end
    end
end