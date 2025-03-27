# Hypotheses - the null (H0), alternative hypothesis (H1)

fish_weights <- c(48, 52, 49, 50, 51, 47, 53, 50)

# H0 - the mean fish weight is 50 grams
# alternative hypothesis H1: true mean is not equal to 50

t_test <- t.test(fish_weights, mu = 50)
print(t_test)

# P-Value (sig. level: 0.05)

print(t_test$p.value)


# Levene's test, ANOVA

library(car)

grp1 <- c(20, 22, 19, 21, 23)
grp2 <- c(25, 30, 22, 28, 35)

df <- data.frame(height = c(grp1, grp2),
                   group = factor(rep(c("A", "B"), each = 5)))

levene_test <- leveneTest(height ~ group, data = df)
print(levene_test)


# Shapiro-Wilk's test

shapiro_test <- shapiro.test(fish_weights)
print(shapiro_test)

fisher_exact <- fisher.test(fish_weights, simulate.p.value = TRUE)

# Transformations: log and square root

# Log

incomes <- c(1000, 1500, 2000, 3000, 10000)
log_incomes <- log(incomes)

par(mfrow = c(1, 2))
hist(incomes, main = "Original Data", col = "lightblue")
hist(log_incomes, main = "LOG Transformed Data", col = "lightgreen")

# Square Root Transformation
defects <- c(0, 1, 4, 9, 16, 25)
sqrt_defects <- sqrt(defects)
hist(defects, main = "Original Data", col = "magenta")
hist(sqrt_defects, main = "Square Root Transformed Data", col = "aquamarine")








