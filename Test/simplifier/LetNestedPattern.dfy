// RUN: %dafny /compile:0 "%s" > "%t"
// RUN: %diff "%s.expect" "%t"

function method {:simp} simp<T>(t: T): T { t }

function method {:opaque} Foo(x: int): int
{
  42
}

lemma {:simp} Foo_42(x: int)
  ensures Foo(7) == 42
{
  reveal Foo();
}

lemma {:simp} proj0_simp<S, T>(x: S, y: T)
  ensures (x, y).0 == x
{}

lemma {:simp} Foo_dest_x_simp(x: int, y: int)
  ensures FooC(x, y).x == x
{}

datatype ADT = FooC(x: int, y: int)

method letTest() {
  assert simp(Foo(var (FooC(a, b), c) := (FooC(7, 8), 9); a)) == 42;
}