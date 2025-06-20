function simulate_abo(p, q, r, generations)
    println("世代\tA遺伝子\tB遺伝子\tO遺伝子\taa\t ao\t bb\t bo\t oo\t ab")
    for gen in 1:generations
        aa = p^2
        ao = 2 * p * r
        bb = q^2
        bo = 2 * q * r
        oo = r^2
        ab = 2 * p * q

        println("$(gen)\t$(round(p, digits=3))\t$(round(q, digits=3))\t$(round(r, digits=3))\t$(round(aa, digits=3))\t$(round(ao, digits=3))\t$(round(bb, digits=3))\t$(round(bo, digits=3))\t$(round(oo, digits=3))\t$(round(ab, digits=3))")

        total = aa + ao + bb + bo + oo + ab

        p_next = (2*aa + ao + ab) / (2*total)
        q_next = (2*bb + bo + ab) / (2*total)
        r_next = (2*oo + ao + bo) / (2*total)

        p, q, r = p_next, q_next, r_next
    end
end

simulate_abo(0.27, 0.16, 0.57, 20)