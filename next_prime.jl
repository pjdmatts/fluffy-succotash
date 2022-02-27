using Primes

# return the next prime after x

# define the function...
function next_prime(x)
    x += iseven(x) ? 1 : 2
    while !isprime(x)
        x += 2
    end
    return x
end

# and now invoke it 
ans = next_prime(10000000)
println(ans)