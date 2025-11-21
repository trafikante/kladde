## Deutsch

Diese Beispiel-Edition entstand im Rahmen eines KI-basierten Workflows, der für einen Vortrag auf der Konferenz **„Artifizielle Hermeneutik. Kontingenz, Sinn & Digitalität”** (19.–21. November 2025, Universität des Saarlandes, Saarbrücken) entwickelt wurde. Ziel war es, die grundlegenden Schritte einer digitalen Edition – von der Transkription bis zur Webpräsentation – mithilfe eines großen Sprachmodells durchzuführen und dabei einem konsequenten *expert-in-the-loop*-Ansatz zu folgen: Die Interaktion zwischen Mensch und Maschine konzentriert sich auf das Prompting, während die editorische Umsetzung so weit wie möglich dem Sprachmodell überlassen wird.

Ediert wird **eine einzelne Manuskriptseite** aus der Arbeitskladde *„Future Texts“*. Der Workflow umfasst:

- Transkription des Bild-Digitalisats  
- TEI-konforme Auszeichnung von Metadaten und ediertem Text (ohne vorherige Modellierung)  
- strukturelle und semantische Auszeichnung mit mittlerer Granularität (inkl. Entitäten und Normdaten-ID-Recherche)  
- Erstellung eines Stellenkommentars  

Die Ausgabe wird als einfache Edition mit Text- und Bildansicht präsentiert und ist über **GitHub Pages** verfügbar:  

- Startseite **https://trafikante.github.io/kladde/**
- Edition **https://trafikante.github.io/kladde/viewer.html?doc=tei/ft-139.xml**

Alle Daten und der Code stehen **unter CC-0** zur freien Nutzung bereit.

### Technische Hinweise  
- Datenformat: TEI (XML)  
- Transformation: XSLT für die Ausgabe im Webviewer  
- Web-Frontend: statisches HTML5 + CSS  
- Hosting: GitHub Pages  
- Versionskontrolle: Git/GitHub  
- Annotationen: strukturelle und semantische Auszeichnung, Entitäten, Normdaten-IDs, Stellenkommentar  
- KI-Unterstützung: Automatisierung von Transkriptions- und Annotationsteilprozessen durch ein großes Sprachmodell (LLM)  

---

## English

This sample edition was produced as part of an AI-assisted editorial workflow developed for a presentation at the **“Artificial Hermeneutics. Contingency, Meaning & Digitality”** conference (19–21 November 2025, University of the Saarland, Saarbrücken). The aim was to carry out the essential steps of a digital scholarly edition—from transcription to web presentation—with the support of a large language model while adhering to a strict *expert-in-the-loop* approach: human intervention is limited to prompting, while the editorial tasks are delegated as far as possible to the model.

The edition covers **a single manuscript page** from the working notebook *“Future Texts”*. The workflow comprises:

- transcription of the digitized image  
- TEI-compliant encoding of metadata and edited text (without prior data modelling)  
- structural and semantic markup with medium granularity (including entities and authority-ID research)  
- commentary on selected passages  

The edition is presented as a simple text-and-image viewer and is available via **GitHub Pages**:

- Landing Page **https://trafikante.github.io/kladde/**
- Edition **https://trafikante.github.io/kladde/viewer.html?doc=tei/ft-139.xml**

All data and code are released under **CC-0** for unrestricted reuse.

### Technical overview  
- Data format: TEI (XML)  
- Transformation: XSLT for web output  
- Web frontend: static HTML5 + CSS  
- Hosting: GitHub Pages  
- Version control: Git/GitHub  
- Annotations: structural and semantic encoding, entities, authority IDs, commentary on selected passages  
- AI support: automation of transcription and annotation subprocesses using a large language model (LLM)  

---

### Zitierhinweis / How to cite

Kraft, Tobias; ChatGPT (v. 5.1) (OpenAI) (2025): *Beispiel-Edition „Future Texts“ – KI-gestützter Workflow*. GitHub Repository. Verfügbar unter: https://trafikante.github.io/kladde/viewer.html?doc=tei/ft-139.xml (Zugriff: [Datum]).
