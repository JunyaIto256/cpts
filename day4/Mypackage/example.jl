using ITensors


K = 1
chi = 100

# 4脚テンソルの定義
i = Index(2, "i")
j = Index(2, "j")
k = Index(2, "k")
l = Index(2, "l")
W = ITensor(i, j, k, l)

for ii in 0:1, jj in 0:1, kk in 0:1, ll in 0:1
    W[i => ii+1, j => jj+1, k => kk+1, l => ll+1] = exp(K * ((2 * ii - 1) * (2 * jj - 1) + (2 * jj - 1) * (2 * kk - 1) + (2 * kk - 1) * (2 * ll - 1) + (2 * ll - 1) * (2 * ii - 1)))
end

@show W

# 3脚テンソルの生成
P = W * delta(l)

@show P


# 各転送行列の生成
C = P * delta(k)

@show C



# Pの拡大
m = Index(2, "m")
n = Index(2, "n")
P_b = replaceinds(P, [j, k] => [m, n])
P_a = W * P_b

# P_aにcombinerを適用してP_bを作成
# P_a[j,k,l,m,n] -> P_b[k,a,b]
P_expanded = P_a * combiner(m, l; tags="a") * combiner(n, j; tags="b")

@show P_expanded


# Cの拡大
o = Index(2, "o")
p = Index(2, "p")
P_l = replaceinds(P, [j, k] => [m, n])
P_r = replaceinds(P, [i, j, k] => [l, o, p])
C_b = replaceinds(C, [i, j] => [n, o])
C_a = P_l * C_b * P_r * W
C_expanded = C_a * combiner(m, j; tags="a") * combiner(k, p; tags="b")

@show C_expanded
