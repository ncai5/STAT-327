# STAT327-003: HW1

## Part2 

# Check the solution using

HoltWinters(x=nhtemp, beta=FALSE, gamma=FALSE)$alpha

## Part 3(b)

# Check the solution using

glm(cbind(Menarche, Total-Menarche) ~ Age, 
        family=binomial(logit), data=menarche)$coefficients
