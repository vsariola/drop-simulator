function convert_pillar_data_xls_to_mat
    filename = '../../data/small pillars.xlsx';    
    
    rets = {};
    retp = {};    
    
    for i = 1:4    
        rets{i} = readlinear(i,'B2:K11');        
    end           
    retp{1} = readlinear(5,'P20:Y29');
    retp{2} = readlinear(5,'P3:Y12');
    retp{3} = readlinear(5,'B3:K12');
    retp{4} = readlinear(5,'B20:K29');
    
    filename = '../../data/contact angles and big pillars.xlsx';    
    rets{5} = readlinear(2,'A5:A7');        
    retp{5} = readlinear(2,'B5:B7');        
    rets{6} = readlinear(2,'D5:D7');        
    retp{6} = readlinear(2,'E5:E7');        
    rets{7} = readlinear(2,'G5:G7');        
    retp{7} = readlinear(2,'H5:H7');        
    rets{8} = readlinear(2,'J5:J7');        
    retp{8} = readlinear(2,'K5:K7');        
    rets{9} = readlinear(2,'M5:M7');        
    retp{9} = readlinear(2,'N5:N7');      
    
    retr = [10 20 35 50 100 150 200 250 400]; % um
    % Note that the excel file lists them as diameters

    radii = retr;
    snapins = rets;
    pulloffs = retp;
    
    if ~exist('../../output','dir')
        mkdir('../../output');
    end
    
    save('../../output/pillar_data.mat','radii','snapins','pulloffs');
    
    function ret = readlinear(sheet,range)
        ret = xlsread(filename,sheet,range);
        ret = ret(:);
    end
end