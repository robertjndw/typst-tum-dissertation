// Must fail to compile: dates have to be a datetime, not a string.
#import "../tum-dissertation/lib.typ": dissertation

#show: dissertation.with(submission-date: "09.10.2026")
