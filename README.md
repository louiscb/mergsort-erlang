# Mergesort written in Erlang

This repo contains two implementations of the mergesort algorithm: one sequential and one concurrent.

## Sequential

```
1> mergesort:ms([3,2,1]).             
[1,2,3]
```

## Concurrent

```
1> mergesort:pms([3,2,1]).             
[1,2,3]
```
