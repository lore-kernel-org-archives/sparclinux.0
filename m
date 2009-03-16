From: David Miller <davem@davemloft.net>
Date: Mon, 16 Mar 2009 03:32:36 +0000
Subject: Re: Ultra1 ESP detection problem
Message-Id: <20090315.203236.173780380.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0903132344220.21922@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0903132344220.21922@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Friedrich Oslage <bluebird@gentoo.org>
Date: Sat, 14 Mar 2009 22:42:56 +0100

> David Miller schrieb:
> > We need to figure out why the logic isn't triggering properly.
> 
> That's easy, because the code isn't reached :)
> 
> In build_device_resources we have
> 
> 	bus->count_cells(op->node, &na, &ns);
> 	preg = of_get_property(op->node, bus->addr_prop_name, &num_reg);
> 
> which, for the esp, results in
> 
> 	na = 2;
> 	ns = 2; # this should be 1 according to of_bus_sbus_count_cells
> 	num_reg = 12;
> 
> after doing the maths
> 
> 	num_reg /= 4;
> 	num_reg /= na + ns;
> 
> we end up with num_reg = 0 and the for loop is skipped.
> 
> That's why I changed of_bus_sbus_match to make cell_count return 2, 1
> for the esp.

Ok, but your change will break cases where the parent between SBUS
and the child device really does translate things differently.

One such case is QFE.

Look at the qec-->qe hierarchy in the ss1000 entry of the prtconfs
GIT repo:

            Node 0xffd992ec
                ranges:  00000000.00000000.00000001.00030000.00004000.00000001.00000000.00000001.00034000.00004000.00000002.00000000.00000001.00038000.00004000.00000003.00000000.00000001.0003c000.00004000.00000010.00000000.00000001.00010000.00004000.00000011.00000000.00000001.00014000.00004000.00000012.00000000.00000001.00018000.00004000.00000013.00000000.00000001.0001c000.00004000
                name:  'qec'

                Node 0xffd9ac44
                    name:  'qe'

                Node 0xffd9df24
                    name:  'qe'

                Node 0xffd9e39c
                    name:  'qe'

                Node 0xffd9e814
                    name:  'qe'

Your change will make the 'qe' nodes match SBUS as a bus.  That's
wrong, and we need to use na = 2 and ns = 2 for this case.

So this doesn't work as a mechanism to bypass intermediate parent
nodes up to the SBUS.  You need to fix this while preserving the
invariants and expectations of how this translation system works.

For now, perhaps we can add those use_1to1_mapping() checks to
of_bus_sbus_match() as a quick fix that won't break other cases like
the 'qec' mentioned above.
