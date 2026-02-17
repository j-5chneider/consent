## NRW Data ####################################################################
# Doesn't work, there is no time captured for the first (welcome) page
# and we can't compute it

library(rio)
library(here)
library(tidyverse)

tmp <- rio::import(here("data/survey_834863_spss.sav")) 

group_times <- names(tmp)[2:46]

tmp <- tmp %>%
  dplyr::mutate(sum_group_times = rowSums(across(group_times)),
                consent_time = interviewtime - sum_group_times)

ggplot(tmp, aes(x=interviewtime)) + 
  geom_density()



## UzVvTP_LAS ##################################################################

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

tmp %>%
  dplyr::mutate(over_550 = words_per_minute > 500,
                over_900 = words_per_minute > 900) %>%
  dplyr::summarize(perc_500 = mean(over_550, na.rm = T),
                   perc_900 = mean(over_900, na.rm = T))


ggplot(tmp, aes(y = words_per_minute, x = 1)) +
  geom_jitter(height = 0) +
  geom_hline(yintercept=550)


## UzVvTP_LAS ##################################################################

library(formr)
library(tidyverse)

# formr::formr_store_keys("Juergen_formr",
#                         "j.schn@posteo.de",
#                         secret_2fa = "")

formr::formr_connect(keyring = "Juergen_formr")

tmp <- formr_item_displays("base_ld_1a")

## Angezeigter Text: 278 Wörter
# Einwilligungserklärung
# Für nähere Informationen zur Einwilligung klicken Sie auf den Button.
# Informationen zur Einwilligung
# Ich bin schriftlich über die Studie und den Versuchsablauf aufgeklärt worden. Ich willige ein, an der Expertenbefragung zur ‚Tübinger Bibliothek aufbereiteter Forschungssynthesen – TüDi-BASE‘ teilzunehmen.
# Sofern ich Fragen zu dieser vorgesehenen Studie hatte, wurden sie vollständig und zu meiner Zufriedenheit beantwortet.
# Mit der beschriebenen Erhebung und Verarbeitung der Daten meiner Einschätzung und Wahrnehmung von TüDi-BASE, sowie einige Rahmendaten zu meinem Alter, meiner Berufserfahrung, Unterrichtsfächer und meiner Selbsteinschätzung zu meiner Erfahrung mit digitalen Medien und statistischen Vorkenntnissen bin ich einverstanden. Die Aufzeichnung und Auswertung dieser Daten erfolgt pseudonymisiert in der Tübingen School of Education, d.h., unter Verwendung eines Pseudonyms. Dieses Pseudonym wird lediglich dazu genutzt, um meinen Vorabfragebogen mit der Hauptstudie und dem Abschlussfragebogen zu verknüpfen. Sobald diese Verknüpfung stattgefunden hat, werden die Daten anonymisiert, d.h., auch das Pseudonym durch eine zufällig gezogene Versuchspersonennummer ersetzt. Damit ist es niemandem mehr möglich, die erhobenen Daten mit meinem Namen in Verbindung zu bringen. Bis zur Anonymisierung der Daten habe ich die Möglichkeit, meine Daten unter Angabe meines persönlichen Kennwortes löschen zu lassen.
# Mir ist bekannt, dass ich mein Einverständnis zur Aufbewahrung bzw. Speicherung dieser Daten widerrufen kann, ohne dass mir daraus Nachteile entstehen. Ich bin darüber informiert worden, dass ich jederzeit eine Löschung all meiner Daten verlangen kann. Wenn allerdings die Daten bereits anonymisiert sind, kann mein Datensatz nicht mehr identifiziert und also auch nicht mehr gelöscht werden. Ich bin einverstanden, dass meine anonymisierten Daten zu Forschungszwecken weiterverwendet werden können und mindestens 10 Jahre gespeichert bleiben.
# Rückmeldung von Ergebnissen
# Wenn ich an den Ergebnissen der Studie interessiert bin, dann melde ich dies beim Studienleiter Dr. Jürgen Schneider (juergen.schneider@uni-tuebingen.de). Ergebnisse erhalte ich zu gegebener Zeit per E-Mail.
# Ich habe die Informationen der Einwilligungserklärung verstanden und willige der Teilnahme ein.



tmp <- tmp %>%
  dplyr::filter(item_name == "datenschutz") %>%   # item: consent agreed
  mutate(dwell_time_sec = answered_relative/1000, # recorded in milliseconds relative to pageload
         # converted to seconds
         words_per_minute = 278 / (dwell_time_sec/60))  # 97 words in the consent

