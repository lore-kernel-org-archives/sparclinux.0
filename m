From: Friedrich Oslage <bluebird@gentoo.org>
Date: Sat, 14 Mar 2009 21:42:56 +0000
Subject: Re: Ultra1 ESP detection problem
Message-Id: <49BC24E0.1030308@gentoo.org>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0903132344220.21922@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0903132344220.21922@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller schrieb:
> We need to figure out why the logic isn't triggering properly.

That's easy, because the code isn't reached :)

In build_device_resources we have

	bus->count_cells(op->node, &na, &ns);
	preg = of_get_property(op->node, bus->addr_prop_name, &num_reg);

which, for the esp, results in

	na = 2;
	ns = 2; # this should be 1 according to of_bus_sbus_count_cells
	num_reg = 12;

after doing the maths

	num_reg /= 4;
	num_reg /= na + ns;

we end up with num_reg = 0 and the for loop is skipped.

That's why I changed of_bus_sbus_match to make cell_count return 2, 1
for the esp.

Cheers,
Friedrich
