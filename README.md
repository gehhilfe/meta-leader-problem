Nats Server version: v2.10.16
Nats Cli version: 0.1.4

Produces a jetstream cluster where 6 nodes are expected but only 3 are running without reaching meta cluster quorum


It starts three nodes nats1, nats2 and nats3 in jetstream
It rename each node step by step
1. nats3 to nats30
2. nats2 to nats20
3. nats1 to nats10
Afterwards it renames each node back step by step
1. nats10 to nats1
2. nats20 to nats2
3. nats30 to nats3

During the rename the data directories are kept