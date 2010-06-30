From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 30 Jun 2010 21:52:51 +0000
Subject: Re: [PATCH 2/4] sparc: break out some prom device-tree building code
Message-Id: <AANLkTilme2uAoXjorUEzam9j_xosR8kl70W8PS71d-Th@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20100628215407.2017bf2f@debian> <20100628220037.5744c207@debian>
	<AANLkTilN3_ntG7AWKi-8LM9X_dZJPPlWM6xRM_V_00xU@mail.gmail.com>
	<20100629110324.2756cc02@debian> <AANLkTinPsrqxj5oQirEDRvVOuOeWgWSdljsMRbw8wn8V@mail.gmail.com>
	<20100629193618.5a840b8e@dev.queued.net>
In-Reply-To: <20100629193618.5a840b8e@dev.queued.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Andres Salomon <dilinger@queued.net>
Cc: devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org, x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, cjb@laptop.org, Mitch Bradley <wmb@laptop.org>, pgf@laptop.org, linux-kernel@vger.kernel.org, davem@davemloft.net, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Tue, Jun 29, 2010 at 5:36 PM, Andres Salomon <dilinger@queued.net> wrote:
> On Tue, 29 Jun 2010 15:42:54 -0600
> Grant Likely <grant.likely@secretlab.ca> wrote:
>
>> On Tue, Jun 29, 2010 at 9:03 AM, Andres Salomon <dilinger@queued.net>
>> wrote:
> [...]
>>
>> > =A0Sparc and OLPC have very similar
>> > mechanisms for getting device tree info from OFW, so it makes sense
>> > to share code between them.
>>
>> Other than the flattened tree step; is the powerpc method dissimilar
>> from the Sparc and OLPC method for talking to OFW? =A0(This is not a
>> rhetorical question, I'm want to know if I'm missing some details).
>> The main difference I know about is that OFW can still kept alive at
>> runtime for sparc, which powerpc does not do. =A0However, keeping OFW
>> callable is a separate issue from how to extract the device tree.
>>
>
> After having a look at powerpc's flatten_device_tree, I don't see any
> obvious reason why OLPC couldn't use this

Okay.

>(though it still strikes me
> as weird to go from prom->fdt->dt when the option of prom->dt is
> available and less complex).

Which is why I didn't simply NACK it out of hand.  It is a valid point.

I'd probably be happier if both fdt and pdt used a shared set of
utility functions for allocating and tying together the device_node
data structures.  Then at least there would be only one instance of
code to deal with the fiddly data structure interconnections.

The nice thing about the powerpc version is that the tree can be
extracted really early in the boot process, before any of the core
kernel infrastructure or memory management is initialized.

> Do you already have the patches that put
> this into drivers/of/?

No.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
