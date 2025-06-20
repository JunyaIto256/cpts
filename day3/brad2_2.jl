using Random
using Plots

# 遺伝子型のリスト
genotypes = ["aa", "ao", "bb", "bo", "oo", "ab"]

# 日本人の推定初期割合（10000人にスケール）
init_ratios = Dict(
    "aa" => 0.073,
    "ao" => 0.308,
    "bb" => 0.026,
    "bo" => 0.182,
    "oo" => 0.325,
    "ab" => 0.086
)
N = 10000
population = []
for gt in genotypes
    append!(population, fill(gt, Int(round(init_ratios[gt]*N))))
end

# 遺伝子型から遺伝子ペアを返す辞書
allele_map = Dict(
    "aa" => ("a", "a"),
    "ao" => ("a", "o"),
    "bb" => ("b", "b"),
    "bo" => ("b", "o"),
    "oo" => ("o", "o"),
    "ab" => ("a", "b")
)

# 2人の遺伝子型から子の遺伝子型を決める関数
function make_child(gt1, gt2)
    alleles1 = allele_map[gt1]
    alleles2 = allele_map[gt2]
    # それぞれからランダムに1つずつ遺伝子を選ぶ
    a1 = rand(alleles1)
    a2 = rand(alleles2)
    # 並び順をソートして遺伝子型に変換
    child_alleles = sort([a1, a2])
    if child_alleles == ["a", "a"]
        return "aa"
    elseif child_alleles == ["a", "b"]
        return "ab"
    elseif child_alleles == ["a", "o"]
        return "ao"
    elseif child_alleles == ["b", "b"]
        return "bb"
    elseif child_alleles == ["b", "o"]
        return "bo"
    else
        return "oo"
    end
end

# シミュレーション
steps = 100000
history = Dict(gt => Float64[] for gt in genotypes)

for step in 1:steps
    # 集団から2人を重複なしで選ぶ（選ばれた人は一時的に集団から除く）
    idxs = sort(randperm(length(population))[1:2])
    gt1, gt2 = population[idxs[1]], population[idxs[2]]
    # 2人を集団から除く
    deleteat!(population, idxs)
    # 2人の子を作る
    child1 = make_child(gt1, gt2)
    child2 = make_child(gt1, gt2)
    # 新しい2人を集団に戻す
    push!(population, child1)
    push!(population, child2)
    # 各世代ごとに割合を記録
    counts = Dict(gt => 0 for gt in genotypes)
    for gt in population
        counts[gt] += 1
    end
    for gt in genotypes
        push!(history[gt], counts[gt]/length(population))
    end
end

# 最終的な割合を計算
countss = Dict(gt => 0 for gt in genotypes)
for gt in population
    countss[gt] += 1
end

# グラフ描画
plot()
for gt in genotypes
    plot!(history[gt], label=gt)
end
xlabel!("世代")
ylabel!("割合")
title!("各遺伝子型の割合の推移")
savefig("genotype_ratios_2.png")

# 最終的な割合を表示
println("最終的な遺伝子型の割合（100000回操作後）")
for gt in genotypes
    println("$gt: $(round(countss[gt]/length(population), digits=3))")
end