tmp %>%
  dplyr::mutate(over_550 = words_per_minute > 500,
                over_900 = words_per_minute > 900) %>%
  dplyr::summarize(perc_500 = mean(over_550, na.rm = T),
                   perc_900 = mean(over_900, na.rm = T))


ggplot(tmp, aes(y = words_per_minute, x = 1)) +
  geom_jitter(height = 0) +
  geom_hline(yintercept=550)



## AssIC #######################################################################

library(here)
library(tidyverse)

tmp <- rio::import(here("data/data_assic1_dwelltime.xlsx"))

## Angezeigter Text: 330 Wörter
# Durchführende Institution: Die Studie wird im Rahmen eines Forschungsprojekts am DIPF | Leibniz-Institut für Bildungsforschung und Bildungsinformation in Frankfurt am Main durchgeführt.
# Studienleitung: Tina Bagus (t.bagus@dipf.de)
# Forschungsgegenstand: Die Studie befasst sich mit Gedanken und Gefühlen im Entscheidungsfindungsprozess. Weitere Informationen zum dahinterliegenden theoretischen Konstrukt werden im Anschluss an die Befragung nachgereicht. 
# Ablauf und Dauer der Befragung: In der vorliegenden Befragung werden Ihnen neben Fragen zu demografischen Angaben unter anderem Fragen zu Gedanken und Gefühlen im Entscheidungsfindungsprozess gestellt. Die Bearbeitung des Fragebogens wird ca. 10 Minuten dauern.
# Freiwilligkeit: Die Teilnahme an der Studie ist freiwillig und es ergeben sich keinerlei Nachteile bei einer Nichtteilnahme. Es steht Ihnen jederzeit frei, einzelne Fragen nicht zu beantworten oder die Befragung ohne Angabe von Gründen abzubrechen.
# Vertraulichkeit: Die erhobenen Daten werden streng vertraulich behandelt. Alle im Projekt beschäftigten Personen unterliegen der Schweigepflicht. Des Weiteren wird die geplante Veröffentlichung der Ergebnisse der Studie ausschließlich in anonymisierter Form der Daten erfolgen.
# Anonymität: Alle erhobenen Daten werden nur in anonymisierter Form genutzt. Das bedeutet, dass es niemandem möglich ist, Ihre Daten mit Ihnen als Person in Verbindung zu bringen. Zudem werden Sie zu keinem Zeitpunkt in dieser Untersuchung nach Ihrem Namen oder anderen Informationen gefragt, anhand derer wir Sie identifizieren können. Demografische Angaben wie Alter oder Geschlecht lassen ohne weitere Angaben keine eindeutigen Schlüsse auf Ihre Person zu. Aufgrund der Anonymisierung können die Daten nach Abschluss der Befragung nicht gelöscht werden.
# Datenverarbeitung: Der Umgang mit den im Projekt erhobenen Daten unterliegt den Regelungen der Datenschutz-Grundverordnung der Europäischen Union (DSGVO) und denen der Deutschen Forschungsgesellschaft (DFG). Die Daten werden in anonymisierter Form auf Datenträgern für mindestens 10 Jahre gespeichert und für wissenschaftliche Zwecke verwendet.
# Open Science: Die in dieser Studie erhobenen anonymisierten Daten werden im Sinne der Richtlinien der Deutschen Forschungsgemeinschaft zur guten wissenschaftlichen Praxis in einem kollaborativen Forschungsarchiv aufbewahrt und dort zur Nachnutzung zur Verfügung gestellt.
# Offene Fragen: Falls Sie noch offene Fragen zum Forschungsvorhaben oder zu Ihren Rechten als Studienteilnehmende haben sollten, wenden Sie sich bitte an t.bagus@dipf.de


tmp <- tmp %>%
  mutate(words_per_minute = 330 / (dwelltime/60))  # 97 words in the consent

tmp %>%
  dplyr::mutate(over_550 = words_per_minute > 500,
                over_900 = words_per_minute > 900) %>%
  dplyr::summarize(perc_500 = mean(over_550, na.rm = T),
                   perc_900 = mean(over_900, na.rm = T))


ggplot(tmp, aes(y = words_per_minute, x = 1)) +
  geom_jitter(height = 0) +
  geom_hline(yintercept=550)
