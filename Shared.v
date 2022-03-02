Inductive Boole : Set :=
  |igaz   : Boole
  |hamis  : Boole
  |lehet  : Boole.

Definition és (x : Boole) (y : Boole) : Boole :=
  match x with
    |igaz => match y with
      |igaz  => igaz
      |hamis => hamis
      |lehet => lehet
    end
    |hamis => hamis
    |lehet => match y with
      |igaz  => lehet
      |hamis => hamis
      |lehet => lehet
    end
  end.

Definition vagy (x : Boole) (y : Boole) : Boole :=
  match x with
    |igaz   => igaz
    |hamis => y
    |lehet  => match y with
      |igaz  => igaz
      |hamis => lehet
      |lehet => lehet
    end
 end.

Definition nem (x : Boole) : Boole :=
  match x with
    |igaz  => hamis
    |hamis => igaz
    |lehet => lehet
  end.
