### A Pluto.jl notebook ###
# v0.20.20

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    #! format: off
    return quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
    #! format: on
end

# ╔═╡ 755b8685-0711-48a2-a3eb-f80af39f10e1
begin
    using PlutoUI
    using PlutoTeachingTools

    using LinearAlgebra
    using Statistics
    using Distributions
    using BenchmarkTools

    using ImageCore
    using ImageShow
    using ImageMagick
    using TestImages

    using LaTeXStrings
    using Plots
end

# ╔═╡ 23a44498-6941-4436-a595-ff75a02fce49
html"""<style>.dont-panic{ display: none }</style>"""

# ╔═╡ f7347c06-c1b7-11ed-3b8e-fbf167ce9cba
html"""
	<h1 style="text-align:left">
		Julia for Machine Learning
	</h1>
	<div style="text-align:left">
		<p style="font-weight:bold; font-size: 35px; font-variant: small-caps; margin: 0px">
			Homework 2: Indexing & Linear Algebra
		</p>
		<p style="font-size: 20px;">
			TU Berlin, Winter Semester 25/26<br>
		</p>
	</div>
"""

# ╔═╡ bdcb27c5-0603-49ac-b831-d78c558b31f0
md"Due date: **Monday, November 3rd 2025 at 23:59**"

# ╔═╡ ddd6e83e-5a0d-4ff0-afe4-dedfc860994c
md"### Student information"

# ╔═╡ d03e4e95-faab-4ab3-ab27-81189cbd8231
student = (
    name="Mara Mustermann",
    email="m.mustermann@campus.tu-berlin.de", # TU Berlin email address
    id=456123, # Matrikelnummer
)

# ╔═╡ ff5d316f-806c-4652-97d8-323462395c69
# Please don't edit your name here, but in the cell below. Thanks!
md"Submission by: **_$(student.name)_** ($(student.email), Matr.-Nr.: $(student.id))" # DO NOT EDIT

# ╔═╡ 44ec9e94-f6af-431e-8841-bae44431dfa3
if student.name == "Mara Mustermann"
    still_missing(md"""Please replace `"Mara Mustermann"` with your name.
            Use `Shift+Enter` to run your edits.""")
elseif student.email == "m.mustermann@campus.tu-berlin.de"
    still_missing(md"Please enter your TU Berlin E-Mail address.")
elseif student.id == 456123
    still_missing(md"Please enter your TU Berlin student ID (Matrikelnummer).")
elseif !isa(student.id, Number)
    still_missing(md"Please enter your TU Berlin student ID as number, not a string.")
else
    correct()
end

# ╔═╡ 06c0ad65-22d4-4c8e-ae19-4f05ba125e79
md"### Initializing packages
**Note:** Running this notebook for the first time can take several minutes.
"

# ╔═╡ 5061a130-fc0a-4306-bdf5-6966e8de938a
begin
    md_parse(str) = Markdown.parse(str)
    md_parse(md::Markdown.MD) = md
    function task(text, pts=1)
        if pts == 1
            pts_str = "(1 point)"
        elseif pts == 0
            pts_str = ""
        else
            pts_str = "($pts points)"
        end
        Markdown.MD(Markdown.Admonition("Task", "Task " * pts_str, [md_parse(text)]))
    end
end;

# ╔═╡ 8ece9aea-20f5-41db-95ca-08c8d4d2d4c1
task("Please add your student information to the cell below.", 0)

# ╔═╡ 74e27f45-9897-4ddd-8516-59669b17b1ad
PlutoTeachingTools.default_language[] = PlutoTeachingTools.PTTEnglish.EnglishUS();

# ╔═╡ d358da52-ee09-4533-a2ef-c68b847e24d5
md"## Exercise 1: Warm up
### Exercise 1.1 – Indexing vectors"

# ╔═╡ e5670193-6221-49c6-a880-d287f717545e
task(
    "Strings can be indexed just like numerical arrays. Use indexing to return specific characters from the string `hello`.",
    0,
)

# ╔═╡ a4bb8383-1238-411e-b697-ed258d3c0c6d
hello = "Hello World!"

# ╔═╡ cb871521-e3d8-4b87-a474-b45b5c8167a9
second_letter = missing # second character in `hello_world`

# ╔═╡ 5e70263e-6512-40ef-ad0a-38287dfba684
if !@isdefined(second_letter)
    not_defined(:second_letter)
else
    if ismissing(second_letter)
        still_missing()
    elseif second_letter != 'e'
        keep_working()
    else
        correct()
    end
end

# ╔═╡ 11df83bc-cb8e-4782-89f4-8abb73803621
first_five = missing # first five characters in `hello_world`

# ╔═╡ b3d54500-daab-4360-943d-30997c90aa02
if !@isdefined(first_five)
    not_defined(:first_five)
else
    if ismissing(first_five)
        still_missing()
    elseif first_five != "Hello"
        keep_working()
    else
        correct()
    end
end

# ╔═╡ fed6823a-bd16-4efd-804c-58dd5a2339ef
last_six = missing # last six characters in `hello_world`

# ╔═╡ e6db1935-af93-4850-acfe-92cec4de4fed
hint(md"Try to make use of `end`.")

# ╔═╡ 17f681ef-f30f-41fa-af34-7f331d359518
if !@isdefined(last_six)
    not_defined(:last_six)
else
    if ismissing(last_six)
        still_missing()
    elseif last_six != "World!"
        keep_working()
    else
        correct()
    end
end

# ╔═╡ 7d81c2cb-5ce2-4a25-96f4-66688863bb54
seven_to_eleven = missing # seventh to eleventh characters in `hello_world`

# ╔═╡ 7adeed1a-70d7-45c4-99e1-9be23bbbeb86
if !@isdefined(seven_to_eleven)
    not_defined(:seven_to_eleven)
else
    if ismissing(seven_to_eleven)
        still_missing()
    elseif seven_to_eleven != "World"
        keep_working()
    else
        correct()
    end
end

# ╔═╡ 0af1c0ee-9739-41be-833e-20b838d3e502
md"### Exercise 1.2 – Indexing matrices
In this exercise, we will be indexing values in an image:
"

# ╔═╡ 09cf939d-88df-4c7e-b164-67bfa431aaa7
img = testimage("mandril_gray")

# ╔═╡ 337eeee7-d39a-4a0e-9988-3e8830ae3989
md"Images in Julia are just matrices of colors, e.g. `Matrix{Gray}` or `Matrix{RGB}`:"

# ╔═╡ 23676fde-e080-4e78-9c22-a2f05178f0c1
typeof(img)

# ╔═╡ 85717691-5103-4c6f-bf6f-f56bbdb67b43
eltype(img)

# ╔═╡ 542df6a2-5e73-4eff-af6e-353e39861c6c
md"This image is of size $(size(img)):"

# ╔═╡ bb555bee-b9d5-4b6e-95c2-2793c3a2820b
size(img)

# ╔═╡ effd9509-4ad7-4d1f-96a5-dd9b32b09daa
md"We can crop an image by indexing it:"

# ╔═╡ 110bb376-57b6-4957-8e99-b8f564090fc1
img[1:100, 1:200]

# ╔═╡ d6dabb0b-c6bc-4581-bb20-5dc598f5d323
task(
    "Write a function `my_crop` that takes an image and returns the right half of it:
```
┌───────┐   ┌───┬───┐               ┌───┐
│       │   │   │   │  crop_right   │   │
│ Image │ = │ L │ R │ ────────────► │ R │
│       │   │   │   │               │   │
└───────┘   └───┴───┘               └───┘

```
If the image contains an uneven number of columns, ignore the center column.
For example, applying `my_crop` to an input matrix
```julia
3×5 Matrix{Int64}:
 1  4  7  10  13
 2  5  8  11  14
 3  6  9  12  15
```
should return
```julia
3×2 Matrix{Int64}:
 10  13
 11  14
 12  15
```
You can assume that the image is a regular Matrix using 1-based indexing.
",
    1,
)

# ╔═╡ 15fe42c4-9262-4673-b1b8-f417de0271d9
function my_crop(img)
    return missing # Replace `missing` with your code
end

# ╔═╡ 9f137e55-ff39-4b95-b501-78921c27f4db
md"Don't forget that you can add cells with your own tests here!"

# ╔═╡ 4c3b1036-f530-43de-83e2-91ef962a86d6
my_crop([1 2 3 4; 5 6 7 8])

# ╔═╡ 377fa7fd-f4a0-46a3-9511-d52155981cb9
if !@isdefined(my_crop)
    not_defined(:my_crop)
else
    let
        mat1 = [1 5 9 13; 2 6 10 14; 3 7 11 15; 4 8 12 16]
        mat2 = [1 4 7 10 13; 2 5 8 11 14; 3 6 9 12 15]
        result1 = my_crop(mat1)
        result2 = my_crop(mat2)

        if ismissing(result1)
            still_missing()
        elseif isnothing(result1)
            keep_working(md"Did you forget to write `return`?")
        elseif ismissing(result2)
            still_missing()
        elseif result1 != [9 13; 10 14; 11 15; 12 16]
            keep_working()
        elseif result2 != [10 13; 11 14; 12 15]
            keep_working(
                md"For matrices with an uneven amount of columns, ignore the center column."
            )
        else
            correct()
        end
    end
end

