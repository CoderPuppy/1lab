```agda
open import Cat.Univalent
open import Cat.Prelude

module Cat.Diagram.Terminal {o h} (C : Precategory o h) where
```

<!--
```agda
open import Cat.Morphism C
```
-->

# Terminal objects

An object $\top$ of a category $\mathcal{C}$ is said to be **terminal**
if it admits a _unique_ map from any other object:

```agda
is-terminal : Ob → Type _
is-terminal ob = ∀ x → is-contr (Hom x ob)

record Terminal : Type (o ⊔ h) where
  field
    top : Ob
    has⊤ : is-terminal top
```

We refer to the centre of contraction as `!`{.Agda}. Since it inhabits a
contractible type, it is unique.

```agda
  ! : ∀ {x} → Hom x top
  ! = has⊤ _ .centre

  !-unique : ∀ {x} (h : Hom x top) → ! ≡ h
  !-unique = has⊤ _ .paths

  !-unique₂ : ∀ {x} (f g : Hom x top) → f ≡ g
  !-unique₂ = is-contr→is-prop (has⊤ _)

open Terminal
```

## Uniqueness

If a category has two terminal objects $t_1$ and $t_2$, then there is a
unique isomorphism $t_1 \cong t_2$. We first establish the isomorphism:
Since $t_1$ (resp. $t_2$) is terminal, there is a _unique_ map $!_1 : t_1 \to
t_2$ (resp. $!_2 : t_2 \to t_1$). To show these maps are inverses, we
must show that $!_1 \circ !_2$ is $\id{id}$; But these morphisms
inhabit a contractible space, namely the space of maps into $t_2$, so
they are equal.

```agda
!-invertible : (t1 t2 : Terminal) → is-invertible (! t1 {top t2})
!-invertible t1 t2 = make-invertible (! t2) (!-unique₂ t1 _ _) (!-unique₂ t2 _ _)

⊤-unique : (t1 t2 : Terminal) → top t1 ≅ top t2
⊤-unique t1 t2 = invertible→iso (! t2) (!-invertible t2 t1)
```


Hence, if $C$ is additionally a category, it has a propositional space of
terminal objects:

```agda
⊤-contractible : is-category C → is-prop Terminal
⊤-contractible ccat x1 x2 i .top =
  iso→path C ccat (⊤-unique x1 x2) i

⊤-contractible ccat x1 x2 i .has⊤ ob =
  is-prop→pathp
    (λ i → is-contr-is-prop {A = Hom _
      (iso→path C ccat (⊤-unique x1 x2) i)})
    (x1 .has⊤ ob) (x2 .has⊤ ob) i
```
