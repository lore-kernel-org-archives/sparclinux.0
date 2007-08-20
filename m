From: Markus Dahms <mad@automagically.de>
Date: Mon, 20 Aug 2007 10:34:17 +0000
Subject: Re: Odp: possible endless loop in PROM initialization
Message-Id: <20070820103417.GA4911@vimes.madsworld.lan>
List-Id: <sparclinux.vger.kernel.org>
References: <20070820075949.GA5927@vimes.madsworld.lan> <46c955d43d407@wp.pl>
In-Reply-To: <46c955d43d407@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Krzysztof Helt <krzysztof.h1@wp.pl>
Cc: sparclinux <sparclinux@vger.kernel.org>, linux-kernel@vger.kernel.org

Krzysztof Helt wrote,
> Could you give name of the function which contains this endless loop?
> When I looked into the tree.c file for the first time I thought
> it had a bug
> in handling the prom_nextprop, but later I concluded that this is ok.
> Maybe there is a bug there after all.

if I understood it correctly the following functions are called in this
order:

* prom_init()                    # arch/sparc/kernel/head.S
[...]
* create_node()                  # arch/sparc/kernel/prom.c
* build_prop_list()              # arch/sparc/kernel/prom.c
* build_one_prop()               # arch/sparc/kernel/prom.c
* prom_nextprop()                # arch/sparc/prom/tree.c
* __prom_nextprop()              # arch/sparc/prom/tree.c
* prom_nodeops->no_nextprop()    # PROM

And this loops while getting the attributes/properties of the /aliases
node.

Greetings,

	Markus
