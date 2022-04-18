```agda
{-# OPTIONS --type-in-type --no-termination-check #-}

open import 1Lab.Path
open import 1Lab.Equiv
open import 1Lab.Type hiding (id)
open import 1Lab.HLevel

module CPup.InftyGrpd where
```

# Internal ω-Groupoids

```agda
record ωGrpd : Type
Ob' : ωGrpd → Type
Hom' : (G : ωGrpd) → Ob' G → Ob' G → ωGrpd
record ωGrpd-Func (G H : ωGrpd) : Type
ωGrpd-Func-id : ∀ {G} → ωGrpd-Func G G
ωGrpd-Func-○ : ∀ {G} → ωGrpd-Func G G
record ωGrpd-NT {G H : ωGrpd} (E F : ωGrpd-Func G H) : Type
ωGrpd-Prod : ωGrpd → ωGrpd → ωGrpd
ωGrpd-Prod-func : ∀ {G₁ G₂ H₁ H₂}
   → ωGrpd-Func G₁ H₁ → ωGrpd-Func G₂ H₂
   → ωGrpd-Func (ωGrpd-Prod G₁ G₂) (ωGrpd-Prod H₁ H₂)
ωGrpd-Prod-cart : ∀ {G H₁ H₂}
   → ωGrpd-Func G H₁ → ωGrpd-Func G H₂
   → ωGrpd-Func G (ωGrpd-Prod H₁ H₂)

record ωGrpd where
  coinductive
  field
    Ob : Type
    Hom : Ob → Ob → ωGrpd
    id : ∀ {x} → Ob' (Hom x x)
    _○_ : ∀ {x y z} → ωGrpd-Func (ωGrpd-Prod (Hom y z) (Hom x y)) (Hom x z)
    _¯¹ : ∀ {x y} → ωGrpd-Func (Hom x y) (Hom y x)
    idl : ∀ {x y} → ωGrpd-NT idl-Func ωGrpd-Func-id
    -- idl : ∀ {x y} (f : Ob' (Hom x y)) → Ob' (Hom' (Hom x y) (id ○ f) f)
    -- idr : ∀ {x y} (f : Ob' (Hom x y)) → Ob' (Hom' (Hom x y) (f ○ id) f)
    -- assoc : ∀ {w x y z}
    --   (f : Ob' (Hom y z))
    --   (g : Ob' (Hom x y))
    --   (h : Ob' (Hom w x))
    --   → Ob' (Hom' (Hom w z) (f ○ (g ○ h)) ((f ○ g) ○ h))
Ob' = ωGrpd.Ob
Hom' = ωGrpd.Hom
open ωGrpd public

record ωGrpd-Func G H where
  coinductive
  field
    map-Ob : G .Ob → H .Ob
    map-Hom : ∀ {x y} → ωGrpd-Func (G .Hom x y) (H .Hom (map-Ob x) (map-Ob y))
    -- TODO preservation of id, composition, inverse
open ωGrpd-Func

ωGrpd-Func-id .map-Ob x = x
ωGrpd-Func-id .map-Hom = ωGrpd-Func-id

record ωGrpd-NT {G} {H} E F where
  field
    η : (x : G .Ob) → H .Hom (E .map-Ob x) (F .map-Ob y) .Ob
    -- TODO naturality

w3 : ∀ {G₁₁ G₁₂ G₂₁ G₂₂ H₁ H₂}
   → ωGrpd-Func (ωGrpd-Prod G₁₁ G₁₂) H₁
   → ωGrpd-Func (ωGrpd-Prod G₂₁ G₂₂) H₂
   → ωGrpd-Func (ωGrpd-Prod (ωGrpd-Prod G₁₁ G₂₁)
                            (ωGrpd-Prod G₁₂ G₂₂))
                (ωGrpd-Prod H₁ H₂)

ωGrpd-Prod G H .Ob = G .Ob × H .Ob
ωGrpd-Prod G H .Hom (x₁ , x₂) (y₁ , y₂) =
  ωGrpd-Prod (G .Hom x₁ y₁) (H .Hom x₂ y₂)
ωGrpd-Prod G H .id = id G , id H
ωGrpd-Prod G H ._○_ = w3 (G ._○_) (H ._○_)
ωGrpd-Prod G H ._¯¹ = ωGrpd-Prod-func (G ._¯¹) (H ._¯¹)

ωGrpd-Prod-func F₁ F₂ .map-Ob (x₁ , x₂) = F₁ .map-Ob x₁ , F₂ .map-Ob x₂
ωGrpd-Prod-func F₁ F₂ .map-Hom = ωGrpd-Prod-func (F₁ .map-Hom) (F₂ .map-Hom)

w3 F₁ F₂ .map-Ob ((x₁₁ , x₂₁) , (x₁₂ , x₂₂)) =
  F₁ .map-Ob (x₁₁ , x₁₂) , F₂ .map-Ob (x₂₁ , x₂₂)
w3 F₁ F₂ .map-Hom = w3 (F₁ .map-Hom) (F₂ .map-Hom)

-- record isUnivalent (G : ωGrpd) : Type where
--   coinductive
--   field
--     w1 : ∀ {x} → isContr (Σ[ y ∈ _ ] G .Hom x y .Ob)
--     w2 : ∀ {x y} → isUnivalent (G .Hom x y)
```
