; superscripts and subscripts conceals
(text
  word: (subscript) @text.math
  (#has-ancestor? @text.math math_environment inline_formula displayed_equation)
  (#not-has-ancestor? @text.math text_mode label_definition)
  (#any-of? @text.math 
   "_0" "_1" "_2" "_3" "_4" "_5" "_6" "_7" "_8" "_9"
   "_a" "_e" "_h" "_i" "_j" "_k" "_l" "_m" "_n" "_o" "_p" "_r" "_s" "_t"
   "_u" "_v" "_x" "_\\.")
  (#set-pairs! @text.math conceal
   "_0" "₀"
   "_1" "₁"
   "_2" "₂"
   "_3" "₃"
   "_4" "₄"
   "_5" "₅"
   "_6" "₆"
   "_7" "₇"
   "_8" "₈"
   "_9" "₉"
   "_a" "ₐ"
   "_e" "ₑ"
   "_h" "ₕ"
   "_i" "ᵢ"
   "_j" "ⱼ"
   "_k" "ₖ"
   "_l" "ₗ"
   "_m" "ₘ"
   "_n" "ₙ"
   "_o" "ₒ"
   "_p" "ₚ"
   "_r" "ᵣ"
   "_s" "ₛ"
   "_t" "ₜ"
   "_u" "ᵤ"
   "_v" "ᵥ"
   "_x" "ₓ"
   "_\\." "‸"))

(text
  word: (word) @text.math
  (#has-ancestor? @text.math subscript)
  (#has-ancestor? @text.math math_environment inline_formula displayed_equation)
  (#not-has-ancestor? @text.math text_mode label_definition)
  (#any-of? @text.math 
   "0" "1" "2" "3" "4" "5" "6" "7" "8" "9"
   "a" "e" "h" "i" "j" "k" "l" "m" "n" "o" "p" "r" "s" "t" "u" "v" "x" "\\.")
  (#set-pairs! @text.math conceal
   "0" "₀"
   "1" "₁"
   "2" "₂"
   "3" "₃"
   "4" "₄"
   "5" "₅"
   "6" "₆"
   "7" "₇"
   "8" "₈"
   "9" "₉"
   "a" "ₐ"
   "e" "ₑ"
   "h" "ₕ"
   "i" "ᵢ"
   "j" "ⱼ"
   "k" "ₖ"
   "l" "ₗ"
   "m" "ₘ"
   "n" "ₙ"
   "o" "ₒ"
   "p" "ₚ"
   "r" "ᵣ"
   "s" "ₛ"
   "t" "ₜ"
   "u" "ᵤ"
   "v" "ᵥ"
   "x" "ₓ"
   "_\\." "‸"))

(text
  word: (subscript) @operator
  (#has-ancestor? @operator math_environment inline_formula displayed_equation)
  (#not-has-ancestor? @operator label_definition text_mode)
  (#any-of? @operator "_+" "_-" "_/")
  (#set-pairs! @operator conceal
   "_+" "₊"
   "_-" "₋"
   "_/" "ˏ"))

(text
  word: (operator) @operator
  (#has-ancestor? @operator subscript)
  (#has-ancestor? @operator math_environment inline_formula displayed_equation)
  (#not-has-ancestor? @operator label_definition text_mode)
  (#any-of? @operator "+" "-" "/")
  (#set-pairs! @operator conceal
   "+" "₊"
   "-" "₋"
   "/" "ˏ"))

(text
  word: (superscript) @text.math
  (#has-ancestor? @text.math math_environment inline_formula displayed_equation)
  (#not-has-ancestor? @text.math label_definition text_mode)
  (#any-of? @text.math
  "^0" "^1" "^2" "^3" "^4" "^5" "^6" "^7" "^8" "^9" 
  "^a" "^b" "^c" "^d" "^e" "^f" "^g" "^h" "^i" "^j" 
  "^k" "^l" "^m" "^n" "^o" "^p" "^r" "^s" "^t" "^u" 
  "^v" "^w" "^x" "^y" "^z" "^A" "^B" "^D" "^E" "^G" 
  "^H" "^I" "^J" "^K" "^L" "^M" "^N" "^O" "^P" "^R" 
  "^T" "^U" "^V" "^W")
  (#set-pairs! @text.math conceal
  "^0" "⁰"
  "^1" "¹"
  "^2" "²"
  "^3" "³"
  "^4" "⁴"
  "^5" "⁵"
  "^6" "⁶"
  "^7" "⁷"
  "^8" "⁸"
  "^9" "⁹"
  "^a" "ᵃ"
  "^b" "ᵇ"
  "^c" "ᶜ"
  "^d" "ᵈ"
  "^e" "ᵉ"
  "^f" "ᶠ"
  "^g" "ᵍ"
  "^h" "ʰ"
  "^i" "ⁱ"
  "^j" "ʲ"
  "^k" "ᵏ"
  "^l" "ˡ"
  "^m" "ᵐ"
  "^n" "ⁿ"
  "^o" "ᵒ"
  "^p" "ᵖ"
  "^r" "ʳ"
  "^s" "ˢ"
  "^t" "ᵗ"
  "^u" "ᵘ"
  "^v" "ᵛ"
  "^w" "ʷ"
  "^x" "ˣ"
  "^y" "ʸ"
  "^z" "ᶻ"
  "^A" "ᴬ"
  "^B" "ᴮ"
  "^D" "ᴰ"
  "^E" "ᴱ"
  "^G" "ᴳ"
  "^H" "ᴴ"
  "^I" "ᴵ"
  "^J" "ᴶ"
  "^K" "ᴷ"
  "^L" "ᴸ"
  "^M" "ᴹ"
  "^N" "ᴺ"
  "^O" "ᴼ"
  "^P" "ᴾ"
  "^R" "ᴿ"
  "^T" "ᵀ"
  "^U" "ᵁ"
  "^V" "ⱽ"
  "^W" "ᵂ"))

(text
  word: (word) @text.math
  (#has-ancestor? @text.math superscript)
  (#has-ancestor? @text.math math_environment inline_formula displayed_equation)
  (#not-has-ancestor? @text.math label_definition text_mode)
  (#any-of? @text.math
  "0" "1" "2" "3" "4" "5" "6" "7" "8" "9" "a" "b" "c" "d" "e" "f" "g" "h" "i" 
  "j" "k" "l" "m" "n" "o" "p" "r" "s" "t" "u" "v" "w" "x" "y" "z" 
  "A" "B" "D" "E" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "R" "T" "U" "V" "W")
  (#set-pairs! @text.math conceal
  "0" "⁰"
  "1" "¹"
  "2" "²"
  "3" "³"
  "4" "⁴"
  "5" "⁵"
  "6" "⁶"
  "7" "⁷"
  "8" "⁸"
  "9" "⁹"
  "a" "ᵃ"
  "b" "ᵇ"
  "c" "ᶜ"
  "d" "ᵈ"
  "e" "ᵉ"
  "f" "ᶠ"
  "g" "ᵍ"
  "h" "ʰ"
  "i" "ⁱ"
  "j" "ʲ"
  "k" "ᵏ"
  "l" "ˡ"
  "m" "ᵐ"
  "n" "ⁿ"
  "o" "ᵒ"
  "p" "ᵖ"
  "r" "ʳ"
  "s" "ˢ"
  "t" "ᵗ"
  "u" "ᵘ"
  "v" "ᵛ"
  "w" "ʷ"
  "x" "ˣ"
  "y" "ʸ"
  "z" "ᶻ"
  "A" "ᴬ"
  "B" "ᴮ"
  "D" "ᴰ"
  "E" "ᴱ"
  "G" "ᴳ"
  "H" "ᴴ"
  "I" "ᴵ"
  "J" "ᴶ"
  "K" "ᴷ"
  "L" "ᴸ"
  "M" "ᴹ"
  "N" "ᴺ"
  "O" "ᴼ"
  "P" "ᴾ"
  "R" "ᴿ"
  "T" "ᵀ"
  "U" "ᵁ"
  "V" "ⱽ"
  "W" "ᵂ"))

(text
  word: (superscript) @operator
  (#any-of? @operator
  "^+" "^-" "^<" "^>" "^/" "^=" "^\.")
  (#has-ancestor? @operator math_environment inline_formula displayed_equation)
  (#not-has-ancestor? @operator text_mode label_definition)
  (#set-pairs! @operator conceal
  "^+" "⁺"
  "^-" "⁻"
  "^<" "˂"
  "^>" "˃"
  "^/" "ˊ"
  "^\." "˙"
  "^=" "˭"))

(text
  word: (operator) @operator
  (#has-ancestor? @operator superscript)
  (#has-ancestor? @operator math_environment inline_formula displayed_equation)
  (#not-has-ancestor? @operator label_definition text_mode)
  (#any-of? @operator
  "+" "-" "<" ">" "/" "=" "\.")
  (#set-pairs! @operator conceal
  "+" "⁺"
  "-" "⁻"
  "<" "˂"
  ">" "˃"
  "/" "ˊ"
  "\." "˙"
  "=" "˭"))

