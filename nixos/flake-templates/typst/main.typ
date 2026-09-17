#import "template.typ": project

#show: project.with(
  theme: "Theme of the document",
  title: "Title of the document",
  subtitle: "Subtitle for more context",
  authors: ("John Doe",),
  date: "01 january 1999",
)
