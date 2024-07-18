library(openai)
############################################################################## #
## example of a concern by a participant                                    ####
############################################################################## #
participant_concern <- "I don't know where the data goes"

############################################################################## #
## text of your informed consent form                                       ####
############################################################################## #
informed_consent <- "Liebe Lehramtsanwärter_innen,

herzlichen Dank für Ihre Bereitschaft, an dieser Befragung teilzunehmen. Wir interessieren uns vor allem für Ihre professionelle Entwicklung im Vorbereitungsdienst. Im Folgenden möchten wir daher zum einen von Ihnen erfahren, wie Sie Ihren Vorbereitungsdienst erleben, zum anderen interessieren uns Ihre aktuellen beruflichen Überzeugungen, Ihr berufliches Wohlbefinden sowie Ihre Kenntnisse zu Themen aus unterschiedlichen Bereichen der Bildungswissenschaften. 

Die Befragung wird voraussichtlich 90 Minuten dauern. Ihre Angaben dienen dazu, die Reformprozesse des Vorbereitungsdienstes genauer zu untersuchen. Ihnen entstehen dadurch keine Nachteile. Alle Berichte über die Ergebnisse der Evaluation werden auf zusammengefassten Daten beruhen. Rückschlüsse auf einzelne Personen sind somit nicht möglich – und sind seitens der Studienleitung auch nicht gewollt, da sich die relevanten Fragestellungen des Evaluationsvorhabens nicht auf Einzelpersonen beziehen.

Die Verantwortung für die Erhebung und Verarbeitung der Daten liegt bei der Leiterin des Evaluationsvorhabens, Frau Prof. Dr. Erika Musterfrau. Bei Rückfragen zur Erhebung wenden Sie sich bitte an die Testleitung vor Ort.

Wir wissen Ihr Engagement bei der Teilnahme an dieser Erhebung sehr zu schätzen und bedanken uns herzlich für Ihre gewissenhafte Mitarbeit.


Mit freundlichen Grüßen
Prof. Dr. Erika Musterfrau

-------------------------------------------------------------------


Hinweise zur Freiwilligkeit und zum Datenschutz:

Die Teilnahme an der Erhebung ist freiwillig. Ihnen entstehen keine Nachteile, wenn Sie nicht an der Erhebung teilnehmen. Möchten Sie einzelne Fragen nicht beantworten, so können Sie diese bei der Bearbeitung auslassen.

Information zum Umgang mit personenbezogenen Daten

Das Musterforschungsinstitut arbeitet nach den Vorschriften der Datenschutz-Grundverordnung (DS-GVO), des Bundesdatenschutzgesetzes (BDSG), des hessischen Datenschutz- und Informationsfreiheitsgesetzes (HDSIG) sowie allen anderen datenschutzrechtlichen Bestimmungen.

Im Rahmen dieser Befragung werden folgende Daten erhoben: 

1. Fragebogendaten zu ihren persönlichen Einschätzungen hinsichtlich Ihres beruflichen und persönlichen Wohlbefindens, sowie Abläufe während Ihres Vorbereitungsdienstes 
2. Erfassung des während Ihres Studiums erworbenen Bildungswissenschaftlichen Wissens 
3. Erfassung Ihres Technologisch-Pädagogischen-Wissens.
4. Soziodemografische Angaben: Diese Daten zu Ihrer Person, wie z.B. Alter und Geschlecht, werden ausschließlich für wissenschaftliche Zwecke, also zur Beantwortung von Forschungsfragen, erhoben und verarbeitet.
5. Individueller Code: Da die Erhebung Teil einer Längsschnittstudie ist, generieren Sie zu Beginn jeder Erhebung einen individuellen Code aus einer mehrstelligen Buchstaben- und Zahlenkombination. Dieser Code wird dafür verwendet, die Daten ein und derselben Person von unterschiedlichen Erhebungszeitpunkten miteinander zu verknüpfen. Darüber hinaus dient dieser Code der nachträglichen Identifikation Ihrer Daten im Falle eines Widerrufs (siehe unten).


Diese Daten möchten wir wie im Folgenden dargelegt verwenden:

Ihre Daten werden geschützt aufbewahrt, und nur berechtigte Forscher*innen erhalten Zugriff. Diese und projektbeteiligte Mitarbeiter*innen, welche Zugriff auf die Daten haben, werden schriftlich zur Einhaltung der datenschutzrechtlichen Bestimmungen verpflichtet.

Die Veröffentlichung von Forschungsergebnissen in Publikationen oder auf Tagungen erfolgt ausschließlich  in anonymisierter Form und lässt zu keinem Zeitpunkt Rückschlüsse auf Sie als Person zu. Es erfolgt keine Veröffentlichung von personenbezogenen Daten. Die Ergebnisse werden ausschließlich in anonymisierter Form dargestellt. Das bedeutet: Niemand kann aus den Ergebnissen erkennen, von welcher Person die  Angaben gemacht worden sind. Teile Ihrer Aussagen werden eventuell inhaltlich zitiert; z.B. in Publikationen, Berichten, im Web oder anderen Ergebnisdarstellungen. Dies geschieht in anonymisierter Form, d.h. ohne Angabe Ihres Namens oder Ihrer Adresse.

