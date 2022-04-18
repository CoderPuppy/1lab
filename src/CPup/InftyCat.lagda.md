```agda
{-# OPTIONS --type-in-type --no-termination-check --no-positivity-check #-}

open import 1Lab.Type hiding (id; _*_)

module CPup.InftyCat where
```

# Internal (ω,ω)-categories

```agda
record Cat : Type
Ob' : Cat → Type
Hom' : (C : Cat) → (x y : Ob' C) → Cat
Cats : Cat

record isEquiv {C : Cat} {x y : Ob' C} (f : Ob' (Hom' C x y)) : Type
record Equiv {C : Cat} (x y : Ob' C) : Type
record Func (C D : Cat) : Type
record NE {C D : Cat} (F G : Func C D) : Type
record NT {C D : Cat} (F G : Func C D) : Type
* : Cat
Prod : Cat → Cat → Cat

record Cat where
  coinductive
  field
    Ob : Type
    Hom : Ob → Ob → Cat
    id : ∀ {x} → Ob' (Hom x x)
    _○_ : ∀ {x y z} → Func (Prod (Hom y z) (Hom x y)) (Hom x z)
    -- idl : ∀ {x y} → NT {Hom x y} idl-Func Func-id
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

record Func C D where
  coinductive
  field
    map-Ob : C .Ob → D .Ob
    map-Hom : ∀ {x y} → Func (C .Hom x y) (D .Hom (map-Ob x) (map-Ob y))
    -- TODO preservation of id, composition, inverse
open Func

Func-id : ∀ {C} → Func C C
Func-id .map-Ob x = x
Func-id .map-Hom = Func-id

Const : ∀ {C D} → D .Ob → Func C D
Const x .map-Ob _ = x
Const {D = D} x .map-Hom = Const (D .id)

Func-○ : ∀ {C D E} → Func D E → Func C D → Func C E
Func-○ F G .map-Ob x = F .map-Ob (G .map-Ob x)
Func-○ F G .map-Hom = Func-○ (F .map-Hom) (G .map-Hom)

Prod C D .Ob = C .Ob × D .Ob
Prod C D .Hom (x₁ , x₂) (y₁ , y₂) = Prod (C .Hom x₁ y₁) (D .Hom x₂ y₂)
Prod C D .id = C .id , D .id
Prod C D ._○_ = go (C ._○_) (D ._○_)
  where
    go : ∀ {C₁₁ C₁₂ C₂₁ C₂₂ D₁ D₂}
       → Func (Prod C₁₁ C₁₂) D₁
       → Func (Prod C₂₁ C₂₂) D₂
       → Func (Prod (Prod C₁₁ C₂₁)
                    (Prod C₁₂ C₂₂))
              (Prod D₁ D₂)
    go F₁ F₂ .map-Ob ((x₁₁ , x₂₁) , (x₁₂ , x₂₂)) =
      F₁ .map-Ob (x₁₁ , x₁₂) , F₂ .map-Ob (x₂₁ , x₂₂)
    go F₁ F₂ .map-Hom =
      go (F₁ .map-Hom) (F₂ .map-Hom)

Prod-cart : ∀ {C D₁ D₂} → Func C D₁ → Func C D₂ → Func C (Prod D₁ D₂)
Prod-cart F G .map-Ob x = F .map-Ob x , G .map-Ob x
Prod-cart {C} {D₁} {D₂} F G .map-Hom = Prod-cart (F .map-Hom) (G .map-Hom)

Prod-fst : ∀ {C D} → Func (Prod C D) C
Prod-fst .map-Ob (x , y) = x
Prod-fst .map-Hom = Prod-fst

Prod-snd : ∀ {C D} → Func (Prod C D) D
Prod-snd .map-Ob (x , y) = y
Prod-snd .map-Hom = Prod-snd

* .Ob = ⊤
* .Hom _ _ = *
* .id = tt
* ._○_ .map-Ob _ = tt
* ._○_ .map-Hom = * ._○_

record isEquiv {C x y} f where
  coinductive
  field
    inv : C .Hom y x .Ob
    invˡ : Equiv {C .Hom y y} (C ._○_ .map-Ob (f , inv)) (C .id)
    invʳ : Equiv {C .Hom x x} (C ._○_ .map-Ob (inv , f)) (C .id)
record Equiv {C} x y where
  coinductive
  field
    to : C .Hom x y .Ob
    hasIsEquiv : isEquiv to
open Equiv

record NT {C} {D} F G where
  coinductive
  field
    η : (x : C .Ob) → D .Hom (F .map-Ob x) (G .map-Ob x) .Ob
    naturality : (x y : C .Ob)
               → NE {C .Hom x y} {D .Hom (F .map-Ob x) (G .map-Ob y)}
                    (Func-○ (D ._○_) (Prod-cart (Const (η y)) (F .map-Hom)))
                    (Func-○ (D ._○_) (Prod-cart (G .map-Hom) (Const (η x))))

record NE {C D} F G where
  coinductive
  field
    nt : NT F G
    is : (x : C .Ob) → isEquiv (nt .NT.η x)

NE-id : ∀ {C D F} → NE {C} {D} F F

NT-id : ∀ {C D F} → NT {C} {D} F F
NT-id {D = D} .NT.η x = D .id
NT-id .NT.naturality x y = ?

NE-Func-○ : ∀ {C D E F G F' G'}
          → NE {D} {E} F F'
          → NE {C} {D} G G'
          → NE {C} {E} (Func-○ F G) (Func-○ F' G')

NT-Func-○ : ∀ {C D E F G F' G'}
          → NT {D} {E} F F'
          → NT {C} {D} G G'
          → NT {C} {E} (Func-○ F G) (Func-○ F' G')
NT-Func-○ {E = E} {_} {G} {F'} f g .NT.η x =
  E ._○_ .map-Ob ( F' .map-Hom .map-Ob (g .NT.η x)
                 , f .NT.η (G .map-Ob x) )
NT-Func-○ f g .NT.naturality x y = ?

record NE² {C D : Cat}
           {F G : Func C D}
           (f g : NT F G)
           : Type where
  -- https://q.uiver.app/?q=WzAsMTMsWzAsMSwieCJdLFsyLDEsInkiXSxbOCwzLCJGIHgiXSxbNiwwLCJHIHgiXSxbNiw2LCJGIHkiXSxbNSwzLCJHIHkiXSxbMCwyLCJGIHgiXSxbMiwyLCJHIHgiXSxbMCwzLCJGIHgiXSxbMiwzLCJHIHgiXSxbMTAsMCwiRyB4Il0sWzExLDMsIkcgeSJdLFsxMCw2LCJGIHkiXSxbMCwxLCJmIl0sWzIsMywiXFxldGFfezF4fSIsMix7ImxhYmVsX3Bvc2l0aW9uIjo2MH1dLFs0LDUsIlxcZXRhX3sxeX0iLDIseyJsYWJlbF9wb3NpdGlvbiI6NDB9XSxbMiw0LCJGIGYiLDFdLFs2LDcsIlxcZXRhX3sxeH0iXSxbOCw5LCJcXGV0YV97Mnh9Il0sWzIsMTAsIlxcZXRhX3syeH0iLDAseyJsYWJlbF9wb3NpdGlvbiI6NjB9XSxbMTAsMTEsIkcgZiIsMV0sWzIsMTEsIkcgZiBcXGNpcmMgXFxldGFfezJ4fSIsMCx7ImN1cnZlIjotM31dLFsyLDExLCJcXGV0YV97Mnl9IFxcY2lyYyBGIGYiLDIseyJjdXJ2ZSI6M31dLFsyLDUsIlxcZXRhX3sxeX0gXFxjaXJjIEYgZiIsMCx7ImN1cnZlIjotM31dLFsyLDUsIkcgZiBcXGNpcmMgXFxldGFfezF4fSIsMix7ImN1cnZlIjozfV0sWzMsNSwiRyBmIiwxXSxbMTIsMTEsIlxcZXRhX3syeX0iLDAseyJsYWJlbF9wb3NpdGlvbiI6NDB9XSxbMiwxMiwiRiBmIiwxXSxbNCwxMiwiaWRfe0YgeX0iLDEseyJzdHlsZSI6eyJ0YWlsIjp7Im5hbWUiOiJhcnJvd2hlYWQifX19XSxbMjIsMjEsIiIsMix7InNob3J0ZW4iOnsic291cmNlIjoyMCwidGFyZ2V0IjoyMH0sInN0eWxlIjp7InRhaWwiOnsibmFtZSI6ImFycm93aGVhZCJ9fX1dLFsyMywyMiwiXFxsZWZ0KFxcY2lyYyBGIGZcXHJpZ2h0KSBcXGNpcmMgXFxldGFeMl95IiwyLHsiY3VydmUiOjMsInNob3J0ZW4iOnsic291cmNlIjoyMCwidGFyZ2V0IjoyMH19XSxbMjQsMjEsIlxcbGVmdChHIGYgXFxjaXJjIFxccmlnaHQpIFxcY2lyYyBcXGV0YV4yX3giLDAseyJjdXJ2ZSI6LTMsInNob3J0ZW4iOnsic291cmNlIjoyMCwidGFyZ2V0IjoyMH19XSxbMTQsMTksIlxcZXRhXjJfeCIsMCx7Im9mZnNldCI6LTIsImN1cnZlIjotMywic2hvcnRlbiI6eyJzb3VyY2UiOjIwLCJ0YXJnZXQiOjIwfX1dLFsxNSwyNiwiXFxldGFeMl95IiwwLHsiY3VydmUiOjUsInNob3J0ZW4iOnsic291cmNlIjoxMCwidGFyZ2V0IjoxMH19XSxbMjMsMjQsIiIsMCx7InNob3J0ZW4iOnsic291cmNlIjoyMCwidGFyZ2V0IjoyMH0sInN0eWxlIjp7InRhaWwiOnsibmFtZSI6ImFycm93aGVhZCJ9fX1dLFszMCwzMSwiIiwwLHsic2hvcnRlbiI6eyJzb3VyY2UiOjIwLCJ0YXJnZXQiOjIwfSwic3R5bGUiOnsidGFpbCI6eyJuYW1lIjoiYXJyb3doZWFkIn19fV1d
  coinductive
  field
    η : (x : C .Ob) → D .Hom (F .map-Ob x) (G .map-Ob x) .Hom (f .NT.η x) (g .NT.η x) .Ob
    naturality : (x y : C .Ob)
               → NE² {C .Hom x y} {D .Hom (F .map-Ob x) (G .map-Ob y)}
                     {Func-○ (D ._○_) (Prod-cart (Const (f .NT.η y)) (F .map-Hom))}
                     {Func-○ (D ._○_) (Prod-cart (G .map-Hom) (Const (g .NT.η x)))}
                     ? ?
    w1 : (x y : C .Ob) (w : C .Hom x y .Ob) →
      D .Hom (F .map-Ob x) (G .map-Ob y)
        .Hom (D ._○_ .map-Ob ( f .NT.η y
                             , F .map-Hom .map-Ob w))
             (D ._○_ .map-Ob ( G .map-Hom .map-Ob w
                             , g .NT.η x))
        .Hom (D .Hom (F .map-Ob x) (G .map-Ob y) ._○_ .map-Ob
               ( g .NT.naturality x y .NE.nt .NT.η w
               , (D ._○_ .map-Hom .map-Ob ( η y
                                          , D .Hom (F .map-Ob x) (F .map-Ob y) .id))))
             (D .Hom (F .map-Ob x) (G .map-Ob y) ._○_ .map-Ob
               ( (D ._○_ .map-Hom .map-Ob ( D .Hom (G .map-Ob x) (G .map-Ob y) .id
                                          , η x))
               , f .NT.naturality x y .NE.nt .NT.η w ))
        .Ob
    -- naturality : (x y : C .Ob)
    --             → NE {C .Hom x y}
    --                  {D .Hom (F .map-Ob x) (G .map-Ob y)
    --                     .Hom (D ._○_ .map-Ob (G .map-Hom .map-Ob 
    --             
    -- naturality : (x y : C .Ob)
    --            → NE {C .Hom x y} {D .Hom (F .map-Ob x) (G .map-Ob y)}
    --                 (Func-○ (D ._○_) (Prod-cart (Const (η² y)) (F .map-Hom)))
    --                 (Func-○ (D ._○_) (Prod-cart (G .map-Hom) (Const (η² x))))

-- Cats .Ob = Cat
-- Cats .Hom C D .Ob = Func C D
-- Cats .Hom C D .Hom F G .Ob = NT F G
-- Cats .Hom C D .Hom F G .Hom f g .Ob = (x : C .Ob) → D .Hom (F .map-Ob x) (G .map-Ob x) .Hom (f .η x) (g .η x) .Ob
-- Cats .id .map-Ob x = x
-- Cats .id {C} .map-Hom {x} {y} = Cats .id {C .Hom x y}

-- record NT {C} {D} E F where
--   field
--     η : (x : G .Ob) → H .Hom (E .map-Ob x) (F .map-Ob y) .Ob
--     -- TODO naturality

```