# ╔═╡ 7f8b9940-9ebf-4d93-a76c-1e055c733122
hint(md"`size` returns a tuple, which can be deconstructed using `h, w = size(img)`.

 You then need to compute the index of the center column. Several approaches are possible:
 - use `iseven` and an if-else statement or ternary operator
 - use `ceil(Int, x)`

 Also try returning a `@view`!")

# ╔═╡ d5ebd2a3-8067-479c-bd9d-6e9c7c55972e
my_crop(img)

# ╔═╡ 3e933ccb-a6f3-4c2c-99ae-7ff03ed3a786
md"## Exercise 2: Singular value decomposition
The [Singular value decomposition](https://en.wikipedia.org/wiki/Singular_value_decomposition) (SVD) factorizes matrices $M$ into

$M = U \Sigma V' \quad .$

LinearAlgebra.jl implements SVD in the function `svd`. For this implementation of SVD:
*  $\Sigma$ is a vector of  sorted, non-negative real numbers, the [singular values](https://en.wikipedia.org/wiki/Singular_value)
*  $U$ is a unitary matrix
*  $V$ is a unitary matrix
*  $V'$ is the adjoint / conjugate transpose of $V$
"

# ╔═╡ 8d144b90-32de-4367-86aa-89dd897c66d5
M = rand(4, 3)

# ╔═╡ 57a9a2a7-06cd-4d55-b7fd-2f6d86f938a7
U, Σ, V = svd(M)

# ╔═╡ afc54444-091c-4d06-95d3-dc7f0cb127b5
U * Diagonal(Σ) * V' ≈ M

# ╔═╡ 61895459-48df-419f-b884-5cb51e1038e9
U' * U ≈ I # U is unitary

# ╔═╡ c467be45-d8ef-4f68-9794-0ee9f15acf5f
V' * V ≈ I # V is unitary

# ╔═╡ 5858a0b8-6ead-4f26-b7be-ec684bd4602d
md"### Exercise 2.1: Low-rank approximation"

# ╔═╡ 49c75eed-d1cc-47e0-884b-8c327f638250
task(
    md"Write a function `rank_n_approx` that uses SVD to compute a rank $n$ approximation $\tilde{A}$ of the input matrix $A$.

For this purpose:
1. Compute $U$, $\Sigma$ and $V$ from $A$
2. In $\Sigma$, set all singular values after the $n$-th entry to zero. We will call this $\tilde{\Sigma}.$
3. Return $\tilde{A} = U \tilde{\Sigma} V'$
",
    1,
)

# ╔═╡ ec262620-a818-4f5c-b6b9-24a58b73a603
function rank_n_approx(A, n)
    return missing # Replace `missing` with your code
end

# ╔═╡ 81a85548-ccf0-4d09-9cdf-f6eefc08017a
md"Let's see if the function works:"

# ╔═╡ 8789e280-9d06-4284-8f43-42824e06bb20
T = rand(-9:9, 5, 5)

# ╔═╡ 3fe28b4d-4a7a-4ea9-9b60-7a50c8f6b1e3
T̃ = rank_n_approx(T, 1)

# ╔═╡ 6112c7eb-b2fb-4f46-8601-bc5787577042
rank(T)

# ╔═╡ bcb516cd-6bee-4cd8-b633-a872a2bc107f
rank(T̃)

# ╔═╡ 0585d514-9255-49c5-bf57-c408c71600c7
if !@isdefined(rank_n_approx)
    not_defined(:rank_n_approx)
else
    let
        T = [1 2 3; 1 2 2; 1 1 1]
        sol = [
            0.9403007439221942 2.074443754686133 2.9668694123600576
            1.1341430107639383 1.8327264015961187 2.074443754686132
            0.8924256576739248 1.1341430107639388 0.9403007439221938
        ]
        result = rank_n_approx(T, 2)

        if ismissing(result)
            still_missing()
        elseif isnothing(result)
            keep_working(md"Did you forget to write `return`?")
        elseif !(result ≈ sol)
            keep_working()
        else
            correct()
        end
    end
end

# ╔═╡ ef2c3f94-5db0-4a49-8bb2-cd2380e6fd82
hint(
    md"You can set values in an array to zero by using the `.=` operator, which will broadcast assignments.",
)

# ╔═╡ 7e4268d1-54d9-429b-9ec2-c2ccab5a7eda
@bind n Slider(1:50, default=50, show_value=true)

# ╔═╡ 8401a066-f5c0-4d86-8d0e-e9c287762252
md"Note that from a numerical perspective, it is a bit unusual to multiply the factorization $U \tilde{\Sigma} V'$ back together into an array $\tilde{A}$. We did this so we can apply the low-rank approximation to our image.

Let's compute a rank $n=$ $(n) approximation. Adjust the rank using the following slider:"

# ╔═╡ f597829c-b0c7-4b7f-b58b-bac8e52030f5
rank_n_approx(img, n) .|> Gray

# ╔═╡ 5bba64bc-1dd1-4a71-bfe0-86497c31d617
md"## Exercise 3: Kernel Ridge Regression
Given the dataset $(X, y)$, we want to apply Kernel ridge regression to predict $\hat{y}$ for unknown $x$.
"

# ╔═╡ f1846dfe-0718-49f9-9825-84256a871ac7
X = [0.004, 0.018, 0.083, 0.276, 0.325, 0.610, 0.667, 0.698, 0.877, 0.951]

# ╔═╡ a72971ae-b1de-4892-85d2-52cb8ff025ff
y = [0.003, 0.094, 0.444, 0.905, 0.820, -0.474, -0.883, -0.931, -0.616, -0.269]

# ╔═╡ dcba5dbb-1a3d-49e8-a301-68c6bcae13b7
md"Let's visualize the data we are given in a scatter plot:"

# ╔═╡ 87236fbd-e09c-4b81-b065-5954b2057b9b
scatter(X, y; label="Data", xlabel=L"x", ylabel=L"y")

# ╔═╡ 4e1f60e5-77c1-467a-9500-69c00f74700c
md"### Exercise 3.1 – Kernel function"

# ╔═╡ ef23ba30-3f81-4676-850f-1a65062753a6
task(
    md"Define a function `rbf` that evaluates the [radial basis function kernel](https://en.wikipedia.org/wiki/Radial_basis_function_kernel) (RBF kernel) $k$ on two data points $x_i$, $x_j$:

$k(x_i, x_j) = \exp\left(-\frac{||x_i - x_j|| ^2}{2\sigma^2}\right)$
",
    0.5,
)

# ╔═╡ 7f9afd24-fd1c-49cd-b6bf-598cea9758c7
md"Note that you can type σ using `\sigma<TAB>`.

`σ`'s default value `σ_slider` is defined at the bottom of this notebook."

# ╔═╡ 3e0b27fc-1ccb-440b-a98f-ee6541f3282e
md"### Exercise 3.2 – Training kernel matrix $K_{XX}$"

# ╔═╡ e2a37317-171d-4c45-975e-2752daf88008
task(
    md"Use broadcasting to compute the training kernel matrix `kXX`, defined as

$K_{XX} = \begin{bmatrix}
    k(x_1, x_1) & \cdots & k(x_1, x_n) \\
    \vdots 		& \ddots & \vdots \\
    k(x_n, x_1) & \cdots & k(x_n, x_n)
\end{bmatrix} \in \mathbb{R}^{n \times n}$

where $x_i$ is the $i$-th entry in the dataset $X$ and $k$ is the kernel function.
Use the RBF kernel with $\sigma=0.5$.",
    0.5,
)

# ╔═╡ 45d51447-beb8-4682-8b09-f65de7cfb95a
kXX = missing # Replace `missing` with your code

# ╔═╡ 776d80f1-ea26-4aeb-8bd5-c230956fa724
md"Since kernel functions $k$ are symmetric and positive-definite, this should also apply to the matrix $K$:"

# ╔═╡ 5774bd94-3c87-48b5-868e-73418afbb5c7
issymmetric(kXX)

# ╔═╡ 23227a0e-413a-4e05-9bf2-109a499b12cb
isposdef(kXX)

# ╔═╡ 5eea7d2e-cfda-4b42-9697-31ef645a1a79
if !@isdefined(kXX)
    not_defined(:kXX)
else
    if ismissing(kXX)
        still_missing()
    elseif isnothing(kXX)
        keep_working(md"`kXX` is `nothing`.")
    elseif typeof(kXX) != Matrix{Float64}
        keep_working(md"`kXX` should be of type `Matrix{Float64}`.")
    elseif size(kXX) != (10, 10)
        keep_working(md"`kXX` should be of size (10, 10), got $(size(kXX)).")
    elseif !issymmetric(kXX)
        keep_working(md"`kXX` should be a symmetric matrix.")
    elseif !isposdef(kXX)
        keep_working(md"`kXX` should be a positive-definite matrix.")
    elseif !(sum(kXX) ≈ 70.69205369179959)
        keep_working(md"Did you use $\sigma=0.5$?")
    else
        correct()
    end
end

# ╔═╡ ce97f41f-8b71-468f-bac3-39a66e440cd5
hint(md"There are several viable approaches:
* broadcast the RBF kernel over `X` and `X'`
* use a multi-dimensional comprehension
* pre-allocate a matrix and write into it using for-loops
")

# ╔═╡ 45d61914-591c-48bb-a0ad-902028d61089
md"### Exercise 3.3 – Test kernel matrix $K_{\hat{x}X}$"

# ╔═╡ cecb430c-0236-4a16-b74f-1809710fbdfe
task(
    md"Compute `kxX`, defined as

$K_{\hat{x}X} = \begin{bmatrix}
    k(\hat{x}, x_1) & \cdots & k(\hat{x}, x_n)
\end{bmatrix} \in \mathbb{R}^{1 \times n}$

where $x_i$ is the $i$-th entry in the dataset $X$. Use $\hat{x}=0.8$ and the RBF kernel with $\sigma=0.5$.
",
    0.5,
)

# ╔═╡ f9906c93-f96d-45fd-b0ae-48794d82d54e
kxX = missing # Replace `missing` with your code

# ╔═╡ 58dd630a-ed1b-471a-94a3-fea43ec41d19
if !@isdefined(kxX)
    not_defined(:kxX)
else
    if ismissing(kxX)
        still_missing()
    elseif isnothing(kxX)
        keep_working(md"`kxX` is `nothing`.")
    elseif size(kxX) != (1, 10)
        keep_working(md"`kxX` should be of size (1, 10), got $(size(kxX)).")
    elseif !(sum(kxX) ≈ 6.966497082632841)
        keep_working(md"Did you use $\hat{x}=0.8$ and $\sigma=0.5$?")
    else
        correct()
    end
end

# ╔═╡ de0a1efb-77ae-45bd-83a5-77029e2b095d
hint(md"There are several viable approaches:
* broadcast over `x = 0.8` and `X'`
* use a comprehension
* pre-allocate a matrix and write into it in a for-loop
")

# ╔═╡ 60ebcfda-f28f-4aae-b1af-8e2a2313b3da
md"""### Interlude: Cholesky decomposition

As we've seen above, systems of equations involving **symmetric and positive-definite** matrices $A$ often arise in classic machine learning algorithms.

Using the Cholesky decomposition, a symmetric positive-definite matrix $A$ can be factorized into the product of a lower triangular matrix $L$ and its conjugate transpose:

$A = LL'$

Let's apply the Cholesky decomposition to a toy example.
By calling LinearAlgebra.jl's `cholesky`, we obtain a factorization `C`:
"""

# ╔═╡ aec673aa-fd15-46d6-85eb-4db54babfea8
A = [42 -37  52  25; -37  89 -89 -32; 52 -89 172 -22; 25 -32 -22  66]

# ╔═╡ 32d3a10a-bc5c-44a6-950c-8928936cd808
issymmetric(A) && isposdef(A)

# ╔═╡ 46ca52b7-3ec7-4c97-8a1e-0fadda4fc883
C = cholesky(A) # returns factorization

# ╔═╡ cf9d05d8-791a-4280-a160-d17992c25146
md"We can use this factorization to access $L$ and check whether $A = LL'$ holds:"

# ╔═╡ fc2d0d0b-a790-465b-93a6-0cf0c533b070
C.L

# ╔═╡ c2b1e609-8839-4788-8173-ede22c6dff19
C.L * C.L' ≈ A  # works!

# ╔═╡ 01053f0e-adcb-4fae-9f6b-9709056bb5a2
md"#### Solving linear systems
In the next exercise, we are going to use the Cholesky decomposition to solve a system of linear equations $Ax=b$ for $x$:

$x = A^{-1}b$

Let's compare three approaches on a random vector $b$:
"

# ╔═╡ 0bc1537f-dc1b-46a8-a270-4decee040e9a
b = rand(4)

# ╔═╡ 8d8657ee-17c3-4b31-a28e-f6eca4e98b83
inv(A) * b # Approach A: naive implementation using matrix inverse (never do this!)

# ╔═╡ 468d3484-b2c9-42e6-a9e4-753c3e4a57ac
A \ b # Approach B: left division operator

# ╔═╡ c4491060-fd42-4045-a8a6-8a2e6437984a
C \ b # Approach C: left division operator and Cholesky factorization

# ╔═╡ cb3a2a70-7a4c-4adb-9983-95614645971b
md"In this example, all three approaches compute the correct result. However, matrix inversion is often numerically unstable, which is why it should be avoided.

The approach using the Cholesky factorization is numerically stable, fast and therefore well suited for the next exercise:"

# ╔═╡ 7d1a176a-5b5c-4ccb-b8d4-3ff8c9370776
@benchmark inv(A) * b  # slowest and unstable, never do this!

# ╔═╡ cb5a04e5-848d-4974-9667-73ab80d4a54b
@benchmark A \ b  # slow

# ╔═╡ 87459e6f-f147-44bb-a713-b75d0d2702e0
@benchmark C \ b # fast

# ╔═╡ b5937641-83df-4e64-b51f-84c988a1f9f5
md"### Exercise 3.4 – Kernel Ridge Regression"

# ╔═╡ 57829229-6fe8-4f30-bb10-49d763316864
task(
    md"Implement Kernel Ridge Regression in the function `kernel_ridge` below.

##### Step 1
Inside the function `kernel_ridge`, construct the training kernel matrix $K_{XX}$ using the function `kernel`. Add a regularization term $\lambda I$, where where $I$ is the identity matrix and $\lambda \in \mathbb{R}$ is a regularization term:

$\tilde{K}_{XX} = K_{XX} + \lambda I$

Don't specify the kernel bandwidth $\sigma$.

##### Step 2
Use the Cholesky decomposition on $\tilde{K}_{XX}$ to compute

$\alpha = (K_{XX} + \lambda I)^{-1}y \quad .$


##### Step 3
Inside the `kernel_ridge` function, write a prediction function `predict` that takes a point $x$, computes the test kernel matrix $K_{\hat{x}X}$ and returns a prediction

$\hat{y} = K_{\hat{x}X} \cdot \alpha \quad .$

",
    1.5,
)

# ╔═╡ 5561d5fa-74fa-430f-850b-8339ad3df433
md"### Interactive plot"

# ╔═╡ 272aeadc-773e-41a7-a112-80e814e4ac3d
@bind σ_slider Slider(0.01:0.01:1, default=1.0, show_value=true)

# ╔═╡ 74d0409d-8a10-4660-8a01-c75505f612e2
function rbf(xi, xj; σ=σ_slider) # Don't change this line
    return missing # Replace `missing` with your code
end

# ╔═╡ 05032f1b-ca1e-4fb0-ae21-060c06146871
if !@isdefined(rbf)
    not_defined(:rbf)
else
    let
        result1 = rbf(0.12, 0.32; σ=1.0)
        result2 = rbf(0.12, 0.32; σ=0.3)
        if ismissing(result1)
            still_missing()
        elseif isnothing(result1)
            keep_working(md"Did you forget to write `return`?")
        elseif !(result1 ≈ 0.9801986733067553)
            keep_working()
        elseif !(result2 ≈ 0.8007374029168081)
            keep_working(md"Did you forget $\sigma^2$?")
        else
            correct()
        end
    end
end

# ╔═╡ b5d7850d-dac2-482e-b0bc-273660d0646a
function kernel_ridge(X, y; kernel=rbf, λ=1e-8)  # Don't change this line
    # Write your code here

    function predict(xtest::Real)
        return missing # Replace `missing` with your code
    end

    return predict # Don't change this line
end

# ╔═╡ ea43cd35-b7f8-46e0-befb-d9b0248e0eb3
if !@isdefined(kernel_ridge)
    not_defined(:kernel_ridge)
else
    let
        k(x1, x2) = rbf(x1, x2; σ=0.2)
        pred = kernel_ridge(X, y; kernel=k, λ=10^8)
        result = pred(0.2)

        if ismissing(result)
            still_missing()
        elseif isnothing(result)
            keep_working(md"Did you forget to write `return`?")
        elseif result isa AbstractArray
            keep_working(
                md"""
The `predict` function should return a scalar prediction $\hat{y}$ for scalar inputs $\hat{x}$.
Currently, an array of size $(size(result)) is returned.

If the size is (1,) or (1, 1), you can use the function `only` on your output to access the only element in it. Alternatively, use the dot product.
""",
            )
        elseif !(result ≈ 1.7946744507800904e-8)
            keep_working()
        else
            correct()
        end
    end
end

# ╔═╡ 725c19e3-2659-4f2d-8442-2bbc6010661b
md"""If you successfully implemented Kernel ridge regression, you can use the following sliders to interact with the RBF kernel bandwidth $\sigma=$ $(σ_slider)"""

# ╔═╡ 31056ca3-acd2-4457-bbd3-9ddd2c2ff641
@bind ex Slider(-10.0:2.0, default=-8, show_value=true)

# ╔═╡ 027c7870-1603-4aba-95eb-3d14b7a0829f
md"""and the exponent `ex` of the regularization term $\lambda =$ $(10^ex)"""

# ╔═╡ 2f57e6de-c874-4f90-8e71-70cd1d002359
predict = kernel_ridge(X, y; λ=10^ex);

# ╔═╡ 2000a153-4b4d-4aec-a503-eaf3cc9d89c3
begin
    p = scatter(X, y; label="Dataset", xlabel=L"x", ylabel=L"y", ylims=(-1, 1))
    plot!(p, predict, -0.1, 1.1; label="Prediction", title="Kernel ridge regression")
end

# ╔═╡ 0fe33d6c-d65d-4f29-857d-34ea792a1f48
md"How does a high/low bandwidth affect the prediction? How does regularization affect it?

You can also implement [more kernel functions](https://en.wikipedia.org/wiki/Positive-definite_kernel#Examples_of_p.d._kernels) and pass them to the `kernel_ridge` keyword-argument `kernel` to see how the prediction changes.
"

# ╔═╡ 71c2b3dd-3fb4-4f8b-9e19-a043e05ff498
md"### Exercise 4 – Multiple dispatch on diagonal matrix"

# ╔═╡ c986580b-fe8c-4b68-9fa1-230b429e6de8
md"""
### Overview diagonal matrix
A diagonal matrix is a square matrix that has non-zero elements only in the diagonal.

An example for a diagonal matrix would be:
"""

# ╔═╡ 57d23d48-4f7b-434c-95f3-dd6c704dbb0b
A₁ = [3 0 0; 0 7 0; 0 0 -4]

# ╔═╡ d89bd03c-5dda-4141-af90-1673af2370e3
md"""
In this implementation using the regular, dense `Array` type, all elements are stored, regardless of whether they are zero or not. 
Since we used nine `Float64` numbers instead of just three, this results in more storage and computation.
### `Diagonal` from LinearAlgebra.jl
For that reason, [LinearAlgebra.jl](https://docs.julialang.org/en/v1/stdlib/LinearAlgebra/) implements a type called [Diagonal](https://docs.julialang.org/en/v1/stdlib/LinearAlgebra/#LinearAlgebra.Diagonal) for diagonal matrices. Instead of storing a dense diagonal matrix with all of its off-diagonal zeros, matrices of type `Diagonal` contain only the non-zero diagonal elements in a vector called `diag`:

```julia
struct Diagonal{V<:AbstractVector} <: AbstractMatrix
  diag::V
end
```

Our previous matrix `A₁` can now be declared as follows: 
"""

# ╔═╡ 29a57a0e-7859-416b-a6d5-ab8b4ec9516c
A₂ = Diagonal([3, 7, -4])

# ╔═╡ 3dbc1078-85b1-4711-98fe-29d48d0b1474
task(
    md"""
   In this task, you will define two methods for the `trace` function:

   1. Implement a method `trace` for inputs of type `AbstractMatrix`
   2. Using multiple dispatch, implement a method `trace` for matrices of type `Diagonal`.

   ##### Trace Definition:

   The trace of an $n \times n$ square matrix $\mathbf{A}$ is defined as:

   $\text{trace}(\mathbf{A}) = \sum_{i=1}^{n} a_{ii} = a_{11} + a_{22} + \dots + a_{nn}$

   	""",
    2,
)

# ╔═╡ 9f99e017-08f6-43b9-9db8-cec9e310b4b7
function trace(A::AbstractMatrix)  # Don't change this line
    # Write your code here

    return missing
end

# ╔═╡ f6a2038a-9b42-4580-a61d-89c6a398ee66
function trace(A::Diagonal)  # Don't change this line
    # Write your code here

    return missing
end

# ╔═╡ 65b736a4-1a38-4366-b519-cd13893d24a5
trace(A₁)

# ╔═╡ 5b4773c3-fcbc-4f97-8684-653fd8f1dfbd
trace(A₂)

# ╔═╡ 68e50ed7-c17d-4d89-9eb6-40aa790a87e8
if !@isdefined(trace)
    not_defined(:trace)
else
    let
        # Define matrices
        v = rand(20)
        A_diagonal = Diagonal(v)
        A_square = Matrix(A_diagonal)
        result_ref = sum(v)
        # Results
        result_square = trace(A_square)
        result_diagonal = trace(A_diagonal)

		# Test missing
		if ismissing(result_square) || ismissing(result_diagonal)
            still_missing()
        # Test for square matrix
        elseif !isapprox(result_square, result_ref, atol=1e-4)
            keep_working(md"Check your implementation for square matrices.")
            # Test for diagonal matrix
        elseif !isapprox(result_diagonal, result_ref, atol=1e-4)
            keep_working(md"Check your implementation for diagonal matrices.")
        else
            correct()
        end
    end
end

# ╔═╡ 41a7bd3b-56f5-45e7-ac8d-313bb3a46181
md"## Exercise 5: Principal Component Analysis
### Overview
Assume an input dataset $$X = [x_1, x_2, \ldots x_n] \in \mathbb{R}^{d\times n}$$, where
*  $d$ is the dimensionality of each data point: $x_i \in \mathbb{R}^d$
*  $n$ is the number of data points in $X$

Substracting the mean over all data points gives us the *mean-centered* data matrix $\hat{X}$.

**Idea:** PCA with $k$ principal components finds the projection $W_k = [w_1, w_2, \ldots, w_k]$ that maximizes the variance in the projected data $W_k^T\hat{X}$.

![PCA Plot](https://i.imgur.com/FEyXwwX.png)

In the example above, this maximization of variance would correspond to a projection $W_1^T\hat{X} = w_1^T\hat{X}$ of all datapoints onto the red arrow, reducing the dimensionality from 2D to 1D.
"

# ╔═╡ 067c7894-2e3f-43de-998f-4f1a250bc0f7
Markdown.MD(
    Markdown.Admonition(
        "warning",
        "Note",
        [
            md"This exercise does not provide automated feedback in order to get you to practice programming in Julia on your own!",
        ],
    ),
)

# ╔═╡ 4a9735f7-0d2b-4557-a293-f0e0c6c19179
md"### Exercise 5.1 – Implementation"

# ╔═╡ af5e47f0-010b-4e69-bed3-95fdf9fce3fe
task(
    md"Implement [Principal Component Analysis](https://en.wikipedia.org/wiki/Principal_component_analysis) (PCA) in the function `pca` below.

##### Step 1
Calculate the mean-centered data matrix $\hat{X}=[\hat{x}_1, \hat{x}_2, \ldots, \hat{x}_n]$ such that

$\hat{x}_i = x_i - \mu_x \quad ,$

where $\mu_x$ is the sample mean vector of the data $X$.
You can use the `mean` function for this purpose.

##### Step 2
Compute the sample covariance matrix $C = \hat{X}\hat{X}^T$.

##### Step 3
Compute an eigendecomposition of $C$ into eigenvectors $w_i$ and eigenvalues $\lambda_i$
using the function `eigen`.


Select the eigenvectors $w_i$ corresponding to the $k$ largest eigenvalues $\lambda_i$,
such that $\lambda_1\ge\lambda_2\ge\ldots\ge\lambda_k$:

$W_k = [w_1, w_2, \ldots, w_k]$

##### Step 4
Calculate the projection $H = W_k^T \hat{X}$ of the mean-centered data $\hat{X}$ onto $W_k$.
",
    3,
)

# ╔═╡ 216dcbf9-91aa-40fe-bef2-6dea56a35be7
function pca(X, k=2)  # Don't change this line
    # Write your code here
    Wk = missing
    H = missing
    return Wk, H # Don't change this line
end

# ╔═╡ dda486b4-5838-429b-aec8-450d2f0c55be
hint(
    md"""
* The `mean` function allows you to compute the mean along an axis of an array. Refer to the documentation for examples.
* Read the documentation of `eigen` thoroughly. Eigenvectors are sorted by *increasing* eigenvalues. You can make use of clever indexing to obtain them in decreasing order.
* Accessing docstrings is described in the lecture *"Getting Help"*.
""",
)

# ╔═╡ df1540c4-d458-428c-b230-6c42557557e1
md"### Visualization of PCA"

# ╔═╡ 39c8a7fd-8746-4179-865e-9ec7df230fff
md"""
The following visualization will help you verify your `pca` implementation.
1. Make sure that the vectors $w_1$ and $w_2$ are orthogonal.
2. The produced plot should look similar, with minute differences, to the example image given in the task description.
"""

# ╔═╡ f3d0483f-ba78-4d3d-a23e-ec051923175d
n_samples = 100;

# ╔═╡ 4639b31c-9ef9-47a8-b9a9-b65b2e6d13fa
my_distribution = MixtureModel(
    [MvNormal([0.0, 10.0], [3.0 2.0; 2.0 3.0]), MvNormal([15.0, 20.0], [7.0 0.3; 0.3 4.0])],
    [0.5, 0.5],
);

# ╔═╡ 474cd2c3-b35b-4d01-b62a-e7171b4ee476
X_test = rand(my_distribution, n_samples);

# ╔═╡ 6fd61dac-2ab1-464a-a20c-c0e1d7d23e8b
begin
    # Plot data
    scatter(
        X_test[1, :],
        X_test[2, :];
        label=L"Data $X$",
        xlabel=L"x_1",
        ylabel=L"x_2",
        ratio=1,
        legend=:topleft,
    )

    # Plot mean
    μ = mean(X_test; dims=2)
    scatter!((μ[1], μ[2]); c=:black, label=L"Sample mean $\mu_x$")

    # Compute PCA
    W, H = pca(X_test, 2)

    # Plot PCA
    scale = 10
    pc1 = μ + scale * W[:, 1]
    pc2 = μ + scale * W[:, 2]
    plot!([μ[1], pc1[1]], [μ[2], pc1[2]]; arrow=true, lw=2, c=:red, label=L"1st PC $w_1$")
    plot!([μ[1], pc2[1]], [μ[2], pc2[2]]; arrow=true, lw=2, c=:blue, label=L"2nd PC $w_2$")
end

# ╔═╡ edb7814a-eddf-4c87-8857-19bb0a0c0241
md"""# Feedback
Please help us improve the course by giving us feedback!

You can write whatever you want in the following string. Feel free to add or delete whatever you want.
"""

# ╔═╡ f60be2e0-9b43-46b5-96ef-7747ab56e164
feedback = """
The homework took me around XX minutes.

In the lecture / homework I would have liked more detailed explanations on:
* foo
* bar

I liked:
* baz

I didn't like:
* qux
""";

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
BenchmarkTools = "6e4b80f9-dd63-53aa-95a3-0cdb28fa8baf"
Distributions = "31c24e10-a181-5473-b8eb-7969acd0382f"
ImageCore = "a09fc81d-aa75-5fe9-8630-4744c3626534"
ImageMagick = "6218d12a-5da1-5696-b52f-db25d2ecc6d1"
ImageShow = "4e3cecfd-b093-5904-9786-8bbb286a6a31"
LaTeXStrings = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Statistics = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
TestImages = "5e47fb64-e119-507b-a336-dd2b206d9990"

[compat]
BenchmarkTools = "~1.6.3"
Distributions = "~0.25.122"
ImageCore = "~0.10.5"
ImageMagick = "~1.4.2"
ImageShow = "~0.3.8"
LaTeXStrings = "~1.4.0"
Plots = "~1.41.1"
PlutoTeachingTools = "~0.4.6"
PlutoUI = "~0.7.73"
TestImages = "~1.9.0"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.7"
manifest_format = "2.0"
project_hash = "858c45ac76a7f5b85a1b881a7c0d53d7b142c996"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "6e1d2a35f2f90a4bc7c2ed98079b2ba09c35b83a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.2"

[[deps.AliasTables]]
deps = ["PtrArrays", "Random"]
git-tree-sha1 = "9876e1e164b144ca45e9e3198d0b689cadfed9ff"
uuid = "66dad0bd-aa9a-41b7-9441-69ab47430ed8"
version = "1.1.3"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.2"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"
version = "1.11.0"

[[deps.AxisArrays]]
deps = ["Dates", "IntervalSets", "IterTools", "RangeArrays"]
git-tree-sha1 = "4126b08903b777c88edf1754288144a0492c05ad"
uuid = "39de3d68-74b9-583c-8d2d-e117c070f3a9"
version = "0.4.8"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"
version = "1.11.0"

[[deps.BenchmarkTools]]
deps = ["Compat", "JSON", "Logging", "Printf", "Profile", "Statistics", "UUIDs"]
git-tree-sha1 = "7fecfb1123b8d0232218e2da0c213004ff15358d"
uuid = "6e4b80f9-dd63-53aa-95a3-0cdb28fa8baf"
version = "1.6.3"

[[deps.BitFlags]]
git-tree-sha1 = "0691e34b3bb8be9307330f88d1a3c3f25466c24d"
uuid = "d1d4a3ce-64b1-5f1a-9ba4-7e7e69966f35"
version = "0.1.9"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1b96ea4a01afe0ea4090c5c8039690672dd13f2e"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.9+0"

[[deps.CEnum]]
git-tree-sha1 = "389ad5c84de1ae7cf0e28e381131c98ea87d54fc"
uuid = "fa961155-64e5-5f13-b03f-caf6b980ea82"
version = "0.5.0"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "CompilerSupportLibraries_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "fde3bf89aead2e723284a8ff9cdf5b551ed700e8"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.18.5+0"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "962834c22b66e32aa10f7611c08c8ca4e20749a9"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.8"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "ColorVectorSpace", "Colors", "FixedPointNumbers", "PrecompileTools", "Random"]
git-tree-sha1 = "b0fd3f56fa442f81e0a47815c92245acfaaa4e34"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.31.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "67e11ee83a43eb71ddc950302c53bf33f0690dfe"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.12.1"
weakdeps = ["StyledStrings"]

    [deps.ColorTypes.extensions]
    StyledStringsExt = "StyledStrings"

[[deps.ColorVectorSpace]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "Requires", "Statistics", "TensorCore"]
git-tree-sha1 = "8b3b6f87ce8f65a2b4f857528fd8d70086cd72b1"
uuid = "c3611d14-8923-5661-9e6a-0046d554d3a4"
version = "0.11.0"
weakdeps = ["SpecialFunctions"]

    [deps.ColorVectorSpace.extensions]
    SpecialFunctionsExt = "SpecialFunctions"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "37ea44092930b1811e666c3bc38065d7d87fcc74"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.13.1"

[[deps.Compat]]
deps = ["TOML", "UUIDs"]
git-tree-sha1 = "9d8a54ce4b17aa5bdce0ea5c34bc5e7c340d16ad"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.18.1"
weakdeps = ["Dates", "LinearAlgebra"]

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.1+0"

[[deps.ConcurrentUtilities]]
deps = ["Serialization", "Sockets"]
git-tree-sha1 = "d9d26935a0bcffc87d2613ce14c527c99fc543fd"
uuid = "f0e56b4a-5159-44fe-b623-3e5288b988bb"
version = "2.5.0"

[[deps.Contour]]
git-tree-sha1 = "439e35b0b36e2e5881738abc8857bd92ad6ff9a8"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.6.3"

[[deps.DataAPI]]
git-tree-sha1 = "abe83f3a2f1b857aac70ef8b269080af17764bbe"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.16.0"

[[deps.DataStructures]]
deps = ["OrderedCollections"]
git-tree-sha1 = "f0d05ae68d39d73a96883fc89c61bfe127290472"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.19.2"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"
version = "1.11.0"

[[deps.Dbus_jll]]
deps = ["Artifacts", "Expat_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "473e9afc9cf30814eb67ffa5f2db7df82c3ad9fd"
uuid = "ee1fde0b-3d02-5ea6-8484-8dfef6360eab"
version = "1.16.2+0"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
git-tree-sha1 = "9e2f36d3c96a820c678f2f1f1782582fcf685bae"
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"
version = "1.9.1"

[[deps.Distances]]
deps = ["LinearAlgebra", "Statistics", "StatsAPI"]
git-tree-sha1 = "c7e3a542b999843086e2f29dac96a618c105be1d"
uuid = "b4f34e82-e78d-54a5-968a-f98e89d6e8f7"
version = "0.10.12"

    [deps.Distances.extensions]
    DistancesChainRulesCoreExt = "ChainRulesCore"
    DistancesSparseArraysExt = "SparseArrays"

    [deps.Distances.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"
version = "1.11.0"

[[deps.Distributions]]
deps = ["AliasTables", "FillArrays", "LinearAlgebra", "PDMats", "Printf", "QuadGK", "Random", "SpecialFunctions", "Statistics", "StatsAPI", "StatsBase", "StatsFuns"]
git-tree-sha1 = "3bc002af51045ca3b47d2e1787d6ce02e68b943a"
uuid = "31c24e10-a181-5473-b8eb-7969acd0382f"
version = "0.25.122"

    [deps.Distributions.extensions]
    DistributionsChainRulesCoreExt = "ChainRulesCore"
    DistributionsDensityInterfaceExt = "DensityInterface"
    DistributionsTestExt = "Test"

    [deps.Distributions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    DensityInterface = "b429d917-457f-4dbc-8f4c-0cc954292b1d"
    Test = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.DocStringExtensions]]
git-tree-sha1 = "7442a5dfe1ebb773c29cc2962a8980f47221d76c"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.5"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.EpollShim_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8a4be429317c42cfae6a7fc03c31bad1970c310d"
uuid = "2702e6a9-849d-5ed8-8c21-79e8b8f9ee43"
version = "0.0.20230411+1"

[[deps.ExceptionUnwrapping]]
deps = ["Test"]
git-tree-sha1 = "d36f682e590a83d63d1c7dbd287573764682d12a"
uuid = "460bff9d-24e4-43bc-9d9f-a8973cb893f4"
version = "0.1.11"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "27af30de8b5445644e8ffe3bcb0d72049c089cf1"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.7.3+0"

[[deps.FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "95ecf07c2eea562b5adbd0696af6db62c0f52560"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.5"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "PCRE2_jll", "Zlib_jll", "libaom_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "ccc81ba5e42497f4e76553a5545665eed577a663"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "8.0.0+0"

[[deps.FFTW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6d6219a004b8cf1e0b4dbe27a2860b8e04eba0be"
uuid = "f5851436-0d7a-5f13-b9de-f02708fd171a"
version = "3.3.11+0"

[[deps.FileIO]]
deps = ["Pkg", "Requires", "UUIDs"]
git-tree-sha1 = "d60eb76f37d7e5a40cc2e7c36974d864b82dc802"
uuid = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
version = "1.17.1"
weakdeps = ["HTTP"]

    [deps.FileIO.extensions]
    HTTPExt = "HTTP"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"
version = "1.11.0"

[[deps.FillArrays]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "173e4d8f14230a7523ae11b9a3fa9edb3e0efd78"
uuid = "1a297f60-69ca-5386-bcde-b61e274b549b"
version = "1.14.0"
weakdeps = ["PDMats", "SparseArrays", "Statistics"]

    [deps.FillArrays.extensions]
    FillArraysPDMatsExt = "PDMats"
    FillArraysSparseArraysExt = "SparseArrays"
    FillArraysStatisticsExt = "Statistics"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "05882d6995ae5c12bb5f36dd2ed3f61c98cbb172"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.5"

[[deps.Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Zlib_jll"]
git-tree-sha1 = "f85dac9a96a01087df6e3a749840015a0ca3817d"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.17.1+0"

[[deps.Format]]
git-tree-sha1 = "9c68794ef81b08086aeb32eeaf33531668d5f5fc"
uuid = "1fa38f19-a742-5d3f-a2b9-30dd87b9d5f8"
version = "1.3.7"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "2c5512e11c791d1baed2049c5652441b28fc6a31"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.13.4+0"

[[deps.FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "7a214fdac5ed5f59a22c2d9a885a16da1c74bbc7"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.17+0"

[[deps.GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll", "libdecor_jll", "xkbcommon_jll"]
git-tree-sha1 = "fcb0584ff34e25155876418979d4c8971243bb89"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.4.0+2"

[[deps.GR]]
deps = ["Artifacts", "Base64", "DelimitedFiles", "Downloads", "GR_jll", "HTTP", "JSON", "Libdl", "LinearAlgebra", "Preferences", "Printf", "Qt6Wayland_jll", "Random", "Serialization", "Sockets", "TOML", "Tar", "Test", "p7zip_jll"]
git-tree-sha1 = "f52c27dd921390146624f3aab95f4e8614ad6531"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.73.18"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "FreeType2_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Qt6Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "4b0406b866ea9fdbaf1148bc9c0b887e59f9af68"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.73.18+0"

[[deps.GettextRuntime_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll"]
git-tree-sha1 = "45288942190db7c5f760f59c04495064eedf9340"
uuid = "b0724c58-0f36-5564-988d-3bb0596ebc4a"
version = "0.22.4+0"

[[deps.Ghostscript_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Zlib_jll"]
git-tree-sha1 = "38044a04637976140074d0b0621c1edf0eb531fd"
uuid = "61579ee1-b43e-5ca0-a5da-69d92c66a64b"
version = "9.55.1+0"

[[deps.Giflib_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6570366d757b50fabae9f4315ad74d2e40c0560a"
uuid = "59f7168a-df46-5410-90c8-f2779963d0ec"
version = "5.2.3+0"

[[deps.Glib_jll]]
deps = ["Artifacts", "GettextRuntime_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE2_jll", "Zlib_jll"]
git-tree-sha1 = "50c11ffab2a3d50192a228c313f05b5b5dc5acb2"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.86.0+0"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8a6dbda1fd736d60cc477d99f2e7a042acfa46e8"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.15+0"

[[deps.Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[deps.HTTP]]
deps = ["Base64", "CodecZlib", "ConcurrentUtilities", "Dates", "ExceptionUnwrapping", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "OpenSSL", "PrecompileTools", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "5e6fe50ae7f23d171f44e311c2960294aaa0beb5"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.10.19"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll"]
git-tree-sha1 = "f923f9a774fcf3f5cb761bfa43aeadd689714813"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "8.5.1+0"

[[deps.HypergeometricFunctions]]
deps = ["LinearAlgebra", "OpenLibm_jll", "SpecialFunctions"]
git-tree-sha1 = "68c173f4f449de5b438ee67ed0c9c748dc31a2ec"
uuid = "34004b35-14d8-5ef3-9330-4cdb6864b03a"
version = "0.3.28"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "179267cfa5e712760cd43dcae385d7ea90cc25a4"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.5"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "7134810b1afce04bbc1045ca1985fbe81ce17653"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.5"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "0ee181ec08df7d7c911901ea38baf16f755114dc"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "1.0.0"

[[deps.ImageAxes]]
deps = ["AxisArrays", "ImageBase", "ImageCore", "Reexport", "SimpleTraits"]
git-tree-sha1 = "e12629406c6c4442539436581041d372d69c55ba"
uuid = "2803e5a7-5153-5ecf-9a86-9b4c37f5f5ac"
version = "0.6.12"

[[deps.ImageBase]]
deps = ["ImageCore", "Reexport"]
git-tree-sha1 = "eb49b82c172811fd2c86759fa0553a2221feb909"
uuid = "c817782e-172a-44cc-b673-b171935fbb9e"
version = "0.1.7"

[[deps.ImageCore]]
deps = ["ColorVectorSpace", "Colors", "FixedPointNumbers", "MappedArrays", "MosaicViews", "OffsetArrays", "PaddedViews", "PrecompileTools", "Reexport"]
git-tree-sha1 = "8c193230235bbcee22c8066b0374f63b5683c2d3"
uuid = "a09fc81d-aa75-5fe9-8630-4744c3626534"
version = "0.10.5"

[[deps.ImageIO]]
deps = ["FileIO", "IndirectArrays", "JpegTurbo", "LazyModules", "Netpbm", "OpenEXR", "PNGFiles", "QOI", "Sixel", "TiffImages", "UUIDs", "WebP"]
git-tree-sha1 = "696144904b76e1ca433b886b4e7edd067d76cbf7"
uuid = "82e4d734-157c-48bb-816b-45c225c6df19"
version = "0.6.9"

[[deps.ImageMagick]]
deps = ["FileIO", "ImageCore", "ImageMagick_jll", "InteractiveUtils"]
git-tree-sha1 = "8e64ab2f0da7b928c8ae889c514a52741debc1c2"
uuid = "6218d12a-5da1-5696-b52f-db25d2ecc6d1"
version = "1.4.2"

[[deps.ImageMagick_jll]]
deps = ["Artifacts", "Bzip2_jll", "FFTW_jll", "Ghostscript_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "OpenJpeg_jll", "Zlib_jll", "Zstd_jll", "libpng_jll", "libwebp_jll", "libzip_jll"]
git-tree-sha1 = "d670e8e3adf0332f57054955422e85a4aec6d0b0"
uuid = "c73af94c-d91f-53ed-93a7-00f77d67a9d7"
version = "7.1.2005+0"

[[deps.ImageMetadata]]
deps = ["AxisArrays", "ImageAxes", "ImageBase", "ImageCore"]
git-tree-sha1 = "2a81c3897be6fbcde0802a0ebe6796d0562f63ec"
uuid = "bc367c6b-8a6b-528e-b4bd-a4b897500b49"
version = "0.9.10"

[[deps.ImageShow]]
deps = ["Base64", "ColorSchemes", "FileIO", "ImageBase", "ImageCore", "OffsetArrays", "StackViews"]
git-tree-sha1 = "3b5344bcdbdc11ad58f3b1956709b5b9345355de"
uuid = "4e3cecfd-b093-5904-9786-8bbb286a6a31"
version = "0.3.8"

[[deps.Imath_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "0936ba688c6d201805a83da835b55c61a180db52"
uuid = "905a6f67-0a94-5f89-b386-d35d92009cd1"
version = "3.1.11+0"

[[deps.IndirectArrays]]
git-tree-sha1 = "012e604e1c7458645cb8b436f8fba789a51b257f"
uuid = "9b13fd28-a010-5f03-acff-a1bbcff69959"
version = "1.0.0"

[[deps.Inflate]]
git-tree-sha1 = "d1b1b796e47d94588b3757fe84fbf65a5ec4a80d"
uuid = "d25df0c9-e2be-5dd7-82c8-3ad0b3e990b9"
version = "0.1.5"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
version = "1.11.0"

[[deps.IntervalSets]]
git-tree-sha1 = "5fbb102dcb8b1a858111ae81d56682376130517d"
uuid = "8197267c-284f-5f27-9208-e0e47529a953"
version = "0.7.11"
weakdeps = ["Random", "RecipesBase", "Statistics"]

    [deps.IntervalSets.extensions]
    IntervalSetsRandomExt = "Random"
    IntervalSetsRecipesBaseExt = "RecipesBase"
    IntervalSetsStatisticsExt = "Statistics"

[[deps.IrrationalConstants]]
git-tree-sha1 = "b2d91fe939cae05960e760110b328288867b5758"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.6"

[[deps.IterTools]]
git-tree-sha1 = "42d5f897009e7ff2cf88db414a389e5ed1bdd023"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.10.0"

[[deps.JLFzf]]
deps = ["REPL", "Random", "fzf_jll"]
git-tree-sha1 = "82f7acdc599b65e0f8ccd270ffa1467c21cb647b"
uuid = "1019f520-868f-41f5-a6de-eb00f4b6a39c"
version = "0.1.11"

[[deps.JLLWrappers]]
deps = ["Artifacts", "Preferences"]
git-tree-sha1 = "0533e564aae234aff59ab625543145446d8b6ec2"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.7.1"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.JpegTurbo]]
deps = ["CEnum", "FileIO", "ImageCore", "JpegTurbo_jll", "TOML"]
git-tree-sha1 = "9496de8fb52c224a2e3f9ff403947674517317d9"
uuid = "b835a17e-a41a-41e7-81f0-2f016b05efe0"
version = "0.1.6"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "4255f0032eafd6451d707a51d5f0248b8a165e4d"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "3.1.3+0"

[[deps.LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "059aabebaa7c82ccb853dd4a0ee9d17796f7e1bc"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.3+0"

[[deps.LERC_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "aaafe88dccbd957a8d82f7d05be9b69172e0cee3"
uuid = "88015f11-f218-50d7-93a8-a6af411a945d"
version = "4.0.1+0"

[[deps.LLVMOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "eb62a3deb62fc6d8822c0c4bef73e4412419c5d8"
uuid = "1d63c593-3942-5779-bab2-d838dc0a180e"
version = "18.1.8+0"

[[deps.LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1c602b1127f4751facb671441ca72715cc95938a"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.3+0"

[[deps.LaTeXStrings]]
git-tree-sha1 = "dda21b8cbd6a6c40d9d02a73230f9d70fed6918c"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.4.0"

[[deps.Latexify]]
deps = ["Format", "Ghostscript_jll", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "OrderedCollections", "Requires"]
git-tree-sha1 = "44f93c47f9cd6c7e431f2f2091fcba8f01cd7e8f"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.16.10"

    [deps.Latexify.extensions]
    DataFramesExt = "DataFrames"
    SparseArraysExt = "SparseArrays"
    SymEngineExt = "SymEngine"
    TectonicExt = "tectonic_jll"

    [deps.Latexify.weakdeps]
    DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
    SymEngine = "123dc426-2d89-5057-bbad-38513e3affd8"
    tectonic_jll = "d7dd28d6-a5e6-559c-9131-7eb760cdacc5"

[[deps.LazyModules]]
git-tree-sha1 = "a560dd966b386ac9ae60bdd3a3d3a326062d3c3e"
uuid = "8cdb02fc-e678-4876-92c5-9defec4f444e"
version = "0.3.1"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.4"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.6.0+0"

[[deps.LibGit2]]
deps = ["Base64", "LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"
version = "1.11.0"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.7.2+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.0+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"
version = "1.11.0"

[[deps.Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "c8da7e6a91781c41a863611c7e966098d783c57a"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.4.7+0"

[[deps.Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "d36c21b9e7c172a44a10484125024495e2625ac0"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.7.1+1"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "be484f5c92fad0bd8acfef35fe017900b0b73809"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.18.0+0"

[[deps.Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "3acf07f130a76f87c041cfb2ff7d7284ca67b072"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.41.2+0"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "XZ_jll", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "f04133fe05eff1667d2054c53d59f9122383fe05"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.7.2+0"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "2a7a12fc0a4e7fb773450d17975322aa77142106"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.41.2+0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
version = "1.11.0"

[[deps.LittleCMS_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll"]
git-tree-sha1 = "8e6a74641caf3b84800f2ccd55dc7ab83893c10b"
uuid = "d3a379c0-f9a3-5b72-a4c0-6bf4d2e8af0f"
version = "2.17.0+0"

[[deps.LogExpFunctions]]
deps = ["DocStringExtensions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "13ca9e2586b89836fd20cccf56e57e2b9ae7f38f"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.29"

    [deps.LogExpFunctions.extensions]
    LogExpFunctionsChainRulesCoreExt = "ChainRulesCore"
    LogExpFunctionsChangesOfVariablesExt = "ChangesOfVariables"
    LogExpFunctionsInverseFunctionsExt = "InverseFunctions"

    [deps.LogExpFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    ChangesOfVariables = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"
version = "1.11.0"

[[deps.LoggingExtras]]
deps = ["Dates", "Logging"]
git-tree-sha1 = "f00544d95982ea270145636c181ceda21c4e2575"
uuid = "e6f89c97-d47a-5376-807f-9c37f3926c36"
version = "1.2.0"

[[deps.MIMEs]]
git-tree-sha1 = "c64d943587f7187e751162b3b84445bbbd79f691"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "1.1.0"

[[deps.MacroTools]]
git-tree-sha1 = "1e0228a030642014fe5cfe68c2c0a818f9e3f522"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.16"

[[deps.MappedArrays]]
git-tree-sha1 = "2dab0221fe2b0f2cb6754eaa743cc266339f527e"
uuid = "dbb5928d-eab1-5f90-85c2-b9b0edb7c900"
version = "0.4.2"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"
version = "1.11.0"

[[deps.MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "MozillaCACerts_jll", "NetworkOptions", "Random", "Sockets"]
git-tree-sha1 = "c067a280ddc25f196b5e7df3877c6b226d390aaf"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.1.9"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.6+0"

[[deps.Measures]]
git-tree-sha1 = "b513cedd20d9c914783d8ad83d08120702bf2c77"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.3"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "ec4f7fbeab05d7747bdf98eb74d130a2a2ed298d"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.2.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"
version = "1.11.0"

[[deps.MosaicViews]]
deps = ["MappedArrays", "OffsetArrays", "PaddedViews", "StackViews"]
git-tree-sha1 = "7b86a5d4d70a9f5cdf2dacb3cbe6d251d1a61dbe"
uuid = "e94cdb99-869f-56ef-bcf0-1ae2bcbe0389"
version = "0.3.4"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.12.12"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "9b8215b1ee9e78a293f99797cd31375471b2bcae"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.1.3"

[[deps.Netpbm]]
deps = ["FileIO", "ImageCore", "ImageMetadata"]
git-tree-sha1 = "d92b107dbb887293622df7697a2223f9f8176fcd"
uuid = "f09324ee-3d7c-5217-9330-fc30815ba969"
version = "1.1.1"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OffsetArrays]]
git-tree-sha1 = "117432e406b5c023f665fa73dc26e79ec3630151"
uuid = "6fe1bfb0-de20-5000-8ca7-80f57d26f881"
version = "1.17.0"

    [deps.OffsetArrays.extensions]
    OffsetArraysAdaptExt = "Adapt"

    [deps.OffsetArrays.weakdeps]
    Adapt = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "b6aa4566bb7ae78498a5e68943863fa8b5231b59"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.6+0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.27+1"

[[deps.OpenEXR]]
deps = ["Colors", "FileIO", "OpenEXR_jll"]
git-tree-sha1 = "97db9e07fe2091882c765380ef58ec553074e9c7"
uuid = "52e1d378-f018-4a11-a4be-720524705ac7"
version = "0.3.3"

[[deps.OpenEXR_jll]]
deps = ["Artifacts", "Imath_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "8292dd5c8a38257111ada2174000a33745b06d4e"
uuid = "18a262bb-aa17-5467-a713-aee519bc75cb"
version = "3.2.4+0"

[[deps.OpenJpeg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libtiff_jll", "LittleCMS_jll", "libpng_jll"]
git-tree-sha1 = "215a6666fee6d6b3a6e75f2cc22cb767e2dd393a"
uuid = "643b3616-a352-519d-856d-80112ee9badc"
version = "2.5.5+0"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.5+0"

[[deps.OpenSSL]]
deps = ["BitFlags", "Dates", "MozillaCACerts_jll", "NetworkOptions", "OpenSSL_jll", "Sockets"]
git-tree-sha1 = "386b47442468acfb1add94bf2d85365dea10cbab"
uuid = "4d8831e6-92b7-49fb-bdf8-b643e874388c"
version = "1.6.0"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "f19301ae653233bc88b1810ae908194f07f8db9d"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "3.5.4+0"

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1346c9208249809840c91b26703912dff463d335"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.6+0"

[[deps.Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "c392fc5dd032381919e3b22dd32d6443760ce7ea"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.5.2+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "05868e21324cede2207c6f0f466b4bfef6d5e7ee"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.8.1"

[[deps.PCRE2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "efcefdf7-47ab-520b-bdef-62a2eaa19f15"
version = "10.42.0+1"

[[deps.PDMats]]
deps = ["LinearAlgebra", "SparseArrays", "SuiteSparse"]
git-tree-sha1 = "d922b4d80d1e12c658da7785e754f4796cc1d60d"
uuid = "90014a1f-27ba-587c-ab20-58faa44d9150"
version = "0.11.36"
weakdeps = ["StatsBase"]

    [deps.PDMats.extensions]
    StatsBaseExt = "StatsBase"

[[deps.PNGFiles]]
deps = ["Base64", "CEnum", "ImageCore", "IndirectArrays", "OffsetArrays", "libpng_jll"]
git-tree-sha1 = "cf181f0b1e6a18dfeb0ee8acc4a9d1672499626c"
uuid = "f57f5aa1-a3ce-4bc8-8ab9-96f992907883"
version = "0.4.4"

[[deps.PaddedViews]]
deps = ["OffsetArrays"]
git-tree-sha1 = "0fac6313486baae819364c52b4f483450a9d793f"
uuid = "5432bcbf-9aad-5242-b902-cca2824c8663"
version = "0.5.12"

[[deps.Pango_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "FriBidi_jll", "Glib_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1f7f9bbd5f7a2e5a9f7d96e51c9754454ea7f60b"
uuid = "36c8627f-9965-5494-a995-c6b170f724f3"
version = "1.56.4+0"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "7d2f8f21da5db6a806faf7b9b292296da42b2810"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.3"

[[deps.Pixman_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "LLVMOpenMP_jll", "Libdl"]
git-tree-sha1 = "db76b1ecd5e9715f3d043cec13b2ec93ce015d53"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.44.2+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "Random", "SHA", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.11.0"
weakdeps = ["REPL"]

    [deps.Pkg.extensions]
    REPLExt = "REPL"

[[deps.PkgVersion]]
deps = ["Pkg"]
git-tree-sha1 = "f9501cc0430a26bc3d156ae1b5b0c1b47af4d6da"
uuid = "eebad327-c553-4316-9ea0-9fa01ccd7688"
version = "0.3.3"

[[deps.PlotThemes]]
deps = ["PlotUtils", "Statistics"]
git-tree-sha1 = "41031ef3a1be6f5bbbf3e8073f210556daeae5ca"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "3.3.0"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "PrecompileTools", "Printf", "Random", "Reexport", "StableRNGs", "Statistics"]
git-tree-sha1 = "3ca9a356cd2e113c420f2c13bea19f8d3fb1cb18"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.4.3"

[[deps.Plots]]
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "JLFzf", "JSON", "LaTeXStrings", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "Pkg", "PlotThemes", "PlotUtils", "PrecompileTools", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "RelocatableFolders", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "TOML", "UUIDs", "UnicodeFun", "Unzip"]
git-tree-sha1 = "12ce661880f8e309569074a61d3767e5756a199f"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.41.1"

    [deps.Plots.extensions]
    FileIOExt = "FileIO"
    GeometryBasicsExt = "GeometryBasics"
    IJuliaExt = "IJulia"
    ImageInTerminalExt = "ImageInTerminal"
    UnitfulExt = "Unitful"

    [deps.Plots.weakdeps]
    FileIO = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
    GeometryBasics = "5c1252a2-5f33-56bf-86c9-59e7332b4326"
    IJulia = "7073ff75-c697-5162-941a-fcdaad2a7d2a"
    ImageInTerminal = "d8c32880-2388-543b-8c61-d9f865259254"
    Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[[deps.PlutoTeachingTools]]
deps = ["Downloads", "HypertextLiteral", "Latexify", "Markdown", "PlutoUI"]
git-tree-sha1 = "dacc8be63916b078b592806acd13bb5e5137d7e9"
uuid = "661c6b06-c737-4d37-b85c-46df65de6f69"
version = "0.4.6"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Downloads", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "3faff84e6f97a7f18e0dd24373daa229fd358db5"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.73"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "5aa36f7049a63a1528fe8f7c3f2113413ffd4e1f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.1"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "0f27480397253da18fe2c12a4ba4eb9eb208bf3d"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.5.0"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"
version = "1.11.0"

[[deps.Profile]]
uuid = "9abbd945-dff8-562f-b5e8-e1ebf5ef1b79"
version = "1.11.0"

[[deps.ProgressMeter]]
deps = ["Distributed", "Printf"]
git-tree-sha1 = "fbb92c6c56b34e1a2c4c36058f68f332bec840e7"
uuid = "92933f4c-e287-5a05-a399-4b506db050ca"
version = "1.11.0"

[[deps.PtrArrays]]
git-tree-sha1 = "1d36ef11a9aaf1e8b74dacc6a731dd1de8fd493d"
uuid = "43287f4e-b6f4-7ad1-bb20-aadabca52c3d"
version = "1.3.0"

[[deps.QOI]]
deps = ["ColorTypes", "FileIO", "FixedPointNumbers"]
git-tree-sha1 = "8b3fc30bc0390abdce15f8822c889f669baed73d"
uuid = "4b34888f-f399-49d4-9bb3-47ed5cae4e65"
version = "1.0.1"

[[deps.Qt6Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Vulkan_Loader_jll", "Xorg_libSM_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_cursor_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "libinput_jll", "xkbcommon_jll"]
git-tree-sha1 = "34f7e5d2861083ec7596af8b8c092531facf2192"
uuid = "c0090381-4147-56d7-9ebc-da0b1113ec56"
version = "6.8.2+2"

[[deps.Qt6Declarative_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Qt6Base_jll", "Qt6ShaderTools_jll"]
git-tree-sha1 = "da7adf145cce0d44e892626e647f9dcbe9cb3e10"
uuid = "629bc702-f1f5-5709-abd5-49b8460ea067"
version = "6.8.2+1"

[[deps.Qt6ShaderTools_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Qt6Base_jll"]
git-tree-sha1 = "9eca9fc3fe515d619ce004c83c31ffd3f85c7ccf"
uuid = "ce943373-25bb-56aa-8eca-768745ed7b5a"
version = "6.8.2+1"

[[deps.Qt6Wayland_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Qt6Base_jll", "Qt6Declarative_jll"]
git-tree-sha1 = "8f528b0851b5b7025032818eb5abbeb8a736f853"
uuid = "e99dba38-086e-5de3-a5b1-6e4c66e897c3"
version = "6.8.2+2"

[[deps.QuadGK]]
deps = ["DataStructures", "LinearAlgebra"]
git-tree-sha1 = "9da16da70037ba9d701192e27befedefb91ec284"
uuid = "1fd47b50-473d-5c70-9696-f719f8f3bcdc"
version = "2.11.2"

    [deps.QuadGK.extensions]
    QuadGKEnzymeExt = "Enzyme"

    [deps.QuadGK.weakdeps]
    Enzyme = "7da242da-08ed-463a-9acd-ee780be4f1d9"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "StyledStrings", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"
version = "1.11.0"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
version = "1.11.0"

[[deps.RangeArrays]]
git-tree-sha1 = "b9039e93773ddcfc828f12aadf7115b4b4d225f5"
uuid = "b3c3ace0-ae52-54e7-9d0b-2c1406fd6b9d"
version = "0.3.2"

[[deps.RecipesBase]]
deps = ["PrecompileTools"]
git-tree-sha1 = "5c3d09cc4f31f5fc6af001c250bf1278733100ff"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.3.4"

[[deps.RecipesPipeline]]
deps = ["Dates", "NaNMath", "PlotUtils", "PrecompileTools", "RecipesBase"]
git-tree-sha1 = "45cf9fd0ca5839d06ef333c8201714e888486342"
uuid = "01d81517-befc-4cb6-b9ec-a95719d0359c"
version = "0.6.12"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.RelocatableFolders]]
deps = ["SHA", "Scratch"]
git-tree-sha1 = "ffdaf70d81cf6ff22c2b6e733c900c3321cab864"
uuid = "05181044-ff0b-4ac5-8273-598c1e38db00"
version = "1.0.1"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "62389eeff14780bfe55195b7204c0d8738436d64"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.1"

[[deps.Rmath]]
deps = ["Random", "Rmath_jll"]
git-tree-sha1 = "5b3d50eb374cea306873b371d3f8d3915a018f0b"
uuid = "79098fc4-a85e-5d69-aa6a-4863f24498fa"
version = "0.9.0"

[[deps.Rmath_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "58cdd8fb2201a6267e1db87ff148dd6c1dbd8ad8"
uuid = "f50d1b31-88e8-58de-be2c-1cc44531875f"
version = "0.5.1+0"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.SIMD]]
deps = ["PrecompileTools"]
git-tree-sha1 = "e24dc23107d426a096d3eae6c165b921e74c18e4"
uuid = "fdea26ae-647d-5447-a871-4b548cad5224"
version = "3.7.2"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "9b81b8393e50b7d4e6d0a9f14e192294d3b7c109"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.3.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"
version = "1.11.0"

[[deps.Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

[[deps.SimpleBufferStream]]
git-tree-sha1 = "f305871d2f381d21527c770d4788c06c097c9bc1"
uuid = "777ac1f9-54b0-4bf8-805c-2214025038e7"
version = "1.2.0"

[[deps.SimpleTraits]]
deps = ["InteractiveUtils", "MacroTools"]
git-tree-sha1 = "be8eeac05ec97d379347584fa9fe2f5f76795bcb"
uuid = "699a6c99-e7fa-54fc-8d76-47d257e15c1d"
version = "0.9.5"

[[deps.Sixel]]
deps = ["Dates", "FileIO", "ImageCore", "IndirectArrays", "OffsetArrays", "REPL", "libsixel_jll"]
git-tree-sha1 = "0494aed9501e7fb65daba895fb7fd57cc38bc743"
uuid = "45858cf5-a6b0-47a3-bbea-62219f50df47"
version = "0.1.5"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"
version = "1.11.0"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "64d974c2e6fdf07f8155b5b2ca2ffa9069b608d9"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.2.2"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
version = "1.11.0"

[[deps.SpecialFunctions]]
deps = ["IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "f2685b435df2613e25fc10ad8c26dddb8640f547"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.6.1"

    [deps.SpecialFunctions.extensions]
    SpecialFunctionsChainRulesCoreExt = "ChainRulesCore"

    [deps.SpecialFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"

[[deps.StableRNGs]]
deps = ["Random"]
git-tree-sha1 = "95af145932c2ed859b63329952ce8d633719f091"
uuid = "860ef19b-820b-49d6-a774-d7a799459cd3"
version = "1.0.3"

[[deps.StackViews]]
deps = ["OffsetArrays"]
git-tree-sha1 = "be1cf4eb0ac528d96f5115b4ed80c26a8d8ae621"
uuid = "cae243ae-269e-4f55-b966-ac2d0dc13c15"
version = "0.1.2"

[[deps.Statistics]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "ae3bb1eb3bba077cd276bc5cfc337cc65c3075c0"
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.11.1"
weakdeps = ["SparseArrays"]

    [deps.Statistics.extensions]
    SparseArraysExt = ["SparseArrays"]

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "9d72a13a3f4dd3795a195ac5a44d7d6ff5f552ff"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.7.1"

[[deps.StatsBase]]
deps = ["AliasTables", "DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "a136f98cefaf3e2924a66bd75173d1c891ab7453"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.34.7"

[[deps.StatsFuns]]
deps = ["HypergeometricFunctions", "IrrationalConstants", "LogExpFunctions", "Reexport", "Rmath", "SpecialFunctions"]
git-tree-sha1 = "91f091a8716a6bb38417a6e6f274602a19aaa685"
uuid = "4c63d2b9-4356-54db-8cca-17b64c39e42c"
version = "1.5.2"

    [deps.StatsFuns.extensions]
    StatsFunsChainRulesCoreExt = "ChainRulesCore"
    StatsFunsInverseFunctionsExt = "InverseFunctions"

    [deps.StatsFuns.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.StringDistances]]
deps = ["Distances", "StatsAPI"]
git-tree-sha1 = "5b2ca70b099f91e54d98064d5caf5cc9b541ad06"
uuid = "88034a9c-02f8-509d-84a9-84ec65e18404"
version = "0.11.3"

[[deps.StyledStrings]]
uuid = "f489334b-da3d-4c2e-b8f0-e476e12c162b"
version = "1.11.0"

[[deps.SuiteSparse]]
deps = ["Libdl", "LinearAlgebra", "Serialization", "SparseArrays"]
uuid = "4607b0f0-06f3-5cda-b6b1-a6196a1729e9"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "7.7.0+0"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.TensorCore]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1feb45f88d133a655e001435632f019a9a1bcdb6"
uuid = "62fd8b95-f654-4bbd-a8a5-9c27f68ccd50"
version = "0.1.1"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"
version = "1.11.0"

[[deps.TestImages]]
deps = ["AxisArrays", "ColorTypes", "FileIO", "ImageIO", "ImageMagick", "OffsetArrays", "Pkg", "StringDistances"]
git-tree-sha1 = "fc32a2c7972e2829f34cf7ef10bbcb11c9b0a54c"
uuid = "5e47fb64-e119-507b-a336-dd2b206d9990"
version = "1.9.0"

[[deps.TiffImages]]
deps = ["ColorTypes", "DataStructures", "DocStringExtensions", "FileIO", "FixedPointNumbers", "IndirectArrays", "Inflate", "Mmap", "OffsetArrays", "PkgVersion", "PrecompileTools", "ProgressMeter", "SIMD", "UUIDs"]
git-tree-sha1 = "98b9352a24cb6a2066f9ababcc6802de9aed8ad8"
uuid = "731e570b-9d59-4bfa-96dc-6df516fadf69"
version = "0.11.6"

[[deps.TranscodingStreams]]
git-tree-sha1 = "0c45878dcfdcfa8480052b6ab162cdd138781742"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.11.3"

[[deps.Tricks]]
git-tree-sha1 = "311349fd1c93a31f783f977a71e8b062a57d4101"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.13"

[[deps.URIs]]
git-tree-sha1 = "bef26fb046d031353ef97a82e3fdb6afe7f21b1a"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.6.1"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"
version = "1.11.0"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
version = "1.11.0"

[[deps.UnicodeFun]]
deps = ["REPL"]
git-tree-sha1 = "53915e50200959667e78a92a418594b428dffddf"
uuid = "1cfade01-22cf-5700-b092-accc4b62d6e1"
version = "0.4.1"

[[deps.Unzip]]
git-tree-sha1 = "ca0969166a028236229f63514992fc073799bb78"
uuid = "41fe7b60-77ed-43a1-b4f0-825fd5a5650d"
version = "0.2.0"

[[deps.Vulkan_Loader_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Wayland_jll", "Xorg_libX11_jll", "Xorg_libXrandr_jll", "xkbcommon_jll"]
git-tree-sha1 = "2f0486047a07670caad3a81a075d2e518acc5c59"
uuid = "a44049a8-05dd-5a78-86c9-5fde0876e88c"
version = "1.3.243+0"

[[deps.Wayland_jll]]
deps = ["Artifacts", "EpollShim_jll", "Expat_jll", "JLLWrappers", "Libdl", "Libffi_jll"]
git-tree-sha1 = "96478df35bbc2f3e1e791bc7a3d0eeee559e60e9"
uuid = "a2964d1f-97da-50d4-b82a-358c7fce9d89"
version = "1.24.0+0"

[[deps.WebP]]
deps = ["CEnum", "ColorTypes", "FileIO", "FixedPointNumbers", "ImageCore", "libwebp_jll"]
git-tree-sha1 = "aa1ca3c47f119fbdae8770c29820e5e6119b83f2"
uuid = "e3aaa7dc-3e4b-44e0-be63-ffb868ccd7c1"
version = "0.1.3"

[[deps.XZ_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "fee71455b0aaa3440dfdd54a9a36ccef829be7d4"
uuid = "ffd25f8a-64ca-5728-b0f7-c24cf3aae800"
version = "5.8.1+0"

[[deps.Xorg_libICE_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "a3ea76ee3f4facd7a64684f9af25310825ee3668"
uuid = "f67eecfb-183a-506d-b269-f58e52b52d7c"
version = "1.1.2+0"

[[deps.Xorg_libSM_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libICE_jll"]
git-tree-sha1 = "9c7ad99c629a44f81e7799eb05ec2746abb5d588"
uuid = "c834827a-8449-5923-a945-d239c165b7dd"
version = "1.2.6+0"

[[deps.Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "b5899b25d17bf1889d25906fb9deed5da0c15b3b"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.8.12+0"

[[deps.Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "aa1261ebbac3ccc8d16558ae6799524c450ed16b"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.13+0"

[[deps.Xorg_libXcursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXfixes_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "6c74ca84bbabc18c4547014765d194ff0b4dc9da"
uuid = "935fb764-8cf2-53bf-bb30-45bb1f8bf724"
version = "1.2.4+0"

[[deps.Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "52858d64353db33a56e13c341d7bf44cd0d7b309"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.6+0"

[[deps.Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "a4c0ee07ad36bf8bbce1c3bb52d21fb1e0b987fb"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.7+0"

[[deps.Xorg_libXfixes_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "75e00946e43621e09d431d9b95818ee751e6b2ef"
uuid = "d091e8ba-531a-589c-9de9-94069b037ed8"
version = "6.0.2+0"

[[deps.Xorg_libXi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXext_jll", "Xorg_libXfixes_jll"]
git-tree-sha1 = "a376af5c7ae60d29825164db40787f15c80c7c54"
uuid = "a51aa0fd-4e3c-5386-b890-e753decda492"
version = "1.8.3+0"

[[deps.Xorg_libXinerama_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXext_jll"]
git-tree-sha1 = "a5bc75478d323358a90dc36766f3c99ba7feb024"
uuid = "d1454406-59df-5ea1-beac-c340f2130bc3"
version = "1.1.6+0"

[[deps.Xorg_libXrandr_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXext_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "aff463c82a773cb86061bce8d53a0d976854923e"
uuid = "ec84b674-ba8e-5d96-8ba1-2a689ba10484"
version = "1.5.5+0"

[[deps.Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "7ed9347888fac59a618302ee38216dd0379c480d"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.12+0"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXau_jll", "Xorg_libXdmcp_jll"]
git-tree-sha1 = "bfcaf7ec088eaba362093393fe11aa141fa15422"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.17.1+0"

[[deps.Xorg_libxkbfile_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "e3150c7400c41e207012b41659591f083f3ef795"
uuid = "cc61e674-0454-545c-8b26-ed2c68acab7a"
version = "1.1.3+0"

[[deps.Xorg_xcb_util_cursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_jll", "Xorg_xcb_util_renderutil_jll"]
git-tree-sha1 = "9750dc53819eba4e9a20be42349a6d3b86c7cdf8"
uuid = "e920d4aa-a673-5f3a-b3d7-f755a4d47c43"
version = "0.1.6+0"

[[deps.Xorg_xcb_util_image_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_jll"]
git-tree-sha1 = "f4fc02e384b74418679983a97385644b67e1263b"
uuid = "12413925-8142-5f55-bb0e-6d7ca50bb09b"
version = "0.4.1+0"

[[deps.Xorg_xcb_util_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll"]
git-tree-sha1 = "68da27247e7d8d8dafd1fcf0c3654ad6506f5f97"
uuid = "2def613f-5ad1-5310-b15b-b15d46f528f5"
version = "0.4.1+0"

[[deps.Xorg_xcb_util_keysyms_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_jll"]
git-tree-sha1 = "44ec54b0e2acd408b0fb361e1e9244c60c9c3dd4"
uuid = "975044d2-76e6-5fbe-bf08-97ce7c6574c7"
version = "0.4.1+0"

[[deps.Xorg_xcb_util_renderutil_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_jll"]
git-tree-sha1 = "5b0263b6d080716a02544c55fdff2c8d7f9a16a0"
uuid = "0d47668e-0667-5a69-a72c-f761630bfb7e"
version = "0.3.10+0"

[[deps.Xorg_xcb_util_wm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_jll"]
git-tree-sha1 = "f233c83cad1fa0e70b7771e0e21b061a116f2763"
uuid = "c22f9ab0-d5fe-5066-847c-f4bb1cd4e361"
version = "0.4.2+0"

[[deps.Xorg_xkbcomp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxkbfile_jll"]
git-tree-sha1 = "801a858fc9fb90c11ffddee1801bb06a738bda9b"
uuid = "35661453-b289-5fab-8a00-3d9160c6a3a4"
version = "1.4.7+0"

[[deps.Xorg_xkeyboard_config_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xkbcomp_jll"]
git-tree-sha1 = "00af7ebdc563c9217ecc67776d1bbf037dbcebf4"
uuid = "33bec58e-1273-512f-9401-5d533626f822"
version = "2.44.0+0"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "a63799ff68005991f9d9491b6e95bd3478d783cb"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.6.0+0"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+1"

[[deps.Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "446b23e73536f84e8037f5dce465e92275f6a308"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.7+1"

[[deps.eudev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "c3b0e6196d50eab0c5ed34021aaa0bb463489510"
uuid = "35ca27e7-8b34-5b7f-bca9-bdc33f59eb06"
version = "3.2.14+0"

[[deps.fzf_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "b6a34e0e0960190ac2a4363a1bd003504772d631"
uuid = "214eeab7-80f7-51ab-84ad-2988db7cef09"
version = "0.61.1+0"

[[deps.libaom_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "371cc681c00a3ccc3fbc5c0fb91f58ba9bec1ecf"
uuid = "a4ae2306-e953-59d6-aa16-d00cac43593b"
version = "3.13.1+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "125eedcb0a4a0bba65b657251ce1d27c8714e9d6"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.17.4+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.11.0+0"

[[deps.libdecor_jll]]
deps = ["Artifacts", "Dbus_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "Pango_jll", "Wayland_jll", "xkbcommon_jll"]
git-tree-sha1 = "9bf7903af251d2050b467f76bdbe57ce541f7f4f"
uuid = "1183f4f0-6f2a-5f1a-908b-139f9cdfea6f"
version = "0.2.2+0"

[[deps.libevdev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "56d643b57b188d30cccc25e331d416d3d358e557"
uuid = "2db6ffa8-e38f-5e21-84af-90c45d0032cc"
version = "1.13.4+0"

[[deps.libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "646634dd19587a56ee2f1199563ec056c5f228df"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.4+0"

[[deps.libinput_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "eudev_jll", "libevdev_jll", "mtdev_jll"]
git-tree-sha1 = "91d05d7f4a9f67205bd6cf395e488009fe85b499"
uuid = "36db933b-70db-51c0-b978-0f229ee0e533"
version = "1.28.1+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "07b6a107d926093898e82b3b1db657ebe33134ec"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.50+0"

[[deps.libsixel_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "Libdl", "libpng_jll"]
git-tree-sha1 = "c1733e347283df07689d71d61e14be986e49e47a"
uuid = "075b6546-f08a-558a-be8f-8157d0f608a5"
version = "1.10.5+0"

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll"]
git-tree-sha1 = "11e1772e7f3cc987e9d3de991dd4f6b2602663a5"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.8+0"

[[deps.libwebp_jll]]
deps = ["Artifacts", "Giflib_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libglvnd_jll", "Libtiff_jll", "libpng_jll"]
git-tree-sha1 = "4e4282c4d846e11dce56d74fa8040130b7a95cb3"
uuid = "c5f90fcd-3b7e-5836-afba-fc50a0988cb2"
version = "1.6.0+0"

[[deps.libzip_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "OpenSSL_jll", "XZ_jll", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "86addc139bca85fdf9e7741e10977c45785727b7"
uuid = "337d8026-41b4-5cde-a456-74a10e5b31d1"
version = "1.11.3+0"

[[deps.mtdev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "b4d631fd51f2e9cdd93724ae25b2efc198b059b1"
uuid = "009596ad-96f7-51b1-9f1b-5ce2d5e8a71e"
version = "1.1.7+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.59.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+2"

[[deps.x264_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "14cc7083fc6dff3cc44f2bc435ee96d06ed79aa7"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "10164.0.1+0"

[[deps.x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e7b67590c14d487e734dcb925924c5dc43ec85f3"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "4.1.0+0"

[[deps.xkbcommon_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll", "Xorg_xkeyboard_config_jll"]
git-tree-sha1 = "fbf139bce07a534df0e699dbb5f5cc9346f95cc1"
uuid = "d8fb68d0-12a3-5cfd-a85a-d49703b185fd"
version = "1.9.2+0"
"""

# ╔═╡ Cell order:
# ╟─23a44498-6941-4436-a595-ff75a02fce49
# ╟─ff5d316f-806c-4652-97d8-323462395c69
# ╟─f7347c06-c1b7-11ed-3b8e-fbf167ce9cba
# ╟─bdcb27c5-0603-49ac-b831-d78c558b31f0
# ╟─ddd6e83e-5a0d-4ff0-afe4-dedfc860994c
# ╟─8ece9aea-20f5-41db-95ca-08c8d4d2d4c1
# ╠═d03e4e95-faab-4ab3-ab27-81189cbd8231
# ╟─44ec9e94-f6af-431e-8841-bae44431dfa3
# ╟─06c0ad65-22d4-4c8e-ae19-4f05ba125e79
# ╠═755b8685-0711-48a2-a3eb-f80af39f10e1
# ╟─5061a130-fc0a-4306-bdf5-6966e8de938a
# ╟─74e27f45-9897-4ddd-8516-59669b17b1ad
# ╟─d358da52-ee09-4533-a2ef-c68b847e24d5
# ╟─e5670193-6221-49c6-a880-d287f717545e
# ╠═a4bb8383-1238-411e-b697-ed258d3c0c6d
# ╠═cb871521-e3d8-4b87-a474-b45b5c8167a9
# ╟─5e70263e-6512-40ef-ad0a-38287dfba684
# ╠═11df83bc-cb8e-4782-89f4-8abb73803621
# ╟─b3d54500-daab-4360-943d-30997c90aa02
# ╠═fed6823a-bd16-4efd-804c-58dd5a2339ef
# ╟─e6db1935-af93-4850-acfe-92cec4de4fed
# ╟─17f681ef-f30f-41fa-af34-7f331d359518
# ╠═7d81c2cb-5ce2-4a25-96f4-66688863bb54
# ╟─7adeed1a-70d7-45c4-99e1-9be23bbbeb86
# ╟─0af1c0ee-9739-41be-833e-20b838d3e502
# ╠═09cf939d-88df-4c7e-b164-67bfa431aaa7
# ╟─337eeee7-d39a-4a0e-9988-3e8830ae3989
# ╠═23676fde-e080-4e78-9c22-a2f05178f0c1
# ╠═85717691-5103-4c6f-bf6f-f56bbdb67b43
# ╟─542df6a2-5e73-4eff-af6e-353e39861c6c
# ╠═bb555bee-b9d5-4b6e-95c2-2793c3a2820b
# ╟─effd9509-4ad7-4d1f-96a5-dd9b32b09daa
# ╠═110bb376-57b6-4957-8e99-b8f564090fc1
# ╟─d6dabb0b-c6bc-4581-bb20-5dc598f5d323
# ╠═15fe42c4-9262-4673-b1b8-f417de0271d9
# ╟─9f137e55-ff39-4b95-b501-78921c27f4db
# ╠═4c3b1036-f530-43de-83e2-91ef962a86d6
# ╟─377fa7fd-f4a0-46a3-9511-d52155981cb9
# ╟─7f8b9940-9ebf-4d93-a76c-1e055c733122
# ╠═d5ebd2a3-8067-479c-bd9d-6e9c7c55972e
# ╟─3e933ccb-a6f3-4c2c-99ae-7ff03ed3a786
# ╠═8d144b90-32de-4367-86aa-89dd897c66d5
# ╠═57a9a2a7-06cd-4d55-b7fd-2f6d86f938a7
# ╠═afc54444-091c-4d06-95d3-dc7f0cb127b5
# ╠═61895459-48df-419f-b884-5cb51e1038e9
# ╠═c467be45-d8ef-4f68-9794-0ee9f15acf5f
# ╟─5858a0b8-6ead-4f26-b7be-ec684bd4602d
# ╟─49c75eed-d1cc-47e0-884b-8c327f638250
# ╠═ec262620-a818-4f5c-b6b9-24a58b73a603
# ╟─81a85548-ccf0-4d09-9cdf-f6eefc08017a
# ╠═8789e280-9d06-4284-8f43-42824e06bb20
# ╠═3fe28b4d-4a7a-4ea9-9b60-7a50c8f6b1e3
# ╠═6112c7eb-b2fb-4f46-8601-bc5787577042
# ╠═bcb516cd-6bee-4cd8-b633-a872a2bc107f
# ╟─0585d514-9255-49c5-bf57-c408c71600c7
# ╟─ef2c3f94-5db0-4a49-8bb2-cd2380e6fd82
# ╟─8401a066-f5c0-4d86-8d0e-e9c287762252
# ╟─7e4268d1-54d9-429b-9ec2-c2ccab5a7eda
# ╠═f597829c-b0c7-4b7f-b58b-bac8e52030f5
# ╟─5bba64bc-1dd1-4a71-bfe0-86497c31d617
# ╠═f1846dfe-0718-49f9-9825-84256a871ac7
# ╠═a72971ae-b1de-4892-85d2-52cb8ff025ff
# ╟─dcba5dbb-1a3d-49e8-a301-68c6bcae13b7
# ╠═87236fbd-e09c-4b81-b065-5954b2057b9b
# ╟─4e1f60e5-77c1-467a-9500-69c00f74700c
# ╟─ef23ba30-3f81-4676-850f-1a65062753a6
# ╠═74d0409d-8a10-4660-8a01-c75505f612e2
# ╟─7f9afd24-fd1c-49cd-b6bf-598cea9758c7
# ╟─05032f1b-ca1e-4fb0-ae21-060c06146871
# ╟─3e0b27fc-1ccb-440b-a98f-ee6541f3282e
# ╟─e2a37317-171d-4c45-975e-2752daf88008
# ╠═45d51447-beb8-4682-8b09-f65de7cfb95a
# ╟─776d80f1-ea26-4aeb-8bd5-c230956fa724
# ╠═5774bd94-3c87-48b5-868e-73418afbb5c7
# ╠═23227a0e-413a-4e05-9bf2-109a499b12cb
# ╟─5eea7d2e-cfda-4b42-9697-31ef645a1a79
# ╟─ce97f41f-8b71-468f-bac3-39a66e440cd5
# ╟─45d61914-591c-48bb-a0ad-902028d61089
# ╟─cecb430c-0236-4a16-b74f-1809710fbdfe
# ╠═f9906c93-f96d-45fd-b0ae-48794d82d54e
# ╟─58dd630a-ed1b-471a-94a3-fea43ec41d19
# ╟─de0a1efb-77ae-45bd-83a5-77029e2b095d
# ╟─60ebcfda-f28f-4aae-b1af-8e2a2313b3da
# ╠═aec673aa-fd15-46d6-85eb-4db54babfea8
# ╠═32d3a10a-bc5c-44a6-950c-8928936cd808
# ╠═46ca52b7-3ec7-4c97-8a1e-0fadda4fc883
# ╟─cf9d05d8-791a-4280-a160-d17992c25146
# ╠═fc2d0d0b-a790-465b-93a6-0cf0c533b070
# ╠═c2b1e609-8839-4788-8173-ede22c6dff19
# ╟─01053f0e-adcb-4fae-9f6b-9709056bb5a2
# ╠═0bc1537f-dc1b-46a8-a270-4decee040e9a
# ╠═8d8657ee-17c3-4b31-a28e-f6eca4e98b83
# ╠═468d3484-b2c9-42e6-a9e4-753c3e4a57ac
# ╠═c4491060-fd42-4045-a8a6-8a2e6437984a
# ╟─cb3a2a70-7a4c-4adb-9983-95614645971b
# ╠═7d1a176a-5b5c-4ccb-b8d4-3ff8c9370776
# ╠═cb5a04e5-848d-4974-9667-73ab80d4a54b
# ╠═87459e6f-f147-44bb-a713-b75d0d2702e0
# ╟─b5937641-83df-4e64-b51f-84c988a1f9f5
# ╟─57829229-6fe8-4f30-bb10-49d763316864
# ╠═b5d7850d-dac2-482e-b0bc-273660d0646a
# ╟─ea43cd35-b7f8-46e0-befb-d9b0248e0eb3
# ╟─5561d5fa-74fa-430f-850b-8339ad3df433
# ╟─725c19e3-2659-4f2d-8442-2bbc6010661b
# ╟─272aeadc-773e-41a7-a112-80e814e4ac3d
# ╟─027c7870-1603-4aba-95eb-3d14b7a0829f
# ╟─31056ca3-acd2-4457-bbd3-9ddd2c2ff641
# ╠═2f57e6de-c874-4f90-8e71-70cd1d002359
# ╠═2000a153-4b4d-4aec-a503-eaf3cc9d89c3
# ╟─0fe33d6c-d65d-4f29-857d-34ea792a1f48
# ╟─71c2b3dd-3fb4-4f8b-9e19-a043e05ff498
# ╟─c986580b-fe8c-4b68-9fa1-230b429e6de8
# ╠═57d23d48-4f7b-434c-95f3-dd6c704dbb0b
# ╟─d89bd03c-5dda-4141-af90-1673af2370e3
# ╠═29a57a0e-7859-416b-a6d5-ab8b4ec9516c
# ╟─3dbc1078-85b1-4711-98fe-29d48d0b1474
# ╠═9f99e017-08f6-43b9-9db8-cec9e310b4b7
# ╠═f6a2038a-9b42-4580-a61d-89c6a398ee66
# ╠═65b736a4-1a38-4366-b519-cd13893d24a5
# ╠═5b4773c3-fcbc-4f97-8684-653fd8f1dfbd
# ╟─68e50ed7-c17d-4d89-9eb6-40aa790a87e8
# ╟─41a7bd3b-56f5-45e7-ac8d-313bb3a46181
# ╟─067c7894-2e3f-43de-998f-4f1a250bc0f7
# ╟─4a9735f7-0d2b-4557-a293-f0e0c6c19179
# ╟─af5e47f0-010b-4e69-bed3-95fdf9fce3fe
# ╠═216dcbf9-91aa-40fe-bef2-6dea56a35be7
# ╟─dda486b4-5838-429b-aec8-450d2f0c55be
# ╟─df1540c4-d458-428c-b230-6c42557557e1
# ╟─39c8a7fd-8746-4179-865e-9ec7df230fff
# ╠═f3d0483f-ba78-4d3d-a23e-ec051923175d
# ╠═474cd2c3-b35b-4d01-b62a-e7171b4ee476
# ╟─6fd61dac-2ab1-464a-a20c-c0e1d7d23e8b
# ╟─4639b31c-9ef9-47a8-b9a9-b65b2e6d13fa
# ╟─edb7814a-eddf-4c87-8857-19bb0a0c0241
# ╠═f60be2e0-9b43-46b5-96ef-7747ab56e164
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
