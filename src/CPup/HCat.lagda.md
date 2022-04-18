```agda
{-# OPTIONS --type-in-type --no-termination-check #-}

open import 1Lab.Path
open import 1Lab.Equiv
open import 1Lab.Type hiding (id; _*_)
open import 1Lab.HLevel
-- open import Data.Nat.Base

module CPup.HCat where
```

# Internal (ω,n)-categories

```agda
pred : Nat → Nat
pred (suc n) = n
pred zero = zero

record Cat (n : Nat) : Type
Ob' : ∀ {n} → Cat n → Type
Hom' : ∀ {n} → (C : Cat n) → (x y : Ob' C) → Cat (pred n)
Cats : (n : Nat) → Cat (suc n)

record Func {n} (C D : Cat n) : Type
* : ∀ {n} → Cat n
Prod : ∀ {n} → Cat n → Cat n → Cat n

record Cat n where
  coinductive
  field
    Ob : Type
    Hom : Ob → Ob → Cat (pred n)
    id : ∀ {x} → Ob' (Hom x x)
    _○_ : ∀ {x y z} → Func (Prod (Hom y z) (Hom x y)) (Hom x z)
    _¯¹ : ∀ {x y} → n ≡ 0 → Func (Hom x y) (Hom y x)
    -- idl : ∀ {x y} → ωGrpd-NT idl-Func ωGrpd-Func-id
    -- idl : ∀ {x y} (f : Ob' (Hom x y)) → Ob' (Hom' (Hom x y) (id ○ f) f)
    -- idr : ∀ {x y} (f : Ob' (Hom x y)) → Ob' (Hom' (Hom x y) (f ○ id) f)
    -- assoc : ∀ {w x y z}
    --   (f : Ob' (Hom y z))
    --   (g : Ob' (Hom x y))
    --   (h : Ob' (Hom w x))
    --   → Ob' (Hom' (Hom w z) (f ○ (g ○ h)) ((f ○ g) ○ h))
Ob' = Cat.Ob
Hom' = Cat.Hom
open Cat public

record Func {n} C D where
  coinductive
  field
    map-Ob : C .Ob → D .Ob
    map-Hom : ∀ {x y} → Func (C .Hom x y) (D .Hom (map-Ob x) (map-Ob y))
    -- TODO preservation of id, composition, inverse
open Func

Prod C D .Ob = C .Ob × D .Ob
Prod C D .Hom (x₁ , x₂) (y₁ , y₂) = Prod (C .Hom x₁ y₁) (D .Hom x₂ y₂)
Prod C D .id = C .id , D .id
Prod C D ._○_ = go (C ._○_) (D ._○_)
  where
    go : ∀ {n} {C₁₁ C₁₂ C₂₁ C₂₂ D₁ D₂ : Cat n}
       → Func (Prod C₁₁ C₁₂) D₁
       → Func (Prod C₂₁ C₂₂) D₂
       → Func (Prod (Prod C₁₁ C₂₁)
                    (Prod C₁₂ C₂₂))
              (Prod D₁ D₂)
    go F₁ F₂ .map-Ob ((x₁₁ , x₂₁) , (x₁₂ , x₂₂)) =
      F₁ .map-Ob (x₁₁ , x₁₂) , F₂ .map-Ob (x₂₁ , x₂₂)
    go F₁ F₂ .map-Hom =
      go (F₁ .map-Hom) (F₂ .map-Hom)
Prod C D ._¯¹ n≡0 .map-Ob (f₁ , f₂) = C ._¯¹ n≡0 .map-Ob f₁ , D ._¯¹ n≡0 .map-Ob f₂
Prod C D ._¯¹ n≡0 .map-Hom = ?

* .Ob = ⊤
* .Hom _ _ = *
* .id = tt
* ._○_ .map-Ob _ = tt
* {n} ._○_ .map-Hom = * {pred n} ._○_
* ._¯¹ n≡0 .map-Ob _ = tt
* ._¯¹ n≡0 .map-Hom = * ._¯¹ (λ i → pred (n≡0 i))

-- record NT {C} {D} E F where
--   field
--     η : (x : G .Ob) → H .Hom (E .map-Ob x) (F .map-Ob y) .Ob
--     -- TODO naturality

```
