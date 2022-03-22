int: v;
int: b;
int: r;
array[1..v,1..b]  of var bool: portfolios;
array[1..v] of var set of 1..b: portfolios_sets; 

%Smarter bound for the objective variable based on a paper
float: rv_b = r*v/b;
int: floor_sq = pow(floor(rv_b),2);
int: ceil_sq = pow(ceil(rv_b),2);
int: rv_b_mod = r*v mod b; 
int: numerator = ceil_sq * rv_b_mod + floor_sq * (b - rv_b_mod) - r*v;
int: bound = ceil(numerator / (v*(v-1)));

var bound..b: lambda;


constraint forall (i in 1..v)(
    sum(row(portfolios,i)) = r
);

constraint forall (i in 1..v)(
    card(portfolios_sets[i]) = r
);



constraint max(i,j in 1..v where i<j)(
    sum([portfolios[i,k]*portfolios[j,k] | k in 1..b]) 
) = lambda;

constraint max(i,j in 1..v where i<j)(
    card(portfolios_sets[i] intersect portfolios_sets[j])
) = lambda;




%Further symmetry breaking
include "lex2.mzn";
constraint symmetry_breaking_constraint(lex2(portfolios));

%Channeling
include "link_set_to_booleans.mzn";
constraint forall (i in 1..v)(
    link_set_to_booleans(portfolios_sets[i], row(portfolios,i))
);


solve ::
    seq_search(
        [
            int_search(
                array1d(portfolios), input_order, indomain_max
            ),
            set_search(
                portfolios_sets, input_order, indomain_max
            ),
            int_search([lambda], input_order, indomain_min)
        ]
    ) minimize lambda;