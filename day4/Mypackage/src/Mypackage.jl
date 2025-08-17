module Mypackage

using ITensors

greet() = print("Hello World!")

# スカラー付き規格化テンソル構造体の定義
struct NormalizedTensor
    tensor::ITensor
    norm::Float64
end

# 規格化テンソルの作成
function normalize_tensor(T::ITensor)
    norm_T = norm(T)

    return NormalizedTensor(T / norm_T, norm_T)
end



end # module Mypackage
