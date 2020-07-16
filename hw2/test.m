function [] = test(letterMatrix,letter,std,weight,n)
    noisyLetter = letterMatrix + std*randn(10); 
    figure('Name',"Letter: " + letter + " std: " + std);
    
    subplot(2,n+2,1);
    imshow(letterMatrix,[]);
    title('original');
        
    subplot(2,n+2,2);
    imshow(noisyLetter,[]);
    title('noisy letter');
    fNoisyLetter = sign(noisyLetter);
    subplot(2,n+2,n+4);
    imshow(fNoisyLetter,[]);
    title({'noisy letter',"threshold"});
    %testing part%%%%%%%%%%%%%%%%%%%%%%%

    fEstVector = fNoisyLetter(:);


    for i=1:n
        estVector = weight*fEstVector;
        fEstVector = sign(estVector);

        estMat = reshape(estVector,10,10);
        subplot(2,n+2,2+i);
        imshow(estMat,[]);
        title("iteration" + i);

        fEstMat = reshape(fEstVector,10,10);
        subplot(2,n+2,n+i+4);
        imshow(fEstMat,[]);
        title({"iteration" + i , "threshold"});
    end
end

