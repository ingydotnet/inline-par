inline-par
==========

Attempting to make Perl's Inline and PAR work together

## Synopsis

```
make test
```

The test system requires Docker to be installed.

## Description

Docker's `alpine` image is a minimal Linux without a `perl` binary installed by
default.
We can build stuff in one container after installing perl and Inline.
Then we run the result in a container without perl to see if it works.