Ihr Einverständnis vorausgesetzt werden die in dieser Befragung erhobenen Daten im Sinne guter wissenschaftlicher Praxis bei einem vertrauenswürdigen Archiv aufbewahrt und von anderen Wissenschaftler*innen zu Zwecken der Bildungsforschung genutzt werden. Ihr Einverständnis vorausgesetzt, werden die Daten nach Abschluss dieser Studie im Sinne der Richtlinien der Deutschen Forschungsgemeinschaft zur guten wissenschaftlichen Praxis mindestens an ein professionelles Forschungsdatenzentrum übergeben. Dieses gewährleistet deren sichere und zugriffsgeschützte Aufbewahrung. In dem Datenzentrum stehen die Daten anderen berechtigten Forscher*innen zu wissenschaftlichen Zwecken in thematisch verwandten Forschungsbereichen zu definierten Forschungszwecken zur Verfügung. Ihre Daten werden stets vertraulich unter Wahrung der Datenschutzgesetze behandelt. 

Sie haben jederzeit die Möglichkeit folgende Rechte zum Datenschutz geltend zu machen:

Artikel 7 Absatz 3 DS-GVO: Recht auf Widerruf der Einwilligung
Sie haben das Recht, Ihre Einwilligung jederzeit mit Wirkung für die Zukunft zu widerrufen.
Artikel 15 DS-GVO: Auskunftsrecht
Sie haben uns gegenüber das Recht, Auskunft darüber zu erhalten, welche Daten wir zu Ihrer Person verarbeiten. 
Artikel 16 DS-GVO: Recht auf Berichtigung
Sollten die Sie betreffenden Daten nicht richtig oder unvollständig sein, so können Sie die Berichtigung unrichtiger oder die Vervollständigung unvollständiger Angaben verlangen. 
Artikel 17 DS-GVO: Recht auf Löschung
Sie können jederzeit die Löschung ihrer Daten verlangen. 
Artikel 18 DS-GVO: Recht auf Einschränkung der Verarbeitung
Sie können die Einschränkung der Verarbeitung der Sie betreffenden personenbezogenen Daten verlangen. 
Artikel 21 DS-GVO: Widerspruchsrecht
Sie können jederzeit gegen die Verarbeitung der Sie betreffenden Daten Widerspruch einlegen. 
Artikel 77 DS-GVO: Recht auf Beschwerde bei einer Aufsichtsbehörde
Wenn Sie der Auffassung sind, dass wir bei der Verarbeitung Ihrer Daten datenschutzrechtliche Vorschriften nicht beachtet haben, können Sie sich mit einer Beschwerde an die zuständige Aufsichtsbehörde wenden, die Ihre Beschwerde prüfen wird.

Der von Ihnen zu Beginn des Fragebogens generierte, individuelle Code wird im Zuge der Aufbereitung der Daten vor der Übergabe an ein professionelles Forschungsdatenzentrum entfernt.  Nach erfolgter Übergabe der Daten (voraussichtlich Ende 2025) ist uns eine Löschung der dort bereitgestellten Daten im Falle eines Widerrufs somit nicht mehr möglich. Es gelten die Datenschutzbestimmungen des Forschungsdatenzentrums.

In jedem Fall gilt: Ihre Teilnahme an unserer Befragung ist freiwillig. Lehnen Sie die Teilnahme ab oder widerrufen oder beschränken Sie Ihre Einwilligung, entstehen Ihnen hieraus keine Nachteile. 
Eine Erklärung zur Geltendmachung Ihrer Rechte ist grundsätzlich schriftlich an den Verantwortlichen zu richten."


############################################################################## #
## Defining content of the role "system"                                    ####
############################################################################## #
system_content <- "You are a data protection officer at a research institution and advise study participants who come to you with questions. You are sympathetic to participants' privacy concerns, while at the same time trying to give them a realistic picture of the strict data security that is common in scientific research."


############################################################################## #
## Put the content of the role "user" together                              ####
############################################################################## #
user_content <- paste0("I am conducting a scientific study that requires participants to sign an informed consent form. The study adheres to strict data protection guidelines, but one participant has expressed concerns about signing the consent form. I need a clear, honest, and informative response to address this concern. The aim of the response is for the participant to understand the data protection of the study and that unsubstantiated concerns are mitigated. This is the text of the informed consent of the relevant study:
                       
#####
",
  informed_consent,
"
#####

The participant's concerns may not be fully formulated or may contain several concerns at once. Try to categorize the concerns as clearly and precisely as possible, separating several concerns if necessary. Address each concern individually to provide comprehensive and focused answers.

This is how the participant formulated their concern: ",
  participant_concern,
"

Task:
Please provide an honest assessment of the participant's concern(s), explaining how the study ensures data protection and addresses these specific issues. The response should be clear and informative to help participants understand the safeguards in place. Use straightforward and non-technical language to make the information accessible to all types of participants. Limit yourself strictly to answering the specific question, do not provide any additional information and do not offer any further help or to answer further questions. You do not have to introduce yourself or say goodbye.")




############################################################################## #
## Send prompt to ChatGPT and get answer                                    ####
############################################################################## #
response <- create_chat_completion(
  model = "gpt-3.5-turbo",
  temperature = 0.5,
  max_tokens = 500,
  messages = list(
    list(
      "role" = "system",
      "content" = system_content
    ),
    list(
      "role" = "user",
      "content" = user_content
    )
  )
)

## Check answer 
response$choices$message.content
