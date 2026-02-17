library(brms)
library(formr)
library(tidyverse)

# formr::formr_store_keys("Juergen_formr",
#                         "j.schn@posteo.de",
#                         secret_2fa = "")

formr::formr_connect(keyring = "Juergen_formr")

tmp <- formr_item_displays("UzVvTP_LAS")

## Angezeigter Text: 97 Wörter
# Ihr Datenschutz
# Das Ausfüllen der Befragung ist freiwillig und ein Nichtausfüllen wird für Sie keinerlei Nachteile mit sich bringen.
# Sie können jederzeit ihr Einverständnis zur Befragung zurückziehen. Kontaktieren Sie hierzu den Studienleiter (siehe Fußzeile).
# Die Ergebnisse der Befragung werden ausschließlich in anonymisierter Form dargestellt, so dass niemand aus den Ergebnissen erkennen kann, von welcher Person diese Angaben gemacht worden sind.
# Alle Daten werden streng vertraulich behandelt und nur für wissenschaftliche Zwecke genutzt.
# Es gibt keine Weitergabe an Dritte, die Ihre Person erkennen lassen.
# Ich habe die Datenschutzbestimmungen gelesen, verstanden und willige der Befragung ein. (Fragen an [EmailBlinded])



tmp <- tmp %>%
  dplyr::filter(item_name == "datenschutz") %>%   # item: consent agreed
  mutate(dwell_time_sec = answered_relative/1000, # recorded in milliseconds relative to pageload
         # converted to seconds
         words_per_minute = 97 / (dwell_time_sec/60))  # 97 words in the consent







############################################################################## #
## With random intercept                                                    ####
############################################################################## #

fit_gamma_RE <- brm(
  words_per_minute ~ 1 + (1 | study),
  data = data,
  family = Gamma(link = "log"),
  chains = 4, iter = 4000, cores = 4, seed = 123
)

# --- get posterior mean and CI ---
# Posterior: erwarteter Populationsmittelwert (auf Originalskala)
newdata <- data.frame(study = NA)   # NA in Gruppierungsvariable => neue Ebene (re_formula = NA fixiert random effects auf 0)
epred <- posterior_epred(fit_gamma_RE, 
                         newdata = newdata, # predict these cases
                         re_formula = NA)  # ignore random effects, gets population average (only fixed effects)
epred_vec <- as.numeric(epred[,1])         # get vector with posterior draws

mean(epred_vec)                       # Posterior mean of population expected reading_speed
quantile(epred_vec, c(0.025, 0.975))  # 95% CI

# --- hypothesis() on log-Scale ---
log_238 <- log(238)
log_500 <- log(500)
log_900 <- log(900)

hypothesis(fit_gamma_RE, paste0("Intercept > ", log_238))
hypothesis(fit_gamma_RE, paste0("Intercept > ", log_500))
hypothesis(fit_gamma_RE, paste0("Intercept > ", log_900))





############################################################################## #
## Without random intercept                                                 ####
############################################################################## #
library(brms)

# 🔧 Gamma-Modell mit log-Link, nur Intercept
fit_gamma_noRE <- brm(
  words_per_minute ~ 1,
  data = tmp,
  family = Gamma(link = "log"),
  chains = 4, iter = 4000, cores = 4, seed = 123
)


# --- get posterior mean and CI ---
epred <- posterior_epred(fit_gamma_noRE)
epred_vec <- as.numeric(epred[, 1])

mean(epred_vec)                       # Posterior mean
quantile(epred_vec, c(0.025, 0.975))  # 95%-Intervall

# --- hypothesis() on log-Scale ---
log_238 <- log(238)
log_500 <- log(500)
log_900 <- log(900)

hypothesis(fit_gamma_noRE, paste0("Intercept > ", log_238))
hypothesis(fit_gamma_noRE, paste0("Intercept > ", log_500))
hypothesis(fit_gamma_noRE, paste0("Intercept > ", log_900))




##################################
# --- Posterior draws der erwarteten Werte ---
epred <- posterior_epred(fit_gamma_noRE)
epred_vec <- as.numeric(epred[, 1])

# --- Credible Interval berechnen ---
ci <- quantile(epred_vec, c(0.025, 0.975))

# --- Dataframe für ggplot ---
plot_df <- data.frame(reading_speed = epred_vec)

ggplot(plot_df, aes(x = reading_speed)) +
  geom_density(fill = "skyblue", alpha = 0.4) +
  geom_vline(xintercept = ci, color = "blue", linetype = "dashed", linewidth = 0.7) +
  geom_vline(xintercept = 238, color = "red", linetype = "solid", linewidth = 1) +
  geom_vline(xintercept = 500, color = "darkred", linetype = "solid", linewidth = 1) +
  geom_vline(xintercept = 900, color = "darkred", linetype = "solid", linewidth = 1) +
  annotate("text", x = 238, y = 0, label = "238", angle = 90, vjust = -0.5, color = "red") +
  annotate("text", x = 500, y = 0, label = "500", angle = 90, vjust = -0.5, color = "darkred") +
  annotate("text", x = 900, y = 0, label = "900", angle = 90, vjust = -0.5, color = "darkred") +
  labs(
    title = "Posterior Distribution of Expected Reading Speed",
    subtitle = paste0("95% Credible Interval: [", round(ci[1], 1), ", ", round(ci[2], 1), "]"),
    x = "Reading speed (ms)", y = "Density"
  ) +
  theme_minimal(base_size = 14)

