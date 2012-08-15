From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 15 Aug 2012 10:02:00 +0000
Subject: Re: [PATCH] sparc64: Be less verbose during vmemmap population.
Message-Id: <20120815100200.GA6154@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20120815.003847.825743633212686022.davem@davemloft.net>
In-Reply-To: <20120815.003847.825743633212686022.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

>=20
> diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
> index 6026fdd..d58edf5 100644
> --- a/arch/sparc/mm/init_64.c
> +++ b/arch/sparc/mm/init_64.c
> +
> +void __meminit vmemmap_populate_print_last(void)
> +{
> +	if (addr_start) {
> +		printk(KERN_DEBUG " [%lx-%lx] on node %d\n",
> +		       addr_start, addr_end-1, node_start);
> +		addr_start =3D 0;
> +		addr_end =3D 0;
> +		node_start =3D 0;
> +	}
> +}
This confused me... I saw you added a function wh=EDch was never used.
include/linux/mm.h had a protoype with no comments at all !?!?
But then I could see we have a weak version defined in mm/
and you just add the arch version which overrides the waeak version.

A small comment would have helped me here.
But on the other hand you followed the comment style for this anyway :-(

	Sam - going to grab some coffe to be less grumble
