From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 27 Jul 2010 13:34:01 +0000
Subject: Re: [PATCH v3] of: Create asm-generic/of.h and provide default of_node_to_nid()
Message-Id: <201007271534.01250.arnd@arndb.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20100726220405.1550.63442.stgit@angua> <20100726222627.GA23501@merkur.ravnborg.org> <AANLkTikcV3jJUm_My-oK-drudSDz3M2iH1cWhxdt+W1s@mail.gmail.com>
In-Reply-To: <AANLkTikcV3jJUm_My-oK-drudSDz3M2iH1cWhxdt+W1s@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree-discuss@lists.ozlabs.org
Cc: Grant Likely <grant.likely@secretlab.ca>, Sam Ravnborg <sam@ravnborg.org>, sfr@canb.auug.org.au, microblaze-uclinux@itee.uq.edu.au, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org, davem@davemloft.net

On Tuesday 27 July 2010, Grant Likely wrote:
> > I suggest to go back to v2 of your patch where you use asm-generic/of.h.
> 
> Stephen suggested dropping asm-generic/of.h.  I'm happy to do it either way.

I don't mind adding stuff to asm-generic, but I think in this case it would
be easier to keep this in linux/of.h because there is nothing wrong with
all architectures including it.

Most files in asm-generic are there only for historical reasons, where some
architectures use them but others don't. IMHO we should use the include/linux
headers preferred for new stuff though.

	Arnd
