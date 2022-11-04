module square (
    input  [2:0] num,
    output [5:0] square_num
);
    // assign square_num[0] = num[0];
    // assign square_num[1] = 0;
    // assign square_num[2] = num[1]&~num[0];
    // assign square_num[3] = (~num[2]&num[1]&num[0])|(num[2]&~num[1]&num[0]);
    // assign square_num[4] = num[2]&(~num[1]|num[0]);
    // assign square_num[5] = num[2]&num[1];

    assign square_num[0] = num[0];

    assign square_num[1] = 0;

    assign square_num[2] =~(
        (
            ~num[1]
        ) 
        | 
        (
            num[0]
        )
    );

    assign square_num[3] =(
        (
            ~(num[2]|~num[1]|~num[0])
        )
        |
        (
            ~(~num[2]|num[1]|~num[0])
        )
    );


    assign square_num[4] =~(
        (
            ~num[2]   
        ) 
        | 
        (
            ~(~num[1]|num[0])
        )
    );

    assign square_num[5] =~(
        (
            ~num[2]
        )
        |
        (
            ~num[1]
        )

    );

endmodule