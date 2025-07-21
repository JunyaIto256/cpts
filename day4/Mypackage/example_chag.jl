using ITensors

K = 1.0
chi = 100  # 今は未使用

# Index の定義
i = Index(2, "i")
j = Index(2, "j")
k = Index(2, "k")
l = Index(2, "l")

# 4脚テンソル W を定義
W = ITensor(i, j, k, l)

# 各成分に値を代入
for ii in 0:1, jj in 0:1, kk in 0:1, ll in 0:1
    s_i = 2 * ii - 1
    s_j = 2 * jj - 1
    s_k = 2 * kk - 1
    s_l = 2 * ll - 1
    energy = s_i * s_j + s_j * s_k + s_k * s_l + s_l * s_i
    W[i => ii+1, j => jj+1, k => kk+1, l => ll+1] = exp(K * energy)
end

println("W = ", W)

# l方向を縮約して3脚テンソル P を作る
P = W * delta(l)

println("P = ", P)

# 成分を表示
for ii in 1:2, jj in 1:2, kk in 1:2
    println("P[$ii,$jj,$kk] = ", P[i => ii, j => jj, k => kk])
end
